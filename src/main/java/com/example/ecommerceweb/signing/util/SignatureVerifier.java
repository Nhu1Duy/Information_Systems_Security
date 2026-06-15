package com.example.ecommerceweb.signing.util;

import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.model.Order;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

/**
 * Xác minh chữ ký số (SHA256withRSA, khóa RSA 2048-bit) cho đơn hàng.
 * Dữ liệu được ký là canonical_json, chữ ký lưu dạng Base64 trong cột signature.
 */
public class SignatureVerifier {

    private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";

    /**
     * Xác minh chữ ký của 1 đơn hàng.
     *
     * @param order đơn hàng cần xác minh (cần canonicalJson + signature + keyId)
     * @param key   khóa công khai (KeyStore) ứng với order.getKeyId(), có thể null
     * @return một trong: UNSIGNED, VERIFIED, TAMPERED, REJECTED
     */
    public static String verify(Order order, KeyStore key) {
        String signature = order.getSignature();
        String canonicalJson = order.getCanonicalJson();

        // Chưa ký -> không có gì để verify
        if (signature == null || signature.trim().isEmpty()) {
            return "UNSIGNED";
        }

        // Có chữ ký nhưng mất dữ liệu canonical_json -> coi như bị xáo trộn
        if (canonicalJson == null || canonicalJson.isEmpty()) {
            return "TAMPERED";
        }

        // Không xác định được khóa đã dùng để ký
        if (key == null) {
            return "REJECTED";
        }

        // Khóa đã bị thu hồi -> chữ ký không còn được công nhận, dù toán học có khớp hay không
        if (!"ACTIVE".equalsIgnoreCase(key.getStatus())) {
            return "REJECTED";
        }

        try {
            PublicKey publicKey = parsePublicKey(key.getPublicKey());

            Signature sig = Signature.getInstance(SIGNATURE_ALGORITHM);
            sig.initVerify(publicKey);
            sig.update(canonicalJson.getBytes(StandardCharsets.UTF_8));

            byte[] sigBytes = Base64.getDecoder().decode(signature.trim());

            return sig.verify(sigBytes) ? "VERIFIED" : "TAMPERED";

        } catch (Exception e) {
            // Sai định dạng Base64, khóa lỗi, v.v. -> coi như dữ liệu/chữ ký không hợp lệ
            return "TAMPERED";
        }
    }

    /**
     * Parse public key dạng Base64 (X.509/SubjectPublicKeyInfo),
     * hỗ trợ cả 2 dạng đang lưu trong key_store:
     *  - Có header/footer PEM "-----BEGIN/END PUBLIC KEY-----" kèm xuống dòng
     *  - Base64 thô không có header/footer
     */
    public static PublicKey parsePublicKey(String keyText) throws Exception {
        String clean = keyText
                .replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "")
                .replaceAll("\\s+", "");

        byte[] decoded = Base64.getDecoder().decode(clean);
        X509EncodedKeySpec spec = new X509EncodedKeySpec(decoded);
        return KeyFactory.getInstance("RSA").generatePublic(spec);
    }
}