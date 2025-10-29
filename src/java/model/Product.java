package model;

import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private ArrayList<String> images = new ArrayList<>();
    private int price_original, price_promo, sale_rate;

    // Bổ sung danh sách thông số
    private List<ProductSpec> specs = new ArrayList<>();

    public Product(int id, String name, int price_original, int price_promo, double sale_rate, ArrayList<String> images) {
        this.id = id;
        this.name = name;
        this.price_original = price_original;
        this.price_promo = price_promo;
        this.sale_rate = (int)(sale_rate);
        this.images = images;
    }

    // Getter/Setter hiện tại
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public ArrayList<String> getImages() { return images; }
    public void setImages(ArrayList<String> images) { this.images = images; }
    public int getPrice_original() { return price_original; }
    public void setPrice_original(int price_original) { this.price_original = price_original; }
    public int getPrice_promo() { return price_promo; }
    public void setPrice_promo(int price_promo) { this.price_promo = price_promo; }
    public int getSale_rate() { return sale_rate; }
    public void setSale_rate(int sale_rate) { this.sale_rate = sale_rate; }

    // Getter/Setter cho specs
    public List<ProductSpec> getSpecs() { return specs; }
    public void setSpecs(List<ProductSpec> specs) { this.specs = specs; }
}
