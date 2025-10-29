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
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import model.Product;
import model.ProductSpec;

/**
 *
 * @author Admin
 */
public class ProductDAO {
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
    public static ArrayList<Product> getProductList(String sortField, String sortOrder, String brandId, int page, int pageSize){
	if(sortField != null && sortField.equals("sale-rate")){
	    sortField = "sale_rate";
	    sortOrder = "DESC";
	}
	List<String> allowedFields = Arrays.asList("price", "sale_rate");
	List<String> allowedOrders = Arrays.asList("ASC", "DESC");
	if (sortField == null || !allowedFields.contains(sortField)) {
	    sortField = "p.id"; // mặc định
	    sortOrder = "ASC";
	}
	if (!allowedOrders.contains(sortOrder.toUpperCase())) {
	    sortOrder = "ASC"; // mặc định
	}
	
	if(brandId == null){
	    brandId = "1 = 1";
	}
	else{
	    brandId = "p.brand_id = " + brandId;
	}
	
	int offset = (page - 1) * pageSize;
	try(Connection c = getConnection()){
	    String sql = String.format("SELECT *, promo_price AS price, 1.0 * (original_price - promo_price) / original_price * 100 AS sale_rate "
		       + "FROM products p "
		       + "JOIN product_images i "
		       + "ON p.id = i.product_id "
		       + "WHERE i.is_main = 1 AND %s "
		       + "ORDER BY %s %s "
		       + "LIMIT %d, %d", brandId, sortField, sortOrder, offset, pageSize);
	    PreparedStatement ps = c.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();
	    System.out.println(ps.toString());
	    
	    ArrayList<Product> list = new ArrayList<>();
	    while(rs.next()){
		ArrayList<String> imgs = new ArrayList<>();
		imgs.add(rs.getString("image_url"));
		list.add(new Product(rs.getInt("id"), rs.getString("name"), rs.getInt("original_price"), 
			rs.getInt("promo_price"), rs.getDouble("sale_rate"), imgs ));
	    }
	    return list;
	    
	}catch(SQLException e){
	    e.printStackTrace();
	}
	return null;
    }
    public static int countProducts(String brandId){
	try(Connection c = getConnection()){
	    String sql = "SELECT COUNT(*) AS cnt FROM products p ";
	    if(brandId != null){
		sql += "WHERE p.brand_id = " + brandId;
	    }
	    PreparedStatement ps = c.prepareStatement(sql);
	    ResultSet rs = ps.executeQuery();
	    if(rs.next()){
		return rs.getInt("cnt");
	    }
	}catch(SQLException e){
	    e.printStackTrace();
	}
	return 0;
    }
    // Lấy chi tiết sản phẩm theo ID (bao gồm main + tất cả ảnh thumbnail + specs)
    public static Product getProductById(int id) {
        String sql = "SELECT i.image_url, p.id, p.name, p.original_price, p.promo_price, " +
                     "1.0 * (p.original_price - p.promo_price) / p.original_price * 100 AS sale_rate " +
                     "FROM products p " +
                     "JOIN product_images i ON p.id = i.product_id " +
                     "WHERE p.id = ?";
        try(Connection c = getConnection()){
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            ArrayList<String> imgs = new ArrayList<>();
            Product product = null;
            while(rs.next()){
                imgs.add(rs.getString("image_url"));
                if(product == null){ // chỉ tạo Product 1 lần
                    product = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("original_price"),
                            rs.getInt("promo_price"),
                            rs.getDouble("sale_rate"),
                            imgs
                    );
                }
            }

            // Lấy thông số sản phẩm và loại trùng
            if(product != null){
                List<ProductSpec> specs = getSpecsByProductId(product.getId());
                product.setSpecs(specs);
            }

            return product;
        } catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }

    // Hàm lấy danh sách specs theo product_id, loại bỏ trùng
    public static List<ProductSpec> getSpecsByProductId(int productId) {
        List<ProductSpec> specs = new ArrayList<>();
        String sql = "SELECT spec_name, spec_value FROM product_spec WHERE product_id = ?";
        try(Connection c = getConnection();
            PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            Set<String> seen = new LinkedHashSet<>();
            while(rs.next()){
                String name = rs.getString("spec_name");
                String value = rs.getString("spec_value");
                String key = name + "::" + value;
                if(!seen.contains(key)){
                    seen.add(key);
                    specs.add(new ProductSpec(name, value));
                }
            }

        } catch(SQLException e){
            e.printStackTrace();
        }
        return specs;
    }
}
