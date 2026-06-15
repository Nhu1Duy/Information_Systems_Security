package com.example.ecommerceweb.controller;

import com.example.ecommerceweb.DAO.KeyDAO;
import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.KeyStore;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.util.SignatureVerifier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
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

            case "detail":
                int detailId = Integer.parseInt(request.getParameter("id"));
                Order detailOrder = OrderDAO.getOrderById(detailId);
                if (detailOrder != null && detailOrder.getKeyId() > 0) {
                    KeyStore detailKey = KeyDAO.getKeyById(detailOrder.getKeyId());
                    request.setAttribute("detailKey", detailKey);
                }
                request.setAttribute("detailOrder", detailOrder);
                request.getRequestDispatcher("WEB-INF/adminView/adminOrderDetail.jsp")
                        .forward(request, response);
                break;

            default:
                List<Order> orders = OrderDAO.getAllOrders();

                for (Order order : orders) {
                    String signature = order.getSignature();
                    if (signature == null || signature.trim().isEmpty()) {
                        continue;
                    }

                    KeyStore key = order.getKeyId() > 0 ? KeyDAO.getKeyById(order.getKeyId()) : null;
                    String result = SignatureVerifier.verify(order, key);

                    if (!result.equals(order.getSigStatus())) {
                        OrderDAO.updateSigStatus(order.getId(), result);
                    }
                    order.setSigStatus(result);
                }

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

        if (order == null) {
            response.sendRedirect("adminOrder");
            return;
        }

        KeyStore key = order.getKeyId() > 0 ? KeyDAO.getKeyById(order.getKeyId()) : null;
        String result = SignatureVerifier.verify(order, key);

        OrderDAO.updateSigStatus(orderId, result);
        if ("VERIFIED".equals(result)) {
            OrderDAO.updateStatus(orderId, "COMPLETED");
        }

        response.sendRedirect("adminOrder?verifyResult=" + result + "&orderId=" + orderId);
    }
}