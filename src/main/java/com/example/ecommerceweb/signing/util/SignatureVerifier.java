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
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;

public class SignatureVerifier {

    private static final String RSA_TRANSFORMATION = "RSA/ECB/PKCS1Padding";
    
    // Verify danh sách đơn hàng và cập nhật trạng thái chữ ký
    public static List<Order> verifyOrders(List<Order> orders){
    	 String signature, result;
         KeyStore key;
         for (Order order : orders) {
        	 // Nếu đơn hàng đã bị thu hồi key thì không cần verify lại
        	 if(order.getSigStatus().equalsIgnoreCase(SignatureStatus.KEY_REVOKED)) {
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
    	if(order.getSigStatus().equalsIgnoreCase(SignatureStatus.KEY_REVOKED)) {
   		 	return SignatureStatus.KEY_REVOKED;
   	 	}
    	if (key == null) {
    		return SignatureStatus.UNSIGNED;
    	}
    	// Nếu đơn hàng đã được ký và chưa được xác nhận và user báo mất key => trả về trạng thái key đã bị thu hồi
    	if(key.getRevokedAt() != null) {
    		if(order.getStatus().equals(OrderStatus.PENDING) 
            		&& (order.getSigStatus().equalsIgnoreCase(SignatureStatus.SIGNED) || order.getSigStatus().equalsIgnoreCase(SignatureStatus.MISMATCH))) {
    			return SignatureStatus.KEY_REVOKED;
    		}
    	}
        
        String signature = order.getSignature();
        if (signature == null || signature.isBlank()) {
            return SignatureStatus.UNSIGNED;
        }
        
        // So sánh canonicalJson đã băm với chữ ký của order đã được giải mã
        String canonicalJson = order.getCanonicalJson();
	if (canonicalJson == null || canonicalJson.isBlank()) {
            return SignatureStatus.MISMATCH;	
	}
        try {
            String hashJson = sha256Hex(canonicalJson);
            PublicKey publicKey = RsaKeyCodec.decodePublicKey(key.getPublicKey());

            Cipher cipher = Cipher.getInstance(RSA_TRANSFORMATION);
            cipher.init(Cipher.DECRYPT_MODE, publicKey);
            byte[] data = cipher.doFinal(Base64.getDecoder().decode(signature.trim()));
            String plainText = new String(data, StandardCharsets.UTF_8);
            
            return hashJson.equals(plainText)
                    ? SignatureStatus.SIGNED
                    : SignatureStatus.MISMATCH;
        } catch (Exception e) {
            e.printStackTrace();
            return SignatureStatus.MISMATCH;
        }
    }

    // Dùng SHA-256 để băm chuỗi json
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