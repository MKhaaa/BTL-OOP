/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Brand;

/**
 *
 * @author Admin
 */
public class BrandDAO {
    
    public static ArrayList<Brand> getBrandList(){
	try(Connection c = DBConfig.getConnection()){
	    String sql = "SELECT * FROM brands";
	    PreparedStatement ps = c.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();
	    
	    ArrayList<Brand> list = new ArrayList<>();
	    while(rs.next()){
		list.add(new Brand(rs.getInt("id"), rs.getString("name")));
	    }
	    return list;
	    
	}catch(SQLException e){
	    e.printStackTrace();
	}
	return null;
    }
}
