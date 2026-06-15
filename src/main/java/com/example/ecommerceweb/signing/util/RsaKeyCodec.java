package com.example.ecommerceweb.signing.util;

import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public final class RsaKeyCodec {
    public static final String ALGORITHM = "RSA";
    public static final int KEY_SIZE = 2048;

    private RsaKeyCodec() {}

    public static KeyPair generateKeyPair() throws Exception {
        KeyPairGenerator gen = KeyPairGenerator.getInstance(ALGORITHM);
        gen.initialize(KEY_SIZE);
        return gen.generateKeyPair();
    }

    public static String encodePublicKey(PublicKey key) {
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public static String encodePrivateKey(PrivateKey key) {
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public static PublicKey decodePublicKey(String text) throws Exception {
        byte[] decoded = Base64.getDecoder().decode(stripPem(text));
        return KeyFactory.getInstance(ALGORITHM)
                .generatePublic(new X509EncodedKeySpec(decoded));
    }

    public static PrivateKey decodePrivateKey(String text) throws Exception {
        byte[] decoded = Base64.getDecoder().decode(stripPem(text));
        return KeyFactory.getInstance(ALGORITHM)
                .generatePrivate(new PKCS8EncodedKeySpec(decoded));
    }

    private static String stripPem(String text) {
        return text.replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "")
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replaceAll("\\s+", "");
    }
}