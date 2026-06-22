package com.example.ecommerceweb.signing.util;

import com.example.ecommerceweb.signing.dao.KeyDAO;
import com.example.ecommerceweb.signing.dao.OrderDAO;
import com.example.ecommerceweb.signing.model.KeyStore;
import com.example.ecommerceweb.signing.model.Order;
import com.example.ecommerceweb.signing.model.OrderStatus;
import com.example.ecommerceweb.signing.model.SignatureStatus;

import javax.crypto.Cipher;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.util.Base64;
import java.util.List;

public class SignatureVerifier {

    private static final String RSA_TRANSFORMATION = "RSA/ECB/PKCS1Padding";
    
    // Verify danh sách đơn hàng và cập nhật trạng thái chữ ký
    public static List<Order> verifyOrders(List<Order> orders){
    	 String signature, result;
         KeyStore key;
         for (Order order : orders) {
        	 if(order.getSigStatus().equals(SignatureStatus.SIGNED)) continue;
        	 
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
    	if (key == null) {
    		return SignatureStatus.UNSIGNED;
    	}
    	// Nếu đơn hàng đã được ký và chưa được xác nhận và user báo mất key => doi
        if (order.getStatus() == OrderStatus.PENDING 
        		&& (order.getSigStatus() == SignatureStatus.SIGNED && order.getSigStatus() == SignatureStatus.MISMATCH)
                && !"ACTIVE".equalsIgnoreCase(key.getStatus())) {
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

            //debug
            System.out.println("[WEB] canonicalJson  = " + canonicalJson);
            System.out.println("[WEB] expectedHash   = " + expectedHashHex);
            System.out.println("[WEB] expectedHash.len = " + expectedHashHex.length());

            // 2. Giải mã chữ ký bằng khóa công khai
            PublicKey publicKey = RsaKeyCodec.decodePublicKey(key.getPublicKey());

            Cipher cipher = Cipher.getInstance(RSA_TRANSFORMATION);
            cipher.init(Cipher.DECRYPT_MODE, publicKey);
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(signature.trim()));
            String signedHashHex = new String(decryptedBytes, StandardCharsets.UTF_8);
            //debug
            System.out.println("[WEB] signedHashHex  = " + signedHashHex);
            System.out.println("[WEB] signedHash.len = " + signedHashHex.length());
            System.out.println("[WEB] match = " + expectedHashHex.equals(signedHashHex));
            System.out.println("----------------" );
            // 3. So sánh
            return expectedHashHex.equals(signedHashHex)
                    ? SignatureStatus.SIGNED
                    : SignatureStatus.MISMATCH;


        } catch (Exception e) {
            System.out.println("[WEB] EXCEPTION: " + e.getClass().getName() + " - " + e.getMessage());
            e.printStackTrace();
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