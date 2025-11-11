package com.example.pttk_final.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/pttk_final?useUnicode=true&characterEncoding=utf8&autoReconnect=true&useSSL=false";
            String dbClass = "com.mysql.cj.jdbc.Driver";

            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "12345"); // Thay "password" bằng mật khẩu của bạn
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
