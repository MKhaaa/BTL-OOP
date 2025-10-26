package dao;

import java.sql.*;
import model.Cart;
import model.CartItem;

public class CartDAO {
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
    //Lấy thông tin giỏ hàng người dùng
    public Cart getCartByUserId(int userId){
        Cart cart = new Cart(userId);
        try(Connection conn = getConnection()){ 
            String sql = "SELECT c.quantity, c.product_id, p.name, p.promo_price, pi.image_url "
                    + "FROM cart c " + 
                    "JOIN products p ON c.product_id = p.id " +
                    "JOIN product_images pi ON c.product_id = pi.product_id " +
                    "WHERE pi.is_main = 1 AND c.user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
//	    System.out.println(ps.toString());
            ResultSet rs = ps.executeQuery();
            while(rs.next()){ 
                int productId = rs.getInt("product_id");
                CartItem ci = new CartItem(
                    productId,
                    rs.getString("name"),
                    rs.getString("image_url"),
                    rs.getDouble("promo_price"),
                    rs.getInt("quantity")
                );
                cart.addItem(productId, ci);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return cart;
    }
    //Cập nhật số lượng của từng sản phẩm
    public void updateQuantity(int userId, int productId, int quantity){
        try(Connection conn = getConnection()){
            String sql = "UPDATE cart " +
                    "SET quantity = ? " +
                    "WHERE product_id = ? AND user_id = ?";
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, userId);
            ps.executeUpdate();
        }
        catch(Exception e){ 
            e.printStackTrace();
        }
    }
    //Xóa sản phẩm khỏi giỏ hàng
    public void removeItem(int userId, int productId){ 
        try(Connection conn = getConnection()){
            String sql = "DELETE FROM cart WHERE product_id = ? " +
                    "AND user_id = ?";
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
        catch(Exception e){ 
            e.printStackTrace();
        }
    }
}
