// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;
import java.util.List;

import com.example.ecommerceweb.DAO.ProductDAO;
import com.example.ecommerceweb.DAO.CategoryDAO;
import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        List<Product> products = ProductDAO.getAllProductsForHome();
        List<Category> categories = CategoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("WEB-INF/views/index.jsp")
                .forward(request, response);
    }

}
