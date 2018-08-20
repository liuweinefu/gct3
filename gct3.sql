/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : gct3

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-08-20 22:50:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for card
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_number` varchar(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `balance` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `phone` varchar(11) NOT NULL,
  `otherphone` varchar(64) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_number` (`card_number`),
  UNIQUE KEY `name` (`name`),
  KEY `card_type_id` (`card_type_id`),
  CONSTRAINT `card_ibfk_1` FOREIGN KEY (`card_type_id`) REFERENCES `card_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of card
-- ----------------------------
INSERT INTO `card` VALUES ('1', '1', '1', '123', '1.2300', '123', '123', '123', '2018-08-19 14:24:49', '2018-08-19 14:24:49', '5');
INSERT INTO `card` VALUES ('2', '2', '新会员卡 163', null, '0.0000', '00000000000', '0000', '备注826', '2018-08-19 14:02:13', '2018-08-20 13:42:50', '2');
INSERT INTO `card` VALUES ('9', '3', '新会员卡 318', null, '222.3400', '00000000000', '0000', '备注119', '2018-08-19 14:03:32', '2018-08-19 14:03:32', '1');
INSERT INTO `card` VALUES ('10', '4', '新会员卡 659', null, '0.0000', '00000000000', '0000', '备注817', '2018-08-20 13:42:41', '2018-08-20 13:43:16', '1');
INSERT INTO `card` VALUES ('14', '5', '新会员卡 321', null, '0.0000', '00000000000', '0000', '备注534', '2018-08-20 13:42:59', '2018-08-20 13:43:16', '5');

-- ----------------------------
-- Table structure for card_recharge
-- ----------------------------
DROP TABLE IF EXISTS `card_recharge`;
CREATE TABLE `card_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `card_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `card_id` (`card_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `card_recharge_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `card_recharge_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of card_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for card_type
-- ----------------------------
DROP TABLE IF EXISTS `card_type`;
CREATE TABLE `card_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `discount` decimal(10,4) NOT NULL DEFAULT '1.0000',
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of card_type
-- ----------------------------
INSERT INTO `card_type` VALUES ('1', '金', '0.5500', '2', '2', '2018-08-19 14:32:22', '2018-08-20 12:28:10');
INSERT INTO `card_type` VALUES ('2', '银', '0.6500', '3', '3', '2018-08-19 14:32:22', '2018-08-20 12:28:10');
INSERT INTO `card_type` VALUES ('3', '铜', '0.7000', '4', '4', '2018-08-19 14:32:22', '2018-08-20 12:28:10');
INSERT INTO `card_type` VALUES ('4', '铁', '0.8000', '5', '5', '2018-08-19 14:32:22', '2018-08-20 12:28:10');
INSERT INTO `card_type` VALUES ('5', 'Vip', '0.4500', '1', '3', '2018-08-19 14:36:35', '2018-08-20 12:28:32');
INSERT INTO `card_type` VALUES ('6', '会员卡类型 256', '1.0000', '6', '备注764', '2018-08-20 12:49:12', '2018-08-20 12:49:12');
INSERT INTO `card_type` VALUES ('7', '会员卡类型 656', '1.0000', '13', '备注502', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('8', '会员卡类型 849', '1.0000', '12', '备注590', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('9', '会员卡类型 730', '1.0000', '11', '备注365', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('10', '会员卡类型 356', '1.0000', '10', '备注760', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('11', '会员卡类型 244', '1.0000', '9', '备注995', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('12', '会员卡类型 782', '1.0000', '8', '备注18', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('13', '会员卡类型 696', '1.0000', '7', '备注36', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('14', '会员卡类型 26', '1.0000', '14', '备注882', '2018-08-20 12:49:21', '2018-08-20 12:49:21');

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `stocks` int(11) NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `commodity_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `commodity_type_id` (`commodity_type_id`),
  CONSTRAINT `commodity_ibfk_1` FOREIGN KEY (`commodity_type_id`) REFERENCES `commodity_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of commodity
-- ----------------------------

-- ----------------------------
-- Table structure for commodity_type
-- ----------------------------
DROP TABLE IF EXISTS `commodity_type`;
CREATE TABLE `commodity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of commodity_type
-- ----------------------------

-- ----------------------------
-- Table structure for commodity_warehousing
-- ----------------------------
DROP TABLE IF EXISTS `commodity_warehousing`;
CREATE TABLE `commodity_warehousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commodity_id` (`commodity_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `commodity_warehousing_ibfk_1` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `commodity_warehousing_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of commodity_warehousing
-- ----------------------------

-- ----------------------------
-- Table structure for consumption
-- ----------------------------
DROP TABLE IF EXISTS `consumption`;
CREATE TABLE `consumption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `quantity` int(11) NOT NULL DEFAULT '1',
  `is_discount` tinyint(1) NOT NULL DEFAULT '1',
  `is_cash` tinyint(1) NOT NULL DEFAULT '0',
  `is_close` tinyint(1) NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_id` int(11) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `employee_wage_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `card_id` (`card_id`),
  KEY `commodity_id` (`commodity_id`),
  KEY `user_id` (`user_id`),
  KEY `member_id` (`member_id`),
  KEY `employee_id` (`employee_id`),
  KEY `employee_wage_id` (`employee_wage_id`),
  CONSTRAINT `consumption_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_2` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_4` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_6` FOREIGN KEY (`employee_wage_id`) REFERENCES `employee_wage` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of consumption
-- ----------------------------

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `otherphone` varchar(64) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `employee_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `employee_type_id` (`employee_type_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`employee_type_id`) REFERENCES `employee_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee
-- ----------------------------

-- ----------------------------
-- Table structure for employee_type
-- ----------------------------
DROP TABLE IF EXISTS `employee_type`;
CREATE TABLE `employee_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `wage` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee_type
-- ----------------------------

-- ----------------------------
-- Table structure for employee_wage
-- ----------------------------
DROP TABLE IF EXISTS `employee_wage`;
CREATE TABLE `employee_wage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wage` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `bonus` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `employee_wage_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `employee_wage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee_wage
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `otherphone` varchar(64) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `case` text,
  `case_remark` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `card_id` (`card_id`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of member
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `router` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'menu', '\\menu', '1', '0000-00-00 00:00:00', '2018-08-19 14:01:07');
INSERT INTO `menu` VALUES ('2', 'user', '\\user', '2', '0000-00-00 00:00:00', '2018-08-19 14:01:07');
INSERT INTO `menu` VALUES ('3', 'card', '\\card', '3', '0000-00-00 00:00:00', '2018-08-19 14:01:07');
INSERT INTO `menu` VALUES ('4', 'member', '\\member', '5', '0000-00-00 00:00:00', '2018-08-19 14:01:26');
INSERT INTO `menu` VALUES ('10', 'cardType', '\\cardType', '4', '2018-08-19 14:01:26', '2018-08-19 14:01:26');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `location` varchar(32) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `user_type_id` (`user_type_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '新登录用户 743', null, null, '2', '9', null, '2018-08-04 07:39:11', '2018-08-05 01:19:56', '1');
INSERT INTO `user` VALUES ('2', '新登录用户 26', null, null, '2', '8', null, '2018-08-04 07:40:18', '2018-08-05 01:19:56', '1');
INSERT INTO `user` VALUES ('3', '22', null, null, '2', '2', null, '2018-08-04 07:40:27', '2018-08-05 01:19:56', '2');
INSERT INTO `user` VALUES ('4', '新登录用户 227', null, null, '2', '3', null, '2018-08-04 07:40:27', '2018-08-05 01:19:56', '2');
INSERT INTO `user` VALUES ('5', '新登录用户 413', null, null, '2', '5', null, '2018-08-04 07:40:27', '2018-08-05 01:19:56', '3');
INSERT INTO `user` VALUES ('6', '4', null, null, '2', '6', null, '2018-08-04 07:40:27', '2018-08-05 01:19:56', '4');
INSERT INTO `user` VALUES ('10', '新登录用户 700', null, null, '2', '1', null, '2018-08-04 14:34:18', '2018-08-05 01:19:56', '5');
INSERT INTO `user` VALUES ('11', '新登录用户 346', null, null, '2', '4', null, '2018-08-04 14:34:18', '2018-08-05 01:19:56', '1');
INSERT INTO `user` VALUES ('12', '新登录用户 275', null, null, '2', '7', null, '2018-08-04 14:34:18', '2018-08-05 01:19:56', '1');

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_type
-- ----------------------------
INSERT INTO `user_type` VALUES ('1', '系统管理员', '1', null, '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `user_type` VALUES ('2', '管理员', '2', null, '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `user_type` VALUES ('3', '总经理', '3', null, '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `user_type` VALUES ('4', '前台', '4', null, '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `user_type` VALUES ('5', '会计', '5', null, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for user_type_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_type_menu`;
CREATE TABLE `user_type_menu` (
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `menu_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`,`user_type_id`),
  KEY `user_type_id` (`user_type_id`),
  CONSTRAINT `user_type_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_type_menu_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user_type_menu
-- ----------------------------
