package com.example.ecommerceweb.signing.service;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.util.RsaKeyCodec;

import java.security.KeyPair;
import java.security.PublicKey;
import java.util.List;

public class KeyService {

    public static class GenerateKeyResult {
        public final String privateKeyB64;
        public final String message;

        public GenerateKeyResult(String privateKeyB64, String message) {
            this.privateKeyB64 = privateKeyB64;
            this.message = message;
        }
    }

    public KeyStore getActiveKey(int userId) {
        return KeyDAO.getActiveKey(userId);
    }

    public List<KeyStore> getKeyHistory(int userId) {
        return KeyDAO.getKeyHistory(userId);
    }

    public KeyStore getKeyById(int keyId) {
        return KeyDAO.getKeyById(keyId);
    }

    public GenerateKeyResult generateKey(int userId, String username) throws Exception {
        if (KeyDAO.getActiveKey(userId) != null) {
            throw new IllegalStateException("Bạn cần báo mất/thu hồi khóa hiện tại trước khi tạo khóa mới.");
        }

        KeyPair pair = RsaKeyCodec.generateKeyPair();
        String pubB64 = RsaKeyCodec.encodePublicKey(pair.getPublic());
        String privB64 = RsaKeyCodec.encodePrivateKey(pair.getPrivate());

        KeyDAO.insertKey(userId, pubB64);

        pair = null;
        System.gc();

        return new GenerateKeyResult(privB64, "Đã tạo khóa mới, hãy lưu khóa và không chia sẻ khóa với bất kì ai.");
    }

    public void useOwnPublicKey(int userId, String publicKeyText) throws Exception {
        if (publicKeyText == null || publicKeyText.isBlank()) {
            throw new IllegalArgumentException("Hãy nhập public key của bạn.");
        }
        if (KeyDAO.getActiveKey(userId) != null) {
            throw new IllegalStateException("Bạn cần báo mất/thu hồi khóa hiện tại trước khi dùng public key mới.");
        }

        PublicKey publicKey = RsaKeyCodec.decodePublicKey(publicKeyText);
        String normalized = RsaKeyCodec.encodePublicKey(publicKey);
        KeyDAO.insertKey(userId, normalized);
    }

    public void revokeKey(int userId) {
        KeyDAO.revokeAllActiveKeys(userId);
    }
}