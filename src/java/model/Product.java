/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author AdminS
 */
public class Product {
    private int id;
    private String name;
    private ArrayList<String> images = new ArrayList<>();
    private int price_original, price_promo, sale_rate;

    public Product(int id, String name, int price_original, int price_promo, double sale_rate, ArrayList<String> images) {
	this.id = id;
	this.name = name;
	this.price_original = price_original;
	this.price_promo = price_promo;
//	this.sale_rate = (int)(1.0 * (price_original - price_promo) / price_original * 100);
	this.sale_rate = (int)(sale_rate);
	this.images = images;
    }

    public int getId() {
	return id;
    }

    public void setId(int id) {
	this.id = id;
    }

    public String getName() {
	return name;
    }

    public void setName(String name) {
	this.name = name;
    }

    public ArrayList<String> getImages() {
	return images;
    }

    public void setImages(ArrayList<String> images) {
	this.images = images;
    }

    public int getPrice_original() {
	return price_original;
    }

    public void setPrice_original(int price_original) {
	this.price_original = price_original;
    }

    public int getPrice_promo() {
	return price_promo;
    }

    public void setPrice_promo(int price_promo) {
	this.price_promo = price_promo;
    }

    public int getSale_rate() {
	return sale_rate;
    }

    public void setSale_rate(int sale_rate) {
	this.sale_rate = sale_rate;
    }
    
}
