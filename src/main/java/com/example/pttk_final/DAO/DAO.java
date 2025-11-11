package com.example.pttk_final.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        try {
            // Check if connection is null or closed, then create/recreate it
            if (con == null || con.isClosed()) {
                String dbUrl = "jdbc:mysql://localhost:3306/pttk_final?useUnicode=true&characterEncoding=utf8&autoReconnect=true&useSSL=false&serverTimezone=UTC";
                String dbClass = "com.mysql.cj.jdbc.Driver";

                try {
                    Class.forName(dbClass);
                    con = DriverManager.getConnection(dbUrl, "root", "12345");
                    System.out.println("Database connection established successfully");
                } catch (Exception e) {
                    System.err.println("Error establishing database connection: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.err.println("Error checking database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
