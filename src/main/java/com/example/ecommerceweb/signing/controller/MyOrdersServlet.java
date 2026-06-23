package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.signing.service.KeyService;
import com.example.ecommerceweb.signing.service.OrderService;
import com.example.ecommerceweb.signing.util.SignatureVerifier;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {
	private final OrderService orderService = new OrderService();
	private final KeyService keyService = new KeyService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			resp.sendRedirect("login");
			return;
		}
		String action = req.getParameter("action");
		if (action == null)
			action = "list";

		switch (action) {
		case "detail":
			int id = Integer.parseInt(req.getParameter("id"));
			Order order = orderService.getOrderById(id);
			if(order == null) {
				resp.sendRedirect("myOrders");
				return;
			}
			KeyStore key = keyService.getKeyById(order.getKeyId());
			req.setAttribute("detailKey", key);

			req.setAttribute("detailOrder", order);
			req.getRequestDispatcher("WEB-INF/sign/myOrderDetail.jsp").forward(req, resp);
			break;

		default:
			int userId = user.getId();

			List<Order> orders = OrderDAO.getOrdersByUserId(userId);
			orders = SignatureVerifier.verifyOrders(orders);

			req.setAttribute("orders", orders);
			req.setAttribute("currentPage", "myOrders");
			req.getRequestDispatcher("/WEB-INF/sign/myOrders.jsp").forward(req, resp);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}