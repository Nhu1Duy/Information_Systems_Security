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

 Date: 16/06/2026 01:20:11
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
-- Table structure for key_store
-- ----------------------------
DROP TABLE IF EXISTS `key_store`;
CREATE TABLE `key_store`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `public_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `revoked_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_key_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_key_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of key_store
-- ----------------------------
INSERT INTO `key_store` VALUES (1, 2, '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmIOLVSfqiJbPn3HRxcyt3FUHa1RjYaeeyYIzMSEj1r0U1id7Vv1d28RdEMYzvSw90jTG8nfLwCoGsY0FHLgkMcc6utzhGisVDIseVpRDB3Epy5ubrPLH2h+ZUz1+nLymSWW4apFO7hAjycTgxDpcDCupfwo9LiAgUD6MonC8qHr6y4LPDPzZo3w1qvXDLGPhA9qZ+V5OyHUrymInKBnqYPrnoRI7l41szVOaoQX8phfwb2cSQwc47EIMzfgUlEv7np9JdSCkZoOQXRd6GNOX6s2Dd+BRK9AS1hi3+yrGD9v2ALBY8770gllTsuPvtjf5UOvTSRrt7HX12yEGCDhYWQIDAQAB\n-----END PUBLIC KEY-----', 'REVOKED', '2026-06-13 09:17:29', '2026-06-13 09:53:32');
INSERT INTO `key_store` VALUES (3, 7, '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjwwsnz6T/XiKglEyvgqRVqtbtcwjoXEZC02OWsXuH8ukVRVHUJPuG3qY6v2r2GzmfYCpyWISwMGp25g2NwtaYFj8dDVZNHJN3xz4ZuwYSSMRIq4dHSeFZ0bnDoavFnjkUDGzXe8jiIRAcuHUMkk4AVAK/80IbjHr5nQJsXeGpIIZ96mQBEAKMy9b/Vpov5GxbbvYnR+fpNwjb7iqmqIhsmE4KtQu64n8+4/a4pYmiamnfy8bkEaTA/7+iiGrw/x6dpAjTS7IU2DuaI77fOJ5okfgCHJ8ExHXP2p4l+g4BqN/2E38LAgqqZW+XURjlrmDvjbaFC0BQiYKsHv6g7441QIDAQAB\n-----END PUBLIC KEY-----', 'REVOKED', '2026-06-13 09:41:24', '2026-06-13 09:43:27');
INSERT INTO `key_store` VALUES (4, 7, '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo4BNbjWCqKiZONWOaZ8QJ3qLsAgEdaob9DdtUZHSZ1DurXhU1tjG4nlRfXcidQLR1i2yekQ591GNjts3vZ0uYDW1imOMHVZ5PV1hacPwOWW0zK7rdqYBZN3YOyofggMzEXEDL58h6kjhvLwQNfE4tr9x9uok4Ct6ZaBzgjot6X4Lq61BMOvwU1RLUxYi5ASu6iY/2g+oO4rVVngxro7A+Hi9WBcObhQCpM6c/0pC63Z6l7ljF+i1XHCaVqlIVEeBIUMcl7ABW7tHoZ7kOV/anc1ZambF3Cc6mg/hUd1FG9PWvFxrIchey0u0qBEr9Nx9MJMBycP4dOigMIa7RAIzPQIDAQAB\n-----END PUBLIC KEY-----', 'REVOKED', '2026-06-13 09:42:34', '2026-06-13 09:43:27');
INSERT INTO `key_store` VALUES (5, 7, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvazIN7UE+MAXqp4zTlnSkobKLyzpbeatmjyBblb84jqL8A095QTfiC9Uf2g1SVFfAEb4oaQq+XM8fcHmc70r1RhgHnu7/h4NZCIhJKJHBJD8lnatbxXECEWPNVlAIY7VnhP9OUAIQolP2Gx7OiIYTz8FjHYQleP2WZQbFTXG2yP/XDbEUcG+/TORRYPlcly7B3DxZWIJgpurWUd6ycferelJe6Cu6JJeFVUKATx+yx8LHSgZX9XQ4Hgd/XEb0VhghfABTh4+98M6kvOspO3pckz6N17x6VmU21Lp8wFN45C+5n65/c8exWRG5k9tO+odcLJlLRPIfmZYtoTEmR78YQIDAQAB', 'ACTIVE', '2026-06-13 09:51:17', NULL);
INSERT INTO `key_store` VALUES (6, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtgn/OJbuJcQ0PasZ4oOsW7ypwBpVUoNttMr5oDMPUSSHTXfQOVpAhSGhGi9web2xTMl4vZHxI007pQ5jG5HzmqQuCqBPBlbglMfeOir4NNl83PwDzliwhUrJqFFeEuC9CcB/1cjZBM/jTNHYe4zR/OkBGtBTEwOMunrYaWxF5rIV4MGU9nDJD7e3K8rhNAxF6UJYKy/rBDa3k+ymLP081KwBcolM88tCwdasY/tO0CodskdvsqmgEZ7hFyJ0vTBxBX9Qvuy5tgQxZw+smI1PdlmFzWc3Sn1fyo2ppOe7O4ppqiHJXcnujpI+mn/lMhqTHuPx7rqICEDvkx3DapAfaQIDAQAB', 'REVOKED', '2026-06-13 09:53:34', '2026-06-13 10:08:30');
INSERT INTO `key_store` VALUES (7, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5L+CAdkD3/be/DSPfpAaLyBbmyLY78TvKrizJcYZT0Nrx5hbEKRLvgBFtJ043SbZSXKwJHANhW8N/aKYIXOarwd56BUxw4Iu2H4YOuzzlOTh69KOjWvgFsruAUFIGN7UkPAxG8Hu+hvUzuePDVWXLRfNjuUtDThWirTxGqcYINhigYLtLDzrp5Cbvf7FqUB2zDd01wwANDuN+rZtnDNI9BJSaIfvamRPgeu+lQVW9nKxAtpTbSyowOQ4BPE1ilW+2Ef9MQFcFc8BgatMfc837+J2lE6HYsL19lh0evQ93KAi62G9cEswB9xQ+2tCEQb/bc9Ij+c8OE6QQ3y/PM9fLQIDAQAB', 'REVOKED', '2026-06-13 10:08:50', '2026-06-13 11:58:59');
INSERT INTO `key_store` VALUES (8, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmLY+JlnaL1joHoEV4q7FhpHUU6dHuw5GqRJLI6FhKI8qm91IUgRyzH9vOR6hxajp1GNQpfbJ8L/7V8c4VHBj/dNOeucgwO6cLeyuBolnAg1IuSJfrb5GZ1KkRBuXMN2dta0dW5h6/OgW0IBdJPVdoxjUgd354IzUanKB1g1yuCXWpxIJtVh8ab+x3wF/HorTvUeag5UKGeW7b6QrsWAAD4CWXBQeW9pH5O3hzAbPV4W95mlI0OkkwWxNDzXgBOx7mfPYq4FNG8Dc6LXEUVmKUeihpzaLAz48GqSymPXbKKv83VzA4tVcJR7010JwJv+ywvORAxhdi0NhQdKO502UMQIDAQAB', 'REVOKED', '2026-06-13 11:59:04', '2026-06-16 00:37:04');
INSERT INTO `key_store` VALUES (9, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwALvUv1/yJU3UPvBixnC5s/PtFb/ijUb3DBZSrnyYC6B7MDMpqXrIgenMbimMbZ+VpawkvXe9ckaWAMMK+L8V+ihmmrzmkMSpDXzb/NXO9WwYLkko6xftazF+5wB1qFtZRB5TwMGYAUVg29q4rzQDtptAKO1XfB4AfgePazQPDDQeQIc62qEE2FL2vhIYqusk2DZU3CTdRQ+Tek7lFwAzq3tzqIaTP4qkJAc08GeVWhSvPFY1w3TGxXDbj0xR7BVre4YuiNpYV5CN0/mQNoladVplebBE1fqSKs/Vff6sRyCfCUMc4x9scRMbWB1sM7N3eMAcCjXoZ1t16e8UhJ/JwIDAQAB', 'REVOKED', '2026-06-13 12:09:05', '2026-06-16 00:37:04');
INSERT INTO `key_store` VALUES (10, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuBPpHlP/s6RrbsuEVE8SHwhBJIS15PReVazBVqKu4Wwt4m88ddIafC39wZ/ElFQrAuLohDenfOmMEJ8d/ylTYguXqVztCyV8pQ61qsnpMSkQkWC0+JTDHuk86bjzquVb7qDmuF7Y6kMa+m/azMptoXfpY6LIQ2zyrslhyoqDOaHlyj09rbhjBBBIxJ16ZXVUqJOIBpAzFN38qpCPfhmf+TTEtBXX9kVIS18aPFVb0zlHRBXgs6msn24L8VUmEjjYTiX6Z5Nv5q4XuGzUC2MBJI6AQPTEo4sDwKLiava6ijmNmqzl2K+SB2wdTnG0bQ+wzkXTbEIn1Njq/sjKuHXtAwIDAQAB', 'ACTIVE', '2026-06-16 00:37:06', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `order_items` VALUES (14, 12, 8, 1, 95000);
INSERT INTO `order_items` VALUES (15, 13, 8, 1, 95000);
INSERT INTO `order_items` VALUES (16, 14, 11, 1, 2131);
INSERT INTO `order_items` VALUES (17, 15, 2, 1, 32000);
INSERT INTO `order_items` VALUES (18, 15, 8, 1, 95000);
INSERT INTO `order_items` VALUES (19, 16, 2, 1, 32000);
INSERT INTO `order_items` VALUES (20, 17, 11, 1, 2131);
INSERT INTO `order_items` VALUES (21, 18, 7, 1, 90000);
INSERT INTO `order_items` VALUES (22, 18, 11, 1, 2131);
INSERT INTO `order_items` VALUES (23, 19, 11, 1, 2131);
INSERT INTO `order_items` VALUES (24, 20, 11, 1, 2131);
INSERT INTO `order_items` VALUES (25, 21, 2, 1, 32000);
INSERT INTO `order_items` VALUES (26, 22, 11, 1, 2131);
INSERT INTO `order_items` VALUES (27, 23, 11, 1, 2131);
INSERT INTO `order_items` VALUES (28, 24, 8, 1, 95000);
INSERT INTO `order_items` VALUES (29, 25, 11, 1, 2131);
INSERT INTO `order_items` VALUES (30, 26, 8, 1, 95000);
INSERT INTO `order_items` VALUES (31, 27, 8, 1, 95000);
INSERT INTO `order_items` VALUES (32, 28, 11, 1, 2131);
INSERT INTO `order_items` VALUES (33, 29, 2, 1, 32000);
INSERT INTO `order_items` VALUES (34, 30, 11, 1, 2131);
INSERT INTO `order_items` VALUES (35, 31, 4, 1, 38000);
INSERT INTO `order_items` VALUES (36, 32, 5, 1, 25000);
INSERT INTO `order_items` VALUES (37, 33, 5, 1, 25000);
INSERT INTO `order_items` VALUES (38, 34, 8, 1, 95000);

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
  `canonical_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `signature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `sig_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'UNSIGNED',
  `key_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2026-03-11 22:16:21', 95000, NULL, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (2, '2026-03-11 22:17:43', 360000, NULL, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (3, '2026-03-11 23:39:49', 380000, 2, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (4, '2026-03-11 23:42:16', 135000, 2, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (5, '2026-03-11 23:56:36', 90000, 2, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (6, '2026-03-11 23:58:34', 703000, 2, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (7, '2026-03-12 15:33:47', 25000, 2, 'PENDING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (8, '2026-03-12 20:50:42', 288000, 2, 'SHIPPING', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (9, '2026-03-12 21:05:46', 2131, 2, 'COMPLETED', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (10, '2026-03-12 21:23:50', 580000, 1, 'COMPLETED', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (11, '2026-03-12 21:24:02', 76000, 2, 'CANCELLED', NULL, NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (12, '2026-06-13 09:07:51', 95000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:07:51Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":12,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (13, '2026-06-13 09:13:13', 95000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:13:13Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":13,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (14, '2026-06-13 09:14:50', 2131, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:14:50Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":14,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (15, '2026-06-13 09:15:55', 127000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:15:56Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1},{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":15,\"total\":127000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (16, '2026-06-13 09:16:45', 32000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:16:45Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1}],\"order_id\":16,\"total\":32000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (17, '2026-06-13 09:20:58', 2131, 2, 'PENDING', '{', 'Kj0o2C+WQNANQj52AYiKh6b0cDwhuD/URRYKZ8o3R8EmcGNQVS1CZuwi01Tschnz56hpjoXkGN6YrHZ6xI4bA/ubFCNSQBIszqcZ8tME6Ho+pY5i9vnHDJiwRvCpwPOU3a9SRJLcu9+djJ98JPZ0wmN7BVgJfrfx/HCK6Dn16Z0oZ5C9ts8eA/URvoP2el6d4bAmzu6BMTRMBIfdq+w+FlKS9E13L8+/0a7hBZMQ2qotxgPOlQOdQcMq3n1uv3hh8kn6mRjsPg/kvOvgwpzgEoLnQM3SZ4DO9RIzePxJAzjrZ+sfWMuLNeD4kIGth2J3BPONA1NiSdfMxJ+PgpTCyg==', 'MISMATCH', 1);
INSERT INTO `orders` VALUES (18, '2026-06-13 09:31:26', 92131, 2, 'PENDING', '{\"created_at\":\"2026-06-13T09:31:26Z\",\"items\":[{\"price\":90000.0,\"product_id\":7,\"product_name\":\"Phô Mai Cheddar\",\"quantity\":1},{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":18,\"total\":92131.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (19, '2026-06-13 09:32:21', 2131, 7, 'PENDING', '{\"created_at\":\"2026-06-13T09:32:21Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":19,\"total\":2131.0,\"user_id\":7,\"username\":\"duy11\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (20, '2026-06-13 09:36:54', 2131, 7, 'PENDING', '{\"created_at\":\"2026-06-13T09:36:54Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":20,\"total\":2131.0,\"user_id\":7,\"username\":\"duy11\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (21, '2026-06-13 09:41:17', 32000, 7, 'PENDING', '{\"created_at\":\"2026-06-13T09:41:17Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1}],\"order_id\":21,\"total\":32000.0,\"user_id\":7,\"username\":\"duy11\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (22, '2026-06-13 09:51:59', 2131, 7, 'SHIPPING', '{\"created_at\":\"2026-06-13T09:51:59Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":22,\"total\":2131.0,\"user_id\":7,\"username\":\"duy11\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (23, '2026-06-13 09:53:46', 2131, 2, 'PENDING', '{', 'Up16fCbQ6oV79y/lVybbWgafEKF6hsGVEd0lipm8fGPzLV910wV6To/7QxDXDjDKdhYKP2WD4vIi6j+f7CnXW4EFV7phLZpPToly6Cpo9izSYqAJfFd9vQyvJAK8n6vg9I54x362KebmQYJeCHbbgJEIKWaX/hDKh6Qd4T+jqGyJavSi8v10CslXnJhz8lImZjRW9HuSVZyCYcl7k4DdP84T+6GC1F57XWXhTh30dy7mXsqX0uS54MHN2XHVxFa/3YdY+HXNe0OpUmenEeQNcPJTrhCbBbDcZcVLNZivSkRFOp06A+7g8mW/3louGx3GQrv81mab6FEViy6RujY2GA==', 'MISMATCH', 6);
INSERT INTO `orders` VALUES (24, '2026-06-13 10:03:25', 95000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T10:03:25Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":24,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', 'sfsjEo++vkGR188WegrCgzmfw9gJ4VcEEiNKifU+lJoj9brzmO5vng7He5OTqkLfEJlTc9GMW2pl7j++zKRcVihIjiRzDNKeEkEAshmqdnMRGTpjr0qL7sVFPF8lYCOZ3FmzVie2t45t029EGWpyNX2pysusaXxGSwv9BSXLSAHkzQ4pkhs6ncXbw6+AHHKC8D6Vz9I8ekSEIZ70BG6wc1ggBoqHmd6K+qEVQe4hI2pwFay5fpEgxYxnl7lgAorJ7U+K0QaJ0bm8lyUvsQMsMxwALuXx3rrtE1Jl1kSI4t82OKsAoVQF4XZAP5dhN6ESvJjS1Q0paX1ROZ7dnM60Cw==', 'MISMATCH', 6);
INSERT INTO `orders` VALUES (25, '2026-06-13 10:06:51', 2131, 2, 'PENDING', '{\"created_at\":\"2026-06-13T10:06:51Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":25,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', 'Ogt1Exdad3AIszF4THJz0pf9N+Gt+ntgXNpMjfIvel0GZUOP2GtpKaZ9yiXF1mlc/rhuhWpCOXBDM3G/djBOatBizdInTt4VqKwa85s8P4PjNnzCXLWdL1d6PTgScXOt30O+uhryByz1am+aldAQqK2OyTGBIAE0CTRiEWZ5B18PNFDsFmtDMJ+iOWQAOYxFRXC0tTgoUdK9AiGE7MJ6vtA00Yb/PQ1nQieEKZ/PAP3qHJYK8Da1UYwf5QlD4CLDDyW1hZiUVjo/JsdtA8Gq3L6jthhHm8t9Ed02E76t7p0lODtmFiIrcZx0F3kPT4A9Oq4Gamamf0DUu3yQdCTTsw==', 'MISMATCH', 6);
INSERT INTO `orders` VALUES (26, '2026-06-13 10:10:04', 95000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T10:10:04Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":26,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', '2KFcIhJwwFUoW8tuDmMVbam6SvirzH3LBcmFXQflsAj2VwuiII2MN6EQ7ykft+bd60/+DvSseAb4PpdWH/Ndd9smGdxeCLrjGxIGubHuedSO6hUxO8x1xUyiqOBfmUCqiCF/hhu8p2f/yYC7OPxMsd3sGzu6Wti8ip7gtEbKzcmdiDiwqoQWTGI/8vI2pu4vumeGvrBViMOjoHtec0wFeGyl00hGnL225q2JOMW7qA/OclE/05HheyZHOKIVBUOIrV+EbPGjU+6qM69VrgLVTgmuROCL2JAs/l7bsNYU17HJ2DM8R5ywCJb+DGp7bR5wqPbSJjamcr+JduhrSEFh7Q==', 'MISMATCH', 7);
INSERT INTO `orders` VALUES (27, '2026-06-13 10:47:20', 95000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T10:47:20Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":27,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', 'Ye/RCW88vncDxrZb36sRy76HczVynd9c+jm78T+LT6onvoyRt5nU5LMmjcetMoZRssm36FmY3sA0rGuhB+y4FZCkEdIaEm14LQUqgbzIiKN6sxKNDW5qqHPzVf2X2HDOWHsqyUPG/BfzM7DgNeSxKZh3p0cB/VoxMjyXfd6wrVUNKeIcdfYVcgiD4NFv5hkWAzYYFLLBozoPhBS0BQ8gAaKEWAZ8djnJf41+X38QECymJ2osLfwoWCni5MDcxtRHWW4TLEZN3S2j8yAhCJcA6jEQcsEkwxr7YbOXl2VupYkqHlo8xrbTxBh+LAALtBNQSovxwWJBVldKCtiTHme4Fw==', 'MISMATCH', 7);
INSERT INTO `orders` VALUES (28, '2026-06-13 10:51:27', 2131, 2, 'SHIPPING', '{\"created_at\":\"2026-06-13T10:51:27Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":28,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', 'vFvQbSOc2tfhmZoXpCSC9bX5SDLXKgcNRDT00QgoFNbyLAwt3YbA8ffR2yMXiTybjw9kQ1NE1CkltPjWqy+4u8hQiyOZKe1SkFBPkTkP6O1chz7SmchHnf1KCIXKWmcy9vtj3CAROr+vypU8G8w8wb/+XVGJbHPlYq5Lj4Wk13zBM2jpU6P1VJuAqXdpKOttIUe2M7nk7l6XOlbkwktIM5w4uZklEMdj1hEmNBBcsQNx9IWEu1q8WJNI/kOP3Qk7KR8s9jM4nE5cSu7rI5lsg+jgk8vTXq3NF/w1nyedWKxJdn8o49EaeXkb8j1QqJfGYODhzixxhOBJwUl84VCvlw==', 'MISMATCH', 7);
INSERT INTO `orders` VALUES (29, '2026-06-13 12:02:16', 32000, 2, 'PENDING', '{\"created_at\":\"2026-06-13T12:02:16Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1}],\"order_id\":29,\"total\":32000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);
INSERT INTO `orders` VALUES (30, '2026-06-13 12:03:28', 2131, 2, 'COMPLETED', '{\"created_at\":\"2026-06-13T12:03:28Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":30,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', 'IJXbgcCqguSh7aNx/XqhWSpLAG4eKG4PeXrbQ293RxcJuys1AJk1ZFNimFG3G1RDoBhEm/ak1QdW9qouNiIjpueTzlpQtqswSto/nIvZ0b/53GmQ+vYCh1q7QLpQ5rRZAYmb5v+uFgLeaS6qRGc5JYVWSc9OW2Nm39xXerug+//uZxABrOlYdr+qwTnHW6gCvTV3BvKsHJW9NnHGmlX1YEtqSvNaZuDTuPZYgxgn2vEB+7r0h01tcUsnJjfuaUXS/zHMWee3I4wyQ7iM49IsANr8cLHM86naMCFA1DVIPv7VlRhjpuFzujKPelidNhlZOx4bqpzHeJdPfduM4NuCrw==', 'MISMATCH', 8);
INSERT INTO `orders` VALUES (31, '2026-06-16 00:36:56', 38000, 2, 'PENDING', '{\"created_at\":\"2026-06-16T00:36:56Z\",\"items\":[{\"price\":38000.0,\"product_id\":4,\"product_name\":\"Sữa Tươi Nguyên Chất\",\"quantity\":1}],\"order_id\":31,\"total\":38000.0,\"user_id\":2,\"username\":\"duy\"}', 'Qi7eFTq6w4sdUwU1ChblJUHQtVhq1SlvtvKB/87ywgAL6yAbv++abtrp58C+u3nU3rcyPu66Mf7/Q+Lu/brv9+OGKcH2RTP2OIoG8Ov3j6CRsOe/Cr+w/rphYbU7kUQbJC5PQimzqzG6QO/o+Pc44vf4ddGPLVMKYZAoQ3rr5xDzTzevIi5Xdg7c/THe1ei9CY4t8tAOE+JuDgYcjI+v6jK9ms3K7FqYhTw3iG01tI5jd/rkTmXrz2IAJhyMOMr/MP/YbCvCG24DMvIk4yk309e+6XQCM6xg4x308yPt+j1c9UFRBIISWg1AT1ij1cWUHfXkohlzW9IVC3G4XwVxug==', 'SIGNED', 10);
INSERT INTO `orders` VALUES (32, '2026-06-16 00:42:18', 25000, 2, 'COMPLETED', '{\"created_at\":\"2026-06-16T00:42:18Z\",\"items\":[{\"price\":25000.0,\"product_id\":5,\"product_name\":\"Khoai Tây Chiên Giòn\",\"quantity\":1}],\"order_id\":32,\"total\":25000.0,\"user_id\":2,\"username\":\"duy\"}', 't2CDIPy1ZBTPhW4o3lwys844lJGc6X0HGJgY4UApbGvGT+ITR6+prm6hk9D9oyOJesA08vSNKtE8XQ+1rH9e0c4hNDL5Hg5yN5tAK/O0UXkSOp0ax8X6elUy5Cksbtfy28EtXYd5TCKRInzQpeQrtU8VKnxOv7u2EkG/UjosC7rP01ottnE8W5oc2k7WLwLIG9RkTwJHwV767xg5kUb2BYeLuRQpBJUYrutyKeugtABqJyAyLT4OghvD24RaVXRaoojRR9mcR18O+ZtzzBRu5P7ofS+w+oXoaRcetgq6Raf7hq1JWBvSFMdAgOd06wp1CRImJBZm+7OdVeTuz0V7ew==', 'SIGNED', 10);
INSERT INTO `orders` VALUES (33, '2026-06-16 01:08:01', 25000, 2, 'PENDING', '{\"created_at\":\"2026-06-16T01:08:01Z\",\"items\":[{\"price\":25000.0,\"product_id\":5,\"product_name\":\"Khoai Tây Chiên Giòn\",\"quantity\":1}],\"order_id\":33,\"total\":25000.0,\"user_id\":2,\"username\":\"duy\"}', 'RpVMvPGfnPULmo8DBD1ngZvYOatMl9+tX77TKRccivhuxG+XgQXIt+Ulp4elf3NZQgf4/HoL/bYWfQEr2Dl5boDScKL99y9vVnhqM79Kbj8WXGtDm1SYcYJt6BCJooqA+dJqHghq31R7jtPiuqlXiW2VNQu1nafU1fL3emAksaq4EEsm686LdQzLlTdBQALfTVYeiuQZRvFhn3xnFz3+nsXwsUe3ZsMkzlrSGbxolGEQvo3y3S/eZUYR6m1ewTDGLvNPKPplDUqZIBTjgw54v0TrcNXLj9DeSQdNYPmYA/hINOFcFpyXZnswihI/WI2xtznxk1C4L6651NymV/VgUg==', 'MISMATCH', 10);
INSERT INTO `orders` VALUES (34, '2026-06-16 01:16:12', 95000, 2, 'COMPLETED', '{\"created_at\":\"2026-06-16T01:16:12Z\",\"items\":[{\"price\":9995000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":34,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', 'Cfl29AabESoxahvSE2G3pSRAsjVhRjXp0AFH1Gb4EfiCho7ufhiUcWTiUK8kIXMvxlRZ5NB0HXA6b1eWVfaebyFyHrHsZ+3Y/6MLBVKx/dWK4nNN0ZLQ3Ru8Q29AoEMSh98CPTOF4Alj6//ys39p5cRPaUwx139BI3eMpwzQvFG+Vah9kxZdeDBLfc8BM9R0LHsxQ1z+fWgPbWNGEmIfUqpQOnvdt9DRDkzupanaSER66Rhx2Q6GYSiQi4TAbqgffHGSuZM0MWz3B3eWoYtqqs2uqwmK+xS+Np9D/iJ2eJFcXYP+09gvgpm4GFsnQsdpZpmA2iTEwzkUvi2QKF8Ipw==', 'MISMATCH', 10);

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
INSERT INTO `products` VALUES (2, 'Chuối Tươi', 32000, 'https://images.pexels.com/photos/2875814/pexels-photo-2875814.jpeg', 'Chuối chín tự nhiên, thích hợp cho sinh tố, làm bánh hoặc ăn nhẹ.', 1, 1, 107, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (3, 'Rau Cải Bó Xôi Hữu Cơ', 45000, 'https://images.pexels.com/photos/1751149/pexels-photo-1751149.jpeg', 'Lá cải bó xôi non hữu cơ tươi. Phù hợp cho salad, xào hoặc sinh tố.', 2, 3, 57, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (4, 'Sữa Tươi Nguyên Chất', 38000, 'https://images.pexels.com/photos/2198626/pexels-photo-2198626.jpeg', 'Sữa tươi nguyên chất tiệt trùng loại A. Hương vị béo và thơm, thích hợp để uống hoặc nấu ăn.', 3, 5, 76, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (5, 'Khoai Tây Chiên Giòn', 25000, 'https://images.pexels.com/photos/479628/pexels-photo-479628.jpeg', 'Khoai tây chiên giòn vị muối cổ điển. Món ăn vặt hoàn hảo cho mọi dịp.', 4, 6, 147, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (6, 'Cà Rốt Hữu Cơ', 30000, 'https://images.pexels.com/photos/6631952/pexels-photo-6631952.jpeg', 'Cà rốt hữu cơ giòn và ngọt. Thích hợp để ăn sống, nướng hoặc ép nước.', 2, 3, 70, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (7, 'Phô Mai Cheddar', 90000, 'https://images.pexels.com/photos/139746/pexels-photo-139746.jpeg', 'Khối phô mai cheddar vị đậm. Phù hợp cho sandwich, món nướng hoặc ăn kèm.', 3, 4, 29, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (8, 'Dâu Tây Tươi', 95000, 'https://images.pexels.com/photos/2820144/pexels-photo-2820144.jpeg', 'Dâu tây tươi ngon và mọng nước. Phù hợp cho tráng miệng, sinh tố hoặc ăn nhẹ.', 1, 6, 71, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (9, 'Sữa Chua Hy Lạp', 18000, 'https://images.pexels.com/photos/414262/pexels-photo-414262.jpeg', 'Sữa chua Hy Lạp nguyên chất, giàu protein, vị béo và hơi chua nhẹ.', 3, 4, 110, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (11, 'kivi', 2131, 'https://cdn.tgdd.vn/Files/2014/09/25/569033/10-loai-trai-cay-cap-cuu-khi-bi-benh1.jpg', 'asfasd d d', 1, 5, 26, '2026-03-12 18:02:45');

-- ----------------------------
-- Table structure for security_log
-- ----------------------------
DROP TABLE IF EXISTS `security_log`;
CREATE TABLE `security_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `event_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `logged_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of security_log
-- ----------------------------

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
INSERT INTO `users` VALUES (7, 'duy11', '123', 'user', 1, '2026-03-12 18:38:00', '2026-06-13 09:32:10');

SET FOREIGN_KEY_CHECKS = 1;
