CREATE DATABASE  IF NOT EXISTS `shoppingcart` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `shoppingcart`;
-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: shoppingcart
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

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
-- Table structure for table `actor_actor`
--

DROP TABLE IF EXISTS `actor_actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor_actor` (
  `user_ptr_id` int(11) NOT NULL,
  `ssn` varchar(32) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone_number` varchar(32) NOT NULL,
  `alt_phone_number` varchar(32) NOT NULL,
  `alt_email` varchar(75) NOT NULL,
  `skype` varchar(128) NOT NULL,
  `twitter` varchar(128) NOT NULL,
  `website` varchar(200) NOT NULL,
  `blog` varchar(200) NOT NULL,
  `linkedin_name` varchar(128) NOT NULL,
  `linkedin_ref` varchar(128) NOT NULL,
  `description` longtext NOT NULL,
  `language` varchar(8) NOT NULL,
  `timezone` varchar(10) NOT NULL,
  `invite_code` varchar(16) NOT NULL,
  `updated_on` datetime NOT NULL,
  `lockout_times` varchar(10) NOT NULL,
  `actor_key` varchar(128) NOT NULL,
  `secret_key` varchar(128) NOT NULL,
  `access_key` varchar(128) NOT NULL,
  `confirmation_key` varchar(128) NOT NULL,
  `email_confirmation` tinyint(1) NOT NULL,
  `type` varchar(128) NOT NULL,
  `category` varchar(128) NOT NULL,
  `partner_status` tinyint(1) NOT NULL,
  `partner_commission` double NOT NULL,
  `is_first` tinyint(1) NOT NULL,
  `signup_method` varchar(128) NOT NULL,
  `pkb_email` tinyint(1) NOT NULL,
  `email_subscribed` tinyint(1) NOT NULL,
  `sales_email` tinyint(1) NOT NULL,
  `is_sellerregistered` tinyint(1) NOT NULL,
  `Login_IPnumber` varchar(100) NOT NULL,
  `Registration_IPnumber` varchar(100) NOT NULL,
  `google_client_id` varchar(50) NOT NULL,
  `seller_commission` double NOT NULL,
  `currency` varchar(6) NOT NULL,
  PRIMARY KEY (`user_ptr_id`),
  CONSTRAINT `user_ptr_id_refs_id_971f172a` FOREIGN KEY (`user_ptr_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor_actor`
--

LOCK TABLES `actor_actor` WRITE;
/*!40000 ALTER TABLE `actor_actor` DISABLE KEYS */;
INSERT INTO `actor_actor` VALUES (1,'',NULL,'','','','','','','','','','','','UTC+01:00','','2015-06-11 18:15:07','0','5001','deb57bbbf39543e5b7f60d6b3a564af2','bf9178a12bca46a0be5b9b1aad801cbb','4a3891a32c9742d5980ebf4a67fb6402',0,'','',0,0,1,'',1,1,1,0,'','','',-1,'SGD'),(2,'',NULL,'9874561230','','','','','','','','','s','','UTC+01:00','','2015-06-11 18:17:07','0','5002','f4e9c6b327a64d33b859f02ace4b7327','7a755f3f67bf463a9e7597578a0a2a99','dcaeeb0fdb004db5b27ad3c1fd6be17e',0,'','',0,0,1,'',1,1,1,0,'','','',-1,'SGD');
/*!40000 ALTER TABLE `actor_actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add attribute',8,'add_attribute'),(23,'Can change attribute',8,'change_attribute'),(24,'Can delete attribute',8,'delete_attribute'),(25,'Can add review',9,'add_review'),(26,'Can change review',9,'change_review'),(27,'Can delete review',9,'delete_review'),(28,'Can add brand',10,'add_brand'),(29,'Can change brand',10,'change_brand'),(30,'Can delete brand',10,'delete_brand'),(31,'Can add image',11,'add_image'),(32,'Can change image',11,'change_image'),(33,'Can delete image',11,'delete_image'),(34,'Can add category',12,'add_category'),(35,'Can change category',12,'change_category'),(36,'Can delete category',12,'delete_category'),(37,'Can add shipping method',13,'add_shippingmethod'),(38,'Can change shipping method',13,'change_shippingmethod'),(39,'Can delete shipping method',13,'delete_shippingmethod'),(40,'Can add order',14,'add_order'),(41,'Can change order',14,'change_order'),(42,'Can delete order',14,'delete_order'),(43,'Can add offer',15,'add_offer'),(44,'Can change offer',15,'change_offer'),(45,'Can delete offer',15,'delete_offer'),(46,'Can add product',16,'add_product'),(47,'Can change product',16,'change_product'),(48,'Can delete product',16,'delete_product'),(49,'Can add actor',17,'add_actor'),(50,'Can change actor',17,'change_actor'),(51,'Can delete actor',17,'delete_actor'),(52,'Can add basket',18,'add_basket'),(53,'Can change basket',18,'change_basket'),(54,'Can delete basket',18,'delete_basket'),(55,'Can add basket line',19,'add_basketline'),(56,'Can change basket line',19,'change_basketline'),(57,'Can delete basket line',19,'delete_basketline'),(58,'Can add payment',20,'add_payment'),(59,'Can change payment',20,'change_payment'),(60,'Can delete payment',20,'delete_payment'),(61,'Can add refund',21,'add_refund'),(62,'Can change refund',21,'change_refund'),(63,'Can delete refund',21,'delete_refund'),(64,'Can add preapproval',22,'add_preapproval'),(65,'Can change preapproval',22,'change_preapproval'),(66,'Can delete preapproval',22,'delete_preapproval');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'admin','','','admin@gmail.com','pbkdf2_sha256$10000$IxkeeF5qqhAN$B4MuWH7BlR+p+W79U6Y5zlbEqsSDWudRABZuPrheFnk=',1,1,1,'2015-06-11 18:16:35','2015-06-11 18:15:07'),(2,'itssastha@gmail.com','Sastha','M','itssastha@gmail.com','pbkdf2_sha256$10000$f2BYhMT6dH35$Xnv++1gzSohAbGonq5pL7rDLWjdQ+9s2Jed4hmjS24Q=',0,1,0,'2015-06-11 18:16:47','2015-06-11 18:16:47');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_basket`
--

DROP TABLE IF EXISTS `commerce_basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `total_currency` varchar(8) DEFAULT NULL,
  `total_tax` decimal(10,2) NOT NULL,
  `total_quantity` double NOT NULL,
  `active` tinyint(1) NOT NULL,
  `status` varchar(10) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commerce_basket_5066dfde` (`actor_id`),
  CONSTRAINT `actor_id_refs_user_ptr_id_9ef0655c` FOREIGN KEY (`actor_id`) REFERENCES `actor_actor` (`user_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_basket`
--

LOCK TABLES `commerce_basket` WRITE;
/*!40000 ALTER TABLE `commerce_basket` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_basketline`
--

DROP TABLE IF EXISTS `commerce_basketline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_basketline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basket_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commerce_basketline_7e9d6c10` (`basket_id`),
  KEY `commerce_basketline_bb420c12` (`product_id`),
  CONSTRAINT `product_id_refs_id_68d23190` FOREIGN KEY (`product_id`) REFERENCES `sproductinfo_product` (`id`),
  CONSTRAINT `basket_id_refs_id_86729ca5` FOREIGN KEY (`basket_id`) REFERENCES `commerce_basket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_basketline`
--

LOCK TABLES `commerce_basketline` WRITE;
/*!40000 ALTER TABLE `commerce_basketline` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_basketline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-06-11 18:17:07',1,17,'2','itssastha@gmail.com',1,''),(2,'2015-06-11 18:18:05',1,12,'1','MUSEUM',1,''),(3,'2015-06-11 18:18:20',1,12,'2','WaterPark',1,''),(4,'2015-06-11 18:18:54',1,8,'1','Family',1,''),(5,'2015-06-11 18:19:10',1,10,'1','Package Deal!',1,''),(6,'2015-06-11 18:19:18',1,9,'1','Good Products',1,''),(7,'2015-06-11 18:20:07',1,11,'1','Tickets',1,''),(8,'2015-06-11 18:22:53',1,15,'3','sales offer',1,''),(9,'2015-06-11 18:23:14',1,16,'1','Trick Eye Museum (Trickeye) + SEA Aquarium Package',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'attribute','sproductinfo','attribute'),(9,'review','sproductinfo','review'),(10,'brand','sproductinfo','brand'),(11,'image','sproductinfo','image'),(12,'category','sproductinfo','category'),(13,'shipping method','sproductinfo','shippingmethod'),(14,'order','sproductinfo','order'),(15,'offer','sproductinfo','offer'),(16,'product','sproductinfo','product'),(17,'actor','actor','actor'),(18,'basket','commerce','basket'),(19,'basket line','commerce','basketline'),(20,'payment','paypaladaptive','payment'),(21,'refund','paypaladaptive','refund'),(22,'preapproval','paypaladaptive','preapproval');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('a70c968f77041300b5fb5fe63a434238','OGM2ZTI1NDRkZTgxZmYzYzExYzJjOTlmMTdiN2U2MGU0MWU0NGY1YTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2015-06-25 18:16:35');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypaladaptive_payment`
--

DROP TABLE IF EXISTS `paypaladaptive_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypaladaptive_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(10,2) NOT NULL,
  `money_currency` varchar(3) NOT NULL,
  `created_date` datetime NOT NULL,
  `secret_uuid` varchar(32) NOT NULL,
  `debug_request` longtext,
  `debug_response` longtext,
  `pay_key` varchar(255) NOT NULL,
  `transaction_id` varchar(128) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `status_detail` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypaladaptive_payment`
--

LOCK TABLES `paypaladaptive_payment` WRITE;
/*!40000 ALTER TABLE `paypaladaptive_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypaladaptive_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypaladaptive_preapproval`
--

DROP TABLE IF EXISTS `paypaladaptive_preapproval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypaladaptive_preapproval` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(10,2) NOT NULL,
  `money_currency` varchar(3) NOT NULL,
  `created_date` datetime NOT NULL,
  `secret_uuid` varchar(32) NOT NULL,
  `debug_request` longtext,
  `debug_response` longtext,
  `valid_until_date` datetime NOT NULL,
  `preapproval_key` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL,
  `status_detail` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypaladaptive_preapproval`
--

LOCK TABLES `paypaladaptive_preapproval` WRITE;
/*!40000 ALTER TABLE `paypaladaptive_preapproval` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypaladaptive_preapproval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paypaladaptive_refund`
--

DROP TABLE IF EXISTS `paypaladaptive_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paypaladaptive_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(10,2) NOT NULL,
  `money_currency` varchar(3) NOT NULL,
  `created_date` datetime NOT NULL,
  `secret_uuid` varchar(32) NOT NULL,
  `debug_request` longtext,
  `debug_response` longtext,
  `payment_id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `status_detail` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_id` (`payment_id`),
  CONSTRAINT `payment_id_refs_id_3ba3fb88` FOREIGN KEY (`payment_id`) REFERENCES `paypaladaptive_payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paypaladaptive_refund`
--

LOCK TABLES `paypaladaptive_refund` WRITE;
/*!40000 ALTER TABLE `paypaladaptive_refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `paypaladaptive_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_attribute`
--

DROP TABLE IF EXISTS `sproductinfo_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(50) NOT NULL,
  `attribute_code` varchar(150) NOT NULL,
  `attribute_price` double DEFAULT NULL,
  `attribute_desc` longtext NOT NULL,
  `attribute_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_attribute`
--

LOCK TABLES `sproductinfo_attribute` WRITE;
/*!40000 ALTER TABLE `sproductinfo_attribute` DISABLE KEYS */;
INSERT INTO `sproductinfo_attribute` VALUES (1,'Family','FAM',45,'Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','active');
/*!40000 ALTER TABLE `sproductinfo_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_brand`
--

DROP TABLE IF EXISTS `sproductinfo_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brands_name` varchar(150) NOT NULL,
  `brands_details` longtext NOT NULL,
  `brands_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_brand`
--

LOCK TABLES `sproductinfo_brand` WRITE;
/*!40000 ALTER TABLE `sproductinfo_brand` DISABLE KEYS */;
INSERT INTO `sproductinfo_brand` VALUES (1,'Package Deal!','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','active');
/*!40000 ALTER TABLE `sproductinfo_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_category`
--

DROP TABLE IF EXISTS `sproductinfo_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(10) NOT NULL,
  `category_desc` longtext NOT NULL,
  `category_image` varchar(500) DEFAULT NULL,
  `category_thumbnail` varchar(500) DEFAULT NULL,
  `category_createddate` datetime NOT NULL,
  `category_updatedate` datetime NOT NULL,
  `category_metakeyword` longtext NOT NULL,
  `category_metadescripition` longtext NOT NULL,
  `category_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_category`
--

LOCK TABLES `sproductinfo_category` WRITE;
/*!40000 ALTER TABLE `sproductinfo_category` DISABLE KEYS */;
INSERT INTO `sproductinfo_category` VALUES (1,'MUSEUM','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','static/img/photos/8.jpg','','2015-06-11 18:18:05','2015-06-11 18:18:05','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','active'),(2,'WaterPark','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','static/img/photos/2_2.jpg','','2015-06-11 18:18:20','2015-06-11 18:18:20','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','active');
/*!40000 ALTER TABLE `sproductinfo_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_image`
--

DROP TABLE IF EXISTS `sproductinfo_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(150) NOT NULL,
  `photos` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `image_path` varchar(150) NOT NULL,
  `image_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_image`
--

LOCK TABLES `sproductinfo_image` WRITE;
/*!40000 ALTER TABLE `sproductinfo_image` DISABLE KEYS */;
INSERT INTO `sproductinfo_image` VALUES (1,'Tickets','static/img/photos/4_1.jpg','','','active');
/*!40000 ALTER TABLE `sproductinfo_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_offer`
--

DROP TABLE IF EXISTS `sproductinfo_offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_type` varchar(150) NOT NULL,
  `offer_amount` double DEFAULT NULL,
  `offer_price` double DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_offer`
--

LOCK TABLES `sproductinfo_offer` WRITE;
/*!40000 ALTER TABLE `sproductinfo_offer` DISABLE KEYS */;
INSERT INTO `sproductinfo_offer` VALUES (3,'sales offer',2,3,'2015-06-11 18:22:53','2015-06-11 18:22:53');
/*!40000 ALTER TABLE `sproductinfo_offer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_order`
--

DROP TABLE IF EXISTS `sproductinfo_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` double DEFAULT NULL,
  `order_shippingmethods_id` int(11) NOT NULL,
  `shipping_address` longtext NOT NULL,
  `shipping_city` varchar(50) NOT NULL,
  `shipping_email` varchar(50) NOT NULL,
  `shipping_phonenumber` varchar(50) NOT NULL,
  `billing_address` longtext NOT NULL,
  `billing_city` varchar(50) NOT NULL,
  `billing_email` varchar(50) NOT NULL,
  `billing_phonenumber` varchar(50) NOT NULL,
  `customer_comments` longtext NOT NULL,
  `order_createddate` datetime NOT NULL,
  `order_updatedate` datetime NOT NULL,
  `order_status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sproductinfo_order_ee0faac4` (`order_shippingmethods_id`),
  CONSTRAINT `order_shippingmethods_id_refs_id_813da873` FOREIGN KEY (`order_shippingmethods_id`) REFERENCES `sproductinfo_shippingmethod` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_order`
--

LOCK TABLES `sproductinfo_order` WRITE;
/*!40000 ALTER TABLE `sproductinfo_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `sproductinfo_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_product`
--

DROP TABLE IF EXISTS `sproductinfo_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_title` varchar(50) NOT NULL,
  `product_shortdesc` longtext NOT NULL,
  `product_desc` longtext NOT NULL,
  `product_code` varchar(30) NOT NULL,
  `product_category_id` int(11) NOT NULL,
  `product_brands_id` int(11) NOT NULL,
  `product_attributes_id` int(11) NOT NULL,
  `product_reviews_id` int(11) NOT NULL,
  `product_images_id` int(11) NOT NULL,
  `product_price` double DEFAULT NULL,
  `product_currency` varchar(15) NOT NULL,
  `product_sale` int(11) NOT NULL,
  `product_sold` int(11) NOT NULL,
  `product_presold` int(11) NOT NULL,
  `product_availability` int(11) NOT NULL,
  `product_offers_id` int(11) NOT NULL,
  `product_createddate` datetime NOT NULL,
  `product_updatedate` datetime NOT NULL,
  `product_type` varchar(10) NOT NULL,
  `product_status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sproductinfo_product_af7958e4` (`product_category_id`),
  KEY `sproductinfo_product_9f7a40e8` (`product_brands_id`),
  KEY `sproductinfo_product_b78601ad` (`product_attributes_id`),
  KEY `sproductinfo_product_3654851c` (`product_reviews_id`),
  KEY `sproductinfo_product_158ab338` (`product_images_id`),
  KEY `sproductinfo_product_1107be73` (`product_offers_id`),
  CONSTRAINT `product_images_id_refs_id_594798af` FOREIGN KEY (`product_images_id`) REFERENCES `sproductinfo_image` (`id`),
  CONSTRAINT `product_attributes_id_refs_id_a61d37e6` FOREIGN KEY (`product_attributes_id`) REFERENCES `sproductinfo_attribute` (`id`),
  CONSTRAINT `product_brands_id_refs_id_7011ae5d` FOREIGN KEY (`product_brands_id`) REFERENCES `sproductinfo_brand` (`id`),
  CONSTRAINT `product_category_id_refs_id_53411b91` FOREIGN KEY (`product_category_id`) REFERENCES `sproductinfo_category` (`id`),
  CONSTRAINT `product_offers_id_refs_id_c38aacd4` FOREIGN KEY (`product_offers_id`) REFERENCES `sproductinfo_offer` (`id`),
  CONSTRAINT `product_reviews_id_refs_id_c559f073` FOREIGN KEY (`product_reviews_id`) REFERENCES `sproductinfo_review` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_product`
--

LOCK TABLES `sproductinfo_product` WRITE;
/*!40000 ALTER TABLE `sproductinfo_product` DISABLE KEYS */;
INSERT INTO `sproductinfo_product` VALUES (1,'Trick Eye Museum (Trickeye) + SEA Aquarium Package','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]Trick Eye Museum (Trickeye) + ','Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]Trick Eye Museum (Trickeye) + SEA Aquarium Package Deal! [Sentosa Attractions Tickets! Great Deal! Ideal Gifts!]','PR001',1,1,1,1,1,15,'INR',2,1,1,50,3,'2015-06-11 18:23:14','2015-06-11 18:23:14','newarrival','active');
/*!40000 ALTER TABLE `sproductinfo_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_review`
--

DROP TABLE IF EXISTS `sproductinfo_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reviews_details` varchar(150) NOT NULL,
  `reviews_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_review`
--

LOCK TABLES `sproductinfo_review` WRITE;
/*!40000 ALTER TABLE `sproductinfo_review` DISABLE KEYS */;
INSERT INTO `sproductinfo_review` VALUES (1,'Good Products','active');
/*!40000 ALTER TABLE `sproductinfo_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sproductinfo_shippingmethod`
--

DROP TABLE IF EXISTS `sproductinfo_shippingmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sproductinfo_shippingmethod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipping_code` varchar(15) NOT NULL,
  `shipping_name` varchar(55) NOT NULL,
  `shipping_methodtype` varchar(55) NOT NULL,
  `shipping_floor` double DEFAULT NULL,
  `shipping_amount` double DEFAULT NULL,
  `shipping_isactive` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sproductinfo_shippingmethod`
--

LOCK TABLES `sproductinfo_shippingmethod` WRITE;
/*!40000 ALTER TABLE `sproductinfo_shippingmethod` DISABLE KEYS */;
/*!40000 ALTER TABLE `sproductinfo_shippingmethod` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-11 23:55:37
