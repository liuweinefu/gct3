/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100108
Source Host           : localhost:3306
Source Database       : gct3

Target Server Type    : MYSQL
Target Server Version : 100108
File Encoding         : 65001

Date: 2018-08-26 08:16:26
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
  `balance` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of card
-- ----------------------------
INSERT INTO `card` VALUES ('1', '250', '测试用户测试用户测试用户测试用户', 'e10adc3949ba59abbe56e057f20f883e', '0.0000', '123', '123', '123', '2018-08-19 14:24:49', '2018-08-23 08:22:04', '1');
INSERT INTO `card` VALUES ('2', '2', 'b', null, '0.3000', '00000000000', '0000', '备注826', '2018-08-19 14:02:13', '2018-08-22 12:36:09', '2');
INSERT INTO `card` VALUES ('9', '3', 'c', '96e79218965eb72c92a549dd5a330112', '10000000.0000', '11111111111', '0000', '备注119', '2018-08-19 14:03:32', '2018-08-22 12:36:09', '3');
INSERT INTO `card` VALUES ('10', '4', 'd', null, '0.0000', '00000000000', '0000', '备注817', '2018-08-20 13:42:41', '2018-08-22 12:36:09', '4');
INSERT INTO `card` VALUES ('14', '5', 'e', null, '0.0000', '00000000000', '0000', '备注534', '2018-08-20 13:42:59', '2018-08-22 12:36:09', '8');
INSERT INTO `card` VALUES ('15', '16', '新会员卡 608', null, '0.0000', '00000000000', '0000', '备注367', '2018-08-22 14:05:52', '2018-08-22 14:06:55', '12');
INSERT INTO `card` VALUES ('23', '10', '新会员卡 433', null, '0.0000', '00000000000', '0000', '备注248', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '7');
INSERT INTO `card` VALUES ('24', '11', '新会员卡 245', null, '0.0000', '00000000000', '0000', '备注292', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '14');
INSERT INTO `card` VALUES ('25', '12', '新会员卡 756', null, '0.0000', '00000000000', '0000', '备注166', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '2');
INSERT INTO `card` VALUES ('26', '13', '新会员卡 218', null, '0.0000', '00000000000', '0000', '备注318', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '3');
INSERT INTO `card` VALUES ('27', '14', '新会员卡 646', null, '0.0000', '00000000000', '0000', '备注967', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '1');
INSERT INTO `card` VALUES ('28', '15', '新会员卡 466', null, '0.0000', '00000000000', '0000', '备注20', '2018-08-22 14:06:16', '2018-08-22 14:06:55', '2');
INSERT INTO `card` VALUES ('29', '19', '新会员卡 315', null, '0.0000', '00000000000', '0000', '备注251', '2018-08-22 14:06:31', '2018-08-22 14:06:55', '9');
INSERT INTO `card` VALUES ('30', '18', '新会员卡 103', null, '0.0000', '00000000000', '0000', '备注194', '2018-08-22 14:06:31', '2018-08-22 14:06:55', '13');
INSERT INTO `card` VALUES ('31', '17', '新会员卡 33', null, '0.0000', '00000000000', '0000', '备注395', '2018-08-22 14:06:31', '2018-08-22 14:06:55', '2');

-- ----------------------------
-- Table structure for card_recharge
-- ----------------------------
DROP TABLE IF EXISTS `card_recharge`;
CREATE TABLE `card_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
  `discount` decimal(16,4) NOT NULL DEFAULT '1.0000',
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
INSERT INTO `card_type` VALUES ('1', '金', '0.5500', '2', '2', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES ('2', '银', '0.6500', '3', '3', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES ('3', '铜', '0.7000', '4', '4', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES ('4', '铁', '0.8000', '5', '5', '2018-08-19 14:32:22', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES ('5', 'Vip', '0.4500', '1', '3', '2018-08-19 14:36:35', '2018-08-20 12:28:32');
INSERT INTO `card_type` VALUES ('6', '会员卡类型 256', '0.2500', '6', '备注764', '2018-08-20 12:49:12', '2018-08-22 08:44:41');
INSERT INTO `card_type` VALUES ('7', '会员卡类型 656', '1.0000', '13', '备注502', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('8', '会员卡类型 849', '1.0000', '12', '备注590', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('9', '会员卡类型 730', '1.0000', '11', '备注365', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('10', '会员卡类型 356', '1.0000', '10', '备注760', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('11', '会员卡类型 244', '1.0000', '9', '备注995', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('12', '会员卡类型 782', '1.0000', '8', '备注18', '2018-08-20 12:49:21', '2018-08-20 12:49:21');
INSERT INTO `card_type` VALUES ('13', 'abc', '1.0000', '7', '备注36', '2018-08-20 12:49:21', '2018-08-22 08:38:02');
INSERT INTO `card_type` VALUES ('14', '会员卡类型 26', '1.0000', '14', '备注882', '2018-08-20 12:49:21', '2018-08-20 12:49:21');

-- ----------------------------
-- Table structure for case
-- ----------------------------
DROP TABLE IF EXISTS `case`;
CREATE TABLE `case` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `case` text,
  `remark` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `case_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of case
-- ----------------------------
INSERT INTO `case` VALUES ('1', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:03:36', '2018-08-24 14:47:31', '5');
INSERT INTO `case` VALUES ('2', '新病例 Fri Aug 24 2', '1', '2', '2018-08-24 14:04:18', '2018-08-24 14:05:43', '6');
INSERT INTO `case` VALUES ('3', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:57', '11');
INSERT INTO `case` VALUES ('4', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:57', '14');
INSERT INTO `case` VALUES ('5', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:57', '15');
INSERT INTO `case` VALUES ('6', '新病例 Fri Aug 24 2', '', null, '2018-08-24 14:04:18', '2018-08-24 14:05:43', '6');
INSERT INTO `case` VALUES ('7', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');
INSERT INTO `case` VALUES ('8', '新病例 Fri Aug 24 2', null, '', '2018-08-24 14:04:18', '2018-08-24 14:47:31', '1');
INSERT INTO `case` VALUES ('9', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');
INSERT INTO `case` VALUES ('10', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');
INSERT INTO `case` VALUES ('11', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');
INSERT INTO `case` VALUES ('12', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');
INSERT INTO `case` VALUES ('13', '新病例 Fri Aug 24 2', null, null, '2018-08-24 14:04:18', '2018-08-24 14:04:18', '1');

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `price` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES ('1', '新商品 804', '99.9900', '-111111', '备注10', '2', '2018-08-24 16:13:40', '2018-08-24 16:16:18', '1');
INSERT INTO `commodity` VALUES ('2', '新商品 504', '10000.0000', '10000', '备注526', '3', '2018-08-24 16:13:40', '2018-08-24 16:16:18', '3');
INSERT INTO `commodity` VALUES ('3', '新商品 940', '10000.0000', '10000', '备注911', '4', '2018-08-24 16:13:40', '2018-08-24 16:14:53', '5');
INSERT INTO `commodity` VALUES ('4', '新商品 430', '10000.0000', '10000', '备注757', '5', '2018-08-24 16:13:40', '2018-08-24 16:14:53', '1');
INSERT INTO `commodity` VALUES ('5', '新商品 983', '10000.0000', '10000', '备注825', '6', '2018-08-24 16:13:40', '2018-08-24 16:14:53', '2');
INSERT INTO `commodity` VALUES ('6', '新商品 957', '10000.0000', '10000', '备注88', '7', '2018-08-24 16:13:40', '2018-08-24 16:14:53', '3');
INSERT INTO `commodity` VALUES ('7', '新商品 438', '10000.0000', '10000', '备注4', '1', '2018-08-24 16:14:53', '2018-08-24 16:15:27', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of commodity_type
-- ----------------------------
INSERT INTO `commodity_type` VALUES ('1', '商品类型 487', '1', '备注621', '2018-08-24 16:13:27', '2018-08-24 16:13:27');
INSERT INTO `commodity_type` VALUES ('2', '商品类型 196', '2', '备注525', '2018-08-24 16:13:27', '2018-08-24 16:13:27');
INSERT INTO `commodity_type` VALUES ('3', '商品类型 86', '3', '备注326', '2018-08-24 16:13:27', '2018-08-24 16:13:27');
INSERT INTO `commodity_type` VALUES ('4', '商品类型 419', '4', '备注520', '2018-08-24 16:13:27', '2018-08-24 16:13:27');
INSERT INTO `commodity_type` VALUES ('5', '商品类型 418', '5', '备注717', '2018-08-24 16:13:27', '2018-08-24 16:13:27');

-- ----------------------------
-- Table structure for commodity_warehousing
-- ----------------------------
DROP TABLE IF EXISTS `commodity_warehousing`;
CREATE TABLE `commodity_warehousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
  `price` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '新员工 664', '00000000000', null, '备注963', '15', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '24');
INSERT INTO `employee` VALUES ('2', '新员工 404', '00000000000', null, '备注955', '16', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '14');
INSERT INTO `employee` VALUES ('3', '新员工 783', '00000000000', null, '备注901', '17', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '15');
INSERT INTO `employee` VALUES ('4', '新员工 507', '00000000000', null, '备注546', '18', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '17');
INSERT INTO `employee` VALUES ('5', '新员工 976', '00000000000', null, '备注431', '19', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '4');
INSERT INTO `employee` VALUES ('6', '新员工 728', '00000000000', null, '备注674', '20', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '6');
INSERT INTO `employee` VALUES ('7', '新员工 130', '00000000000', null, '备注213', '21', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '1');
INSERT INTO `employee` VALUES ('8', '新员工 625', '00000000000', null, '备注883', '22', '2018-08-24 14:39:37', '2018-08-24 14:40:23', '20');
INSERT INTO `employee` VALUES ('9', '新员工 9', '00000000000', null, '备注734', '14', '2018-08-24 14:40:23', '2018-08-24 14:40:23', '8');
INSERT INTO `employee` VALUES ('10', '新员工 665', '00000000000', null, '备注922', '13', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '6');
INSERT INTO `employee` VALUES ('11', '新员工 453', '00000000000', null, '备注783', '12', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '17');
INSERT INTO `employee` VALUES ('12', '新员工 704', '00000000000', null, '备注831', '11', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '14');
INSERT INTO `employee` VALUES ('13', '新员工 151', '00000000000', null, '备注935', '2', '2018-08-24 14:40:23', '2018-08-24 14:41:31', '18');
INSERT INTO `employee` VALUES ('14', '新员工 902', '00000000000', null, '备注651', '3', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '24');
INSERT INTO `employee` VALUES ('15', '新员工 120', '00000000000', null, '备注14', '4', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '14');
INSERT INTO `employee` VALUES ('16', '新员工 751', '00000000000', null, '备注166', '5', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '18');
INSERT INTO `employee` VALUES ('17', '新员工 636', '00000000000', null, '备注382', '6', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '15');
INSERT INTO `employee` VALUES ('18', '新员工 871', '00000000000', null, '备注450', '7', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '3');
INSERT INTO `employee` VALUES ('19', '新员工 875', '00000000000', null, '备注512', '8', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '18');
INSERT INTO `employee` VALUES ('20', '新员工 688', '00000000000', null, '备注645', '9', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '16');
INSERT INTO `employee` VALUES ('21', '新员工 887', '00000000000', null, '备注95', '10', '2018-08-24 14:40:23', '2018-08-24 14:40:55', '1');
INSERT INTO `employee` VALUES ('22', '新员工 841', '00000000000', null, '备注245', '1', '2018-08-24 14:40:23', '2018-08-24 14:41:31', '6');

-- ----------------------------
-- Table structure for employee_type
-- ----------------------------
DROP TABLE IF EXISTS `employee_type`;
CREATE TABLE `employee_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `wage` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee_type
-- ----------------------------
INSERT INTO `employee_type` VALUES ('1', '技师类型 971', '0.0000', '19', '备注926', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('2', '技师类型 992', '0.0000', '20', '备注470', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('3', '技师类型 726', '0.0000', '21', '备注574', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('4', '技师类型 390', '0.0000', '22', '备注606', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('5', '技师类型 342', '0.0000', '23', '备注877', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('6', '技师类型 485', '0.0000', '24', '备注517', '2018-08-24 14:38:23', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('7', '技师类型 137', '0.0000', '18', '备注828', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('8', '技师类型 681', '0.0000', '17', '备注573', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('9', '技师类型 134', '0.0000', '16', '备注396', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('10', '技师类型 582', '0.0000', '15', '备注12', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('11', '技师类型 944', '0.0000', '14', '备注151', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('12', '技师类型 46', '0.0000', '13', '备注310', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('13', '技师类型 972', '0.0000', '12', '备注569', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('14', '技师类型 152', '0.0000', '2', '备注854', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('15', '技师类型 321', '0.0000', '3', '备注793', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('16', '技师类型 526', '0.0000', '4', '备注554', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('17', '技师类型 451', '0.0000', '5', '备注210', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('18', '技师类型 945', '0.0000', '6', '备注998', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('19', '技师类型 326', '0.0000', '7', '备注211', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('20', '技师类型 605', '0.0000', '8', '备注359', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('21', '技师类型 404', '0.0000', '9', '备注475', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('22', '技师类型 198', '0.0000', '10', '备注649', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('23', '技师类型 27', '0.0000', '11', '备注533', '2018-08-24 14:38:36', '2018-08-24 14:38:36');
INSERT INTO `employee_type` VALUES ('24', '技师类型 141', '0.0000', '1', '备注893', '2018-08-24 14:38:36', '2018-08-24 14:38:36');

-- ----------------------------
-- Table structure for employee_wage
-- ----------------------------
DROP TABLE IF EXISTS `employee_wage`;
CREATE TABLE `employee_wage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wage` decimal(16,4) NOT NULL DEFAULT '0.0000',
  `bonus` decimal(16,4) NOT NULL DEFAULT '0.0000',
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1', '新会员 982', '00000000000', '0000', '2', null, null, '0000-00-00 00:00:00', '2018-08-23 06:32:00', '25');
INSERT INTO `member` VALUES ('5', '新会员 982', '00000000000', '0000', '2', null, null, '2018-08-22 09:04:39', '2018-08-23 06:32:00', '30');
INSERT INTO `member` VALUES ('6', '新会员 983', '00000000000', '0000', '备注494', null, null, '2018-08-22 09:04:39', '2018-08-23 06:32:00', '25');
INSERT INTO `member` VALUES ('7', '新会员 660', '00000000000', '0000', '备注941', null, null, '2018-08-22 09:04:39', '2018-08-23 06:32:00', '1');
INSERT INTO `member` VALUES ('9', '新会员 475', '00000000000', '0000', '备注763', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('10', '新会员 31', '00000000000', '0000', '备注708', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('11', '新会员 602', '00000000000', '0000', '备注549', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('12', '新会员 952', '00000000000', '0000', '备注462', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('13', '新会员 798', '00000000000', '0000', '备注240', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('14', '新会员 662', '00000000000', '0000', '备注136', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '1');
INSERT INTO `member` VALUES ('15', '新会员 677', '00000000000', '0000', '备注520', null, null, '2018-08-23 06:32:20', '2018-08-23 06:32:20', '24');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '菜单', '\\menu', '4', '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('2', '用户', '\\user', '6', '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('3', '会员卡', '\\card', '12', '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('4', '会员', '\\member', '13', '0000-00-00 00:00:00', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('10', '会员卡类型', '\\cardType', '11', '2018-08-19 14:01:26', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('11', '系统设置', '', '3', '2018-08-21 04:04:13', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('12', '员工设置', '', '7', '2018-08-21 04:06:21', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('15', '用户类型', '\\userType', '5', '2018-08-21 08:29:44', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('17', '会员设置', '', '10', '2018-08-22 10:09:42', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('18', '员工类型', '\\employeeType', '8', '2018-08-22 10:11:54', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('19', '员工', '\\employee', '9', '2018-08-22 10:11:54', '2018-08-22 10:14:05');
INSERT INTO `menu` VALUES ('20', '常用', '', '1', '2018-08-22 10:14:05', '2018-08-22 10:14:13');
INSERT INTO `menu` VALUES ('21', '首页', '\\mix', '2', '2018-08-22 10:14:05', '2018-08-22 10:15:58');
INSERT INTO `menu` VALUES ('22', '病例', '\\case', '14', '2018-08-24 14:00:24', '2018-08-24 14:00:24');
INSERT INTO `menu` VALUES ('23', '商品设置', '', '15', '2018-08-24 16:10:07', '2018-08-24 16:13:14');
INSERT INTO `menu` VALUES ('24', '商品', '\\commodity', '17', '2018-08-24 16:12:44', '2018-08-24 16:13:14');
INSERT INTO `menu` VALUES ('25', '商品类型', '\\commodityType', '16', '2018-08-24 16:13:02', '2018-08-24 16:13:02');

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
INSERT INTO `user` VALUES ('1', '新登录用户 743', null, null, '', '9', null, '2018-08-04 07:39:11', '2018-08-21 08:26:48', '4');
INSERT INTO `user` VALUES ('2', '新登录用户 26', '165c468905fa4e852e23d2ab8ab2c33a', null, '', '8', null, '2018-08-04 07:40:18', '2018-08-21 12:07:27', '1');
INSERT INTO `user` VALUES ('3', '22', 'c33367701511b4f6020ec61ded352059', null, '345', '2', null, '2018-08-04 07:40:27', '2018-08-21 12:04:48', '5');
INSERT INTO `user` VALUES ('4', '新登录用户 227', null, null, '', '3', null, '2018-08-04 07:40:27', '2018-08-21 08:26:48', '3');
INSERT INTO `user` VALUES ('5', '新登录用户 413', null, null, '', '5', null, '2018-08-04 07:40:27', '2018-08-21 08:26:48', '3');
INSERT INTO `user` VALUES ('6', '4', null, null, '', '6', null, '2018-08-04 07:40:27', '2018-08-21 08:26:48', '4');
INSERT INTO `user` VALUES ('10', '新登录用户 700', '96e79218965eb72c92a549dd5a330112', null, '1', '1', null, '2018-08-04 14:34:18', '2018-08-22 07:54:09', '2');
INSERT INTO `user` VALUES ('11', '新登录用户 346', null, null, '', '4', null, '2018-08-04 14:34:18', '2018-08-21 08:26:48', '1');
INSERT INTO `user` VALUES ('12', '新登录用户 275', null, null, '', '7', null, '2018-08-04 14:34:18', '2018-08-21 08:26:48', '4');

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
INSERT INTO `user_type` VALUES ('1', '系统管理员', '1', '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES ('2', '管理员', '2', '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES ('3', '总经理', '3', '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES ('4', '前台', '4', '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');
INSERT INTO `user_type` VALUES ('5', '会计', '5', '', '0000-00-00 00:00:00', '2018-08-23 05:20:28');

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
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '2');
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '3');
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '4');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '1', '5');
INSERT INTO `user_type_menu` VALUES ('0000-00-00 00:00:00', '0000-00-00 00:00:00', '2', '2');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', '2', '3');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '2', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', '3', '1');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '3', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '4', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:16:11', '2018-08-22 07:16:11', '10', '1');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '10', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:30:14', '2018-08-22 07:30:14', '11', '1');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '11', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:42:55', '2018-08-22 07:42:55', '12', '3');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '12', '5');
INSERT INTO `user_type_menu` VALUES ('2018-08-22 07:41:27', '2018-08-22 07:41:27', '15', '5');
