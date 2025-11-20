package dao;

import model.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private static final String SELECT_BY_PRODUCT =
        "SELECT c.id, c.product_id, c.user_id, u.username, c.content, c.rating, " +
        "       c.parent_id, c.created_at " +
        "FROM comments c " +
        "JOIN users u ON u.id = c.user_id " +
        "WHERE c.product_id = ? " +
        "ORDER BY c.created_at DESC";

    private static final String INSERT_SQL =
        "INSERT INTO comments(product_id,user_id,content,rating,parent_id) VALUES(?,?,?,?,?)";

    private static final String DELETE_SQL =
        "DELETE FROM comments WHERE id = ? AND user_id = ?";

    public List<Comment> findByProductId(int productId) throws SQLException {
        List<Comment> list = new ArrayList<>();
        try (Connection con = DBConfig.getConnection();     
             PreparedStatement ps = con.prepareStatement(SELECT_BY_PRODUCT)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment cm = new Comment();
                    cm.setId(rs.getInt("id"));
                    cm.setProductId(rs.getInt("product_id"));
                    cm.setUserId(rs.getInt("user_id"));
                    cm.setUsername(rs.getString("username"));
                    cm.setContent(rs.getString("content"));

                    // an toàn với NULL và kiểu số
                    Object rObj = rs.getObject("rating");
                    cm.setRating(rObj == null ? null : ((Number) rObj).intValue());

                    Object pObj = rs.getObject("parent_id");
                    cm.setParentId(pObj == null ? null : ((Number) pObj).intValue());

                    cm.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(cm);
                }
            }
        }
        return list;
    }

    public void insert(Comment c) throws SQLException {
        try (Connection con = DBConfig.getConnection();     
             PreparedStatement ps = con.prepareStatement(INSERT_SQL)) {

            ps.setInt(1, c.getProductId());
            ps.setInt(2, c.getUserId());
            ps.setString(3, c.getContent());

            if (c.getRating() == null) ps.setNull(4, Types.TINYINT);
            else ps.setInt(4, c.getRating());

            if (c.getParentId() == null) ps.setNull(5, Types.INTEGER);
            else ps.setInt(5, c.getParentId());

            ps.executeUpdate();
        }
    }

    // chỉ chủ comment (hoặc admin) được xoá
    public int deleteByIdAndUser(int id, int userId) throws SQLException {
        try (Connection con = DBConfig.getConnection();     
             PreparedStatement ps = con.prepareStatement(DELETE_SQL)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate();
        }
    }
}
