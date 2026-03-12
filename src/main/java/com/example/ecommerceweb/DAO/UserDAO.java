package com.example.ecommerceweb.DAO;

import com.example.ecommerceweb.model.User;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UserDAO {
    public static User checkLogin(String username, String password){
        Jdbi jdbi = JdbiConnector.get();
        try(Handle handle = jdbi.open()){
            return handle.createQuery("SELECT * FROM users WHERE username = :user AND password = :pass")
                    .bind("user", username)
                    .bind("pass", password)
                    .mapToBean(User.class)
                    .findOne()
                    .orElse(null);
        }
    }
    public static boolean register(User user){
        Jdbi jdbi = JdbiConnector.get();
        try(Handle handle = jdbi.open()){
            int rows = handle.createUpdate("INSERT INTO users(username, password) " +
                    "VALUES (:username, :password)")
                    .bindBean(user)
                    .execute();
            return rows > 0;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public static List<User> getAllUsers() {
        Jdbi jdbi = JdbiConnector.get();
        try(Handle handle = jdbi.open()){
            return  handle.createQuery("SELECT * FROM users").mapToBean(User.class).list();
        }
    }

    public static User getUserById(int id) {
        Jdbi jdbi = JdbiConnector.get();
        try(Handle handle = jdbi.open()) {
            return handle.createQuery("SELECT * FROM users WHERE id = :id")
                    .bind("id", id).mapToBean(User.class).findOne().orElse(null);
        }
    }

    public static void update(User user) {
        JdbiConnector.get().useHandle(handle ->
                handle.createUpdate("UPDATE users SET username=:username, role=:role, active=:active WHERE id=:id")
                        .bindBean(user).execute()
        );
    }

    public static void delete(int id) {
        JdbiConnector.get().useHandle(handle ->
                handle.createUpdate("DELETE FROM users WHERE id = :id").bind("id", id).execute()
        );
    }
}
