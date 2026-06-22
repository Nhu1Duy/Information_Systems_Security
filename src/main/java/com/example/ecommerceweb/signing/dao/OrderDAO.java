package com.example.ecommerceweb.signing.dao;

import com.example.ecommerceweb.infor.JdbiConnector;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.model.OrderItem;
import com.example.ecommerceweb.signing.model.OrderStatus;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.text.SimpleDateFormat;
import java.util.*;

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
            String sql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price)\n" +
                    "VALUES (:orderId, :productId, :productName, :quantity, :price)";
            PreparedBatch batch = handle.prepareBatch(sql);
            for (OrderItem item : items) {
                batch.bind("orderId", item.getOrderId())
                        .bind("productId", item.getProductId())
                        .bind("productName", item.getProductName())
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

    public static void updateStatus(int id, OrderStatus status) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("UPDATE orders SET status = :status WHERE id = :id")
                    .bind("status", status.name())
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

    public static String buildCanonicalJsonFromDB(int orderId) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String orderSql = "SELECT o.id, o.total, o.user_id, u.username, o.order_date FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = :id";  Map<String, Object> order = handle.createQuery(orderSql)
                    .bind("id", orderId)
                    .mapToMap()
                    .findOne()
                    .orElse(null);
            if (order == null) return null;
            String itemSql = "SELECT product_id, product_name, quantity, price FROM order_items WHERE order_id = :orderId ORDER BY product_id ASC";

            List<Map<String, Object>> items = handle.createQuery(itemSql)
                    .bind("orderId", orderId)
                    .mapToMap()
                    .list();

            TreeMap<String, Object> result = new TreeMap<>();
            result.put("created_at", formatTimestamp(order.get("order_date")));
            result.put("order_id",   order.get("id"));
            result.put("total",      order.get("total"));
            result.put("user_id",    order.get("user_id"));
            result.put("username",   order.get("username"));

            List<TreeMap<String, Object>> itemList = new ArrayList<>();
            for (Map<String, Object> item : items) {
                TreeMap<String, Object> i = new TreeMap<>();
                i.put("price",        item.get("price"));
                i.put("product_id",   item.get("product_id"));
                i.put("product_name", item.get("product_name"));
                i.put("quantity",     item.get("quantity"));
                itemList.add(i);
            }
            result.put("items", itemList);

            return new GsonBuilder().disableHtmlEscaping().create().toJson(result);
        }
    }
    private static String formatTimestamp(Object orderDate) {
        if (orderDate instanceof java.sql.Timestamp) {
            return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                    .format((java.sql.Timestamp) orderDate);
        }
        return orderDate != null ? orderDate.toString() : "";
    }
}