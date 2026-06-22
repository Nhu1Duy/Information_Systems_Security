package com.example.ecommerceweb.signing.model;

public final class SignatureStatus {

    public static final String UNSIGNED = "UNSIGNED";
    public static final String SIGNED = "SIGNED";
    public static final String MISMATCH = "MISMATCH";
    public static final String KEY_REVOKED = "KEY_REVOKED";

    private SignatureStatus() {}
}