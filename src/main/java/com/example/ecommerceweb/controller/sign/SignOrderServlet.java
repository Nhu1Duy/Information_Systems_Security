package com.example.ecommerceweb.controller.sign;

import com.example.ecommerceweb.DAO.KeyDAO;
import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.KeyStore;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/sign-order")
public class SignOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect("login"); return; }

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = OrderDAO.getOrderById(orderId);

        if (order == null || order.getUserId() != user.getId()) {
            resp.sendRedirect("order-success");
            return;
        }

        KeyStore activeKey = KeyDAO.getActiveKey(user.getId());
        req.setAttribute("order", order);
        req.setAttribute("activeKey", activeKey);
        req.getRequestDispatcher("/WEB-INF/sign/sign-order.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect("login"); return; }

        int orderId      = Integer.parseInt(req.getParameter("orderId"));
        String signature = req.getParameter("signature");

        Order order = OrderDAO.getOrderById(orderId);
        if (order == null || order.getUserId() != user.getId()) {
            resp.sendRedirect("order-success");
            return;
        }

        KeyStore activeKey = KeyDAO.getActiveKey(user.getId());
        if (activeKey == null) {
            session.setAttribute("keyMessage", "Bạn chưa có khóa. Vui lòng tạo khóa trước.");
            resp.sendRedirect("key");
            return;
        }

        OrderDAO.saveSignature(orderId, order.getCanonicalJson(), signature, activeKey.getId());
        resp.sendRedirect("order-success");
    }
}