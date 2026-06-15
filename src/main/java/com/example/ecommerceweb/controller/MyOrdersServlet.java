package com.example.ecommerceweb.controller;

import com.example.ecommerceweb.DAO.KeyDAO;
import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.KeyStore;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.util.SignatureVerifier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        List<Order> orders = OrderDAO.getOrdersByUserId(user.getId());

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

        req.setAttribute("orders", orders);
        req.setAttribute("currentPage", "myOrders");
        req.getRequestDispatcher("/WEB-INF/sign/myOrders.jsp").forward(req, resp);
    }
}