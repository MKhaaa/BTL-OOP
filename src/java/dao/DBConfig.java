/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Admin
 */
public class DBConfig {
    public static String driver = "com.mysql.cj.jdbc.Driver";
    public static String url = "jdbc:mysql://localhost:3306/webphoneoop";
    public static String user = "root";
    public static String password = "322005";
    
    public static Connection getConnection(){
	Connection cnn = null;
	try{
	    Class.forName(DBConfig.driver);
	    cnn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
	    System.out.println("Connect Successful");
	}catch(Exception ex){
	    ex.printStackTrace();
	}
	return cnn;
    }
}
