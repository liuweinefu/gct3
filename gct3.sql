/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MariaDB
 Source Server Version : 100308
 Source Host           : localhost:3306
 Source Schema         : gct3

 Target Server Type    : MariaDB
 Target Server Version : 100308
 File Encoding         : 65001

 Date: 02/11/2018 17:20:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for card
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_number` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `balance` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `otherphone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `card_type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `card_number`(`card_number`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `card_type_id`(`card_type_id`) USING BTREE,
  CONSTRAINT `card_ibfk_1` FOREIGN KEY (`card_type_id`) REFERENCES `card_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of card
-- ----------------------------
INSERT INTO `card` VALUES (1, '250', '测试用户测试用户测试用户测试用户', 'e10adc3949ba59abbe56e057f20f883e', 5000.0000, '123', '123', '123', '2018-08-19 14:24:49', '2018-09-28 07:34:35', 13);
INSERT INTO `card` VALUES (2, '2', 'name', '', 0.3000, '133phone', '133other', '备注826', '2018-08-19 14:02:13', '2018-09-28 07:36:23', 2);
INSERT INTO `card` VALUES (9, '3', 'c', '14e6a05b6a4dcdc99ee86175fe494aab', 10000000.0000, '11111111111', '0000', '备注119', '2018-08-19 14:03:32', '2018-09-28 03:22:43', 3);
INSERT INTO `card` VALUES (10, '4', 'd', NULL, 0.0000, '00000000000', '0000', '备注817', '2018-08-20 13:42:41', '2018-08-22 12:36:09', 4);
INSERT INTO `card` VALUES (14, '5', 'e', NULL, 0.0000, '00000000000', '0000', '备注534', '2018-08-20 13:42:59', '2018-08-22 12:36:09', 8);
INSERT INTO `card` VALUES (15, '16', '新会员卡 608', NULL, 0.0000, '00000000000', '0000', '备注367', '2018-08-22 14:05:52', '2018-08-22 14:06:55', 12);
INSERT INTO `card` VALUES (23, '10', '新会员卡 433', NULL, 0.0000, '00000000000', '0000', '备注248', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 7);
INSERT INTO `card` VALUES (24, '11', '新会员卡 245', NULL, 0.0000, '00000000000', '0000', '备注292', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 14);
INSERT INTO `card` VALUES (25, '12', '新会员卡 756', NULL, 0.0000, '00000000000', '0000', '备注166', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 2);
INSERT INTO `card` VALUES (26, '13', '新会员卡 218', '', -10989.3000, '00000000000', '0000', '备注318', '2018-08-22 14:06:16', '2018-10-28 10:23:13', 3);
INSERT INTO `card` VALUES (27, '14', '新会员卡 646', NULL, 0.0000, '00000000000', '0000', '备注967', '2018-08-22 14:06:16', '2018-09-07 02:35:17', NULL);
INSERT INTO `card` VALUES (28, '15', '新会员卡 466', NULL, 0.0000, '00000000000', '0000', '备注20', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 2);
INSERT INTO `card` VALUES (29, '19', '新会员卡 315', NULL, 0.0000, '00000000000', '0000', '备注251', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 9);
INSERT INTO `card` VALUES (30, '18', '新会员卡 103', NULL, 0.0000, '00000000000', '0000', '备注194', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 13);
INSERT INTO `card` VALUES (31, '17', '新会员卡 33', NULL, 0.0000, '00000000000', '0000', '备注395', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 2);
INSERT INTO `card` VALUES (32, '9999', '新会员卡 671', NULL, 0.0000, '00000000000', '0000', '备注572', '2018-09-07 02:35:02', '2018-09-07 02:35:17', NULL);
INSERT INTO `card` VALUES (39, '110', '2', NULL, 0.0000, '3', '4', '5', '2018-10-31 08:26:59', '2018-10-31 08:26:59', 1);
INSERT INTO `card` VALUES (40, '111', '111', NULL, -6552.0000, '222', '333', '444', '2018-10-31 08:34:55', '2018-11-01 08:18:07', 2);
INSERT INTO `card` VALUES (41, '112', '333', NULL, 0.0000, '444', '555', '666', '2018-10-31 08:37:46', '2018-10-31 08:37:46', 3);
INSERT INTO `card` VALUES (42, '113', '12', NULL, 0.0000, '13', '14', '15', '2018-10-31 08:38:27', '2018-10-31 08:38:27', 13);
INSERT INTO `card` VALUES (43, '114', '234', NULL, 0.0000, '542', '6667', '86554', '2018-10-31 08:40:38', '2018-10-31 08:40:38', 14);
INSERT INTO `card` VALUES (45, '115', '1', NULL, 0.0000, '1', '1', '1', '2018-10-31 08:44:35', '2018-10-31 08:44:35', 2);
INSERT INTO `card` VALUES (50, '654', '11', NULL, 0.0000, '22', '33', '44', '2018-11-01 02:16:36', '2018-11-01 02:16:36', 3);
INSERT INTO `card` VALUES (54, '1', '3', NULL, 0.0000, '4', '5', '6', '2018-11-01 02:23:24', '2018-11-01 02:23:24', 6);

-- ----------------------------
-- Table structure for card_recharge
-- ----------------------------
DROP TABLE IF EXISTS `card_recharge`;
CREATE TABLE `card_recharge`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `card_recharge_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `card_recharge_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for card_type
-- ----------------------------
DROP TABLE IF EXISTS `card_type`;
CREATE TABLE `card_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `discount` decimal(16, 4) NOT NULL DEFAULT 1.0000,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of card_type
-- ----------------------------
INSERT INTO `card_type` VALUES (1, '金', 0.5500, 2, '2', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES (2, '银', 0.6500, 3, '3', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES (3, '铜', 0.7000, 4, '4', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES (4, '铁', 0.8000, 5, '5', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES (5, 'Vip', 0.4500, 1, '3', '2018-08-19 14:36:35', '2018-08-20 12:28:32');
INSERT INTO `card_type` VALUES (6, '会员卡类型 256', 0.2500, 6, '备注764', '2018-08-20 12:49:12', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES (7, '会员卡类型 656', 1.0000, 13, '备注502', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (8, '会员卡类型 849', 1.0000, 12, '备注590', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (9, '会员卡类型 730', 1.0000, 11, '备注365', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (10, '会员卡类型 356', 1.0000, 10, '备注760', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (11, '会员卡类型 244', 1.0000, 9, '备注995', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (12, '会员卡类型 782', 1.0000, 8, '备注18', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES (13, 'abc', 1.0000, 7, '备注36', '2018-08-20 12:49:21', '2018-08-22 08:38:02');
INSERT INTO `card_type` VALUES (14, '会员卡类型 26', 1.0000, 14, '备注882', '2018-08-20 12:49:21', '2018-08-20 12:49:21');

-- ----------------------------
-- Table structure for case
-- ----------------------------
DROP TABLE IF EXISTS `case`;
CREATE TABLE `case`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `case` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `member_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE,
  CONSTRAINT `case_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of case
-- ----------------------------
INSERT INTO `case` VALUES (1, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:03:36', '2018-08-24 14:47:31', 5);
INSERT INTO `case` VALUES (2, '新病例 Fri Aug 24 2', '1', '2', '2018-08-24 14:04:18', '2018-08-24 14:05:43', 6);
INSERT INTO `case` VALUES (3, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:57', 11);
INSERT INTO `case` VALUES (4, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:57', 14);
INSERT INTO `case` VALUES (5, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:57', 15);
INSERT INTO `case` VALUES (6, '新病例 Fri Aug 24 2', '', NULL, '2018-08-24 14:04:18', '2018-08-24 14:05:43', 6);
INSERT INTO `case` VALUES (7, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);
INSERT INTO `case` VALUES (8, '新病例 Fri Aug 24 2', NULL, '', '2018-08-24 14:04:18', '2018-08-24 14:47:31', 1);
INSERT INTO `case` VALUES (9, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);
INSERT INTO `case` VALUES (10, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);
INSERT INTO `case` VALUES (11, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);
INSERT INTO `case` VALUES (12, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);
INSERT INTO `case` VALUES (13, '新病例 Fri Aug 24 2', NULL, NULL, '2018-08-24 14:04:18', '2018-08-24 14:04:18', 1);

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `stocks` int(11) NOT NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `commodity_type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `commodity_type_id`(`commodity_type_id`) USING BTREE,
  CONSTRAINT `commodity_ibfk_1` FOREIGN KEY (`commodity_type_id`) REFERENCES `commodity_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES (1, '足底', 230.0000, 9994, '', 1, '2018-09-08 16:02:53', '2018-10-26 02:40:00', 1);
INSERT INTO `commodity` VALUES (2, '针灸', 80.0000, 9985, '', 4, '2018-09-08 16:03:13', '2018-11-01 08:18:07', 2);
INSERT INTO `commodity` VALUES (3, '红酒', 138.0000, 10000, '', 5, '2018-09-08 16:03:29', '2018-09-20 02:12:54', 3);
INSERT INTO `commodity` VALUES (4, '新商品 120', 10000.0000, 10000, '备注807', 20, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (5, '新商品 214', 10000.0000, 10000, '备注305', 19, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (6, '新商品 102', 10000.0000, 10000, '备注861', 18, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (7, '新商品 896', 10000.0000, 10000, '备注152', 17, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (8, '新商品 58', 10000.0000, 10000, '备注469', 16, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (9, '新商品 561', 10000.0000, 10000, '备注304', 15, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (10, '新商品 361', 10000.0000, 10000, '备注755', 14, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (11, '新商品 816', 10000.0000, 10000, '备注865', 13, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (12, '新商品 492', 10000.0000, 10000, '备注599', 12, '2018-09-19 09:18:47', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (13, '新商品 978', 119.0000, 9998, '备注905', 3, '2018-09-19 09:18:57', '2018-10-28 10:23:13', NULL);
INSERT INTO `commodity` VALUES (14, '新商品 388', 10000.0000, 9998, '备注330', 6, '2018-09-19 09:18:57', '2018-11-01 08:18:07', NULL);
INSERT INTO `commodity` VALUES (15, '新商品 469', 10000.0000, 10000, '备注584', 7, '2018-09-19 09:18:57', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (16, '新商品 398', 10000.0000, 10000, '备注112', 8, '2018-09-19 09:18:57', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (17, '新商品 797', 10000.0000, 10000, '备注782', 9, '2018-09-19 09:18:57', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (18, '新商品 550', 10000.0000, 10000, '备注563', 10, '2018-09-19 09:18:57', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (19, '新商品 343', 10000.0000, 10000, '备注348', 11, '2018-09-19 09:18:57', '2018-09-20 02:12:33', NULL);
INSERT INTO `commodity` VALUES (20, '新商品 255', 523.0000, 9991, '', 2, '2018-09-19 09:18:57', '2018-10-28 10:22:10', NULL);

-- ----------------------------
-- Table structure for commodity_type
-- ----------------------------
DROP TABLE IF EXISTS `commodity_type`;
CREATE TABLE `commodity_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of commodity_type
-- ----------------------------
INSERT INTO `commodity_type` VALUES (1, '足底类', 1, '备注350', '2018-09-08 16:02:27', '2018-09-08 16:02:27');
INSERT INTO `commodity_type` VALUES (2, '针灸类', 2, '备注322', '2018-09-08 16:02:27', '2018-09-08 16:02:27');
INSERT INTO `commodity_type` VALUES (3, '商品类', 3, '备注528', '2018-09-08 16:02:27', '2018-09-08 16:02:27');

-- ----------------------------
-- Table structure for commodity_warehousing
-- ----------------------------
DROP TABLE IF EXISTS `commodity_warehousing`;
CREATE TABLE `commodity_warehousing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `commodity_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `commodity_id`(`commodity_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `commodity_warehousing_ibfk_1` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `commodity_warehousing_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for consumption
-- ----------------------------
DROP TABLE IF EXISTS `consumption`;
CREATE TABLE `consumption`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `is_cash` tinyint(1) NOT NULL DEFAULT 0,
  `is_close` tinyint(1) NOT NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `commodity_id` int(11) NULL DEFAULT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  `member_id` int(11) NULL DEFAULT NULL,
  `employee_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `wage_id` int(11) NULL DEFAULT NULL,
  `updated_at` datetime(0) NOT NULL,
  `created_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  INDEX `commodity_id`(`commodity_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `member_id`(`member_id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  INDEX `wage_id`(`wage_id`) USING BTREE,
  CONSTRAINT `consumption_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_2` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_4` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_6` FOREIGN KEY (`wage_id`) REFERENCES `wage` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of consumption
-- ----------------------------
INSERT INTO `consumption` VALUES (1, 99999999.0000, 11, 1, 0, NULL, 2, 14, 10, 2, 2, NULL, '2018-09-14 16:45:19', '2018-09-14 16:45:22');
INSERT INTO `consumption` VALUES (2, 12345678.0000, 1000, 2, 0, NULL, 1, 2, 13, 4, 5, NULL, '2018-09-10 16:45:33', '2018-09-10 16:45:37');
INSERT INTO `consumption` VALUES (3, 161.0000, 1, 0, 0, NULL, 1, 26, 1, 15, 10, NULL, '2018-10-26 02:26:52', '2018-10-26 02:26:52');
INSERT INTO `consumption` VALUES (4, 366.1000, 1, 0, 0, NULL, 20, 26, 1, 16, 10, NULL, '2018-10-26 02:26:52', '2018-10-26 02:26:52');
INSERT INTO `consumption` VALUES (5, 83.3000, 1, 0, 0, NULL, 13, 26, 1, 12, 10, NULL, '2018-10-26 02:26:52', '2018-10-26 02:26:52');
INSERT INTO `consumption` VALUES (6, 56.0000, 1, 0, 0, NULL, 2, 26, 1, 14, 10, NULL, '2018-10-26 02:26:52', '2018-10-26 02:26:52');
INSERT INTO `consumption` VALUES (7, 7000.0000, 1, 0, 0, NULL, 14, 26, 1, 17, 10, NULL, '2018-10-26 02:26:52', '2018-10-26 02:26:52');
INSERT INTO `consumption` VALUES (8, 366.1000, 1, 0, 0, NULL, 20, 26, 1, 14, 10, NULL, '2018-10-28 09:09:47', '2018-10-28 09:09:47');
INSERT INTO `consumption` VALUES (9, 560.0000, 10, 0, 0, NULL, 2, 26, 1, 12, 10, NULL, '2018-10-28 09:14:39', '2018-10-28 09:14:39');
INSERT INTO `consumption` VALUES (10, 366.1000, 1, 0, 0, NULL, 20, 26, 1, 16, 10, NULL, '2018-10-28 10:22:10', '2018-10-28 10:22:10');
INSERT INTO `consumption` VALUES (11, 83.3000, 1, 0, 0, NULL, 13, 26, 1, 15, 10, NULL, '2018-10-28 10:23:13', '2018-10-28 10:23:13');
INSERT INTO `consumption` VALUES (12, 52.0000, 1, 0, 0, NULL, 2, 40, 27, 14, 10, NULL, '2018-11-01 08:18:07', '2018-11-01 08:18:07');
INSERT INTO `consumption` VALUES (13, 6500.0000, 1, 0, 0, NULL, 14, 40, 27, 14, 10, NULL, '2018-11-01 08:18:07', '2018-11-01 08:18:07');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `otherphone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `employee_type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `employee_type_id`(`employee_type_id`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`employee_type_id`) REFERENCES `employee_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '新员工 36', '00000000000', NULL, '备注559', 13, '2018-09-07 03:15:53', '2018-09-07 09:03:06', 1);
INSERT INTO `employee` VALUES (2, '新员工 776', '00000000000', NULL, '备注564', 14, '2018-09-07 03:15:53', '2018-09-07 09:03:06', 2);
INSERT INTO `employee` VALUES (3, '新员工 896', '00000000000', NULL, '备注599', 15, '2018-09-07 03:15:53', '2018-09-07 09:03:06', 5);
INSERT INTO `employee` VALUES (4, '新员工 952', '00000000000', NULL, '备注519', 16, '2018-09-07 03:15:53', '2018-09-07 09:03:06', 9);
INSERT INTO `employee` VALUES (5, '新员工 251', '00000000000', NULL, '备注811', 17, '2018-09-07 03:15:53', '2018-09-07 09:03:06', 15);
INSERT INTO `employee` VALUES (6, '新员工 853', '00000000000', NULL, '备注128', 12, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 18);
INSERT INTO `employee` VALUES (7, '新员工 869', '00000000000', NULL, '备注232', 11, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 16);
INSERT INTO `employee` VALUES (8, '新员工 186', '00000000000', NULL, '备注409', 10, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 5);
INSERT INTO `employee` VALUES (9, '新员工 688', '00000000000', NULL, '备注544', 9, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 5);
INSERT INTO `employee` VALUES (10, '新员工 909', '00000000000', NULL, '备注238', 8, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 14);
INSERT INTO `employee` VALUES (11, '新员工 985', '00000000000', NULL, '备注673', 7, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 20);
INSERT INTO `employee` VALUES (12, '新员工 461', '00000000000', NULL, '备注674', 6, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 4);
INSERT INTO `employee` VALUES (13, '新员工 125', '00000000000', NULL, '备注289', 5, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 3);
INSERT INTO `employee` VALUES (14, '新员工 777', '00000000000', NULL, '备注97', 4, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 3);
INSERT INTO `employee` VALUES (15, '新员工 575', '00000000000', NULL, '备注293', 3, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 2);
INSERT INTO `employee` VALUES (16, '新员工 992', '00000000000', NULL, '备注435', 2, '2018-09-07 03:21:00', '2018-09-07 09:02:43', 2);
INSERT INTO `employee` VALUES (17, '新员工 911', '00000000000', NULL, '备注596', 1, '2018-09-07 03:21:00', '2018-10-14 16:46:48', 1);

-- ----------------------------
-- Table structure for employee_type
-- ----------------------------
DROP TABLE IF EXISTS `employee_type`;
CREATE TABLE `employee_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `wage` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee_type
-- ----------------------------
INSERT INTO `employee_type` VALUES (1, '一级', 3000.0000, 12, '备注368', '2018-09-07 03:14:44', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (2, '二级', 1500.0000, 13, '备注91', '2018-09-07 03:14:44', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (3, '三级', 1000.0000, 14, '备注22', '2018-09-07 03:14:44', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (4, '四级', 500.0000, 15, '备注28', '2018-09-07 03:14:44', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (5, '实习', 0.0000, 16, '备注995', '2018-09-07 03:19:15', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (6, '技师类型 521', 0.0000, 17, '备注195', '2018-09-07 03:19:54', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (7, '技师类型 224', 0.0000, 18, '备注703', '2018-09-07 03:19:54', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (8, '技师类型 871', 0.0000, 19, '备注35', '2018-09-07 03:19:54', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (9, '技师类型 905', 0.0000, 20, '备注959', '2018-09-07 03:19:54', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (10, '技师类型 904', 0.0000, 11, '备注966', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (11, '技师类型 197', 0.0000, 10, '备注195', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (12, '技师类型 355', 0.0000, 2, '备注228', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (13, '技师类型 845', 0.0000, 3, '备注377', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (14, '技师类型 858', 0.0000, 4, '备注212', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (15, '技师类型 974', 0.0000, 5, '备注637', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (16, '技师类型 7', 0.0000, 6, '备注807', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (17, '技师类型 899', 0.0000, 7, '备注324', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (18, '技师类型 316', 0.0000, 8, '备注959', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (19, '技师类型 526', 0.0000, 9, '备注80', '2018-09-07 03:20:14', '2018-09-07 03:20:15');
INSERT INTO `employee_type` VALUES (20, '技师类型 595', 0.0000, 1, '备注759', '2018-09-07 03:20:14', '2018-09-07 03:20:15');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `otherphone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `case` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `case_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, '新会员 982', '13936248323', '0000', 'abc', NULL, NULL, '0000-00-00 00:00:00', '2018-10-25 09:01:24', 26);
INSERT INTO `member` VALUES (5, '新会员 985', '00000000000', '0000', '2', NULL, NULL, '2018-08-22 09:04:39', '2018-10-25 09:12:05', 2);
INSERT INTO `member` VALUES (6, '新会员 983', '00000000000', '0000', '备注494', NULL, NULL, '2018-08-22 09:04:39', '2018-09-07 03:14:18', 23);
INSERT INTO `member` VALUES (7, '新会员 660', '00000000000', '0000', '备注941', NULL, NULL, '2018-08-22 09:04:39', '2018-08-23 06:32:00', 1);
INSERT INTO `member` VALUES (9, '新会员 475', '00000000000', '0000', '备注763', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (10, '新会员 31', '00000000000', '0000', '备注708', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (11, '新会员 602', '00000000000', '0000', '备注549', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (12, '新会员 952', '00000000000', '0000', '备注462', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (13, '新会员 798', '00000000000', '0000', '备注240', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (14, '新会员 662', '00000000000', '0000', '备注136', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (15, '新会员 677', '00000000000', '0000', '备注520', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 24);
INSERT INTO `member` VALUES (16, '新会员 697', '00000000000', '0000', '备注146', NULL, NULL, '2018-09-07 02:10:45', '2018-09-07 02:10:45', 23);
INSERT INTO `member` VALUES (17, '新会员 134', '00000000000', '0000', '备注371', NULL, NULL, '2018-09-07 02:25:31', '2018-09-07 02:25:31', NULL);
INSERT INTO `member` VALUES (18, '新会员 563', '00000000000', '0000', '备注809', NULL, NULL, '2018-09-07 02:35:50', '2018-09-07 02:35:50', NULL);
INSERT INTO `member` VALUES (19, '新会员 397', '00000000000', '0000', '备注873', NULL, NULL, '2018-10-25 09:12:05', '2018-10-25 09:12:05', NULL);
INSERT INTO `member` VALUES (25, '2', '3', '4', '5', NULL, NULL, '2018-10-31 08:26:59', '2018-10-31 08:26:59', 39);
INSERT INTO `member` VALUES (26, 'n2', 'n3', 'n4', 'n5', NULL, NULL, '2018-10-31 08:28:29', '2018-10-31 08:28:29', 39);
INSERT INTO `member` VALUES (27, '111', '222', '333', '444', NULL, NULL, '2018-10-31 08:34:55', '2018-10-31 08:34:55', 40);
INSERT INTO `member` VALUES (28, 'n1', 'n2', 'n3', 'n4', NULL, NULL, '2018-10-31 08:37:05', '2018-10-31 08:37:05', 40);
INSERT INTO `member` VALUES (29, '333', '444', '555', '666', NULL, NULL, '2018-10-31 08:37:46', '2018-10-31 08:37:46', 41);
INSERT INTO `member` VALUES (30, 'n33', 'n44', 'n55', 'n66', NULL, NULL, '2018-10-31 08:38:07', '2018-10-31 08:38:07', 41);
INSERT INTO `member` VALUES (31, '12', '13', '14', '15', NULL, NULL, '2018-10-31 08:38:27', '2018-10-31 08:38:27', 42);
INSERT INTO `member` VALUES (32, '234', '542', '6667', '86554', NULL, NULL, '2018-10-31 08:40:38', '2018-10-31 08:40:38', 43);
INSERT INTO `member` VALUES (33, '1', '2', '3', '4', NULL, NULL, '2018-10-31 08:42:10', '2018-10-31 08:42:10', 42);
INSERT INTO `member` VALUES (34, '1', '1', '1', '1', NULL, NULL, '2018-10-31 08:44:35', '2018-10-31 08:44:35', 45);
INSERT INTO `member` VALUES (35, '2', '3', '4', '5', NULL, NULL, '2018-11-01 02:16:22', '2018-11-01 02:16:22', 2);
INSERT INTO `member` VALUES (36, '11', '22', '33', '44', NULL, NULL, '2018-11-01 02:16:36', '2018-11-01 02:16:36', 50);
INSERT INTO `member` VALUES (37, '3', '4', '5', '6', NULL, NULL, '2018-11-01 02:23:24', '2018-11-01 02:23:24', 54);
INSERT INTO `member` VALUES (38, '111', '222', '333', '444', NULL, NULL, '2018-11-01 02:23:47', '2018-11-01 02:23:47', 2);
INSERT INTO `member` VALUES (39, '123', '13936248323', '', '', NULL, NULL, '2018-11-01 07:48:38', '2018-11-01 07:48:38', 40);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `router` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '菜单', '/menu', 6, '0000-00-00 00:00:00', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (2, '用户', '/user', 8, '0000-00-00 00:00:00', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (3, '会员卡', '/card', 17, '0000-00-00 00:00:00', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (4, '会员', '/member', 18, '0000-00-00 00:00:00', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (10, '会员卡类型', '/cardType', 16, '2018-08-19 14:01:26', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (11, '系统设置', '', 5, '2018-08-21 04:04:13', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (12, '员工设置', '', 12, '2018-08-21 04:06:21', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (15, '用户类型', '/userType', 7, '2018-08-21 08:29:44', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (17, '会员设置', '', 15, '2018-08-22 10:09:42', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (18, '员工类型', '/employeeType', 13, '2018-08-22 10:11:54', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (19, '员工', '/employee', 14, '2018-08-22 10:11:54', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (20, '常用', '', 1, '2018-08-22 10:14:05', '2018-08-22 10:14:13');
INSERT INTO `menu` VALUES (21, '首页', '/mix', 2, '2018-08-22 10:14:05', '2018-09-08 16:17:21');
INSERT INTO `menu` VALUES (22, '查询', '', 19, '2018-09-07 03:31:43', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (23, '工资记录', '/wage', 20, '2018-09-07 03:32:08', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (24, '消费记录', '/consumption', 21, '2018-09-07 03:32:22', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (25, '商品设置', '', 9, '2018-09-08 15:52:32', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (26, '商品类型', '/commodityType', 10, '2018-09-08 15:53:39', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (27, '商品', '/commodity', 11, '2018-09-08 15:53:39', '2018-10-14 15:32:53');
INSERT INTO `menu` VALUES (30, '员工', '/employee', 3, '2018-09-08 16:16:59', '2018-10-14 15:33:07');
INSERT INTO `menu` VALUES (31, '注销', '/logout', 4, '0000-00-00 00:00:00', '2018-10-14 15:33:07');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `location` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `last_sign_in_at` datetime(0) NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `user_type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `user_type_id`(`user_type_id`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'idone', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, '', 9, '2018-10-14 16:58:15', '2018-08-04 07:39:11', '2018-10-14 16:58:15', 4);
INSERT INTO `user` VALUES (2, '新登录用户 26', '165c468905fa4e852e23d2ab8ab2c33a', NULL, NULL, '', 8, NULL, '2018-08-04 07:40:18', '2018-08-21 12:07:27', 1);
INSERT INTO `user` VALUES (3, 'liuwei', 'e10adc3949ba59abbe56e057f20f883e', '123', NULL, '345', 2, '2018-10-14 17:05:26', '2018-08-04 07:40:27', '2018-10-14 17:05:26', 5);
INSERT INTO `user` VALUES (4, '新登录用户 227', NULL, NULL, NULL, '', 3, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 3);
INSERT INTO `user` VALUES (5, '新登录用户 413', NULL, NULL, NULL, '', 5, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 3);
INSERT INTO `user` VALUES (6, '4', NULL, NULL, NULL, '', 6, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 4);
INSERT INTO `user` VALUES (10, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '1111', '1', 1, '2018-11-01 07:40:34', '2018-08-04 14:34:18', '2018-11-01 07:40:34', 1);
INSERT INTO `user` VALUES (11, '新登录用户 346', NULL, NULL, NULL, '', 4, NULL, '2018-08-04 14:34:18', '2018-08-21 08:26:48', 1);
INSERT INTO `user` VALUES (12, '新登录用户 275', NULL, NULL, NULL, '', 7, NULL, '2018-08-04 14:34:18', '2018-08-21 08:26:48', 4);
INSERT INTO `user` VALUES (13, '新登录用户 23475', NULL, NULL, NULL, '1', 10, NULL, '0000-00-00 00:00:00', '2018-08-31 09:32:03', NULL);

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_type
-- ----------------------------
INSERT INTO `user_type` VALUES (1, '系统管理员', 1, '', '0000-00-00 00:00:00', '2018-10-15 02:09:46');
INSERT INTO `user_type` VALUES (2, '管理员', 2, '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES (3, '总经理', 3, '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES (4, '前台', 4, '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES (5, '会计', 5, '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');

-- ----------------------------
-- Table structure for user_type_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_type_menu`;
CREATE TABLE `user_type_menu`  (
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`, `user_type_id`) USING BTREE,
  INDEX `user_type_id`(`user_type_id`) USING BTREE,
  CONSTRAINT `user_type_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_type_menu_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_type_menu
-- ----------------------------
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 1, 1);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 2);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 3);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 1, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 2, 1);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 2, 2);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', 2, 3);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 2, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', 3, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 3, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 4, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 4, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', 10, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 10, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:30:14', '2018-08-22 07:30:14', 11, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 11, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 12, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', 12, 3);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 12, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 15, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 15, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 17, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 18, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 19, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 20, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:49', '2018-10-14 16:06:49', 20, 4);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 17:04:19', '2018-10-14 17:04:19', 20, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 21, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:49', '2018-10-14 16:06:49', 21, 4);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 17:05:12', '2018-10-14 17:05:12', 21, 5);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 22, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 23, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 24, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 25, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 26, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 27, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 30, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:49', '2018-10-14 16:06:49', 30, 4);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36', '2018-10-14 16:06:36', 31, 1);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 17:03:22', '2018-10-14 17:03:22', 31, 4);
INSERT INTO `user_type_menu` VALUES ('2018-10-14 17:04:19', '2018-10-14 17:04:19', 31, 5);

-- ----------------------------
-- Table structure for wage
-- ----------------------------
DROP TABLE IF EXISTS `wage`;
CREATE TABLE `wage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wage` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `bonus` decimal(16, 4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `employee_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `wage_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `wage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of wage
-- ----------------------------
INSERT INTO `wage` VALUES (1, 2000.0000, 3000.0000, NULL, '2018-09-07 18:13:01', '2018-09-07 18:13:04', 2, 5);
INSERT INTO `wage` VALUES (2, 10.0000, 30.0000, NULL, '2018-09-01 18:13:54', '2018-09-01 18:14:01', 2, 1);
INSERT INTO `wage` VALUES (3, 30.0000, 40.0000, NULL, '2018-09-02 18:14:05', '2018-09-03 18:14:09', 4, 5);

SET FOREIGN_KEY_CHECKS = 1;
