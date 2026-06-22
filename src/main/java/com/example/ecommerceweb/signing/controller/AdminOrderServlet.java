package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.signing.model.OrderStatus;
import com.example.ecommerceweb.signing.model.SignatureStatus;
import com.example.ecommerceweb.signing.service.KeyService;
import com.example.ecommerceweb.signing.service.OrderService;
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
    private final OrderService orderService = new OrderService();
    private final KeyService keyService = new KeyService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "updateStatus":
                int idUpdate = Integer.parseInt(request.getParameter("id"));
                OrderStatus newStatus = OrderStatus.fromDbValue(request.getParameter("status"));
                orderService.updateStatus(idUpdate, newStatus);
                response.sendRedirect("adminOrder");
                break;
            case "verify":
                verifyOrder(request, response);
                break;

            case "detail":
                handleDetail(request, response);
                break;

            default:
                List<Order> orders = orderService.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("WEB-INF/sign/adminOrder.jsp")
                        .forward(request, response);
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
        String resultKey = orderService.verifyOrder(orderId);
        if (resultKey == null) {
            response.sendRedirect("adminOrder");
            return;
        }
        response.sendRedirect("adminOrder?verifyResult=" + resultKey + "&orderId=" + orderId);

    }

    private void handleDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int detailId = Integer.parseInt(request.getParameter("id"));
        Order detailOrder = orderService.getOrderById(detailId);

        KeyStore detailKey = null;
        if (detailOrder != null && detailOrder.getKeyId() > 0) {
            detailKey = keyService.getKeyById(detailOrder.getKeyId());
            request.setAttribute("detailKey", detailKey);
        }
        if (detailKey != null) {
            Date revokedKeyDate = detailKey.getRevokedAt() != null
                    ? Date.from(detailKey.getRevokedAt().atZone(ZoneId.systemDefault()).toInstant())
                    : null;
            request.setAttribute("revokedDate", revokedKeyDate);
        }
        request.setAttribute("detailOrder", detailOrder);
        request.getRequestDispatcher("WEB-INF/sign/adminOrderDetail.jsp")
                .forward(request, response);
    }
}