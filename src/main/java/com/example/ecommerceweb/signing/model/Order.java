package com.example.ecommerceweb.signing.model;

import java.util.Date;

public class Order {
    private int id;
    private Date orderDate;
    private double total;
    private int userId;
    private String customerName;
    private OrderStatus status;
    private String canonicalJson;
    private String signature;
    private String sigStatus;
    private int keyId;

    public Order() {}

    public Order(double total, int userId) {
        this.total = total;
        this.userId = userId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public String getCanonicalJson() { return canonicalJson; }
    public void setCanonicalJson(String canonicalJson) { this.canonicalJson = canonicalJson; }

    public String getSignature() { return signature; }
    public void setSignature(String signature) { this.signature = signature; }

    public String getSigStatus() { return sigStatus; }
    public void setSigStatus(String sigStatus) { this.sigStatus = sigStatus; }

    public int getKeyId() { return keyId; }
    public void setKeyId(int keyId) { this.keyId = keyId; }

    public String getSigStatusLabel() {
        if (sigStatus == null) return "CHƯA KÝ";
        switch (sigStatus) {
            case "SIGNED":      return "ĐÃ KÝ";
            case "MISMATCH":    return "KHÔNG KHỚP";
            case "KEY_REVOKED": return "KHÓA BỊ THU HỒI";
            default:            return "CHƯA KÝ";
        }
    }
}