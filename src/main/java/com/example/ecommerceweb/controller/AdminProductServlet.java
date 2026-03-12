// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;
import java.util.List;

import com.example.ecommerceweb.DAO.CategoryDAO;
import com.example.ecommerceweb.DAO.ProductDAO;
import com.example.ecommerceweb.DAO.UnitDAO;
import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Product;
import com.example.ecommerceweb.model.Unit;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/adminProduct")
public class AdminProductServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException , ServletException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.setAttribute("categories", CategoryDAO.getAllCategories());
                request.setAttribute("units", UnitDAO.getAllUnits());
                request.getRequestDispatcher("WEB-INF/adminView/productForm.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Product existingProduct = ProductDAO.getProductById(id);
                request.setAttribute("product", existingProduct);
                request.setAttribute("categories", CategoryDAO.getAllCategories());
                request.setAttribute("units", UnitDAO.getAllUnits());
                request.getRequestDispatcher("WEB-INF/adminView/productForm.jsp").forward(request, response);
                break;
            case "delete":
                ProductDAO.delete(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("adminProduct");
                break;
            default:
                request.setAttribute("products", ProductDAO.getAllProductsForHome());
                request.getRequestDispatcher("WEB-INF/adminView/adminProduct.jsp").forward(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = request.getParameter("id").isEmpty() ? 0 : Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        String image = request.getParameter("image");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int unitId = Integer.parseInt(request.getParameter("unitId"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setPrice(price);
        p.setDescription(description);
        p.setImage(image);
        p.setCategory(new Category(categoryId));
        p.setUnit(new Unit(unitId));
        p.setStock(stock);

        if (id == 0) ProductDAO.insert(p);
        else ProductDAO.update(p);

        response.sendRedirect("adminProduct");
    }

}
