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

 Date: 22/06/2026 20:41:20
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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `key_store` VALUES (14, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuceLWidHpAetp+C9HH1yvrNSdV5b0v8P+I5X589mw6yIHSI2PUFVyJJK0DVIvte0xv/DD4xiI07K+yhoJCF2tAC5Q7uiD3oKXs9Xy431vbs1qu7drQWnVzNwzu9cIGOPtNNVN5KFmZh0MCajVIhbEkMIK4CAKLcwTzH14PbVp3PsfNgOvISYgtz0iSV5vCbJP9mnB2Azq+C/DQ12Jn0B3KUrrSwKrNHDpYXjE0wg6LJ87gRmUM6PEscWAcpFf8jX1wkfFmaJ7iktiXI7iSFuiOI/0bLiQ/SLLUSswnehdpJws0FOdRAIrXGkTmowpnyTu03lzGeJ+K9ZizT36DmUZQIDAQAB', 'REVOKED', '2026-06-20 12:18:05', '2026-06-21 18:51:34');
INSERT INTO `key_store` VALUES (15, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAni36UdBNB+JHZGKU+q7fYeeIlecyL0Q5JaWWVqEdPUjly8TE7kdVCXALKnFs+64Esks4ctKOTF03SZA3rhLMxuSmHsRb1bkCyDPTds+hDfc3elMeC9YRNZ2VRpbel4jmjQR7mhWkBRczvPC0v5VzWcoDJxpgUwA0pPdtXw0aDmLkxUxlZH6DiUgze24KrDCIpcskP/cCfBi2VQy1BoEZvyTtyALLSEtuawoL+8HKdF1LdXVpb9UPFLy2I/6HorJ8fY+A831XLGUwcoepQelEUWuULfKPh5tRtxyVbu9wDv2ZPlqFrQfJiIyAEvjwR9MtOYZw6MMKmMXoiBAclhfuQQIDAQAB', 'REVOKED', '2026-06-21 18:51:46', '2026-06-22 16:13:15');
INSERT INTO `key_store` VALUES (16, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw1V8Q38DXL5RJ9o9M3Mg8TVNWR0zLTrszomCbLQskF1QHvK0J3I3nZsH56TD6OC3SnZgAHKXqoMWHtAmENbYh0dH1zQVGGPxPtDCnjQIvRjwiJll4w16oIeJtzxynUzx1U9aNCrMi5OQy0jeav37EGYyR5SQm+fOjkNbl0OX1pcrU0BSsyBunoYwbozqrHxZu/cgvKw7jlr3miQPqBcjtyLKdXDiboCnYCQ3CUtS12KrX01Zclq/ckmcO17gmDFVMBt0k8ZWECRKYP2fUtpmF4If7WkiH9+WrtIy64LK/3ncaCMCjiLXJeXeJwdvIiUrgTizm9NvbsGHnYXb+zwbJQIDAQAB', 'REVOKED', '2026-06-22 16:13:17', '2026-06-22 18:20:41');
INSERT INTO `key_store` VALUES (17, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArtQUHlmWFgR+OSZknOCcG84GK1AD62+MEm1Se5jIY1bAGt9r94nyJOuJEex4gY5R+tLNAduHjZqIETM5XJA+XFJEbXvrmxD2ZvVaBRLGedq/5CPANHUvbqbUu+8AZw87e1jLCfZYBu7PXWnq7Ogy5Dop+CXRpJbf+JbHpDiycbj/cuUj511BZtpiZYyGIElw/vznBDyL3vMT/UugSjBtbGcDceJKRhBrLGebqfhEagJ3YYNBmSDYOeDncpbKO51+l7U3mEVO+wtPHwI2gYIJNQXieR4ADea12XMqeG/ldR9wTusuKZV4s+KSSI2rqITSSWvVPqbFS8PuS7h9Ij5LJQIDAQAB', 'REVOKED', '2026-06-22 18:21:28', '2026-06-22 20:10:47');
INSERT INTO `key_store` VALUES (18, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwSMPdoj+lMEoSaA9vRUjqhomv322WSN2URd0npkE1/HlWJmG7SSQj/QRKzegSGzNWUQao19mHf8JBXuihlKzMn6VpV8hNw4n+5HqqhZP2j2s28jPvkXM6d2prxUUK7cfPWkRwcyDvp75yGQu9LJC1f//YsG//7b90D2uJcliBHk54FZvAyakDvoV4ZMjuFUxPSdjEAMvzoqsDc0kupznEZMAIqDXBY0G0fwLDFExzMTbR8utEjJf2LLHOY0SrtXzl5gXFqwk7Lan6aI6ibxUDlnlWalPKy2d8+HtoQoL9TxAb8sSjTyjk2lfoah5XHZCtswKFhlzVJjvB3PrV1/jYwIDAQAB', 'REVOKED', '2026-06-22 20:11:18', '2026-06-22 20:29:16');
INSERT INTO `key_store` VALUES (19, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnKHz5QzXF7vwDnh7Qd/lneNG5faS3vBpRLaG0mB1eJScJi3yEn2kAkM2ns3Gd44cmY8aRdBr/2HWpmksTTloz8py/pkRZx7w/EG0EwRDu/PpkxxeVawfnmFxo2gp20i6UDUC6ByT362ts6TDZmMGuyccpTIlJ9dWCqh35yaqZxySAq485kFqZoGCicXyIKxiK7OjURHujtGO8t8GHAZuwbE8YZ+0/rZIRMquf2qhribFS74gU/OIdczoqLX05FyaFdAH/DVVJqnVRVVrnDrg1ASsqxscl/gNWG3Xg/8h4ij5M082OhLMJtxO7sKkWJZMyXGUw73oSngTO4/9dNiXhwIDAQAB', 'REVOKED', '2026-06-22 20:29:18', '2026-06-22 20:36:38');
INSERT INTO `key_store` VALUES (20, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvbN4adA48Okr1+P5MhXbLaBANi2hWtj9qOH941GcePvxxOToohhCqUPvNRPAS8NFTnBiTSMMpwdhv4qFOYJ0q8iJS+peohyZX43fsR/VsA3GmcUemmStoHyc5UkgPcuc4u6APCGuW6oTTDVVhMpVSZ2e4SCChz9kV0vsrsLjdeHzNJRHozlwogVQ3/JpPS4fikMsIeqlFkYPzEfiTn1OLW4EP1IIFQcQgo5kHVTE70VrNnmTQcEcf1Y3lqj72BxjpFeGK3ExJMCz1XQUfA0OiBGHKFzRPL61RSCr3By637wT+60RAQynyznNsH52z47My1kXz5jhZ9JIflO/N5f9UwIDAQAB', 'REVOKED', '2026-06-22 20:36:40', '2026-06-22 20:39:08');
INSERT INTO `key_store` VALUES (21, 2, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8yA4teYyn5eY8v1l7yP20vhCveYjHkI7RyErWieG6OiKn6Ttt0EMVrs/3TGmiirHenidTxC3QIf6lYjc8SZjuTfiyqGNPvS30L0YEbuW3mmaYK4JYqjBwiQN5DdyT0GIRCAG0tAs2AuUNGItw91gDJ3ATuKWoxFxVGAcOYqnmYVkf/7/jWixr6tEvXS20NIrukGlOTTc92TZTbl3WbnqyLGNtNMv3Pi2G/4KUW1RYRK9CbJdg5xTm8HST8DoVadBmUiPiLNC8S8maMN8q1ZduQEgr8swMI/HqlUOiVesYEkHl6+ec0fK5zfkRgq8s20RcikOTtUgGNpD9dCoBayG8wIDAQAB', 'ACTIVE', '2026-06-22 20:39:15', NULL);

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
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (60, 54, 5, 1, 25000, 'Khoai Tây Chiên Giòn');
INSERT INTO `order_items` VALUES (61, 55, 8, 1, 95000, 'Dâu Tây Tươi');
INSERT INTO `order_items` VALUES (62, 56, 11, 1, 2131, 'kivi');
INSERT INTO `order_items` VALUES (63, 57, 5, 1, 25000, 'Khoai Tây Chiên Giòn');

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
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (54, '2026-06-22 20:35:13', 25000, 2, 'CANCELLED', '{\"created_at\":\"2026-06-22T20:35:14Z\",\"items\":[{\"price\":25000.0,\"product_id\":5,\"product_name\":\"Khoai Tây Chiên Giòn\",\"quantity\":1}],\"order_id\":54,\"total\":25000.0,\"user_id\":2,\"username\":\"duy\"}', 'Ye1gSJM6E8uJJv2bOaFmG1/QzPNY0QLUTvxce2QrO9d1LXpJ+AfHS84OwETC8Na42BgEArQoOlZJMgbYt9sYwqnWkSSp35WCy78QMTpbZdTYLj85vclKm7UEZailIvl4uJ1VOJh4VAeoF23uistW4N7fZ5BotKYC/jg1M6H2UDiNZWt3Ua8h3RhrxHV3rKw0+2mjrhiF4zFKOePO2sHJm0bquRNzTTAf17IuWRrmUSkWh9/+LlYqkCPiC+On86/P7laivGRMSJhYdWpuAIr+3PuPsMm/f4VTizAbmIRbT/Ltf05+JqxvBw4zkIx08K4sHP9sKHGBazSeW+sRKuG6Mg==', 'MISMATCH', 19);
INSERT INTO `orders` VALUES (55, '2026-06-22 20:37:34', 95000, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-22T20:37:34Z\",\"items\":[{\"price\":95000.0,\"product_id\":8,\"product_name\":\"Dâu Tây Tươi\",\"quantity\":1}],\"order_id\":55,\"total\":95000.0,\"user_id\":2,\"username\":\"duy\"}', 'qTTd9KXUmgScQRSKmHJ9x/Nd7eS6AMG/Ux+97G+LtzX45W589qD1X8Kxxwr5sTyE2KU/AcX9qPwJVjTzWB1NvLF3JP7Je/N/MdM4x+JhSRGm8UiCYUdn1ULh+FwQRDiD7DYbO+GmGT9y2JwIBdj49+QX0henNsisbBCipSyFVCOz/idLjl5Uoxy80zF94POwxkbklZvc2aoGawsvWEY5cu2Yb9kxfxtaXK2MCso4Ofpwukz26ZjsHGXKa2I0QG/w+sjC821mHQYY+QtrK+H4u07ezXgf++2IubKjbygBl2SoNAhvhsEbUeSM4WW9goB7OlMbpyQokwALIlJeHfMbfA==', 'SIGNED', 20);
INSERT INTO `orders` VALUES (56, '2026-06-22 20:39:30', 2131, 2, 'CONFIRMED', '{\"created_at\":\"2026-06-22T20:39:30Z\",\"items\":[{\"price\":2131.0,\"product_id\":11,\"product_name\":\"kivi\",\"quantity\":1}],\"order_id\":56,\"total\":2131.0,\"user_id\":2,\"username\":\"duy\"}', 'NZrESVFfYjUsk7JL6N4QV5DdRXMaVHKnz/ne+KlRI7eghS7bsXZUuN5pw0dHDfveBwxmawjM3lLmzu3iWN69yM4MnzqhermefVLRxstcYem7gxPQuZ8lmZa5gkN4W76wdYelbLz5Mc44u9yXAu4snTWmFefe3U7nCiXnxP2rgxOgHEbKy0NlqwWbQe+OX/LfzvxTFie3pOyftkOzmXBoUcn/QdRYIgFcjDLtTiqiVIhqOxDiTq4PFPywLjuoHNBqTUGypSBBk6IN3efx5vTZE2yHchHfxAQsjDLVN47bPsOBzwNte8+MXnHk7HrXtn/+FfqKmuVnuqJbdkMcHgLgQg==', 'SIGNED', 21);
INSERT INTO `orders` VALUES (57, '2026-06-22 20:40:34', 25000, 2, 'PENDING', '{\"created_at\":\"2026-06-22T20:40:34Z\",\"items\":[{\"price\":25000.0,\"product_id\":5,\"product_name\":\"Khoai Tây Chiên Giòn\",\"quantity\":1}],\"order_id\":57,\"total\":25000.0,\"user_id\":2,\"username\":\"duy\"}', NULL, 'UNSIGNED', NULL);

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
INSERT INTO `products` VALUES (1, 'Táo Hữu Cơ', 65000, 'https://images.pexels.com/photos/209339/pexels-photo-209339.jpeg', 'Táo Fuji hữu cơ giòn và ngọt. Phù hợp để ăn trực tiếp, làm bánh hoặc thêm vào salad.', 1, 1, 97, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (2, 'Chuối Tươi', 32000, 'https://images.pexels.com/photos/2875814/pexels-photo-2875814.jpeg', 'Chuối chín tự nhiên, thích hợp cho sinh tố, làm bánh hoặc ăn nhẹ.', 1, 1, 101, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (3, 'Rau Cải Bó Xôi Hữu Cơ', 45000, 'https://images.pexels.com/photos/1751149/pexels-photo-1751149.jpeg', 'Lá cải bó xôi non hữu cơ tươi. Phù hợp cho salad, xào hoặc sinh tố.', 2, 3, 55, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (4, 'Sữa Tươi Nguyên Chất', 38000, 'https://images.pexels.com/photos/2198626/pexels-photo-2198626.jpeg', 'Sữa tươi nguyên chất tiệt trùng loại A. Hương vị béo và thơm, thích hợp để uống hoặc nấu ăn.', 3, 5, 76, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (5, 'Khoai Tây Chiên Giòn', 25000, 'https://images.pexels.com/photos/479628/pexels-photo-479628.jpeg', 'Khoai tây chiên giòn vị muối cổ điển. Món ăn vặt hoàn hảo cho mọi dịp.', 4, 6, 142, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (6, 'Cà Rốt Hữu Cơ', 30000, 'https://images.pexels.com/photos/6631952/pexels-photo-6631952.jpeg', 'Cà rốt hữu cơ giòn và ngọt. Thích hợp để ăn sống, nướng hoặc ép nước.', 2, 3, 70, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (7, 'Phô Mai Cheddar', 90000, 'https://images.pexels.com/photos/139746/pexels-photo-139746.jpeg', 'Khối phô mai cheddar vị đậm. Phù hợp cho sandwich, món nướng hoặc ăn kèm.', 3, 4, 26, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (8, 'Dâu Tây Tươi', 95000, 'https://images.pexels.com/photos/2820144/pexels-photo-2820144.jpeg', 'Dâu tây tươi ngon và mọng nước. Phù hợp cho tráng miệng, sinh tố hoặc ăn nhẹ.', 1, 6, 62, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (9, 'Sữa Chua Hy Lạp', 18000, 'https://images.pexels.com/photos/414262/pexels-photo-414262.jpeg', 'Sữa chua Hy Lạp nguyên chất, giàu protein, vị béo và hơi chua nhẹ.', 3, 4, 110, '2026-03-06 19:22:48');
INSERT INTO `products` VALUES (11, 'kivi', 2131, 'https://cdn.tgdd.vn/Files/2014/09/25/569033/10-loai-trai-cay-cap-cuu-khi-bi-benh1.jpg', 'asfasd d d', 1, 5, 24, '2026-03-12 18:02:45');

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
