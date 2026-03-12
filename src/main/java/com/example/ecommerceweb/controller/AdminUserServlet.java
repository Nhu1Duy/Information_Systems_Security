package com.example.ecommerceweb.controller;
import com.example.ecommerceweb.DAO.UserDAO;
import com.example.ecommerceweb.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/adminUser")
public class AdminUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("userEdit", UserDAO.getUserById(id));
                request.getRequestDispatcher("WEB-INF/adminView/userForm.jsp").forward(request, response);
                break;
            case "delete":
                UserDAO.delete(Integer.parseInt(request.getParameter("id")));
                request.getSession().setAttribute("authMessage", "Mất rồi!");
                request.getSession().setAttribute("authType", "success");
                response.sendRedirect("adminUser");
                break;
            default:
                request.setAttribute("users", UserDAO.getAllUsers());
                request.getRequestDispatcher("WEB-INF/adminView/adminUser.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String role = request.getParameter("role");
        boolean active = request.getParameter("active") != null;

        User user = UserDAO.getUserById(id);
            user.setRole(role);
            user.setActive(active);
            UserDAO.update(user);
            request.getSession().setAttribute("authMessage", "Cập nhập ròi!");
            request.getSession().setAttribute("authType", "success");
        response.sendRedirect("adminUser");
    }
}