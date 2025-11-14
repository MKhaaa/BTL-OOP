package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    static {
        try { Class.forName(DBConfig.driver); }
        catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
    }
    public static String url =
  "jdbc:mysql://localhost:3306/webphoneoop"
+ "?useUnicode=true&characterEncoding=UTF-8"
+ "&serverTimezone=Asia/Ho_Chi_Minh"
+ "&allowPublicKeyRetrieval=true&useSSL=false";

}
