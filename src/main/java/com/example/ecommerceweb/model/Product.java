package com.example.ecommerceweb.model;

public class Product {

    private int id;
    private String name;
    private double price;
    private String image;
    private String description;
    private Category category;
    private Unit unit;
    private int stock;

    public Product(){}

    public Product(int id, String name, double price, String image,
                   String description, Category category, Unit unit, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.description = description;
        this.category = category;
        this.unit = unit;
        this.stock = stock;
    }

    public int getId(){ return id; }
    public String getName(){ return name; }
    public double getPrice(){ return price; }
    public String getImage(){ return image; }
    public String getDescription(){ return description; }
    public Category getCategory() { return category; }
    public Unit getUnit() { return unit; }
    public int getStock(){ return stock; }

    public void setId(int id){ this.id=id; }
    public void setName(String name){ this.name=name; }
    public void setPrice(double price){ this.price=price; }
    public void setImage(String image){ this.image=image; }
    public void setDescription(String description){ this.description=description; }
    public void setCategory(Category category) { this.category = category; }
    public void setUnit(Unit unit) { this.unit = unit; }
    public void setStock(int stock){ this.stock=stock; }
}