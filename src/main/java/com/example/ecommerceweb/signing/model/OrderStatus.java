package com.example.ecommerceweb.signing.model;

public enum OrderStatus {
    PENDING("Chờ xác nhận"),
    CONFIRMED("Đã xác nhận"),
    SHIPPING("Đang giao"),
    COMPLETED("Hoàn thành"),
    CANCELLED("Đã hủy");

    private final String label;

    OrderStatus(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public static OrderStatus fromDbValue(String value) {
        if (value == null) return PENDING;
        for (OrderStatus s : values()) {
            if (s.name().equalsIgnoreCase(value)) return s;
        }
        return PENDING;
    }
}