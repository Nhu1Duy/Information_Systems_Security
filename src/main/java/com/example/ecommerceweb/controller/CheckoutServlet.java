package com.example.ecommerceweb.controller;

import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.model.CartItem;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.model.OrderItem;
import com.example.ecommerceweb.model.User;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

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
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        double total = 0;
        for (CartItem item : cart.values()) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        request.setAttribute("cartItems", cart.values());
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.isEmpty()) { response.sendRedirect("cart"); return; }
        if (user == null) { response.sendRedirect("login"); return; }

        double total = 0;
        for (CartItem item : cart.values()) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }

        Order order = new Order(total, user.getId());
        int orderId = OrderDAO.insertOrder(order);

        List<OrderItem> items = new ArrayList<>();
        for (CartItem ci : cart.values()) {
            OrderItem oi = new OrderItem();
            oi.setOrderId(orderId);
            oi.setProductId(ci.getProduct().getId());
            oi.setProductName(ci.getProduct().getName());
            oi.setQuantity(ci.getQuantity());
            oi.setPrice(ci.getProduct().getPrice());
            items.add(oi);
            OrderDAO.updateStock(ci.getProduct().getId(), ci.getQuantity());
        }
        OrderDAO.insertOrderItems(items);

        String canonicalJson = buildCanonicalJson(orderId, user, cart, total);
        OrderDAO.saveCanonicalJson(orderId, canonicalJson);

        session.removeAttribute("cart");
        response.sendRedirect("sign-order?orderId=" + orderId);
    }

    private String buildCanonicalJson(int orderId, User user,
                                      Map<Integer, CartItem> cart, double total) {
        TreeMap<String, Object> data = new TreeMap<>();
        data.put("order_id", orderId);
        data.put("user_id", user.getId());
        data.put("username", user.getUsername());
        data.put("total", total);
        data.put("created_at", new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                .format(new Date()));

        List<TreeMap<String, Object>> itemList = new ArrayList<>();
        cart.values().stream()
                .sorted(Comparator.comparingInt(ci -> ci.getProduct().getId()))
                .forEach(ci -> {
                    TreeMap<String, Object> item = new TreeMap<>();
                    item.put("product_id",   ci.getProduct().getId());
                    item.put("product_name", ci.getProduct().getName());
                    item.put("quantity",     ci.getQuantity());
                    item.put("price",        ci.getProduct().getPrice());
                    itemList.add(item);
                });
        data.put("items", itemList);

        return new GsonBuilder().disableHtmlEscaping().create().toJson(data);
    }
}