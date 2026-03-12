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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        User account = UserDAO.checkLogin(user,pass);
        if (account != null) {
            if(!account.isActive()){
                session.setAttribute("authMessage", "Mai tao cho vô.");
                session.setAttribute("authType", "error");
                request.getRequestDispatcher("WEB-INF/views/login.jsp").forward(request, response);
            }else{
                session.setAttribute("user", account);
                session.setAttribute("authMessage", "Bỏ vào giỏ, MUA!.");
                session.setAttribute("authType", "success");
                response.sendRedirect("home");
            }
        }else{
            request.setAttribute("authMessage", "Saiiiiiiiii!");
            request.setAttribute("authType", "error");
            request.getRequestDispatcher("WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}

