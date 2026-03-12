package com.example.ecommerceweb.controller;

import com.example.ecommerceweb.DAO.ProductDAO;
import com.example.ecommerceweb.model.CartItem;
import com.example.ecommerceweb.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>)session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        if (action == null) {
            double total = 0;
            for (CartItem item : cart.values()) {
                total += item.getProduct().getPrice() * item.getQuantity();
            }
            request.setAttribute("cartItems", cart.values());
            request.setAttribute("cartTotal", total);
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp")
                    .forward(request, response);
        } else if (action.equals("remove")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.remove(productId);
            response.sendRedirect("cart");
        }
    }
    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantityInput = 1;
        try {
            String qtyStr = request.getParameter("quantity");
            if (qtyStr != null && !qtyStr.isEmpty()) {
                quantityInput = Integer.parseInt(qtyStr);
            }
        } catch (NumberFormatException e) {
            quantityInput = 1;
        }
        HttpSession session = request.getSession();
        Map<Integer,CartItem> cart = (Map<Integer, CartItem>)  session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }


        if (action.equals("add") || action.equals("buynow")) {
            CartItem item = cart.get(productId);

            if (item != null) {
                item.setQuantity(item.getQuantity() + quantityInput);
            } else {
                Product product = ProductDAO.getProductById(productId);
                System.out.println("PRODUCT: " + product);
                if (product != null) {
                    cart.put(productId, new CartItem(product, quantityInput));
                }
            }
            if(action.equals("add")) {response.sendRedirect("cart");}
            if(action.equals("buynow")) {response.sendRedirect("checkout");}
        }
        else if (action.equals("increase")) {
                CartItem item = cart.get(productId);
                if (item != null) {
                    item.setQuantity(item.getQuantity() + 1);
                }
                response.sendRedirect("cart");
            }
        else if (action.equals("decrease")) {
            CartItem item = cart.get(productId);
            if (item != null) {
                int newQty = item.getQuantity() - 1;
                if (newQty <= 0) {
                    cart.remove(productId);
                } else {
                    item.setQuantity(newQty);
                }
            }
            response.sendRedirect("cart");
        }
    }

}


