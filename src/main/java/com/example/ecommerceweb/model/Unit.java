package com.example.ecommerceweb.model;

public class Unit {
    private int id;
    private String name;

    public Unit(){}

    public Unit(int id, String name){
        this.id = id;
        this.name = name;
    }

    public Unit(int unitId) {
        this.id = unitId;
    }

    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}
}
