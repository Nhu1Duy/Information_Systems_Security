package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.signing.service.KeyService;
import com.example.ecommerceweb.signing.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/sign-order")
public class SignOrderServlet extends HttpServlet {
    private OrderService orderService = new OrderService();
    private KeyService keyService = new KeyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = orderService.getOrderForUser(orderId, user.getId());
        if (order == null) {
            resp.sendRedirect("order-success");
            return;
        }

        KeyStore activeKey = keyService.getActiveKey(user.getId());
        req.setAttribute("order", order);
        req.setAttribute("activeKey", activeKey);
        req.getRequestDispatcher("/WEB-INF/sign/sign-order.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String signature = req.getParameter("signature");

        try {
            orderService.signOrder(orderId, user.getId(), signature);
            resp.sendRedirect("order-success");
        } catch (IllegalStateException e) {
            session.setAttribute("keyMessage", e.getMessage());
            resp.sendRedirect("key");
        } catch (IllegalArgumentException e) {
            resp.sendRedirect("order-success");
        }
    }
}