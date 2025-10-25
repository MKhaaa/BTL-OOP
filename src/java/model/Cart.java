package model;

import java.util.*;

public class Cart {
    private int userId;
    private Map<Integer, CartItem> items = new HashMap<>();

    public Cart(int userId) {
        this.userId = userId;
    }
    
    public void addItem(int productId, CartItem item){
        items.put(productId, item);
    }
    
    public void removeItem(int productId){
        items.remove(productId);
    }
    
    public void updateQuantity(int productId, int quantity){
        CartItem item = items.get(productId);
        if (item != null) {
            item.setQuantity(quantity);
        }
    }
    
    public void increaseQuantity(int productId){
        CartItem item = items.get(productId);
        if (item != null) {
            item.increaseQuantity();
        }
    }
    
    public void decreaseQuantity(int productId){
        CartItem item = items.get(productId);
        if (item != null) {
            item.decreaseQuantity();
            if (item.getQuantity() <= 0) {
                item.setQuantity(1);
            }
        }
    }
    
    public double getTotalPrice(){
        double totalPrice = 0;
        for(CartItem item : items.values()){
            totalPrice += item.getTotalPrice();
        }
        return totalPrice;
    }
    
    public CartItem getItem(int productId){ 
        return items.get(productId);
    }
    
    public List<CartItem> getItems(){
        return new ArrayList<>(items.values());
    }
}
