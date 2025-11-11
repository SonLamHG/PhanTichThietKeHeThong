package com.example.pttk_final.Entity;

public class Product {
    private int id;
    private float unitPrice;
    private String name;
    private String brand;
    private String category;
    private String unit;

    public Product() {
    }

    public Product(int id, float unitPrice, String name, String brand, String category, String unit) {
        this.id = id;
        this.unitPrice = unitPrice;
        this.name = name;
        this.brand = brand;
        this.category = category;
        this.unit = unit;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
