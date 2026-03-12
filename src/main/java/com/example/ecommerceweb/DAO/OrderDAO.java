package com.example.ecommerceweb.DAO;

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
            String sql = "INSERT INTO order_items(order_id, product_id, quantity, price) VALUES(:orderId, :productId, :quantity, :price)";
            PreparedBatch batch = handle.prepareBatch(sql); // Thực thi sau vòng For (tối ưu)
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
            // SQL join để lấy customerName từ bảng users
            String sql = "SELECT o.id, o.order_date as orderDate, o.total, o.user_id as userId, " +
                    "u.username as customerName, o.status " +
                    "FROM orders o JOIN users u ON o.user_id = u.id " +
                    "ORDER BY o.order_date DESC";

            return handle.createQuery(sql)
                    .mapToBean(Order.class)
                    .list();
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
}

