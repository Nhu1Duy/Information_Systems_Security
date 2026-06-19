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
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {       
            case "detail":
                int detailId = Integer.parseInt(req.getParameter("id"));
                Order detailOrder = OrderDAO.getOrderById(detailId);
                KeyStore detailKey = null;
                if (detailOrder != null && detailOrder.getKeyId() > 0) {
                	detailKey = KeyDAO.getKeyById(detailOrder.getKeyId());
                    req.setAttribute("detailKey", detailKey);
                }
                if(detailKey != null) {
                    Date revokedKeyDate = detailKey.getRevokedAt() != null ? 
                    		Date.from(detailKey.getRevokedAt().atZone(ZoneId.systemDefault()).toInstant()) : null;
                    req.setAttribute("revokedDate", revokedKeyDate);
                }
                req.setAttribute("detailOrder", detailOrder);
                req.getRequestDispatcher("WEB-INF/sign/myOrderDetail.jsp")
                        .forward(req, resp);
                break;

            default:
            	int userId = user.getId();
                List<Order> orders = OrderDAO.getOrdersByUserId(userId);
                orders = SignatureVerifier.verifyOrders(orders);
              
                KeyStore lastestKey = KeyDAO.getActiveKey(userId);
                // Vì createdAt trong key là LocalDateTime nên chuyển sang kiểu Date để thực hiện so sánh trong jsp
                Date lastestKeyDate = lastestKey != null ?
                		Date.from(lastestKey.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant()) : null;
                
                req.setAttribute("keyDate", lastestKeyDate);
                req.setAttribute("orders", orders);
                req.setAttribute("currentPage", "myOrders");
                req.getRequestDispatcher("/WEB-INF/sign/myOrders.jsp").forward(req, resp);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	doGet(req, resp);    
    }
}