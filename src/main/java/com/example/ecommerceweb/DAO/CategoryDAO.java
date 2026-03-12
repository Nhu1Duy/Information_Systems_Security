package com.example.ecommerceweb.DAO;

import com.example.ecommerceweb.model.Category;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryDAO {

    public static List<Category> getAllCategories() {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT * FROM categories";
            return handle.createQuery(sql).mapToBean(Category.class).list();
        }
    }
    public static void insert(Category category) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "INSERT INTO categories (name, image) VALUES (:name, :image)";
            handle.createUpdate(sql)
                    .bind("name", category.getName())
                    .bind("image", category.getImage())
                    .execute();
        }
    }
    public static void delete(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "DELETE FROM categories WHERE id = :id";
            handle.createUpdate(sql)
                    .bind("id", id)
                    .execute();
        }
    }

}
