package com.example.ecommerceweb.controller.sign;

import com.example.ecommerceweb.DAO.KeyDAO;
import com.example.ecommerceweb.model.KeyStore;
import com.example.ecommerceweb.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.util.Base64;
import java.util.List;

@WebServlet("/key")
public class KeyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect("login"); return; }

        KeyStore activeKey = KeyDAO.getActiveKey(user.getId());
        List<KeyStore> keyHistory = KeyDAO.getKeyHistory(user.getId());

        req.setAttribute("activeKey", activeKey);
        req.setAttribute("keyHistory", keyHistory);
        req.getRequestDispatcher("/WEB-INF/sign/key-management.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect("login"); return; }

        String action = req.getParameter("action");

        if ("generate".equals(action)) {
            try {
                KeyPairGenerator gen = KeyPairGenerator.getInstance("RSA");
                gen.initialize(2048);
                KeyPair pair = gen.generateKeyPair();

                String pubB64 = Base64.getEncoder().encodeToString(pair.getPublic().getEncoded());
                String pubPem = "-----BEGIN PUBLIC KEY-----\n" + pubB64 + "\n-----END PUBLIC KEY-----";

                String privB64 = Base64.getEncoder().encodeToString(pair.getPrivate().getEncoded());
                String privPem = "-----BEGIN PRIVATE KEY-----\n" + privB64 + "\n-----END PRIVATE KEY-----";

                KeyDAO.insertKey(user.getId(), pubPem);

                resp.setContentType("application/octet-stream");
                resp.setHeader("Content-Disposition",
                        "attachment; filename=private_key_" + user.getUsername() + ".pem");
                resp.getWriter().write(privPem);

                pair = null;
                System.gc();

            } catch (Exception e) {
                session.setAttribute("keyMessage", "Lỗi sinh khóa: " + e.getMessage());
                resp.sendRedirect("key");
            }

        } else if ("revoke".equals(action)) {
            KeyDAO.revokeAllActiveKeys(user.getId());
            session.setAttribute("keyMessage",
                    "Đã thu hồi khóa cũ. Hãy tạo khóa mới để tiếp tục ký đơn hàng.");
            resp.sendRedirect("key");
        }
    }
}