// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;
import java.util.List;

import com.example.ecommerceweb.DAO.OrderDAO;
import com.example.ecommerceweb.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
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

            default:
                List<Order> orders = OrderDAO.getAllOrders();
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("WEB-INF/adminView/adminOrder.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
