// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;

import com.example.ecommerceweb.DAO.UserDAO;
import com.example.ecommerceweb.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/signup.jsp")
                .forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User newUser = new User();
        newUser.setUsername(request.getParameter("username"));
        newUser.setPassword(request.getParameter("password"));
        HttpSession session = request.getSession();
        if (UserDAO.register(newUser)) {
            session.setAttribute("authMessage", "Đăng kí thành công! Vui lòng đăng nhập.");
            session.setAttribute("authType", "success");
            response.sendRedirect("login");
        } else {
            request.setAttribute("authMessage", "Tên đã tồn tại!");
            request.setAttribute("authType", "error");
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
        }
    }
}
