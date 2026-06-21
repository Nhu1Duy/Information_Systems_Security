package com.example.ecommerceweb.signing.controller;

import com.example.ecommerceweb.model.User;
import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.service.KeyService;
import com.example.ecommerceweb.signing.util.RsaKeyCodec;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.KeyPair;
import java.security.PublicKey;
import java.util.List;

@WebServlet("/key")
public class KeyServlet extends HttpServlet {
    private KeyService keyService = new KeyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        KeyStore activeKey = keyService.getActiveKey(user.getId());
        List<KeyStore> keyHistory = keyService.getKeyHistory(user.getId());
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
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }

        String action = req.getParameter("action");

        if ("generate".equals(action)) {
            generateKey(user, session, resp);
        } else if ("use-own-public-key".equals(action)) {
            useOwnPublicKey(req, user, session, resp);
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
            KeyService.GenerateKeyResult result = keyService.generateKey(user.getId(), user.getUsername());
            session.setAttribute("generatedPrivateKey", result.privateKeyB64);
            session.setAttribute("generatedPrivateKeyFileName",
                    "private_key_" + user.getUsername() + ".pem");
            session.setAttribute("keyMessage", result.message);
        } catch (IllegalStateException e) {
            session.setAttribute("keyMessage", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("keyMessage", "Lỗi tạo khóa: " + e.getMessage());
        }
        resp.sendRedirect("key");
    }

    private void useOwnPublicKey(HttpServletRequest req, User user, HttpSession session, HttpServletResponse resp) throws IOException {
        try {
            keyService.useOwnPublicKey(user.getId(), req.getParameter("ownPublicKey"));
            session.setAttribute("keyMessage",
                    "Đã lưu public key của bạn. Từ bây giờ hệ thống sẽ dùng public key này để xác minh chữ ký.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            session.setAttribute("keyMessage", e.getMessage());
        } catch (Exception e) {
            session.setAttribute("keyMessage",
                    "Public key không hợp lệ. Hãy kiểm tra lại định dạng RSA public key.");
        }
        resp.sendRedirect("key");
    }

    private void revokeKey(User user, HttpSession session, HttpServletResponse resp) throws IOException {
        keyService.revokeKey(user.getId());
        session.setAttribute("keyMessage",
                "Đã báo mất và thu hồi khóa hiện tại. Có thể tạo khóa bất kì khi nào.");
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
