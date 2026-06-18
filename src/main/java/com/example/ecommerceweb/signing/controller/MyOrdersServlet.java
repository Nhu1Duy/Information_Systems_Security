package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.signing.util.SignatureVerifier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
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

        int userId = user.getId();
        List<Order> orders = OrderDAO.getOrdersByUserId(userId);
        String signature, result;
        KeyStore key;
        for (Order order : orders) {
            signature = order.getSignature();
            if (signature == null || signature.trim().isEmpty()) {
                continue;
            }

            key = KeyDAO.getKeyById(order.getKeyId());
            result = SignatureVerifier.verify(order, key);

            if (!result.equals(order.getSigStatus())) {
                OrderDAO.updateSigStatus(order.getId(), result);
            }
            order.setSigStatus(result);
        }
      
        KeyStore lastestKey = KeyDAO.getActiveKey(userId);
        // Vì createdAt trong key là LocalDateTime nên chuyển sang kiểu Date để thực hiện so sánh trong jsp
        Date lastestKeyDate = lastestKey != null ?
        		Date.from(lastestKey.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant()) : null;
        
        req.setAttribute("keyDate", lastestKeyDate);
        req.setAttribute("orders", orders);
        req.setAttribute("currentPage", "myOrders");
        req.getRequestDispatcher("/WEB-INF/sign/myOrders.jsp").forward(req, resp);
    }
}