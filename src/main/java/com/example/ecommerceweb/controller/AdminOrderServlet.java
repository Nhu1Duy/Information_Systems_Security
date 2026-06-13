package com.example.ecommerceweb.controller;

import com.example.ecommerceweb.DAO.KeyDAO;
import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.KeyStore;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.util.CryptoUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.PublicKey;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/adminOrder")
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "updateStatus":
                int idUpdate = Integer.parseInt(request.getParameter("id"));
                String newStatus = request.getParameter("status");
                OrderDAO.updateStatus(idUpdate, newStatus);
                response.sendRedirect("adminOrder");
                break;

            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                OrderDAO.delete(idDelete);
                response.sendRedirect("adminOrder");
                break;

            case "verify":
                verifyOrder(request, response);
                break;

            default:
                List<Order> orders = OrderDAO.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("WEB-INF/adminView/adminOrder.jsp")
                        .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void verifyOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = OrderDAO.getOrderById(orderId);
        String result;

        try {
            if (order == null || order.getSignature() == null || order.getSignature().isEmpty()) {
                result = "UNSIGNED";
            } else {
                KeyStore key = KeyDAO.getKeyById(order.getKeyId());

                if (key == null) {
                    result = "REJECTED";
                } else {
                    // Tầng 1: kiểm tra thời gian ký vs thời gian thu hồi
                    if ("REVOKED".equals(key.getStatus()) && key.getRevokedAt() != null) {
                        LocalDateTime orderTime = order.getOrderDate()
                                .toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDateTime();
                        if (!orderTime.isBefore(key.getRevokedAt())) {
                            result = "REJECTED";
                            OrderDAO.updateSigStatus(orderId, result);
                            response.sendRedirect("adminOrder?verifyResult=" + result + "&orderId=" + orderId);
                            return;
                        }
                    }

                    PublicKey publicKey = CryptoUtil.loadPublicKey(key.getPublicKey());
                    boolean valid = CryptoUtil.verifySignature(
                            order.getCanonicalJson(), order.getSignature(), publicKey);

                    result = valid ? "VERIFIED" : "TAMPERED";
                }
            }
        } catch (Exception e) {
            result = "TAMPERED";
        }

        OrderDAO.updateSigStatus(orderId, result);
        response.sendRedirect("adminOrder?verifyResult=" + result + "&orderId=" + orderId);
    }
}