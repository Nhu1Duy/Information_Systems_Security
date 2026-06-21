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

 Date: 20/06/2026 12:45:39
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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `key_store` VALUES (10, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuBPpHlP/s6RrbsuEVE8SHwhBJIS15PReVazBVqKu4Wwt4m88ddIafC39wZ/ElFQrAuLohDenfOmMEJ8d/ylTYguXqVztCyV8pQ61qsnpMSkQkWC0+JTDHuk86bjzquVb7qDmuF7Y6kMa+m/azMptoXfpY6LIQ2zyrslhyoqDOaHlyj09rbhjBBBIxJ16ZXVUqJOIBpAzFN38qpCPfhmf+TTEtBXX9kVIS18aPFVb0zlHRBXgs6msn24L8VUmEjjYTiX6Z5Nv5q4XuGzUC2MBJI6AQPTEo4sDwKLiava6ijmNmqzl2K+SB2wdTnG0bQ+wzkXTbEIn1Njq/sjKuHXtAwIDAQAB', 'REVOKED', '2026-06-16 00:37:06', '2026-06-19 21:37:40');
INSERT INTO `key_store` VALUES (11, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwfiWgkb3vT1JRepx+kduWbq4xS2C4l6xv6SBrnDuWYFNMYzVY/EYrjg8VlFpgNXTD7JzW+VXrO0mRV9CHkHsa3egYFo2JsKnQAG9fIBRVQ/Nov1XM9pfnnOzf8BVK0fES4BulZeKXzh8ovrMpswN0LhX6DVO4cqklDVIPzpr1vCbDhjcw8+qb/5NOB6nXLRTsw1syC11orm5ohH+CIp59dt3d/jUzUfdR6SU6KwnXNViBX9OmT19obtxfr7YUcumTOqvc0G5s6k6fGfAmczYDMy9z0XB3SoDPK+gQO7E3YiWpslRXEPV+bOjiZ18L7SaDc75cRPWnIOP+coVpvo14wIDAQAB', 'REVOKED', '2026-06-19 21:38:03', '2026-06-19 23:28:25');
INSERT INTO `key_store` VALUES (12, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqY/p9NdEvhLqx4r7IYIkfxVA9KEhVxf/FQ3UFV3D0PLjzBKyFW2dlrI3+UsvRsG2FPnvBtWfK8eTFoscdVAEGAdH7aIYeqKjClOifQ3xgGpHR8uThhjrFnK2iIcFdA3I00MmgvNzWNq+AzPqsvFb9SH65yanm/qWRFALgUbciTMs1Jh8ObTWvtKxFzspEFTiTiw/8D9qPyn/d4PP73wpgo911cINrvIpf8uxJr3ohKP5H7DHkbMdtAF3WcbZWzs/2tgXCcRlYybByUSEHRCGwSUMwySOSSxdoMT83JFn9uHMHYDwRJQ2QhPqdWnE7/+l+/gHhcWs4AqE63AXrDRPHQIDAQAB', 'REVOKED', '2026-06-19 23:35:28', '2026-06-20 11:39:16');
INSERT INTO `key_store` VALUES (13, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjM0dPlmJ4AFPufidAjBXvo9OWjP70kT+mepBuAW4kytkgdh18OzaeQflqvxsZsejxSft1yTROGmFG8AgMXjafzUjDpNuaASgkp0kC7q56wZ46j9kfxZrSaMc342b2q2r5miwZ2wgbgaWFHh3ZZ0o0Jg2macT1haUDREwZLZHruaJjP19DUOkjmikwM3S1h/DKw8cGGbgIi1VVx1VeYLiIlwEaQJIsnmgwaZS2UIAS9yEr09MqtvExVaplSt1VmvVGftmD/ZJTMP3jFLkcmVBCWdwDGUz8ptrkhMjY3/dWpftJX8NTvyMk8uqS8Rs+C4jzCVoM2nH0Fep0FAYfIxjIwIDAQAB', 'REVOKED', '2026-06-20 11:39:19', '2026-06-20 12:18:02');
INSERT INTO `key_store` VALUES (14, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuceLWidHpAetp+C9HH1yvrNSdV5b0v8P+I5X589mw6yIHSI2PUFVyJJK0DVIvte0xv/DD4xiI07K+yhoJCF2tAC5Q7uiD3oKXs9Xy431vbs1qu7drQWnVzNwzu9cIGOPtNNVN5KFmZh0MCajVIhbEkMIK4CAKLcwTzH14PbVp3PsfNgOvISYgtz0iSV5vCbJP9mnB2Azq+C/DQ12Jn0B3KUrrSwKrNHDpYXjE0wg6LJ87gRmUM6PEscWAcpFf8jX1wkfFmaJ7iktiXI7iSFuiOI/0bLiQ/SLLUSswnehdpJws0FOdRAIrXGkTmowpnyTu03lzGeJ+K9ZizT36DmUZQIDAQAB', 'ACTIVE', '2026-06-20 12:18:05', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (48, 43, 8, 1, 95000);
INSERT INTO `order_items` VALUES (49, 44, 2, 1, 32000);
INSERT INTO `order_items` VALUES (50, 45, 7, 1, 90000);
INSERT INTO `order_items` VALUES (51, 46, 11, 1, 2131);
INSERT INTO `order_items` VALUES (52, 47, 2, 1, 32000);
INSERT INTO `order_items` VALUES (53, 48, 5, 1, 25000);

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
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (43, '2026-06-20 11:35:41', 322354234, 2, 'CANCELLED', '{\"created_at\":\"2026-06-20T11:35:41Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":43,\"total\":9342345000.0,\"user_id\":2,\"username\":\"dudy\"}', 'tuBySv3p34xBL45pVTeX6r6ifrNaTUXQHhc/f86Uw5nYA2/BkTs9Djgk8z1sAeztQTMmPJV7w1YpBU6m66us76XXJoEFl6PPk17OxfEcvjT+Hcr8YPpK3LLc4ank3iVvHxwoRKqbwd80ghVVCCujPq/4ludvEeEkhfPIW80tKPyn1EeJAcIKeFGVpaMXmqAWJWnC13UUwrNwqHhsbI33UHwQgwShCfPAumFFXE5cWBNPIG7JYRKJbOToWifNfCTc1h9i4d3pBZG1OhmOG4smf4vGi2n8MTm+cIHtC5+Aa5O89uzg1jmTfH3hc5wK8Mkfj05g9h3IY322SOaObjEdYA==', 'KHÓA BỊ THU HỒI', 12);
INSERT INTO `orders` VALUES (44, '2026-06-20 11:40:59', 32000, 2, 'SHIPPING', '{\"created_at\":\"2026-06-20T11:40:59Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1}],\"order_id\":44,\"total\":32000.0,\"user_id\":2,\"username\":\"duy\"}', 'ebwUSE+5maRv0M5ziNSL5XmjhnVRvnKh+zGz3C7fXl164bEVNlvAFped6YWfGiKZDxmkETbfKVWZhyD1doVBdvgaRA8vM0JTfbOvNQXV8xG31pc21/1+PzpuRG8FUoiPQuy0LpzNSTEb52XZ4tEYmsg/GuSFNU6mux06CYzdaDI8b2RYm3WNSBPziJP7SDUFR/ZWauzlLsVZW1yPC2PaSUmq2JrJ65LuaLD6yCHVKfxVJt2/kCIGo7qGSMO2ck3Tlz0MhrxH0ndR2GQT3eMIqriFKrnw6c7psAEm+ZHRG+Me2uX5No5N7h2QneMlQvesdocUMRhGZEEuAvF+b4pt9A==', 'ĐÃ KÝ', 13);
INSERT INTO `orders` VALUES (45, '2026-06-20 11:42:04', 90000, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-20T11:42:04Z\",\"items\":[{\"price\":90000.0,\"product_id\":7,\"product_name\":\"Phô Mai Cheddar\",\"quantity\":1}],\"order_id\":45,\"total\":90000.0,\"user_id\":2,\"username\":\"duy\"}', 'QkkLRSrbqqGBHYi2juySjQik1oIRN48J2QUNxVqE9bzWo9TyQj7HdYV1BBycUGMRq1CVi4iNBzrO/9gLysNBbYrQz2TfFfSeROa1G/jUwrAywB3cyRZOPQTJQ6a8zz0utSAiIYLHOG8Y8VkCgiJj2UEqnJ1HCYVGWWwf71J+Qotie6IFd8qizsGWs/eVzbDARVeRjTuk9xHAR5KLsD+i/mu//dhd19YDkdWuEqoy79jvf71eZKOWH7ymaRVUrX9SXpDjxeMMFI2sNNU1GuTnlMZKBYE47EIco8bVsuS6MxjXvwsgs4YuFNaAdnihYNfQQs5V4ScxT2N4gpIcptnSfQ==', 'ĐÃ KÝ', 13);
INSERT INTO `orders` VALUES (46, '2026-06-20 12:15:49', 2131, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-20T12:15:49Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":46,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', 'Ap2NvlcX79hp1MndPyF9Y1Uq5EvirfHkgRrKjfxvDS63Q61Kc9Rzo7wJPc8Yd5HsURYwd7+562OS7FpZJSwC7Yebff8KNOijv1oGTwXyeB3f0/elJBrBLgPWYv85aXyT39Hf8kkBDDGa5PeqJwokfN2zNfk7sblGZ2YQF3EegbGHAMuDLH5uCPuc81ST3YbWzZzKL4+csW1LDxLJgw8ea3ni4m6EKP4p4Zm5DqSwlvCZD2eWZetTjGZQjQCVwltKLxxPCA/8mkaTrjlyohmkI4Ciu2ALkOqDEqfvNQlaIHw2ldRqOqdXOrulQWwmk36YdUDGztraT6C7Ny85rjAzZA==', 'ĐÃ KÝ', 13);
INSERT INTO `orders` VALUES (47, '2026-06-20 12:22:15', 32000, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-20T12:22:16Z\",\"items\":[{\"price\":32000.0,\"product_id\":2,\"product_name\":\"Chuối Tươi\",\"quantity\":1}],\"order_id\":47,\"total\":32000.0,\"user_id\":2,\"username\":\"duy\"}', 'gb/iGMzUiynXdhJoicz+Zv2P0n+aSMxZkIGVCSRZJBRozNYTMDkNwIWZlr+5qEXH1XtIrhqyC4zOQAyKDfYsbTutnd3Ctq7dg72H3SYmiFbvs9V3Xen67dlrqBzsUjjGvjK/58mKUADvdD2dEQxS9LHRL2I++RQWyefc6UFyK/WWboHcIU8cFRz6cXLwSOHhk9FDoYDFmwRvVASKajTI8wIhHJt+zaaLVm+de3CQvcacy+lzsSCeF7almuMoWeWijL1rymIjxKy/2x2K5fDDrBa1a73/stHdjhu4i/TUmXO82TmvmiLjBKFb6mtn7bv2/Kj8JOGbq4sFTnS5mwf2wg==', 'ĐÃ KÝ', 14);
INSERT INTO `orders` VALUES (48, '2026-06-20 12:24:46', 25000, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-20T12:24:46Z\",\"items\":[{\"price\":25000.0,\"product_id\":5,\"product_name\":\"Khoai Tây Chiên Giòn\",\"quantity\":1}],\"order_id\":48,\"total\":25000.0,\"user_id\":2,\"username\":\"duy\"}', 'sREa8OLxDoU4zD07m4SNP979wv9hXPOx5b5b67A2PhIN+6ftwImWYpxkRKjfqick60NDgBNsszLtz41kP3hLO04C+kW0gXHi4psMlfxbbupr4/TRZRP+vYul8mmeK8aOhQ7t4jC4U0g+mPxFbUwajCVqywIStgTbjXkuM92F38xXyYiMJSk238ebEZ4XMlozo2pjf/aLHc1kbaAHxEkV0wvngo086+GWTHP2KZEbUYAMdCFDuyE+pjmhpbC9YOY5jW0VXQ5PfYPEmSyoVmzpzKO6du/otlzorMPLFhkgAC8s+XrlrPq09JuZjxdsonGssAS0NBScS4jIIBhfsgBsog==', 'ĐÃ KÝ', 14);

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
INSERT INTO `products` VALUES (2, 'Chuối Tươi', 32000, 'https://images.pexels.com/photos/2875814/pexels-photo-2875814.jpeg', 'Chuối chín tự nhiên, thích hợp cho sinh tố, làm bánh hoặc ăn nhẹ.', 1, 1, 105, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (3, 'Rau Cải Bó Xôi Hữu Cơ', 45000, 'https://images.pexels.com/photos/1751149/pexels-photo-1751149.jpeg', 'Lá cải bó xôi non hữu cơ tươi. Phù hợp cho salad, xào hoặc sinh tố.', 2, 3, 56, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (4, 'Sữa Tươi Nguyên Chất', 38000, 'https://images.pexels.com/photos/2198626/pexels-photo-2198626.jpeg', 'Sữa tươi nguyên chất tiệt trùng loại A. Hương vị béo và thơm, thích hợp để uống hoặc nấu ăn.', 3, 5, 76, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (5, 'Khoai Tây Chiên Giòn', 25000, 'https://images.pexels.com/photos/479628/pexels-photo-479628.jpeg', 'Khoai tây chiên giòn vị muối cổ điển. Món ăn vặt hoàn hảo cho mọi dịp.', 4, 6, 145, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (6, 'Cà Rốt Hữu Cơ', 30000, 'https://images.pexels.com/photos/6631952/pexels-photo-6631952.jpeg', 'Cà rốt hữu cơ giòn và ngọt. Thích hợp để ăn sống, nướng hoặc ép nước.', 2, 3, 70, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (7, 'Phô Mai Cheddar', 90000, 'https://images.pexels.com/photos/139746/pexels-photo-139746.jpeg', 'Khối phô mai cheddar vị đậm. Phù hợp cho sandwich, món nướng hoặc ăn kèm.', 3, 4, 26, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (8, 'Dâu Tây Tươi', 95000, 'https://images.pexels.com/photos/2820144/pexels-photo-2820144.jpeg', 'Dâu tây tươi ngon và mọng nước. Phù hợp cho tráng miệng, sinh tố hoặc ăn nhẹ.', 1, 6, 65, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (9, 'Sữa Chua Hy Lạp', 18000, 'https://images.pexels.com/photos/414262/pexels-photo-414262.jpeg', 'Sữa chua Hy Lạp nguyên chất, giàu protein, vị béo và hơi chua nhẹ.', 3, 4, 110, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (11, 'kivi', 2131, 'https://cdn.tgdd.vn/Files/2014/09/25/569033/10-loai-trai-cay-cap-cuu-khi-bi-benh1.jpg', 'asfasd d d', 1, 5, 25, '2026-03-12 18:02:45');

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
