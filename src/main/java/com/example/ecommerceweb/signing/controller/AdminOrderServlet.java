package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.signing.model.OrderStatus;
import com.example.ecommerceweb.signing.model.SignatureStatus;
import com.example.ecommerceweb.signing.util.SignatureVerifier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.ZoneId;
import java.util.Date;
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
                OrderStatus newStatus = OrderStatus.fromDbValue(request.getParameter("status"));
                OrderDAO.updateStatus(idUpdate, newStatus);
                response.sendRedirect("adminOrder");
                break;
            case "verify":
                verifyOrder(request, response);
                break;

            case "detail":
            	int detailId = Integer.parseInt(request.getParameter("id"));
                Order detailOrder = OrderDAO.getOrderById(detailId);
                KeyStore detailKey = null;
                if (detailOrder != null && detailOrder.getKeyId() > 0) {
                	detailKey = KeyDAO.getKeyById(detailOrder.getKeyId());
                    request.setAttribute("detailKey", detailKey);
                }
                
                request.setAttribute("detailOrder", detailOrder);
                request.getRequestDispatcher("WEB-INF/sign/adminOrderDetail.jsp")
                        .forward(request, response);
                break;

            default:
                List<Order> orders = OrderDAO.getAllOrders();
                orders = SignatureVerifier.verifyOrders(orders);
                
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("WEB-INF/sign/adminOrder.jsp")
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
        if (order == null) { response.sendRedirect("adminOrder"); return; }

        KeyStore key = order.getKeyId() > 0 ? KeyDAO.getKeyById(order.getKeyId()) : null;
        String result = SignatureVerifier.verify(order, key);

        OrderDAO.updateSigStatus(orderId, result);
        if (SignatureStatus.SIGNED.equals(result)) {
            OrderDAO.updateStatus(orderId, OrderStatus.SHIPPING);
        }

        String resultKey;
        if (SignatureStatus.SIGNED.equals(result)) {
            resultKey = "SIGNED";
        } else if (SignatureStatus.MISMATCH.equals(result)) {
            resultKey = "MISMATCH";
        } else if (SignatureStatus.KEY_REVOKED.equals(result)) {
            resultKey = "KEY_REVOKED";
        } else {
            resultKey = "UNSIGNED";
        }
        response.sendRedirect("adminOrder?verifyResult=" + resultKey + "&orderId=" + orderId);
    }
}