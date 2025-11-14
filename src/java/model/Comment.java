package model;

import java.sql.Timestamp;

public class Comment {
    private int id;
    private int productId;
    private int userId;
    private String username;   // lấy từ JOIN để hiển thị
    private String content;
    private Integer rating;    // có thể null
    private Integer parentId;  // có thể null
    private Timestamp createdAt;

    // getters & setters ...

    public int getId() {
        return id;
    }

    public int getProductId() {
        return productId;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getContent() {
        return content;
    }

    public Integer getRating() {
        return rating;
    }

    public Integer getParentId() {
        return parentId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
}
