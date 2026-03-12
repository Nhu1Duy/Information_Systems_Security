// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.CartItem;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.model.OrderItem;
import com.example.ecommerceweb.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("authMessage", "Vui lòng đăng nhập để thanh toán!");
            session.setAttribute("authType", "error");
            response.sendRedirect("login");
            return;
        }
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>)session.getAttribute("cart");
        double total = 0;
        for (CartItem item : cart.values()) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        request.setAttribute("cartItems", cart.values());
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        double total = 0;
        for (CartItem item : cart.values()) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
            Order order = new Order(total, user.getId());
            int orderId = OrderDAO.insertOrder(order);

            List<OrderItem> items = new ArrayList<>();
            for (CartItem ci : cart.values()) {
                OrderItem oi = new OrderItem();
                oi.setProductId(ci.getProduct().getId());
                oi.setQuantity(ci.getQuantity());
                oi.setPrice(ci.getProduct().getPrice());
                items.add(oi);
                OrderDAO.updateStock(ci.getProduct().getId(), ci.getQuantity());
            }
            OrderDAO.insertOrderItems(items);

            session.removeAttribute("cart");
            response.sendRedirect("order-success");
    }
}

