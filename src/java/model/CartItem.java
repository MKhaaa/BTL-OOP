package model;
public class CartItem {
    private int productId;
    private String name;
    private String img;
    private double price;
    private int quantity;

    public CartItem(int productId, String name, String img, double price, int quantity) {
        this.productId = productId;
        this.name = name;
        this.img = img;
        this.price = price;
        this.quantity = quantity;
    }

    public int getProductId() {
        return productId;
    }

    public String getName() {
        return name;
    }

    public String getImg() {
        return img;
    }

    public double getPrice() {
        return price;
    }
    
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public void increaseQuantity(){
        this.quantity += 1;
    }
    
    public void decreaseQuantity(){
        this.quantity -= 1;
    }
    
    public double getTotalPrice(){
        return this.price * quantity;
    }  
}
