package com.example.ecommerceweb.signing.model;

public final class SignatureStatus {

    public static final String UNSIGNED = "CHƯA KÝ";
    public static final String SIGNED = "ĐÃ KÝ";
    public static final String MISMATCH = "KHÔNG KHỚP";
    public static final String KEY_REVOKED = "KHÓA BỊ THU HỒI";

    private SignatureStatus() {}
}