/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100108
 Source Host           : localhost:3306
 Source Schema         : gct3

 Target Server Type    : MySQL
 Target Server Version : 100108
 File Encoding         : 65001

 Date: 31/08/2018 17:15:06
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
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of card
-- ----------------------------
INSERT INTO `card` VALUES (1, '250', '测试用户测试用户测试用户测试用户', 'e10adc3949ba59abbe56e057f20f883e', 0.0000, '123', '123', '123', '2018-08-19 14:24:49', '2018-08-23 08:22:04', 1);
INSERT INTO `card` VALUES (2, '2', 'b', NULL, 0.3000, '00000000000', '0000', '备注826', '2018-08-19 14:02:13', '2018-08-22 12:36:09', 2);
INSERT INTO `card` VALUES (9, '3', 'c', '96e79218965eb72c92a549dd5a330112', 10000000.0000, '11111111111', '0000', '备注119', '2018-08-19 14:03:32', '2018-08-22 12:36:09', 3);
INSERT INTO `card` VALUES (10, '4', 'd', NULL, 0.0000, '00000000000', '0000', '备注817', '2018-08-20 13:42:41', '2018-08-22 12:36:09', 4);
INSERT INTO `card` VALUES (14, '5', 'e', NULL, 0.0000, '00000000000', '0000', '备注534', '2018-08-20 13:42:59', '2018-08-22 12:36:09', 8);
INSERT INTO `card` VALUES (15, '16', '新会员卡 608', NULL, 0.0000, '00000000000', '0000', '备注367', '2018-08-22 14:05:52', '2018-08-22 14:06:55', 12);
INSERT INTO `card` VALUES (23, '10', '新会员卡 433', NULL, 0.0000, '00000000000', '0000', '备注248', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 7);
INSERT INTO `card` VALUES (24, '11', '新会员卡 245', NULL, 0.0000, '00000000000', '0000', '备注292', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 14);
INSERT INTO `card` VALUES (25, '12', '新会员卡 756', NULL, 0.0000, '00000000000', '0000', '备注166', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 2);
INSERT INTO `card` VALUES (26, '13', '新会员卡 218', NULL, 0.0000, '00000000000', '0000', '备注318', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 3);
INSERT INTO `card` VALUES (27, '14', '新会员卡 646', NULL, 0.0000, '00000000000', '0000', '备注967', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 1);
INSERT INTO `card` VALUES (28, '15', '新会员卡 466', NULL, 0.0000, '00000000000', '0000', '备注20', '2018-08-22 14:06:16', '2018-08-22 14:06:55', 2);
INSERT INTO `card` VALUES (29, '19', '新会员卡 315', NULL, 0.0000, '00000000000', '0000', '备注251', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 9);
INSERT INTO `card` VALUES (30, '18', '新会员卡 103', NULL, 0.0000, '00000000000', '0000', '备注194', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 13);
INSERT INTO `card` VALUES (31, '17', '新会员卡 33', NULL, 0.0000, '00000000000', '0000', '备注395', '2018-08-22 14:06:31', '2018-08-22 14:06:55', 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

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
  `is_discount` tinyint(1) NOT NULL DEFAULT 1,
  `is_cash` tinyint(1) NOT NULL DEFAULT 0,
  `is_close` tinyint(1) NOT NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  `commodity_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `member_id` int(11) NULL DEFAULT NULL,
  `employee_id` int(11) NULL DEFAULT NULL,
  `wage_id` int(11) NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

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
  `case` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `case_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `card_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `card_id`(`card_id`) USING BTREE,
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, '新会员 982', '00000000000', '0000', '2', NULL, NULL, '0000-00-00 00:00:00', '2018-08-23 06:32:00', 25);
INSERT INTO `member` VALUES (5, '新会员 982', '00000000000', '0000', '2', NULL, NULL, '2018-08-22 09:04:39', '2018-08-23 06:32:00', 30);
INSERT INTO `member` VALUES (6, '新会员 983', '00000000000', '0000', '备注494', NULL, NULL, '2018-08-22 09:04:39', '2018-08-23 06:32:00', 25);
INSERT INTO `member` VALUES (7, '新会员 660', '00000000000', '0000', '备注941', NULL, NULL, '2018-08-22 09:04:39', '2018-08-23 06:32:00', 1);
INSERT INTO `member` VALUES (9, '新会员 475', '00000000000', '0000', '备注763', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (10, '新会员 31', '00000000000', '0000', '备注708', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (11, '新会员 602', '00000000000', '0000', '备注549', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (12, '新会员 952', '00000000000', '0000', '备注462', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (13, '新会员 798', '00000000000', '0000', '备注240', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (14, '新会员 662', '00000000000', '0000', '备注136', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 1);
INSERT INTO `member` VALUES (15, '新会员 677', '00000000000', '0000', '备注520', NULL, NULL, '2018-08-23 06:32:20', '2018-08-23 06:32:20', 24);

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '菜单', '\\menu', 4, '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (2, '用户', '\\user', 6, '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (3, '会员卡', '\\card', 12, '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (4, '会员', '\\member', 13, '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (10, '会员卡类型', '\\cardType', 11, '2018-08-19 14:01:26', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (11, '系统设置', '', 3, '2018-08-21 04:04:13', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (12, '员工设置', '', 7, '2018-08-21 04:06:21', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (15, '用户类型', '\\userType', 5, '2018-08-21 08:29:44', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (17, '会员设置', '', 10, '2018-08-22 10:09:42', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (18, '员工类型', '\\employeeType', 8, '2018-08-22 10:11:54', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (19, '员工', '\\employee', 9, '2018-08-22 10:11:54', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES (20, '常用', '', 1, '2018-08-22 10:14:05', '2018-08-22 10:14:13');
INSERT INTO `menu` VALUES (21, '首页', '\\mix', 2, '2018-08-22 10:14:05', '2018-08-22 10:15:58');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `location` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
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
INSERT INTO `user` VALUES (1, '新登录用户 743', NULL, NULL, '', 9, NULL, '2018-08-04 07:39:11', '2018-08-21 08:26:48', 4);
INSERT INTO `user` VALUES (2, '新登录用户 26', '165c468905fa4e852e23d2ab8ab2c33a', NULL, '', 8, NULL, '2018-08-04 07:40:18', '2018-08-21 12:07:27', 1);
INSERT INTO `user` VALUES (3, '22', 'c33367701511b4f6020ec61ded352059', NULL, '345', 2, NULL, '2018-08-04 07:40:27', '2018-08-21 12:04:48', 5);
INSERT INTO `user` VALUES (4, '新登录用户 227', NULL, NULL, '', 3, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 3);
INSERT INTO `user` VALUES (5, '新登录用户 413', NULL, NULL, '', 5, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 3);
INSERT INTO `user` VALUES (6, '4', NULL, NULL, '', 6, NULL, '2018-08-04 07:40:27', '2018-08-21 08:26:48', 4);
INSERT INTO `user` VALUES (10, '新登录用户 700', '96e79218965eb72c92a549dd5a330112', NULL, '1', 1, NULL, '2018-08-04 14:34:18', '2018-08-22 07:54:09', 2);
INSERT INTO `user` VALUES (11, '新登录用户 346', NULL, NULL, '', 4, NULL, '2018-08-04 14:34:18', '2018-08-21 08:26:48', 1);
INSERT INTO `user` VALUES (12, '新登录用户 275', NULL, NULL, '', 7, NULL, '2018-08-04 14:34:18', '2018-08-21 08:26:48', 4);
INSERT INTO `user` VALUES (13, '新登录用户 23475', NULL, NULL, NULL, 10, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL);

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
INSERT INTO `user_type` VALUES (1, '系统管理员', 1, '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
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
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 2);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 3);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 4);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 1, 5);
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', 2, 2);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', 2, 3);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 2, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', 3, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 3, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 4, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', 10, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 10, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:30:14', '2018-08-22 07:30:14', 11, 1);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 11, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', 12, 3);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 12, 5);
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', 15, 5);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
