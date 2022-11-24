package com.koreait.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbconn {
    private static Connection conn;   //메모리에 계속 살아있을것임
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:mysql://localhost/aidev?useSSL=false&allowPublicKeyRetrieval=true";
        String uid = "root";
        String upw = "83140201";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, uid, upw);

        return conn;
    }
}