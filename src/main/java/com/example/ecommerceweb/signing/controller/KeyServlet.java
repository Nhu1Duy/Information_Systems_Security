package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.util.RsaKeyCodec;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.KeyPair;
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
        String keyMessage = (String) session.getAttribute("keyMessage");
        String generatedPrivateKey = (String) session.getAttribute("generatedPrivateKey");
        String generatedPrivateKeyFileName = (String) session.getAttribute("generatedPrivateKeyFileName");

        req.setAttribute("activeKey", activeKey);
        req.setAttribute("keyHistory", keyHistory);
        req.setAttribute("keyMessage", keyMessage);
        req.setAttribute("generatedPrivateKey", generatedPrivateKey);
        req.setAttribute("generatedPrivateKeyFileName", generatedPrivateKeyFileName);
        session.removeAttribute("keyMessage");

        req.getRequestDispatcher("/WEB-INF/sign/key-management.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { resp.sendRedirect("login"); return; }

        String action = req.getParameter("action");

        if ("generate".equals(action)) {
            generateKey(user, session, resp);
        } else if ("revoke".equals(action)) {
            revokeKey(user, session, resp);
        } else if ("download-generated-key".equals(action)) {
            downloadGeneratedKey(user, session, resp);
        } else if ("clear-generated-key".equals(action)) {
            clearGeneratedKey(session, resp);
        } else {
            resp.sendRedirect("key");
        }
    }

    private void generateKey(User user, HttpSession session, HttpServletResponse resp) throws IOException {
        try {
            //tạo khóa mới sau khi báo mất
            KeyStore activeKey = KeyDAO.getActiveKey(user.getId());
            if (activeKey != null) {
                session.setAttribute("keyMessage", "Bạn cần báo mất/thu hồi khóa hiện tại trước khi tạo khóa mới.");
                resp.sendRedirect("key");
                return;
            }

            KeyPair pair = RsaKeyCodec.generateKeyPair();
            String pubB64 = RsaKeyCodec.encodePublicKey(pair.getPublic());
            String privB64 = RsaKeyCodec.encodePrivateKey(pair.getPrivate());

            KeyDAO.insertKey(user.getId(), pubB64);

            //chọn cách lưu khóa
            session.setAttribute("generatedPrivateKey", privB64);
            session.setAttribute("generatedPrivateKeyFileName", "private_key_" + user.getUsername() + ".pem");
            session.setAttribute("keyMessage", "Đã tạo khóa mới, hãy lưu khóa và không chia sẽ khóa với bất kì ai.");

            pair = null;
            System.gc();
            resp.sendRedirect("key");
        } catch (Exception e) {
            session.setAttribute("keyMessage", "Lỗi tạo khóa: " + e.getMessage());
            resp.sendRedirect("key");
        }
    }

    private void revokeKey(User user, HttpSession session, HttpServletResponse resp) throws IOException {
        KeyDAO.revokeAllActiveKeys(user.getId());
        session.setAttribute("keyMessage", "Đã báo mất và thu hồi khóa hiện tại. Có thể tạo khóa bất kì khi nào.");
        resp.sendRedirect("key");
    }

    private void downloadGeneratedKey(User user, HttpSession session, HttpServletResponse resp) throws IOException {
        String privateKey = (String) session.getAttribute("generatedPrivateKey");
        String fileName = (String) session.getAttribute("generatedPrivateKeyFileName");
        if (privateKey == null || privateKey.isBlank()) {
            session.setAttribute("keyMessage", "Không tìm thấy khóa của bạn. Hãy tạo khóa mới.");
            resp.sendRedirect("key");
            return;
        }

        if (fileName == null || fileName.isBlank()) {
            fileName = "private_key_" + user.getUsername() + ".pem";
        }

        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        resp.getWriter().write(privateKey);
    }

    private void clearGeneratedKey(HttpSession session, HttpServletResponse resp) throws IOException {
        //xóa key khỏi session
        session.removeAttribute("generatedPrivateKey");
        session.removeAttribute("generatedPrivateKeyFileName");
        resp.sendRedirect("key");
    }
}
