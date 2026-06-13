/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : ecommerceweb

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 13/06/2026 08:03:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Trái Cây', 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
INSERT INTO `categories` VALUES (2, 'Rau củ', 'https://images.pexels.com/photos/1435904/pexels-photo-1435904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
INSERT INTO `categories` VALUES (3, 'Hằng ngày', 'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
INSERT INTO `categories` VALUES (4, 'Sờ nách', 'https://images.pexels.com/photos/1582482/pexels-photo-1582482.jpeg');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NULL DEFAULT NULL,
  `product_id` int NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, 0, 8, 1, 95000);
INSERT INTO `order_items` VALUES (2, 0, 7, 4, 90000);
INSERT INTO `order_items` VALUES (3, 0, 8, 4, 95000);
INSERT INTO `order_items` VALUES (4, 0, 3, 3, 45000);
INSERT INTO `order_items` VALUES (5, 0, 7, 1, 90000);
INSERT INTO `order_items` VALUES (6, 0, 4, 1, 38000);
INSERT INTO `order_items` VALUES (7, 0, 8, 7, 95000);
INSERT INTO `order_items` VALUES (8, 0, 5, 1, 25000);
INSERT INTO `order_items` VALUES (9, 0, 2, 9, 32000);
INSERT INTO `order_items` VALUES (10, 0, 11, 1, 2131);
INSERT INTO `order_items` VALUES (11, 0, 1, 2, 65000);
INSERT INTO `order_items` VALUES (12, 0, 7, 5, 90000);
INSERT INTO `order_items` VALUES (13, 0, 4, 2, 38000);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` double NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'PENDING',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2026-03-11 22:16:21', 95000, NULL, 'PENDING');
INSERT INTO `orders` VALUES (2, '2026-03-11 22:17:43', 360000, NULL, 'PENDING');
INSERT INTO `orders` VALUES (3, '2026-03-11 23:39:49', 380000, 2, 'PENDING');
INSERT INTO `orders` VALUES (4, '2026-03-11 23:42:16', 135000, 2, 'PENDING');
INSERT INTO `orders` VALUES (5, '2026-03-11 23:56:36', 90000, 2, 'PENDING');
INSERT INTO `orders` VALUES (6, '2026-03-11 23:58:34', 703000, 2, 'PENDING');
INSERT INTO `orders` VALUES (7, '2026-03-12 15:33:47', 25000, 2, 'PENDING');
INSERT INTO `orders` VALUES (8, '2026-03-12 20:50:42', 288000, 2, 'SHIPPING');
INSERT INTO `orders` VALUES (9, '2026-03-12 21:05:46', 2131, 2, 'COMPLETED');
INSERT INTO `orders` VALUES (10, '2026-03-12 21:23:50', 580000, 1, 'COMPLETED');
INSERT INTO `orders` VALUES (11, '2026-03-12 21:24:02', 76000, 2, 'CANCELLED');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` double NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `category_id` int NULL DEFAULT NULL,
  `unit_id` int NULL DEFAULT NULL,
  `stock` int NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `unit_id`(`unit_id` ASC) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Táo Hữu Cơ', 65000, 'https://images.pexels.com/photos/209339/pexels-photo-209339.jpeg', 'Táo Fuji hữu cơ giòn và ngọt. Phù hợp để ăn trực tiếp, làm bánh hoặc thêm vào salad.', 1, 1, 98, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (2, 'Chuối Tươi', 32000, 'https://images.pexels.com/photos/2875814/pexels-photo-2875814.jpeg', 'Chuối chín tự nhiên, thích hợp cho sinh tố, làm bánh hoặc ăn nhẹ.', 1, 1, 111, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (3, 'Rau Cải Bó Xôi Hữu Cơ', 45000, 'https://images.pexels.com/photos/1751149/pexels-photo-1751149.jpeg', 'Lá cải bó xôi non hữu cơ tươi. Phù hợp cho salad, xào hoặc sinh tố.', 2, 3, 57, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (4, 'Sữa Tươi Nguyên Chất', 38000, 'https://images.pexels.com/photos/2198626/pexels-photo-2198626.jpeg', 'Sữa tươi nguyên chất tiệt trùng loại A. Hương vị béo và thơm, thích hợp để uống hoặc nấu ăn.', 3, 5, 77, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (5, 'Khoai Tây Chiên Giòn', 25000, 'https://images.pexels.com/photos/479628/pexels-photo-479628.jpeg', 'Khoai tây chiên giòn vị muối cổ điển. Món ăn vặt hoàn hảo cho mọi dịp.', 4, 6, 149, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (6, 'Cà Rốt Hữu Cơ', 30000, 'https://images.pexels.com/photos/6631952/pexels-photo-6631952.jpeg', 'Cà rốt hữu cơ giòn và ngọt. Thích hợp để ăn sống, nướng hoặc ép nước.', 2, 3, 70, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (7, 'Phô Mai Cheddar', 90000, 'https://images.pexels.com/photos/139746/pexels-photo-139746.jpeg', 'Khối phô mai cheddar vị đậm. Phù hợp cho sandwich, món nướng hoặc ăn kèm.', 3, 4, 30, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (8, 'Dâu Tây Tươi', 95000, 'https://images.pexels.com/photos/2820144/pexels-photo-2820144.jpeg', 'Dâu tây tươi ngon và mọng nước. Phù hợp cho tráng miệng, sinh tố hoặc ăn nhẹ.', 1, 6, 78, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (9, 'Sữa Chua Hy Lạp', 18000, 'https://images.pexels.com/photos/414262/pexels-photo-414262.jpeg', 'Sữa chua Hy Lạp nguyên chất, giàu protein, vị béo và hơi chua nhẹ.', 3, 4, 110, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (11, 'kivi', 2131, 'https://cdn.tgdd.vn/Files/2014/09/25/569033/10-loai-trai-cay-cap-cuu-khi-bi-benh1.jpg', 'asfasd d d', 1, 5, 36, '2026-03-12 18:02:45');

-- ----------------------------
-- Table structure for units
-- ----------------------------
DROP TABLE IF EXISTS `units`;
CREATE TABLE `units`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of units
-- ----------------------------
INSERT INTO `units` VALUES (1, 'kg');
INSERT INTO `units` VALUES (2, 'cái');
INSERT INTO `units` VALUES (3, 'bịch');
INSERT INTO `units` VALUES (4, 'hộp');
INSERT INTO `units` VALUES (5, 'chai');
INSERT INTO `units` VALUES (6, 'gói');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'customer',
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'teo', '123', 'customer', 1, '2026-03-12 18:38:00', '2026-03-12 18:38:00');
INSERT INTO `users` VALUES (2, 'duy', '123', 'admin', 1, '2026-03-12 18:38:00', '2026-03-12 20:11:04');
INSERT INTO `users` VALUES (5, 'duy1', '123', 'user', 0, '2026-03-12 18:38:00', '2026-03-12 20:17:57');
INSERT INTO `users` VALUES (7, 'duy11', '123', 'user', 0, '2026-03-12 18:38:00', '2026-03-12 20:11:14');

SET FOREIGN_KEY_CHECKS = 1;
