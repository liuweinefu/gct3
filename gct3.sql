-- MySQL dump 10.17  Distrib 10.3.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: gct3
-- ------------------------------------------------------
-- Server version	10.3.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `gct3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gct3` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `gct3`;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_number` varchar(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `balance` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `phone` varchar(11) NOT NULL,
  `otherphone` varchar(64) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `card_number` (`card_number`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `card_type_id` (`card_type_id`) USING BTREE,
  CONSTRAINT `card_ibfk_1` FOREIGN KEY (`card_type_id`) REFERENCES `card_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_recharge`
--

DROP TABLE IF EXISTS `card_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `card_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `card_id` (`card_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `card_recharge_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `card_recharge_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_recharge`
--

LOCK TABLES `card_recharge` WRITE;
/*!40000 ALTER TABLE `card_recharge` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_recharge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_type`
--

DROP TABLE IF EXISTS `card_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `discount` decimal(16,4) NOT NULL DEFAULT 1.0000,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_type`
--

LOCK TABLES `card_type` WRITE;
/*!40000 ALTER TABLE `card_type` DISABLE KEYS */;
INSERT INTO `card_type` VALUES (15,'新客（无折扣）',1.0000,4,'','2018-11-29 17:08:20','2018-11-29 17:18:01'),(16,'八五折卡（叁仟）',0.8500,1,'','2018-11-29 17:12:36','2018-11-29 17:17:13'),(17,'七五折卡（伍仟）',0.7500,2,'','2018-11-29 17:12:36','2018-11-29 17:17:13'),(18,'无卡（八五折）',0.8500,5,'','2018-11-29 17:12:36','2018-11-29 17:12:36'),(19,'六五折卡（壹万）',0.6500,3,'','2018-11-29 17:12:36','2018-11-29 17:17:13'),(20,'无卡（七五折）',0.7500,6,'','2018-11-29 17:12:36','2018-11-29 17:12:36'),(21,'无卡（六五折）',1.0000,7,'','2018-11-29 17:13:02','2018-11-29 17:13:30'),(22,'团体客户',1.0000,8,'','2018-11-29 17:18:01','2018-11-29 17:18:01'),(23,'体验卡（一）',1.0000,9,'','2018-11-29 17:18:51','2018-11-29 17:18:51'),(24,'体验卡（二）',1.0000,10,'','2018-11-29 17:18:51','2018-11-29 17:18:51');
/*!40000 ALTER TABLE `card_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commodity`
--

DROP TABLE IF EXISTS `commodity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `stocks` int(11) NOT NULL DEFAULT 0,
  `remark` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `commodity_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `commodity_type_id` (`commodity_type_id`) USING BTREE,
  CONSTRAINT `commodity_ibfk_1` FOREIGN KEY (`commodity_type_id`) REFERENCES `commodity_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commodity`
--

LOCK TABLES `commodity` WRITE;
/*!40000 ALTER TABLE `commodity` DISABLE KEYS */;
INSERT INTO `commodity` VALUES (21,'足底（关震）',198.0000,9990,'',1,'2018-11-29 14:32:51','2018-12-07 16:07:22',1),(22,'针灸',138.0000,9998,'',8,'2018-11-29 14:32:51','2018-12-07 15:56:29',1),(23,'足底（其他）',138.0000,9996,'',2,'2018-11-29 14:32:51','2018-12-13 15:22:56',1),(24,'足底（出诊）',198.0000,9997,'',5,'2018-11-29 14:33:22','2018-12-07 15:57:52',1),(25,'足底（团体）',100.0000,10000,'',4,'2018-12-07 15:10:31','2018-12-07 15:57:52',1),(26,'足底（免费）',0.0000,10000,'',3,'2018-12-07 15:40:19','2018-12-07 15:57:20',1),(27,'针灸（免费）',0.0000,10000,'',9,'2018-12-07 15:41:41','2018-12-07 15:56:29',1),(28,'针灸（团体）',100.0000,10000,'',10,'2018-12-07 15:42:42','2018-12-07 15:56:29',1),(29,'艾灸（成人）',138.0000,10000,'',15,'2018-12-07 15:43:45','2018-12-07 15:56:29',1),(30,'艾灸（儿童）',198.0000,10000,'',14,'2018-12-07 15:44:17','2018-12-07 15:56:29',1),(31,'艾灸（团体）',100.0000,10000,'',17,'2018-12-07 15:46:05','2018-12-07 15:56:29',1),(32,'洗髓',118.0000,10000,'',11,'2018-12-07 15:48:28','2018-12-07 15:56:29',1),(33,'洗髓（免费）',0.0000,10000,'',12,'2018-12-07 15:48:28','2018-12-07 15:56:29',1),(34,'洗髓（团体）',85.0000,10000,'',13,'2018-12-07 15:48:28','2018-12-07 15:56:29',1),(35,'艾灸（免费）',0.0000,10000,'',16,'2018-12-07 15:49:46','2018-12-07 15:56:29',1),(36,'推拿',138.0000,10000,'',18,'2018-12-07 15:51:56','2018-12-07 15:56:29',1),(37,'推拿（免费）',0.0000,10000,'',19,'2018-12-07 15:51:56','2018-12-07 15:56:29',1),(38,'推拿（团体）',100.0000,10000,'',20,'2018-12-07 15:51:56','2018-12-07 15:56:29',1),(39,'按摩',98.0000,10000,'',21,'2018-12-07 15:53:02','2018-12-07 15:56:29',1),(40,'按摩（免费）',0.0000,10000,'',22,'2018-12-07 15:53:02','2018-12-07 15:56:29',1),(41,'拔罐',68.0000,10000,'',23,'2018-12-07 15:54:01','2018-12-07 15:56:29',1),(42,'足底（体验一）',80.0000,10000,'',7,'2018-12-07 15:56:29','2018-12-07 15:57:20',1),(43,'足底（体验二）',100.0000,10000,'',6,'2018-12-07 15:56:29','2018-12-07 15:57:52',1),(44,'按摩棒',15.0000,10000,'',25,'2018-12-07 16:02:46','2018-12-07 16:02:46',3),(45,'按摩油（大）',25.0000,10000,'',26,'2018-12-07 16:02:46','2018-12-07 16:02:46',3),(46,'拔罐（免费）',0.0000,10000,'',24,'2018-12-07 16:02:46','2018-12-07 16:02:46',1),(47,'按摩油（小）',15.0000,10000,'',27,'2018-12-07 16:02:46','2018-12-07 16:02:46',3),(48,'棒+油（大）',35.0000,10000,'',28,'2018-12-07 16:02:46','2018-12-07 16:02:46',3),(49,'棒+油（小）',25.0000,10000,'',29,'2018-12-07 16:02:46','2018-12-07 16:02:46',3),(50,'洗车（小）',25.0000,10000,'',30,'2018-12-07 16:05:43','2018-12-07 16:05:43',5),(51,'洗车（大）',35.0000,10000,'',31,'2018-12-07 16:05:43','2018-12-07 16:05:43',5);
/*!40000 ALTER TABLE `commodity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commodity_type`
--

DROP TABLE IF EXISTS `commodity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commodity_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commodity_type`
--

LOCK TABLES `commodity_type` WRITE;
/*!40000 ALTER TABLE `commodity_type` DISABLE KEYS */;
INSERT INTO `commodity_type` VALUES (1,'服务类',1,'','2018-09-08 16:02:27','2018-12-07 15:38:12'),(2,'保健品类',3,'','2018-09-08 16:02:27','2018-12-07 15:38:12'),(3,'商品类',2,'','2018-09-08 16:02:27','2018-12-07 15:38:12'),(4,'红酒类',4,'','2018-12-07 15:33:24','2018-12-07 15:38:12'),(5,'附加服务类',5,'','2018-12-07 15:38:33','2018-12-07 15:38:33');
/*!40000 ALTER TABLE `commodity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commodity_warehousing`
--

DROP TABLE IF EXISTS `commodity_warehousing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commodity_warehousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `commodity_id` (`commodity_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `commodity_warehousing_ibfk_1` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `commodity_warehousing_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commodity_warehousing`
--

LOCK TABLES `commodity_warehousing` WRITE;
/*!40000 ALTER TABLE `commodity_warehousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `commodity_warehousing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumption`
--

DROP TABLE IF EXISTS `consumption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `is_cash` tinyint(1) NOT NULL DEFAULT 0,
  `is_close` tinyint(1) NOT NULL DEFAULT 0,
  `is_discount` tinyint(1) NOT NULL DEFAULT 0,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `card_id` int(11) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `wage_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `card_id` (`card_id`) USING BTREE,
  KEY `commodity_id` (`commodity_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `employee_id` (`employee_id`) USING BTREE,
  KEY `wage_id` (`wage_id`) USING BTREE,
  CONSTRAINT `consumption_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_2` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_4` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_5` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `consumption_ibfk_6` FOREIGN KEY (`wage_id`) REFERENCES `wage` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumption`
--

LOCK TABLES `consumption` WRITE;
/*!40000 ALTER TABLE `consumption` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `employee_type_id` (`employee_type_id`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`employee_type_id`) REFERENCES `employee_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (5,'员工1','00000000000',NULL,'备注811',2,'2018-09-07 03:15:53','2018-11-29 14:30:15',22),(15,'员工4','00000000000',NULL,'备注293',5,'2018-09-07 03:21:00','2018-11-29 14:30:15',25),(16,'员工3','00000000000',NULL,'备注435',4,'2018-09-07 03:21:00','2018-11-29 14:30:15',24),(17,'员工2','00000000000',NULL,'备注596',3,'2018-09-07 03:21:00','2018-11-29 14:30:15',23),(18,'员工0','00000000000',NULL,'备注264',1,'2018-11-29 14:30:15','2018-12-06 14:41:27',22);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_type`
--

DROP TABLE IF EXISTS `employee_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `wage` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_type`
--

LOCK TABLES `employee_type` WRITE;
/*!40000 ALTER TABLE `employee_type` DISABLE KEYS */;
INSERT INTO `employee_type` VALUES (21,'实习治疗师',1000.0000,4,'','2018-11-29 14:04:24','2018-11-29 14:12:21'),(22,'一级治疗师',1500.0000,5,'','2018-11-29 14:04:49','2018-11-29 14:12:21'),(23,'二级治疗师',2000.0000,6,'','2018-11-29 14:06:06','2018-11-29 14:12:21'),(24,'三级治疗师',2200.0000,7,'','2018-11-29 14:06:06','2018-11-29 14:12:21'),(25,'四级治疗师',2500.0000,8,'','2018-11-29 14:07:02','2018-11-29 14:12:21'),(26,'总经理',0.0000,1,'','2018-11-29 14:09:55','2018-11-29 14:11:06'),(27,'前台',0.0000,3,'','2018-11-29 14:10:27','2018-11-29 14:12:21'),(28,'店长',0.0000,2,'','2018-11-29 14:12:21','2018-11-29 14:12:21');
/*!40000 ALTER TABLE `employee_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `otherphone` varchar(64) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `case` text DEFAULT NULL,
  `case_remark` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `card_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `card_id` (`card_id`) USING BTREE,
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `card` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `router` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'菜单','/menu',16,'0000-00-00 00:00:00','2018-12-05 15:57:45'),(2,'登陆用户','/user',15,'0000-00-00 00:00:00','2018-12-05 15:57:45'),(3,'会员卡','/card',5,'0000-00-00 00:00:00','2018-12-05 15:56:13'),(4,'会员','/member',6,'0000-00-00 00:00:00','2018-12-05 15:56:13'),(10,'会员卡类型','/cardType',18,'2018-08-19 14:01:26','2018-12-01 16:01:29'),(11,'内部管理','',11,'2018-08-21 04:04:13','2018-12-01 16:01:29'),(15,'登陆用户类型','/userType',21,'2018-08-21 08:29:44','2018-12-01 16:01:29'),(17,'会员信息','',4,'2018-08-22 10:09:42','2018-12-05 15:56:13'),(18,'员工类型','/employeeType',19,'2018-08-22 10:11:54','2018-12-01 16:01:29'),(19,'员工','/employee',12,'2018-08-22 10:11:54','2018-12-01 16:01:29'),(20,'首页','',1,'2018-08-22 10:14:05','2018-11-29 16:48:26'),(21,'刷账','/mix',2,'2018-08-22 10:14:05','2018-11-29 16:48:26'),(23,'工资记录','/wage',13,'2018-09-07 03:32:08','2018-12-05 15:57:45'),(24,'会员消费记录','/consumption',10,'2018-09-07 03:32:22','2018-12-05 15:56:13'),(25,'内部设置','',17,'2018-09-08 15:52:32','2018-12-01 16:01:29'),(26,'商品类型','/commodityType',20,'2018-09-08 15:53:39','2018-12-01 16:01:29'),(27,'商品','/commodity',14,'2018-09-08 15:53:39','2018-12-05 15:57:45'),(31,'注销','/logout',3,'0000-00-00 00:00:00','2018-12-05 15:56:13'),(32,'会员充值记录','/cardRecharge',9,'2018-11-17 17:14:37','2018-12-05 15:56:13'),(33,'查询','',7,'2018-11-29 16:05:19','2018-12-05 15:56:13'),(34,'消费记录','/mix/getConsumptionList',8,'2018-12-01 16:01:29','2018-12-05 15:56:13');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `location` varchar(32) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sn` int(11) NOT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `user_type_id` (`user_type_id`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'ning','5714d95124dc30e7e8ac7d6e3d1d1e61','','','',2,'2018-12-13 15:22:07','2018-08-04 07:40:27','2018-12-13 15:22:07',3),(4,'nanhong','a5c55e0a0581fcbff3ced1262e9ed4f5','河松店',NULL,'',3,'2018-12-06 02:00:09','2018-08-04 07:40:27','2018-12-07 15:30:22',4),(10,'admin','7621bb1f1ed60ba5a985e3f708e47f5e','','','',1,'2018-12-13 03:00:16','2018-08-04 14:34:18','2018-12-13 03:00:16',1),(11,'yangyang','ba1b822742209c109e2ee0429baab3b0','哈西店',NULL,'',4,'2018-12-06 01:54:58','2018-08-04 14:34:18','2018-12-07 15:30:22',4);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `sn` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'系统管理员',1,'','0000-00-00 00:00:00','2018-10-15 02:09:46'),(2,'管理员',2,'','0000-00-00 00:00:00','2018-08-23 05:20:28'),(3,'总经理',3,'','0000-00-00 00:00:00','2018-08-23 05:20:28'),(4,'前台',4,'','0000-00-00 00:00:00','2018-08-23 05:20:28'),(5,'会计',5,'','0000-00-00 00:00:00','2018-08-23 05:20:28');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type_menu`
--

DROP TABLE IF EXISTS `user_type_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type_menu` (
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `menu_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`,`user_type_id`) USING BTREE,
  KEY `user_type_id` (`user_type_id`) USING BTREE,
  CONSTRAINT `user_type_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_type_menu_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type_menu`
--

LOCK TABLES `user_type_menu` WRITE;
/*!40000 ALTER TABLE `user_type_menu` DISABLE KEYS */;
INSERT INTO `user_type_menu` VALUES ('2018-10-14 16:06:36','2018-10-14 16:06:36',1,1),('0000-00-00 00:00:00','0000-00-00 00:00:00',1,2),('0000-00-00 00:00:00','0000-00-00 00:00:00',1,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',1,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',2,1),('0000-00-00 00:00:00','0000-00-00 00:00:00',2,2),('2018-08-22 07:42:55','2018-08-22 07:42:55',2,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',2,5),('2018-08-22 07:16:11','2018-08-22 07:16:11',3,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',3,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',3,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',3,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',4,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',4,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',4,3),('2018-12-05 15:58:36','2018-12-05 15:58:36',4,4),('2018-08-22 07:41:27','2018-08-22 07:41:27',4,5),('2018-08-22 07:16:11','2018-08-22 07:16:11',10,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',10,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',10,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',10,5),('2018-08-22 07:30:14','2018-08-22 07:30:14',11,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',11,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',11,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',11,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',15,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',15,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',15,3),('2018-08-22 07:41:27','2018-08-22 07:41:27',15,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',17,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',17,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',17,3),('2018-12-05 15:58:36','2018-12-05 15:58:36',17,4),('2018-10-14 16:06:36','2018-10-14 16:06:36',18,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',18,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',18,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',19,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',19,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',19,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',20,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',20,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',20,3),('2018-10-14 16:06:49','2018-10-14 16:06:49',20,4),('2018-10-14 17:04:19','2018-10-14 17:04:19',20,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',21,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',21,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',21,3),('2018-10-14 16:06:49','2018-10-14 16:06:49',21,4),('2018-10-14 17:05:12','2018-10-14 17:05:12',21,5),('2018-10-14 16:06:36','2018-10-14 16:06:36',23,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',23,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',23,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',24,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',24,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',24,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',25,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',25,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',25,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',26,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',26,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',26,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',27,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',27,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',27,3),('2018-10-14 16:06:36','2018-10-14 16:06:36',31,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',31,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',31,3),('2018-10-14 17:03:22','2018-10-14 17:03:22',31,4),('2018-10-14 17:04:19','2018-10-14 17:04:19',31,5),('2018-11-17 17:14:51','2018-11-17 17:14:51',32,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',32,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',32,3),('2018-12-05 15:58:36','2018-12-05 15:58:36',32,4),('2018-11-29 16:12:50','2018-11-29 16:12:50',33,1),('2018-11-29 16:32:19','2018-11-29 16:32:19',33,2),('2018-11-29 16:33:56','2018-11-29 16:33:56',33,3),('2018-12-05 15:58:36','2018-12-05 15:58:36',33,4),('2018-12-01 16:02:11','2018-12-01 16:02:11',34,1),('2018-12-05 14:50:10','2018-12-05 14:50:10',34,3),('2018-12-01 16:02:17','2018-12-01 16:02:17',34,4);
/*!40000 ALTER TABLE `user_type_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wage`
--

DROP TABLE IF EXISTS `wage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wage` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `bonus` decimal(16,4) NOT NULL DEFAULT 0.0000,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `employee_id` (`employee_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `wage_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `wage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wage`
--

LOCK TABLES `wage` WRITE;
/*!40000 ALTER TABLE `wage` DISABLE KEYS */;
/*!40000 ALTER TABLE `wage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-14 10:23:12
