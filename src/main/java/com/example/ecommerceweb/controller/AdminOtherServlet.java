// Source - https://stackoverflow.com/a/77403079
// Posted by Ali, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-06, License - CC BY-SA 4.0

package com.example.ecommerceweb.controller;

import java.io.*;

import com.example.ecommerceweb.DAO.CategoryDAO;
import com.example.ecommerceweb.DAO.UnitDAO;
import com.example.ecommerceweb.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/adminOther")
public class AdminOtherServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");
        if ("deleteCat".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                CategoryDAO.delete(id);
                request.getSession().setAttribute("authMessage", "Xóa danh mục thành công!");
                request.getSession().setAttribute("authType", "success");
            } catch (Exception e) {
                request.getSession().setAttribute("authMessage", "Lỗi: Không thể xóa mục này vì có dữ liệu liên quan!");
                request.getSession().setAttribute("authType", "error");
            }
            response.sendRedirect("adminOther");
            return;
        } else if ("deleteUnit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                UnitDAO.deleteUnit(id);
                request.getSession().setAttribute("authMessage", "Xóa đơn vị thành công!");
                request.getSession().setAttribute("authType", "success");
            } catch (Exception e) {
                request.getSession().setAttribute("authMessage", "Lỗi: Không thể xóa mục này vì có dữ liệu liên quan!");
                request.getSession().setAttribute("authType", "error");
            }
            response.sendRedirect("adminOther");
            return;
        }
        request.setAttribute("categories", CategoryDAO.getAllCategories());
        request.setAttribute("units", UnitDAO.getAllUnits());
        request.getRequestDispatcher("WEB-INF/adminView/adminOther.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        if ("category".equals(type)) {
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            Category c = new Category();
            c.setName(name);
            c.setImage(image);
            CategoryDAO.insert(c);
        } else if ("unit".equals(type)) {
            String name = request.getParameter("name");
            UnitDAO.insertUnit(name);
        }

        response.sendRedirect("adminOther");
    }

}
