package com.example.ecommerceweb.DAO;

import org.jdbi.v3.core.Jdbi;

public class JdbiConnector {
    private static Jdbi jdbi;

    // SINGLETON
    public static Jdbi get() {
        if (jdbi == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3306/ecommerceweb?useSSL=false&serverTimezone=UTC";
                String user = "root";
                String password = "";
                jdbi = Jdbi.create(url, user, password);

                System.out.println("Success");
            } catch (ClassNotFoundException e) {
                System.out.println("Driver not found");
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        return jdbi;
    }
}