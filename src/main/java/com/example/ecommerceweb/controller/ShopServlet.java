// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;
import java.util.List;

import com.example.ecommerceweb.DAO.CategoryDAO;
import com.example.ecommerceweb.DAO.ProductDAO;
import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");
        String searchQuery = request.getParameter("search");
        String sort = request.getParameter("sort");
        List<Category> categories = CategoryDAO.getAllCategories();

        List<Product> products = ProductDAO.getFilteredProducts(searchQuery, categoryId, sort);
        if (searchQuery != null && !searchQuery.isEmpty()) {
            request.setAttribute("searchTitle", "Kết quả cho: '" + searchQuery + "'");
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("WEB-INF/views/shop.jsp").forward(request, response);
    }
}
