package com.example.ecommerceweb.signing.dao;

import com.example.ecommerceweb.infor.JdbiConnector;
import com.example.ecommerceweb.signing.model.KeyStore;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class KeyDAO {

    public static int insertKey(int userId, String publicKeyPem) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            return h.createUpdate(
                            "INSERT INTO key_store(user_id, public_key, status) VALUES(:uid, :pk, 'ACTIVE')")
                    .bind("uid", userId)
                    .bind("pk", publicKeyPem)
                    .executeAndReturnGeneratedKeys()
                    .mapTo(Integer.class).one();
        }
    }

    public static KeyStore getActiveKey(int userId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            return h.createQuery(
                            "SELECT * FROM key_store WHERE user_id=:uid AND status='ACTIVE' " +
                                    "ORDER BY created_at DESC LIMIT 1")
                    .bind("uid", userId)
                    .mapToBean(KeyStore.class)
                    .findOne().orElse(null);
        }
    }

    public static KeyStore getKeyById(int keyId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            return h.createQuery("SELECT * FROM key_store WHERE id=:id")
                    .bind("id", keyId)
                    .mapToBean(KeyStore.class)
                    .findOne().orElse(null);
        }
    }

    public static void revokeAllActiveKeys(int userId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            h.createUpdate(
                            "UPDATE key_store SET status='REVOKED', revoked_at=NOW() " +
                                    "WHERE user_id=:uid AND status='ACTIVE'")
                    .bind("uid", userId).execute();
        }
    }

    public static List<KeyStore> getKeyHistory(int userId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            return h.createQuery(
                            "SELECT * FROM key_store WHERE user_id=:uid ORDER BY created_at DESC")
                    .bind("uid", userId)
                    .mapToBean(KeyStore.class).list();
        }
    }
}