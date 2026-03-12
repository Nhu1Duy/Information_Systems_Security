package com.example.ecommerceweb.DAO;

import com.example.ecommerceweb.model.Category;
import com.example.ecommerceweb.model.Unit;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UnitDAO {
    public static List<Unit> getAllUnits() {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            String sql = "SELECT * FROM units";
            return handle.createQuery(sql).mapToBean(Unit.class).list();
        }
    }
    public static void insertUnit(String name) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("INSERT INTO units(name) VALUES (:name)")
                    .bind("name", name).execute();
        }
    }

    public static void deleteUnit(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try (Handle handle = jdbi.open()) {
            handle.createUpdate("DELETE FROM units WHERE id = :id")
                    .bind("id", id).execute();
        }
    }
}
