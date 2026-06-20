package com.example.ecommerceweb.signing.util;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.signing.model.SignatureStatus;

import javax.crypto.Cipher;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.util.Base64;
import java.util.List;

/**
 * Xác minh chữ ký số cho đơn hàng, tương thích với Tool Ký Số (desktop):
 *
 *   1. Băm canonical_json bằng SHA-256 -> chuỗi hex (lowercase).
 *   2. Chữ ký = RSA "giải mã" (Cipher RSA/ECB/PKCS1Padding, DECRYPT_MODE,
 *      dùng PUBLIC KEY) của chuỗi Base64 chữ ký -> ra lại chuỗi hex của hash.
 *   3. So sánh hash tính lại với hash được giải ra từ chữ ký.
 *
 * Đây KHÔNG phải chuẩn java.security.Signature (SHA256withRSA), mà là kiểu
 * "raw RSA" do Tool Ký Số sử dụng: ký = RSA private-key "encrypt" của hex(SHA-256(json)).
 */
public class SignatureVerifier {

    private static final String RSA_TRANSFORMATION = "RSA/ECB/PKCS1Padding";
    
    // Verify danh sách đơn hàng và cập nhật trạng thái chữ ký
    public static List<Order> verifyOrders(List<Order> orders){
    	 String signature, result;
         KeyStore key;
         for (Order order : orders) {
        	 if(order.getSigStatus().equalsIgnoreCase(SignatureStatus.SIGNED)) continue;
        	 
             signature = order.getSignature();
             if (signature == null || signature.trim().isEmpty()) {
                 continue;
             }

             key = KeyDAO.getKeyById(order.getKeyId());
             result = SignatureVerifier.verify(order, key);

             if (!result.equals(order.getSigStatus())) {
                 OrderDAO.updateSigStatus(order.getId(), result);
             }
             order.setSigStatus(result);
         }
         return orders;
    }
    
    // Verify đơn hàng và trả về trạng thái chữ ký
    public static String verify(Order order, KeyStore key) {
    	// Kiểm tra nếu trạng thái đơn hàng không phải đang giao hoặc hoàn thành và key đã bị thu hồi thì đổi trang thái "KEY_REVOKED"
    	if (key == null || 
    			((!order.getStatus().equalsIgnoreCase("COMPLETED") || !order.getStatus().equalsIgnoreCase("SHIPPING")) 
    					&& !"ACTIVE".equalsIgnoreCase(key.getStatus()))) {
            return SignatureStatus.KEY_REVOKED;
        }
        
        String signature = order.getSignature();
        String canonicalJson = order.getCanonicalJson();

        if (signature == null || signature.isBlank()) {
            return SignatureStatus.UNSIGNED;
        }
        if (canonicalJson == null || canonicalJson.isBlank()) {
            return SignatureStatus.MISMATCH;
        }

        try {
            // 1. Băm lại đơn hàng bằng SHA-256 -> hex
            String expectedHashHex = sha256Hex(canonicalJson);

            // 2. Giải mã chữ ký bằng khóa công khai
            PublicKey publicKey = RsaKeyCodec.decodePublicKey(key.getPublicKey());

            Cipher cipher = Cipher.getInstance(RSA_TRANSFORMATION);
            cipher.init(Cipher.DECRYPT_MODE, publicKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(signature.trim()));
            String signedHashHex = new String(decryptedBytes, StandardCharsets.UTF_8);

            // 3. So sánh
            return expectedHashHex.equals(signedHashHex)
                    ? SignatureStatus.SIGNED
                    : SignatureStatus.MISMATCH;

        } catch (Exception e) {
            return SignatureStatus.MISMATCH;
        }
    }

    /**
     * Băm chuỗi bằng SHA-256, trả về chuỗi hex viết thường (giống HashFunction.hashString
     * trong Tool Ký Số).
     */
    private static String sha256Hex(String input) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));

        StringBuilder sb = new StringBuilder(hashBytes.length * 2);
        for (byte b : hashBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}