package com.example.ecommerceweb.signing.service;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.signing.model.OrderStatus;
import com.example.ecommerceweb.signing.model.SignatureStatus;
import com.example.ecommerceweb.signing.util.SignatureVerifier;

import java.util.List;

public class OrderService {

    public Order getOrderForUser(int orderId, int userId) {
        Order order = OrderDAO.getOrderById(orderId);
        if (order == null || order.getUserId() != userId) return null;
        return order;
    }

    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = OrderDAO.getOrdersByUserId(userId);
        return SignatureVerifier.verifyOrders(orders);
    }

    public void signOrder(int orderId, int userId, String signature) {
        Order order = getOrderForUser(orderId, userId);
        KeyStore activeKey = KeyDAO.getActiveKey(userId);
        if (activeKey == null) {
            throw new IllegalStateException("Bạn chưa có khóa. Vui lòng tạo khóa trước.");
        }

        OrderDAO.saveSignature(orderId, order.getCanonicalJson(), signature, activeKey.getId());
    }

    public List<Order> getAllOrders() {
        List<Order> orders = OrderDAO.getAllOrders();
        return SignatureVerifier.verifyOrders(orders);
    }

    public Order getOrderById(int orderId) {
        return OrderDAO.getOrderById(orderId);
    }

    public void updateStatus(int orderId, OrderStatus status) {
        OrderDAO.updateStatus(orderId, status);
    }

    public void deleteOrder(int orderId) {
        OrderDAO.delete(orderId);
    }

    public String verifyOrder(int orderId) {
        Order order = OrderDAO.getOrderById(orderId);
        if (order == null) return null;

        KeyStore key = order.getKeyId() > 0 ? KeyDAO.getKeyById(order.getKeyId()) : null;
        String result = SignatureVerifier.verify(order, key);

        OrderDAO.updateSigStatus(orderId, result);
        if (SignatureStatus.SIGNED.equals(result)) {
            OrderDAO.updateStatus(orderId, OrderStatus.CONFIRMED);
        } else if (SignatureStatus.MISMATCH.equals(result)) {
            OrderDAO.updateStatus(orderId, OrderStatus.CANCELLED);
        }

        if (SignatureStatus.SIGNED.equals(result)) return "SIGNED";
        if (SignatureStatus.MISMATCH.equals(result)) return "MISMATCH";
        if (SignatureStatus.KEY_REVOKED.equals(result)) return "KEY_REVOKED";
        return "UNSIGNED";
    }
}