// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;

import com.example.ecommerceweb.DAO.ProductDAO;
import com.example.ecommerceweb.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("shop.jsp");
            return;
        }
        int id = Integer.parseInt(idParam);

        Product product = ProductDAO.getProductById(id);

        request.setAttribute("product", product);

        request.getRequestDispatcher("WEB-INF/views/productDetail.jsp")
                .forward(request, response);
    }

}
