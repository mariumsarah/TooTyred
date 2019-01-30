-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: tootyred
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
DROP DATABASE tootyred;
CREATE DATABASE tootyred;
USE tootyred;
SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_status`
--
--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add users',7,'add_users'),(26,'Can change users',7,'change_users'),(27,'Can delete users',7,'delete_users'),(28,'Can view users',7,'view_users'),(29,'Can add user profile',8,'add_userprofile'),(30,'Can change user profile',8,'change_userprofile'),(31,'Can delete user profile',8,'delete_userprofile'),(32,'Can view user profile',8,'view_userprofile'),(37,'Can add stationstable',10,'add_stationstable'),(38,'Can change stationstable',10,'change_stationstable'),(39,'Can delete stationstable',10,'delete_stationstable'),(40,'Can view stationstable',10,'view_stationstable'),(41,'Can add station',11,'add_station'),(42,'Can change station',11,'change_station'),(43,'Can delete station',11,'delete_station'),(44,'Can view station',11,'view_station'),(45,'Can add bike',12,'add_bike'),(46,'Can change bike',12,'change_bike'),(47,'Can delete bike',12,'delete_bike'),(48,'Can view bike',12,'view_bike'),(49,'Can add bike type',13,'add_biketype'),(50,'Can change bike type',13,'change_biketype'),(51,'Can delete bike type',13,'delete_biketype'),(52,'Can view bike type',13,'view_biketype'),(53,'Can add status of bike',14,'add_statusofbike'),(54,'Can change status of bike',14,'change_statusofbike'),(55,'Can delete status of bike',14,'delete_statusofbike'),(56,'Can view status of bike',14,'view_statusofbike'),(57,'Can add type of bike',15,'add_typeofbike'),(58,'Can change type of bike',15,'change_typeofbike'),(59,'Can delete type of bike',15,'delete_typeofbike'),(60,'Can view type of bike',15,'view_typeofbike'),(61,'Can add acc status',16,'add_accstatus'),(62,'Can change acc status',16,'change_accstatus'),(63,'Can delete acc status',16,'delete_accstatus'),(64,'Can view acc status',16,'view_accstatus'),(65,'Can add bike on reservation',17,'add_bikeonreservation'),(66,'Can change bike on reservation',17,'change_bikeonreservation'),(67,'Can delete bike on reservation',17,'delete_bikeonreservation'),(68,'Can view bike on reservation',17,'view_bikeonreservation'),(69,'Can add checkuplog',18,'add_checkuplog'),(70,'Can change checkuplog',18,'change_checkuplog'),(71,'Can delete checkuplog',18,'delete_checkuplog'),(72,'Can view checkuplog',18,'view_checkuplog'),(73,'Can add complaints',19,'add_complaints'),(74,'Can change complaints',19,'change_complaints'),(75,'Can delete complaints',19,'delete_complaints'),(76,'Can view complaints',19,'view_complaints'),(77,'Can add creditcardinfo',20,'add_creditcardinfo'),(78,'Can change creditcardinfo',20,'change_creditcardinfo'),(79,'Can delete creditcardinfo',20,'delete_creditcardinfo'),(80,'Can view creditcardinfo',20,'view_creditcardinfo'),(85,'Can add customer rating',22,'add_customerrating'),(86,'Can change customer rating',22,'change_customerrating'),(87,'Can delete customer rating',22,'delete_customerrating'),(88,'Can view customer rating',22,'view_customerrating'),(93,'Can add maintenancelog',24,'add_maintenancelog'),(94,'Can change maintenancelog',24,'change_maintenancelog'),(95,'Can delete maintenancelog',24,'delete_maintenancelog'),(96,'Can view maintenancelog',24,'view_maintenancelog'),(105,'Can add reservation',27,'add_reservation'),(106,'Can change reservation',27,'change_reservation'),(107,'Can delete reservation',27,'delete_reservation'),(108,'Can view reservation',27,'view_reservation'),(109,'Can add reservation type',28,'add_reservationtype'),(110,'Can change reservation type',28,'change_reservationtype'),(111,'Can delete reservation type',28,'delete_reservationtype'),(112,'Can view reservation type',28,'view_reservationtype'),(113,'Can add stationfootage',29,'add_stationfootage'),(114,'Can change stationfootage',29,'change_stationfootage'),(115,'Can delete stationfootage',29,'delete_stationfootage'),(116,'Can view stationfootage',29,'view_stationfootage'),(117,'Can add station on reservation',30,'add_stationonreservation'),(118,'Can change station on reservation',30,'change_stationonreservation'),(119,'Can delete station on reservation',30,'delete_stationonreservation'),(120,'Can view station on reservation',30,'view_stationonreservation'),(121,'Can add stationroutes',31,'add_stationroutes'),(122,'Can change stationroutes',31,'change_stationroutes'),(123,'Can delete stationroutes',31,'delete_stationroutes'),(124,'Can view stationroutes',31,'view_stationroutes');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$kCJBCXnabLY4$xNxqQ6/JqmFgcz3hEmqJdVPwCtH9nsrCPv+CLi70sVA=','2019-01-24 10:01:46',1,'tootyredsuperuser','','','tootyredsuperuser@superuser.com',1,1,'2019-01-10 05:02:01'),(10,'pbkdf2_sha256$120000$0ATBH3RyTMRt$16qW0g5mm2t+POuN49OiT2PETodgoWnYtaMmrDpBUsU=','2019-01-24 10:02:34',0,'sarahm13654','sarah','marium','sarahm13654@gmail.com',0,1,'2019-01-12 13:26:14'),(11,'pbkdf2_sha256$120000$MGKoZ4xCC1US$JnofFiaDgQ1o6+z+4lYPzi4+JdAmHZFWTZoU7V0DrPs=','2019-01-24 10:01:58',0,'tootyredemployee','','','',1,1,'2019-01-24 08:54:32');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bike`
--

DROP TABLE IF EXISTS `bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bike` (
  `bike_id` int(11) NOT NULL AUTO_INCREMENT,
  `bike_type` int(11) NOT NULL,
  `travel_count` decimal(8,2) NOT NULL,
  `bike_status` int(11) NOT NULL,
  `bike_stationedat` int(11) DEFAULT NULL,
  PRIMARY KEY (`bike_id`),
  KEY `fk_bike_station_id` (`bike_stationedat`),
  KEY `fk_bike_type` (`bike_type`),
  KEY `fk_bike_status` (`bike_status`),
  CONSTRAINT `fk_bike_station_id` FOREIGN KEY (`bike_stationedat`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bike_status` FOREIGN KEY (`bike_status`) REFERENCES `status_of_bike` (`bike_status_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bike_type` FOREIGN KEY (`bike_type`) REFERENCES `type_of_bike` (`bike_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bike`
--

LOCK TABLES `bike` WRITE;
/*!40000 ALTER TABLE `bike` DISABLE KEYS */;
INSERT INTO `bike` VALUES (1,3,0.00,1,1),(2,3,0.00,1,1),(3,3,0.00,1,1),(4,1,0.00,1,1),(5,1,0.00,1,1),(6,2,0.00,1,1),(7,2,0.00,1,1),(8,4,0.00,1,1),(9,3,0.00,1,2),(10,3,0.00,1,2),(11,3,0.00,1,2),(12,1,0.00,1,2),(13,1,0.00,1,2),(14,2,0.00,1,2),(15,2,0.00,1,2),(16,4,0.00,1,2),(17,3,0.00,1,3),(18,3,0.00,1,3),(19,3,0.00,1,3),(20,1,0.00,1,3),(21,1,0.00,1,3),(22,2,0.00,1,3),(23,2,0.00,1,3),(24,4,0.00,1,3),(25,3,0.00,1,4),(26,3,0.00,1,4),(27,3,0.00,1,4),(28,1,0.00,1,4),(29,1,0.00,1,4),(30,2,0.00,1,4),(31,2,0.00,1,4),(32,4,0.00,1,4),(33,3,0.00,1,5),(34,3,0.00,1,5),(35,3,0.00,1,5),(36,1,0.00,1,5),(37,1,0.00,1,5),(38,2,0.00,1,5),(39,2,0.00,1,5),(40,4,0.00,1,5),(41,3,0.00,1,6),(42,3,0.00,1,6),(43,3,0.00,1,6),(44,1,0.00,1,6),(45,1,0.00,1,6),(46,2,0.00,1,6),(47,2,0.00,1,6),(48,4,0.00,1,6),(49,3,0.00,1,7),(50,3,0.00,1,7),(51,3,0.00,1,7),(52,1,0.00,1,7),(53,1,0.00,1,7),(54,2,0.00,1,7),(55,2,0.00,1,7),(56,4,0.00,1,7),(57,3,0.00,1,8),(58,3,0.00,1,8),(59,3,0.00,1,8),(60,1,0.00,1,8),(61,1,0.00,1,8),(62,2,0.00,1,8),(63,2,0.00,1,8),(64,4,0.00,1,8),(65,3,0.00,1,9),(66,3,0.00,1,9),(67,3,0.00,1,9),(68,1,0.00,1,9),(69,1,0.00,1,9),(70,2,0.00,1,9),(71,2,0.00,1,9),(72,4,0.00,1,9),(73,3,0.00,1,10),(74,3,0.00,1,10),(75,3,0.00,1,10),(76,1,0.00,1,10),(77,1,0.00,1,10),(78,2,0.00,1,10),(79,2,0.00,1,10),(80,4,0.00,1,10);
/*!40000 ALTER TABLE `bike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bike_on_reservation`
--

DROP TABLE IF EXISTS `bike_on_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bike_on_reservation` (
  `bor_bike_id` int(11) NOT NULL,
  `bor_reservation_id` int(11) NOT NULL,
  PRIMARY KEY (`bor_bike_id`,`bor_reservation_id`),
  KEY `fk_bor_reservation_id` (`bor_reservation_id`),
  CONSTRAINT `fk_bor_bike_id` FOREIGN KEY (`bor_bike_id`) REFERENCES `bike` (`bike_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bor_reservation_id` FOREIGN KEY (`bor_reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bike_on_reservation`
--


--
-- Table structure for table `checkuplog`
--

DROP TABLE IF EXISTS `checkuplog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `checkuplog` (
  `clog_id` int(11) NOT NULL AUTO_INCREMENT,
  `clog_count` int(11) NOT NULL,
  `checkup_date` date NOT NULL,
  `checkup_desc` text NOT NULL,
  `checkuplog_station_id` int(11) NOT NULL,
  PRIMARY KEY (`clog_id`),
  KEY `fk_checkuplog_station_id` (`checkuplog_station_id`),
  CONSTRAINT `fk_checkuplog_station_id` FOREIGN KEY (`checkuplog_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkuplog`
--

LOCK TABLES `checkuplog` WRITE;
/*!40000 ALTER TABLE `checkuplog` DISABLE KEYS */;
INSERT INTO `checkuplog` VALUES (1,1,'2019-01-02','slight outward damage on rack no. 12, all racks operating normally',1),(2,2,'2019-01-12','all racks operating normally',1),(3,3,'2019-01-18','all racks operating normally',1),(4,1,'2019-01-01','all racks operating normally',2),(5,2,'2019-01-18','all racks operating normally',2),(6,1,'2019-01-04','racks no. 04 to 08 needs to be cleaned, all racks operating normally',3),(7,1,'2019-01-02','all racks operating normally',4),(8,1,'2019-01-02','all racks operating normally',5);
/*!40000 ALTER TABLE `checkuplog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `complaints` (
  `complaint_id` int(5) NOT NULL AUTO_INCREMENT,
  `complaint_type` varchar(20) NOT NULL,
  `complaint_desc` text NOT NULL,
  PRIMARY KEY (`complaint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1,'defective equipment','the bike that was given me was defective');
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditcardinfo`
--

DROP TABLE IF EXISTS `creditcardinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `creditcardinfo` (
  `card_id` int(5) NOT NULL AUTO_INCREMENT,
  `card_info` int(16) NOT NULL,
  `card_exp_date` date NOT NULL,
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcardinfo`
--

LOCK TABLES `creditcardinfo` WRITE;
/*!40000 ALTER TABLE `creditcardinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `creditcardinfo` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `customer_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer_rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_value` int(1) NOT NULL,
  PRIMARY KEY (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rating`
--

LOCK TABLES `customer_rating` WRITE;
/*!40000 ALTER TABLE `customer_rating` DISABLE KEYS */;
INSERT INTO `customer_rating` VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `customer_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-10 06:08:21','2','test',1,'[{\"added\": {}}]',4,1),(2,'2019-01-10 06:12:41','3','testing',1,'[{\"added\": {}}]',4,1),(3,'2019-01-10 06:12:52','1','UserProfile object (1)',3,'',8,1),(4,'2019-01-10 06:13:12','2','test',3,'',4,1),(5,'2019-01-10 06:13:12','3','testing',3,'',4,1),(6,'2019-01-10 08:09:38','4','test1',3,'',4,1),(7,'2019-01-10 08:09:38','5','test2',3,'',4,1),(8,'2019-01-10 08:32:58','6','test1',3,'',4,1),(9,'2019-01-11 14:33:38','7','sarahm@gmail.com',3,'',4,1),(10,'2019-01-12 13:25:40','8','sarahm13654',3,'',4,1),(11,'2019-01-12 13:25:41','9','sarahm1365429',3,'',4,1),(12,'2019-01-24 08:54:33','11','tootyredemployee',1,'[{\"added\": {}}]',4,1),(13,'2019-01-24 09:42:49','11','tootyredemployee',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(16,'home','accstatus'),(12,'home','bike'),(17,'home','bikeonreservation'),(13,'home','biketype'),(18,'home','checkuplog'),(19,'home','complaints'),(20,'home','creditcardinfo'),(22,'home','customerrating'),(24,'home','maintenancelog'),(27,'home','reservation'),(28,'home','reservationtype'),(11,'home','station'),(29,'home','stationfootage'),(30,'home','stationonreservation'),(31,'home','stationroutes'),(10,'home','stationstable'),(14,'home','statusofbike'),(15,'home','typeofbike'),(8,'home','userprofile'),(7,'home','users'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-01-09 13:47:15'),(2,'auth','0001_initial','2019-01-09 13:47:56'),(3,'admin','0001_initial','2019-01-09 13:48:06'),(4,'admin','0002_logentry_remove_auto_add','2019-01-09 13:48:06'),(5,'admin','0003_logentry_add_action_flag_choices','2019-01-09 13:48:06'),(6,'contenttypes','0002_remove_content_type_name','2019-01-09 13:48:14'),(7,'auth','0002_alter_permission_name_max_length','2019-01-09 13:48:19'),(8,'auth','0003_alter_user_email_max_length','2019-01-09 13:48:20'),(9,'auth','0004_alter_user_username_opts','2019-01-09 13:48:20'),(10,'auth','0005_alter_user_last_login_null','2019-01-09 13:48:31'),(11,'auth','0006_require_contenttypes_0002','2019-01-09 13:48:31'),(12,'auth','0007_alter_validators_add_error_messages','2019-01-09 13:48:31'),(13,'auth','0008_alter_user_username_max_length','2019-01-09 13:48:36'),(14,'auth','0009_alter_user_last_name_max_length','2019-01-09 13:48:48'),(15,'sessions','0001_initial','2019-01-09 13:48:53'),(16,'home','0001_initial','2019-01-09 15:36:52'),(17,'home','0002_userprofile','2019-01-10 05:44:46'),(18,'home','0003_userprofile_creditcardexpirationdate','2019-01-10 05:45:35'),(19,'home','0004_userprofile_creditcardtype','2019-01-10 05:47:39'),(21,'home','0005_stationstable','2019-01-24 08:56:42'),(22,'home','0006_station','2019-01-24 08:56:43'),(23,'home','0007_bike_biketype','2019-01-24 08:56:43'),(24,'home','0008_statusofbike_typeofbike','2019-01-24 08:56:43'),(25,'home','0009_auto_20190121_0954','2019-01-24 08:56:43'),(26,'home','0010_auto_20190123_2233','2019-01-24 08:56:43');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0hxedk42y5f7gcmxwkul9quhnk9a61ry','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-02-14 18:52:54'),('0myxxuy9o203jt8tzc008f6pobn44lt7','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-01-28 05:37:55'),('14dlm19t0jjw3ka286ijox1333qduza2','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-01-24 18:43:10'),('gcnx29vwsd0ayfl4vw7r7hl4kgfnp8y1','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-07 10:02:34'),('lnmcidfh8r3hnsfcx98jkvz0827eh4x7','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-01-27 02:49:23');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `example`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `example` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `example`
--

LOCK TABLES `example` WRITE;
/*!40000 ALTER TABLE `example` DISABLE KEYS */;
INSERT INTO `example` VALUES (1,'Sample data');
/*!40000 ALTER TABLE `example` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `home_userprofile`
--

DROP TABLE IF EXISTS `home_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `home_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(17) NOT NULL,
  `user_id` int(11) NOT NULL,
  `creditcardexpirationdate` date DEFAULT NULL,
  `creditcardtype` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `home_userprofile_user_id_d1f7b466_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_userprofile`
--

LOCK TABLES `home_userprofile` WRITE;
/*!40000 ALTER TABLE `home_userprofile` DISABLE KEYS */;
INSERT INTO `home_userprofile` VALUES (8,'',10,NULL,NULL),(9,'',11,NULL,NULL);
/*!40000 ALTER TABLE `home_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenancelog`
--

DROP TABLE IF EXISTS `maintenancelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `maintenancelog` (
  `mlog_id` int(11) NOT NULL AUTO_INCREMENT,
  `mlog_count` int(11) NOT NULL,
  `maintenance_date` date NOT NULL,
  `maintenance_desc` text NOT NULL,
  `mechanic_name` varchar(50) NOT NULL,
  `maintenance_bike_id` int(11) NOT NULL,
  PRIMARY KEY (`mlog_id`),
  KEY `fk_maintenance_bike_id` (`maintenance_bike_id`),
  CONSTRAINT `fk_maintenance_bike_id` FOREIGN KEY (`maintenance_bike_id`) REFERENCES `bike` (`bike_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenancelog`
--

LOCK TABLES `maintenancelog` WRITE;
/*!40000 ALTER TABLE `maintenancelog` DISABLE KEYS */;
INSERT INTO `maintenancelog` VALUES (1,1,'2019-01-02','no problems with the bike','John Doe',1),(2,1,'2019-01-02','no problems with the bike','John Doe',2),(3,1,'2019-01-02','no problems with the bike','John Doe',3),(4,1,'2019-01-02','no problems with the bike','John Doe',4),(5,1,'2019-01-02','no problems with the bike','John Doe',5),(6,1,'2019-01-02','no problems with the bike','John Doe',6),(7,1,'2019-01-02','no problems with the bike','John Doe',7),(8,1,'2019-01-02','no problems with the bike','John Doe',8),(9,1,'2019-01-02','no problems with the bike','John Doe',9),(10,1,'2019-01-02','no problems with the bike','John Doe',10),(11,1,'2019-01-02','no problems with the bike','John Doe',11),(12,1,'2019-01-02','no problems with the bike','John Doe',12),(13,1,'2019-01-02','no problems with the bike','John Doe',13),(14,1,'2019-01-02','no problems with the bike','John Doe',14),(15,1,'2019-01-02','no problems with the bike','John Doe',15),(16,1,'2019-01-02','no problems with the bike','John Doe',16);
/*!40000 ALTER TABLE `maintenancelog` ENABLE KEYS */;
UNLOCK TABLES;


-
DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_code` varchar(6) NOT NULL,
  `res_type` int(11) NOT NULL,
  `res_cost` decimal(11,2) NOT NULL,
  `res_date` datetime NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `c_rating` int(11) DEFAULT NULL,
  `c_id` int(11) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `fk_res_type` (`res_type`),
  KEY `fk_c_rating` (`c_rating`),
  KEY `fk_c_id` (`c_id`),
  CONSTRAINT `fk_c_id` FOREIGN KEY (`c_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_c_rating` FOREIGN KEY (`c_rating`) REFERENCES `customer_rating` (`rating_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_res_type` FOREIGN KEY (`res_type`) REFERENCES `reservation_type` (`res_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

-- Table structure for table `reservation_type`
--

DROP TABLE IF EXISTS `reservation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reservation_type` (
  `res_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`res_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_type`
--

LOCK TABLES `reservation_type` WRITE;
/*!40000 ALTER TABLE `reservation_type` DISABLE KEYS */;
INSERT INTO `reservation_type` VALUES (1,'past'),(2,'ongoing'),(3,'future');
/*!40000 ALTER TABLE `reservation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `station` (
  `station_id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `rack_capacity` int(11) NOT NULL,
  `num_racks_available` int(11) NOT NULL,
  `info` text NOT NULL,
  `name` varchar(50) NOT NULL,
  `lon` decimal(30,16) NOT NULL,
  `lat` decimal(30,15) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `image` varchar(30) NOT NULL,
  `fine_cost` decimal(11,2) DEFAULT NULL,
  `fine_desc` text,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'1 Greenbank Cres, Edinburgh EH10 5TE, UK',16,8,'It is located in South Edinburgh in the Morningside/Oxgangs area.It is located in South Edinburgh in the Morningside/Oxgangs area. ' ,'Braidburn Valley Park',-3.2135800000000000,55.919100000000000,1,'BraidburnValleyPark.jpg',NULL,NULL),(2,'Edinburgh EH3 5PA, UK',16,8,'The pretty park near Washington Lake,Spread over 34 acres, it also has a delightful formal garden in classic style','Inverleith Park',-3.2143800000000000,55.966530000000000,1,'inverleithpark.jpg',NULL,NULL),(3,'Princes St, Edinburgh EH2 2HG, UK',16,8,'Princes Street Gardens are two adjacent public parks in the centre of Edinburgh','Princes Street Gardens',-3.1983900000000000,55.951752000000000,1,'princesstreetgardens.jpg',NULL,NULL),(4,'Melville Dr, Edinburgh EH9 1ND, UK',16,8,'The Meadows is a large public park in Edinburgh, Scotland, to the south of the city centre.','The Meadows',-3.1918600000000000,55.939940000000000,1,'themeadows.JPG',NULL,NULL),(5,'Lochend Rd S, Edinburgh EH7 6BP, UK',16,8,'The park meant for all kids in townIt is located in South Edinburgh in the Morningside/Oxgangs area.','Lochend Park',-3.1584700000000000,55.961310000000000,1,'lochendpark.jpg',NULL,NULL),(6,'Links Gardens, Edinburgh EH6 7QR, UK',16,8,'The link that connects to the metroSpread over 34 acres, it also has a delightful formal garden in classic style','Leith Links',-3.1621200000000000,55.971740000000000,1,'leithlinks.png',NULL,NULL),(7,'Old Church Ln, Duddingston Village, Edinburgh EH15 3PX, UK',16,8,'The old Neils garden founded in the late 90s','Dr Neils Garden',-3.1463600000000000,55.941720000000000,1,'DrNeilGarden.jpg',NULL,NULL),(8,'Stanedykehead, Alnwickhill EH16 6TN, UK',16,8,'The largest park to visit is righ here.Spread over 34 acres, it also has a delightful formal garden in classic style','Seven Acre Park',-3.1683400000000000,55.905840000000000,1,'SevenAcrePark.jpg',NULL,NULL),(9,'1 Greenbank Cres, Edinburgh EH10 5TE, UK',16,8,'Spread over 34 acres, it also has a delightful formal garden in classic style ','Saughton Park And Gardens',-3.2485290000000000,55.934132000000000,1,'SaughtonParkAndGardens.jpg',NULL,NULL),(10,'24 Ravelston Dykes Rd, Edinburgh EH4 3NZ, UK',16,8,'We are a 9 hole golf course situated within 1.5 miles f the centre of Edinburgh, ','Ravelston Golf Club',-3.2577200000000000,55.954350000000000,1,'ravelstongolfclub.jpg',NULL,NULL);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station_on_reservation`
--

DROP TABLE IF EXISTS `station_on_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `station_on_reservation` (
  `sor_route_id` int(11) NOT NULL,
  `sor_reservation_id` int(11) NOT NULL,
  PRIMARY KEY (`sor_route_id`,`sor_reservation_id`),
  KEY `fk_sor_reservation_id` (`sor_reservation_id`),
  CONSTRAINT `fk_sor_reservation_id` FOREIGN KEY (`sor_reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_sor_route_id` FOREIGN KEY (`sor_route_id`) REFERENCES `stationroutes` (`route_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station_on_reservation`
--


--
-- Table structure for table `stationfootage`
--

DROP TABLE IF EXISTS `stationfootage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stationfootage` (
  `footage_id` int(5) NOT NULL AUTO_INCREMENT,
  `footage_date` varchar(20) NOT NULL,
  `footage_link` varchar(20) NOT NULL,
  `footage_station_id` int(11) NOT NULL,
  PRIMARY KEY (`footage_id`),
  KEY `fk_footage_station_id` (`footage_station_id`),
  CONSTRAINT `fk_footage_station_id` FOREIGN KEY (`footage_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stationfootage`
--

LOCK TABLES `stationfootage` WRITE;
/*!40000 ALTER TABLE `stationfootage` DISABLE KEYS */;
/*!40000 ALTER TABLE `stationfootage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stationroutes`
--

DROP TABLE IF EXISTS `stationroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stationroutes` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_station_id` int(11) DEFAULT NULL,
  `end_station_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `fk_start_station_id` (`start_station_id`),
  KEY `fk_end_station_id` (`end_station_id`),
  CONSTRAINT `fk_end_station_id` FOREIGN KEY (`end_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_start_station_id` FOREIGN KEY (`start_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stationroutes`
--

LOCK TABLES `stationroutes` WRITE;
/*!40000 ALTER TABLE `stationroutes` DISABLE KEYS */;
INSERT INTO `stationroutes` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,2,1),(12,2,2),(13,2,3),(14,2,4),(15,2,5),(16,2,6),(17,2,7),(18,2,8),(19,2,9),(20,2,10),(21,3,1),(22,3,2),(23,3,3),(24,3,4),(25,3,5),(26,3,6),(27,3,7),(28,3,8),(29,3,9),(30,3,10),(31,4,1),(32,4,2),(33,4,3),(34,4,4),(35,4,5),(36,4,6),(37,4,7),(38,4,8),(39,4,9),(40,4,10),(41,5,1),(42,5,2),(43,5,3),(44,5,4),(45,5,5),(46,5,6),(47,5,7),(48,5,8),(49,5,9),(50,5,10),(51,6,1),(52,6,2),(53,6,3),(54,6,4),(55,6,5),(56,6,6),(57,6,7),(58,6,8),(59,6,9),(60,6,10),(61,7,1),(62,7,2),(63,7,3),(64,7,4),(65,7,5),(66,7,6),(67,7,7),(68,7,8),(69,7,9),(70,7,10),(71,8,1),(72,8,2),(73,8,3),(74,8,4),(75,8,5),(76,8,6),(77,8,7),(78,8,8),(79,8,9),(80,8,10),(81,9,1),(82,9,2),(83,9,3),(84,9,4),(85,9,5),(86,9,6),(87,9,7),(88,9,8),(89,9,9),(90,9,10),(91,10,1),(92,10,2),(93,10,3),(94,10,4),(95,10,5),(96,10,6),(97,10,7),(98,10,8),(99,10,9),(100,10,10);
/*!40000 ALTER TABLE `stationroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_of_bike`
--

DROP TABLE IF EXISTS `status_of_bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `status_of_bike` (
  `bike_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `bike_status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`bike_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_of_bike`
--

LOCK TABLES `status_of_bike` WRITE;
/*!40000 ALTER TABLE `status_of_bike` DISABLE KEYS */;
INSERT INTO `status_of_bike` VALUES (1,'stationed'),(2,'OutOfservice'),(3,'active');
/*!40000 ALTER TABLE `status_of_bike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_of_bike`
--

DROP TABLE IF EXISTS `type_of_bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `type_of_bike` (
  `bike_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `bike_info` text NOT NULL,
  `bike_model` varchar(20) NOT NULL,
  `bike_type` varchar(20) NOT NULL,
  `bike_cost` decimal(11,2) NOT NULL,
  `bike_image` varchar(30) NOT NULL,
  PRIMARY KEY (`bike_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_of_bike`
--

LOCK TABLES `type_of_bike` WRITE;
/*!40000 ALTER TABLE `type_of_bike` DISABLE KEYS */;
INSERT INTO `type_of_bike` VALUES (1,'A mountain bike or mountain bicycle (abbreviated Mtn Bike or MTB[1]) is a bicycle designed for off-road cycling. Mountain bikes share similarities with other bicycles, but incorporate features designed to enhance durability and performance in rough terrain.','Shimano XT','Mountain Bike',2.00,'shimano.png'),(2,'The tandem bicycle or twin is a form of bicycle designed to be ridden by more than one person.','Fuji X','Tandem Bike',4.00,'tandem.png'),(3,'The road bike is used  for traveling at speed on paved roads. ','Fuji Crank T ','Road Bike',1.25,'road.png'),(4,' Wheelchair bikes has an advanced wheelchair design enabling easy and comfortable pedaling to ensure maximum maneuverability with minimum effort.','VeloPlus','Wheelchair Bike',3.50,'veloplus.png');
/*!40000 ALTER TABLE `type_of_bike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1),(2),(3),(4),(5),(6),(9),(10),(12),(13);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-24 14:05:11
