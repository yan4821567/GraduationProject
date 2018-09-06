-- MySQL dump 10.13  Distrib 5.5.47, for Win32 (x86)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version	5.5.47

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(20) DEFAULT NULL,
  `customer_gender` int(11) DEFAULT NULL,
  `customer_age` int(11) DEFAULT NULL,
  `customer_tel` varchar(20) DEFAULT NULL,
  `customer_interest` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (5,'毛泽东',1,83,'2323423','100011'),(11,'孙文',1,21,'000999','001010'),(10,'蒋中正',1,130,'747474747','101010');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_discount` double(3,2) DEFAULT NULL,
  `order_table` int(11) DEFAULT NULL,
  `order_count` int(11) DEFAULT NULL,
  `order_cost` double(8,2) DEFAULT NULL,
  `order_start` datetime DEFAULT NULL,
  `order_end` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,0.00,2001,3,150.00,'2016-04-10 10:20:24','2016-04-10 10:27:47'),(2,0.00,1004,2,100.00,'2016-04-10 11:11:31','2016-04-10 12:21:48'),(3,0.00,2001,3,150.00,'2016-04-10 15:03:25','2016-04-10 15:05:44'),(4,0.90,2001,3,135.00,'2016-04-11 08:58:20','2016-04-11 09:02:08'),(5,0.00,1003,2,100.00,'2016-04-11 09:00:51','2016-04-11 09:13:20'),(6,0.10,1003,1,5.00,'2016-04-11 09:32:02','2016-04-11 09:35:33'),(7,0.00,3001,2,100.00,'2016-04-11 09:34:13','2016-04-11 09:35:46'),(8,0.90,2002,1,45.00,'2016-04-11 09:35:18','2016-04-11 09:35:40'),(9,0.00,2003,4,200.00,'2016-04-11 09:37:35','2016-04-11 09:37:53');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(20) DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL,
  `product_count` int(11) DEFAULT NULL,
  `product_price` double(6,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables` (
  `table_id` int(11) DEFAULT NULL,
  `table_hasone` tinyint(1) DEFAULT '0',
  `table_size` int(11) DEFAULT NULL,
  `table_area` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1001,0,0,1),(1002,0,0,1),(1003,0,0,1),(1004,0,0,1),(2004,0,0,2),(2001,0,0,2),(2002,0,0,2),(2003,0,0,2),(3001,0,0,3),(3002,0,0,3),(3003,0,0,3),(3004,0,0,3);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workers` (
  `worker_id` int(11) NOT NULL AUTO_INCREMENT,
  `worker_name` varchar(20) DEFAULT NULL,
  `worker_gender` int(11) DEFAULT NULL,
  `worker_age` int(11) DEFAULT NULL,
  `worker_tel` varchar(20) DEFAULT NULL,
  `worker_role` int(11) DEFAULT NULL,
  `worker_privilege` int(11) DEFAULT NULL,
  `worker_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`worker_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES (1,'Jiagen',1,22,'0000001',0,0,'1'),(2,'Jobs',1,41,'6668888',1,1,'1'),(3,'谢安琪',0,13,'456345345',2,2,'1'),(5,'黄伟文',1,37,'1212121',2,2,'kobe'),(7,'陈奕迅',1,66,'125435',2,2,'james');
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-11  9:43:21
