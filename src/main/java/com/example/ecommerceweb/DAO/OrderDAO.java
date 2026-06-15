package com.example.ecommerceweb.DAO;

import com.example.ecommerceweb.infor.JdbiConnector;
import com.example.ecommerceweb.model.Order;
import com.example.ecommerceweb.model.OrderItem;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.util.List;

public class OrderDAO {

    public static int insertOrder(Order order) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "INSERT INTO orders(total, user_id) VALUES(:total, :userId)";
            return handle.createUpdate(sql)
                    .bind("total", order.getTotal())
                    .bind("userId", order.getUserId())
                    .executeAndReturnGeneratedKeys()
                    .mapTo(Integer.class)
                    .one();
        }
    }

    public static void insertOrderItems(List<OrderItem> items) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "INSERT INTO order_items(order_id, product_id, quantity, price) " +
                    "VALUES(:orderId, :productId, :quantity, :price)";
            PreparedBatch batch = handle.prepareBatch(sql);
            for (OrderItem item : items) {
                batch.bind("orderId", item.getOrderId())
                        .bind("productId", item.getProductId())
                        .bind("quantity", item.getQuantity())
                        .bind("price", item.getPrice())
                        .add();
            }
            batch.execute();
        }
    }

    public static void updateStock(int productId, int quantity) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "UPDATE products SET stock = stock - :quantity WHERE id = :id";
            handle.createUpdate(sql)
                    .bind("quantity", quantity)
                    .bind("id", productId)
                    .execute();
        }
    }

    public static List<Order> getAllOrders() {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT o.id, o.order_date as orderDate, o.total, o.user_id as userId, " +
                    "u.username as customerName, o.status, " +
                    "o.canonical_json as canonicalJson, o.signature, " +
                    "o.sig_status as sigStatus, o.key_id as keyId " +
                    "FROM orders o JOIN users u ON o.user_id = u.id " +
                    "ORDER BY o.order_date DESC";
            return handle.createQuery(sql)
                    .mapToBean(Order.class)
                    .list();
        }
    }

    public static Order getOrderById(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT o.id, o.order_date as orderDate, o.total, o.user_id as userId, " +
                    "o.status, o.canonical_json as canonicalJson, o.signature, " +
                    "o.sig_status as sigStatus, o.key_id as keyId " +
                    "FROM orders o WHERE o.id = :id";
            return handle.createQuery(sql)
                    .bind("id", id)
                    .mapToBean(Order.class)
                    .findOne().orElse(null);
        }
    }

    // Lưu canonical_json + signature sau khi user ký xong
    public static void saveSignature(int orderId, String canonicalJson,
                                     String signature, int keyId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            h.createUpdate(
                            "UPDATE orders SET canonical_json=:cj, signature=:sig, " +
                                    "sig_status='SIGNED', key_id=:kid WHERE id=:id")
                    .bind("cj", canonicalJson)
                    .bind("sig", signature)
                    .bind("kid", keyId)
                    .bind("id", orderId)
                    .execute();
        }
    }

    // Cập nhật kết quả verify
    public static void updateSigStatus(int orderId, String sigStatus) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            h.createUpdate("UPDATE orders SET sig_status=:ss WHERE id=:id")
                    .bind("ss", sigStatus)
                    .bind("id", orderId)
                    .execute();
        }
    }

    public static void updateStatus(int id, String status) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("UPDATE orders SET status = :status WHERE id = :id")
                    .bind("status", status)
                    .bind("id", id)
                    .execute();
        }
    }

    public static void delete(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("DELETE FROM orders WHERE id = :id")
                    .bind("id", id)
                    .execute();
        }
    }

    public static void saveCanonicalJson(int orderId, String canonicalJson) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle h = jdbi.open()) {
            h.createUpdate("UPDATE orders SET canonical_json=:cj WHERE id=:id")
                    .bind("cj", canonicalJson)
                    .bind("id", orderId)
                    .execute();
        }
    }
    public static List<Order> getOrdersByUserId(int userId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT o.id, o.order_date as orderDate, o.total, o.user_id as userId, " +
                    "u.username as customerName, o.status, " +
                    "o.canonical_json as canonicalJson, o.signature, " +
                    "o.sig_status as sigStatus, o.key_id as keyId " +
                    "FROM orders o JOIN users u ON o.user_id = u.id " +
                    "WHERE o.user_id = :userId " +
                    "ORDER BY o.order_date DESC";
            return handle.createQuery(sql)
                    .bind("userId", userId)
                    .mapToBean(Order.class)
                    .list();
        }
    }
}