/* This document is the mysql database and event handler for update queries and the reservations used for the
purpose of demonstration */
DROP DATABASE tootyred;
CREATE DATABASE tootyred;
USE tootyred;
SET NAMES utf8 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$kCJBCXnabLY4$xNxqQ6/JqmFgcz3hEmqJdVPwCtH9nsrCPv+CLi70sVA=','2019-03-14 07:09:01',1,'jaden12345','jaden','molette','tootyredsuperuser@superuser.com',1,1,'2019-01-10 05:02:01'),(10,'pbkdf2_sha256$120000$0ATBH3RyTMRt$16qW0g5mm2t+POuN49OiT2PETodgoWnYtaMmrDpBUsU=','2019-02-25 07:52:58',0,'sarahm13654','sarah','marium','sarahm13654@gmail.com',0,1,'2019-01-12 13:26:14'),(11,'pbkdf2_sha256$120000$MGKoZ4xCC1US$JnofFiaDgQ1o6+z+4lYPzi4+JdAmHZFWTZoU7V0DrPs=','2019-03-14 07:09:15',0,'john12345','john','smith','',1,1,'2019-01-24 08:54:32'),(14,'pbkdf2_sha256$120000$TH4td9IER5FF$Rs3rkdthMpMq5LO0I9ayvC3CZ2vgdqwUjg66yrv6WRA=','2019-02-07 08:06:32',0,'ejmagno','Edgar Joel','Magno','name_wtf@yahoo.com',0,1,'2019-02-07 07:34:07'),(17,'pbkdf2_sha256$120000$OB8JBmzoQx3G$v93Jq2rI9ePq5Dpz4TWATJvxsfORmSJgEp29PmHZlEM=','2019-03-14 06:56:24',0,'jason12345','Jason','Seth','jasonseth12345@gmail.com',0,1,'2019-03-14 05:28:54'),(18,'pbkdf2_sha256$120000$8pMJJi20NSTh$7iOerB//SzGFVZ6Ho//KZX7mpJLvV84mtxLxxDcFmJw=',NULL,0,'alwankazi','Alwan','Kazi','alwankazi@hotmail.com',0,1,'2019-03-14 07:34:55'),(19,'pbkdf2_sha256$120000$tVG7RLyimCg3$qWeoO9+xwKjiP0MYJL+euXvU+Wte6eFdbVcVk4vYvys=',NULL,0,'Priya','Priya','Bhaskaran','priya.bhaskar@hotmail.com',0,1,'2019-03-14 07:36:12'),(20,'pbkdf2_sha256$120000$knjm0cBmBGVg$oubs7Hv7hHzW3m3zAC+uV6lIBef1xJGhwKGyIzOGwWM=',NULL,0,'Svet','Svetlana','mir','sm48@hw.ac.uk',0,1,'2019-03-14 07:36:53');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bike`
--
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_type`
--

LOCK TABLES `reservation_type` WRITE;
/*!40000 ALTER TABLE `reservation_type` DISABLE KEYS */;
INSERT INTO `reservation_type` VALUES (1,'past'),(2,'ongoing'),(3,'future');
/*!40000 ALTER TABLE `reservation_type` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `station` (
  `station_id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(100) NOT NULL,
  `info` text NOT NULL,
  `name` varchar(50) NOT NULL,
  `lon` decimal(30,16) NOT NULL,
  `lat` decimal(30,15) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `image` varchar(30) NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'1 Greenbank Cres, Edinburgh EH10 5TE, UK','It is located in South Edinburgh in the Morningside/Oxgangs area.It is located in South Edinburgh in the Morningside/Oxgangs area. ','Braidburn Valley Park',-3.2135800000000000,55.919100000000000,1,'BraidburnValleyPark.jpg'),(2,'Edinburgh EH3 5PA, UK','The pretty park near Washington Lake,Spread over 34 acres, it also has a delightful formal garden in classic style','Inverleith Park',-3.2143800000000000,55.966530000000000,1,'inverleithpark.jpg'),(3,'Princes St, Edinburgh EH2 2HG, UK','Princes Street Gardens are two adjacent public parks in the centre of Edinburgh','Princes Street Gardens',-3.1983900000000000,55.951752000000000,1,'princesstreetgardens.jpg'),(4,'Melville Dr, Edinburgh EH9 1ND, UK','The Meadows is a large public park in Edinburgh, Scotland, to the south of the city centre.','The Meadows',-3.1918600000000000,55.939940000000000,1,'themeadows.JPG'),(5,'Lochend Rd S, Edinburgh EH7 6BP, UK','The park meant for all kids in townIt is located in South Edinburgh in the Morningside/Oxgangs area.','Lochend Park',-3.1584700000000000,55.961310000000000,1,'lochendpark.jpg'),(6,'Links Gardens, Edinburgh EH6 7QR, UK','The link that connects to the metroSpread over 34 acres, it also has a delightful formal garden in classic style','Leith Links',-3.1621200000000000,55.971740000000000,1,'leithlinks.png'),(7,'Old Church Ln, Duddingston Village, Edinburgh EH15 3PX, UK','The old Neils garden founded in the late 90s','Dr Neils Garden',-3.1463600000000000,55.941720000000000,1,'DrNeilGarden.jpg'),(8,'Stanedykehead, Alnwickhill EH16 6TN, UK','The largest park to visit is righ here.Spread over 34 acres, it also has a delightful formal garden in classic style','Seven Acre Park',-3.1683400000000000,55.905840000000000,1,'SevenAcrePark.jpg'),(9,'1 Greenbank Cres, Edinburgh EH10 5TE, UK','Spread over 34 acres, it also has a delightful formal garden in classic style ','Saughton Park And Gardens',-3.2485290000000000,55.934132000000000,1,'SaughtonParkAndGardens.jpg'),(10,'24 Ravelston Dykes Rd, Edinburgh EH4 3NZ, UK','We are a 9 hole golf course situated within 1.5 miles f the centre of Edinburgh, ','Ravelston Golf Club',-3.2577200000000000,55.954350000000000,1,'ravelstongolfclub.jpg');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `status_of_bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `status_of_bike` (
  `bike_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `bike_status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`bike_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_of_bike`
--

LOCK TABLES `status_of_bike` WRITE;
/*!40000 ALTER TABLE `status_of_bike` DISABLE KEYS */;
INSERT INTO `status_of_bike` VALUES (1,'stationed'),(2,'OutOfservice'),(3,'active'),(4,'stored'),(5,'tracked');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_of_bike`
--

LOCK TABLES `type_of_bike` WRITE;
/*!40000 ALTER TABLE `type_of_bike` DISABLE KEYS */;
INSERT INTO `type_of_bike` VALUES (1,'A mountain bike or mountain bicycle (abbreviated Mtn Bike or MTB[1]) is a bicycle designed for off-road cycling. ','Shimano XT','Mountain Bike',2.00,'shimano.png'),(2,'The tandem bicycle or twin is a form of bicycle designed to be ridden by more than one person.','Fuji X','Tandem Bike',4.00,'tandem.png'),(3,'The road bike is used  for traveling at speed on paved roads. ','Fuji Crank T ','Road Bike',1.25,'road.png'),(4,'Wheelchair bikes has an advanced wheelchair design enabling easy and comfortable pedaling to ensure maximum maneuverability with minimum effort.','VeloPlus','Wheelchair Bike',3.50,'veloplus.png');
/*!40000 ALTER TABLE `type_of_bike` ENABLE KEYS */;
UNLOCK TABLES;


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
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bike`
--

LOCK TABLES `bike` WRITE;
/*!40000 ALTER TABLE `bike` DISABLE KEYS */;
INSERT INTO `bike` VALUES (1,3,0.00,1,4),(2,3,0.00,1,2),(3,3,0.00,1,6),(4,1,0.00,1,5),(5,1,0.00,1,5),(6,2,0.00,1,8),(7,2,0.00,1,5),(8,4,0.00,1,1),(9,3,0.00,1,6),(10,3,0.00,1,4),(11,3,0.00,1,2),(12,1,0.00,1,4),(13,1,0.00,1,1),(14,2,0.00,1,7),(15,2,0.00,1,2),(16,4,0.00,1,1),(17,3,0.00,1,2),(18,3,0.00,1,5),(19,3,0.00,1,5),(20,1,0.00,1,4),(21,1,0.00,1,6),(22,2,0.00,1,5),(23,2,0.00,1,10),(24,4,0.00,1,7),(25,3,0.00,1,4),(26,3,0.00,1,5),(27,3,0.00,1,1),(28,1,0.00,1,7),(29,1,0.00,1,7),(30,2,0.00,1,7),(31,2,0.00,1,9),(32,4,0.00,1,7),(33,3,0.00,1,1),(34,3,0.00,1,6),(35,3,0.00,1,6),(36,1,0.00,1,9),(37,1,0.00,1,5),(38,2,0.00,1,6),(39,2,0.00,1,5),(40,4,0.00,1,5),(41,3,0.00,1,8),(42,3,0.00,1,7),(43,3,0.00,1,3),(44,1,0.00,1,6),(45,1,0.00,1,7),(46,2,0.00,1,9),(47,2,0.00,1,1),(48,4,0.00,1,3),(49,3,0.00,1,8),(50,3,0.00,1,8),(51,3,0.00,1,2),(52,1,0.00,1,8),(53,1,0.00,1,1),(54,2,0.00,1,1),(55,2,0.00,1,2),(56,4,0.00,1,1),(57,3,0.00,1,2),(58,3,0.00,1,1),(59,3,0.00,1,8),(60,1,0.00,1,4),(61,1,0.00,1,7),(62,2,0.00,1,1),(63,2,0.00,1,8),(64,4,0.00,1,3),(65,3,0.00,1,1),(66,3,0.00,1,5),(67,3,0.00,1,7),(68,1,0.00,1,10),(69,1,0.00,1,5),(70,2,0.00,1,4),(71,2,0.00,1,2),(72,4,0.00,1,9),(73,3,0.00,1,2),(74,3,0.00,1,9),(75,3,0.00,1,1),(76,1,0.00,1,7),(77,1,0.00,1,9),(78,2,0.00,1,3),(79,2,0.00,1,3),(80,4,0.00,1,10),(81,1,0.00,4,NULL),(82,1,0.00,4,NULL),(83,1,0.00,4,NULL),(84,1,0.00,4,NULL),(85,1,0.00,4,NULL),(86,1,0.00,4,NULL),(87,1,0.00,4,NULL),(88,1,0.00,4,NULL),(89,1,0.00,4,NULL),(90,1,0.00,4,NULL),(91,1,0.00,4,NULL),(92,1,0.00,4,NULL),(93,1,0.00,4,NULL),(94,1,0.00,4,NULL),(95,1,0.00,4,NULL),(96,2,0.00,4,NULL),(97,2,0.00,4,NULL),(98,2,0.00,4,NULL),(99,2,0.00,4,NULL),(100,2,0.00,4,NULL),(101,2,0.00,4,NULL),(102,2,0.00,4,NULL),(103,2,0.00,4,NULL),(104,2,0.00,4,NULL),(105,2,0.00,4,NULL),(106,2,0.00,4,NULL),(107,2,0.00,4,NULL),(108,2,0.00,4,NULL),(109,2,0.00,4,NULL),(110,2,0.00,4,NULL),(111,3,0.00,4,NULL),(112,3,0.00,4,NULL),(113,3,0.00,4,NULL),(114,3,0.00,4,NULL),(115,3,0.00,4,NULL),(116,3,0.00,4,NULL),(117,3,0.00,4,NULL),(118,3,0.00,4,NULL),(119,3,0.00,4,NULL),(120,3,0.00,4,NULL),(121,3,0.00,4,NULL),(122,3,0.00,4,NULL),(123,3,0.00,4,NULL),(124,3,0.00,4,NULL),(125,3,0.00,4,NULL),(126,4,0.00,4,NULL),(127,4,0.00,4,NULL),(128,4,0.00,4,NULL),(129,4,0.00,4,NULL),(130,4,0.00,4,NULL),(131,4,0.00,4,NULL),(132,4,0.00,4,NULL),(133,4,0.00,4,NULL),(134,4,0.00,4,NULL),(135,4,0.00,4,NULL),(136,4,0.00,4,NULL),(137,4,0.00,4,NULL),(138,4,0.00,4,NULL),(139,4,0.00,4,NULL),(140,4,0.00,4,NULL);
/*!40000 ALTER TABLE `bike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bike_on_reservation`
--

--
-- Table structure for table `contactus`
--

DROP TABLE IF EXISTS `contactUs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contactUs` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `fn` varchar(30) NOT NULL,
  `ln` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `message` varchar(200) NOT NULL,
  PRIMARY KEY (`mail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactUs`
--

LOCK TABLES `contactUs` WRITE;
/*!40000 ALTER TABLE `contactUs` DISABLE KEYS */;
INSERT INTO `contactUs` VALUES (1,'Marium','Sarah','sarahm13654@gmail.com','Hi there, \r\nI would like to know if you offer bike sservices outside of Edinburgh?\r\nDo let me know, thank you'),(2,'Humaira','Tasneem','humaira_tasneem@ymail.com','Hi TooTyred!\r\nHow much does it cost if i want to go from Ravelston to Saughton...I want to go with three of my friends do i have to register?'),(4,'Amina','Anjum','amina.anjum@yahoo.com','Hi there, \r\nIs there a limit to the amount of times i can make reservations?\r\nthanks'),(5,'Mohammed','Mubashir','mhd.mubashir25@gmail.com','Hi there, I would like to know how much it would cost if i want to take a bike to another location outside of Edinburgh...Is this possible?');
/*!40000 ALTER TABLE `contactUs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_rating`
--

DROP TABLE IF EXISTS `customer_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer_rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_value` int(1) NOT NULL,
  PRIMARY KEY (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_rating`
--

LOCK TABLES `customer_rating` WRITE;
/*!40000 ALTER TABLE `customer_rating` DISABLE KEYS */;
INSERT INTO `customer_rating` VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `customer_rating` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `stationroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stationroutes` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_station_id` int(11) DEFAULT NULL,
  `end_station_id` int(11) DEFAULT NULL,
  `min_miles_travelled` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `fk_start_station_id` (`start_station_id`),
  KEY `fk_end_station_id` (`end_station_id`),
  CONSTRAINT `fk_end_station_id` FOREIGN KEY (`end_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_start_station_id` FOREIGN KEY (`start_station_id`) REFERENCES `station` (`station_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stationroutes`
--

LOCK TABLES `stationroutes` WRITE;
/*!40000 ALTER TABLE `stationroutes` DISABLE KEYS */;
INSERT INTO `stationroutes` VALUES (1,1,1,1.00),(2,1,2,3.70),(3,1,3,2.70),(4,1,4,2.00),(5,1,5,4.70),(6,1,6,4.90),(7,1,7,4.20),(8,1,8,2.60),(9,1,9,2.80),(10,1,10,4.30),(11,2,1,3.70),(12,2,2,1.00),(13,2,3,1.40),(14,2,4,2.40),(15,2,5,2.90),(16,2,6,2.80),(17,2,7,4.40),(18,2,8,5.50),(19,2,9,4.10),(20,2,10,2.30),(21,3,1,2.70),(22,3,2,1.40),(23,3,3,1.00),(24,3,4,1.10),(25,3,5,2.10),(26,3,6,2.20),(27,3,7,2.80),(28,3,8,4.00),(29,3,9,2.90),(30,3,10,2.70),(31,4,1,2.00),(32,4,2,2.40),(33,4,3,1.10),(34,4,4,1.00),(35,4,5,2.60),(36,4,6,3.00),(37,4,7,2.20),(38,4,8,3.10),(39,4,9,2.80),(40,4,10,3.40),(41,5,1,4.70),(42,5,2,2.90),(43,5,3,2.10),(44,5,4,2.60),(45,5,5,1.00),(46,5,6,1.00),(47,5,7,2.00),(48,5,8,5.40),(49,5,9,5.00),(50,5,10,5.50),(51,6,1,4.90),(52,6,2,2.80),(53,6,3,2.20),(54,6,4,3.00),(55,6,5,1.00),(56,6,6,1.00),(57,6,7,2.70),(58,6,8,5.50),(59,6,9,6.80),(60,6,10,5.00),(61,7,1,4.20),(62,7,2,4.40),(63,7,3,2.80),(64,7,4,2.20),(65,7,5,2.00),(66,7,6,2.70),(67,7,7,1.00),(68,7,8,3.60),(69,7,9,4.90),(70,7,10,7.40),(71,8,1,2.60),(72,8,2,5.50),(73,8,3,4.00),(74,8,4,3.10),(75,8,5,5.40),(76,8,6,5.50),(77,8,7,3.60),(78,8,8,1.00),(79,8,9,5.80),(80,8,10,6.30),(81,9,1,2.80),(82,9,2,4.10),(83,9,3,2.90),(84,9,4,2.80),(85,9,5,5.00),(86,9,6,6.80),(87,9,7,4.90),(88,9,8,5.80),(89,9,9,1.00),(90,9,10,1.80),(91,10,1,4.30),(92,10,2,2.30),(93,10,3,2.70),(94,10,4,3.40),(95,10,5,5.50),(96,10,6,5.00),(97,10,7,7.40),(98,10,8,6.30),(99,10,9,1.80),(100,10,10,1.00);
/*!40000 ALTER TABLE `stationroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_of_bike`
--
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0hxedk42y5f7gcmxwkul9quhnk9a61ry','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-02-14 18:52:54'),('0myxxuy9o203jt8tzc008f6pobn44lt7','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-01-28 05:37:55'),('0njrnwa01p4jbkhyz13sko8l90s6z5pz','YTFjYzliYzIxNmRkN2ExZjRlYTc1YzZhYWViYjI0MzZjYmViN2QwMDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNhOGYzMDM5YjI4N2UwMzJmYjI1MWVjOGRiNjQyZTI4YWVlMjhjZjciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-02-23 18:45:36'),('14dlm19t0jjw3ka286ijox1333qduza2','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-01-24 18:43:10'),('1wnwc71i3hq0efjev9x4ic8v6eca7r67','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-24 13:59:57'),('4f4l66d6fklyosr0vwi3czeq4fao76gf','YjVhNzQ4YjM5NzExMjAxZDFjNTNlYjA2MzM5MDZmMzU5ZWIwYTk0Nzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ2ZWNiZmZlODAzOWI0ODg3MDNlMDM2YjgyNmJhNDZjYTUyY2UxNmYiLCJfYXV0aF91c2VyX2lkIjoiMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-02-22 11:37:46'),('658uyo2ex2bv04rvnvwgyijrlm5i3b9v','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-23 11:34:01'),('6rmamyim14kkml4pwn8tjq621kdqfzxh','NThkZmU2Y2QxZDcxY2Q3NGU5NTdkYTcyZWY0NDA2Y2E1MjE1ZTQ3NDp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfaGFzaCI6IjhkMTRhOTcwMDNiNDI1MjQ2ZjE5Y2FjNWU3YWUyNTJlNGE1N2UwZTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-03-01 19:51:09'),('9vkev3fy4mv1txtjj6mpguy80ncx33y7','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-24 16:34:27'),('aoh953przl3evcsjt0eqg2jlupfdqf0s','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-27 20:14:04'),('b7k57bkafg9tksl3c1m71e0vtwhg7bbk','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-21 08:18:01'),('b9wyjpmgq9tfpttlnx112gb1l7gc8ke9','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 19:54:48'),('brtvshmt7rkk799idoscrw6cn37mvmoq','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-02-21 14:21:07'),('bu0fs3s34bk3kx1oj9mc6yt13wtk836n','YTFjYzliYzIxNmRkN2ExZjRlYTc1YzZhYWViYjI0MzZjYmViN2QwMDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNhOGYzMDM5YjI4N2UwMzJmYjI1MWVjOGRiNjQyZTI4YWVlMjhjZjciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-03-08 09:20:54'),('bx0a2gcxuljx0sdtvdch5w3njhavn8us','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 20:29:16'),('gar08a33b9mccz1xxhavzr3yyg8zwf2y','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-03-03 11:36:02'),('gcnx29vwsd0ayfl4vw7r7hl4kgfnp8y1','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-07 10:02:34'),('i79vlhwu6krwohzvvy5u02dsmn1ho2mu','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-03-11 07:54:58'),('l2g64jkxzx1f7sypkm94ax6wl4e2cpon','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 20:31:20'),('lnmcidfh8r3hnsfcx98jkvz0827eh4x7','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-01-27 02:49:23'),('lqx0uc24ycwjg77erjb5z3cyvaf0y1xy','Yjg0MDEwN2MyZTMwYTIwZDRlMDIzMzNmNjE3NjZmNzk1NGFlYTI4YTp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCJ9','2019-03-28 05:29:47'),('luptrct3k2pgvkfzp9vje79dj4dsn2xt','YjA3NzhmMWUzMDMwYmYyNTk2MjBjYTM0ZWZiN2E0ZTc5MTc1ZmE2NTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ2ZWNiZmZlODAzOWI0ODg3MDNlMDM2YjgyNmJhNDZjYTUyY2UxNmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxMyJ9','2019-02-24 14:16:49'),('m1nobez33qf9248al38uwq3g8c5jgfeh','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-23 12:43:08'),('nxh3c915d5z0a6knisjbu7dn7p1v2or9','N2I4ZTk2MDA3YjA1NjE5NmMzYWUyNDIwZjMwMTJhNTU3ZDc4NzVmZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmZkYTFjNDI4MDhiNjYwY2JiNTIyYjg3Y2IxZDJkNTEwMjI5Y2JiNSIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2019-03-03 18:33:31'),('tp6m83sj3w5tvfet5syafvreiv7lfgli','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-23 11:34:01'),('woi7qlqef931suyd2sfuh3ibkkfpvdgc','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-21 02:18:23'),('zjok5mt2pis9qu91jpaf7lrtirgf6nw1','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-24 18:46:19');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

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
  `feedback` text,
  `c_id` int(11) DEFAULT NULL,
  `fine_cost` decimal(11,2) DEFAULT NULL,
  `fine_desc` text,
  `fined_at` datetime DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `fk_res_type` (`res_type`),
  KEY `fk_c_rating` (`c_rating`),
  KEY `fk_c_id` (`c_id`),
  CONSTRAINT `fk_c_id` FOREIGN KEY (`c_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_c_rating` FOREIGN KEY (`c_rating`) REFERENCES `customer_rating` (`rating_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_res_type` FOREIGN KEY (`res_type`) REFERENCES `reservation_type` (`res_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (4,'331116',1,14.00,'2018-12-06 17:46:56','2019-02-07 08:30:00','2019-02-07 09:00:00',4,'It was ',10,NULL,NULL,NULL),(7,'938180',1,679.00,'2018-12-11 18:52:52','2016-11-05 12:15:00','2016-11-15 12:30:00',NULL,NULL,10,NULL,NULL,NULL),(8,'631130',1,114.00,'2018-12-11 20:36:19','2019-01-01 14:00:00','2019-01-01 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(9,'812941',1,147.00,'2018-12-11 20:37:21','2019-01-02 14:00:00','2019-01-02 17:00:00',NULL,NULL,10,NULL,NULL,NULL),(10,'354188',1,122.50,'2018-12-11 20:38:35','2019-01-03 17:30:00','2019-01-03 20:00:00',NULL,NULL,10,NULL,NULL,NULL),(11,'054651',1,176.00,'2018-12-11 20:40:22','2019-01-04 21:30:00','2019-01-05 01:30:00',NULL,NULL,10,NULL,NULL,NULL),(12,'793912',1,112.75,'2018-12-11 20:43:38','2019-01-05 21:00:00','2019-01-05 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(13,'022517',1,88.00,'2018-12-11 20:45:20','2019-01-06 14:00:00','2019-01-06 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(14,'867163',1,672.00,'2018-12-11 20:46:18','2019-01-07 18:00:00','2019-01-08 18:00:00',NULL,NULL,10,NULL,NULL,NULL),(15,'205675',1,54.00,'2018-12-11 20:47:02','2019-01-09 22:15:00','2019-01-09 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(16,'589447',1,880.00,'2018-12-11 20:47:42','2019-01-10 22:00:00','2019-01-11 18:00:00',NULL,NULL,10,NULL,NULL,NULL),(17,'904596',1,132.00,'2018-12-11 20:48:15','2019-01-12 17:00:00','2019-01-12 21:00:00',NULL,NULL,10,NULL,NULL,NULL),(18,'992762',1,181.50,'2018-12-11 20:51:03','2019-01-13 17:15:00','2019-01-13 22:45:00',NULL,NULL,10,NULL,NULL,NULL),(19,'868549',1,341.00,'2018-12-11 20:51:45','2019-01-14 20:30:00','2019-01-15 02:00:00',NULL,NULL,10,NULL,NULL,NULL),(20,'596891',1,50.00,'2018-12-11 20:53:02','2019-01-15 14:00:00','2019-01-15 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(21,'894753',1,665.00,'2018-12-11 20:53:33','2019-01-16 20:30:00','2019-01-17 06:00:00',NULL,NULL,10,NULL,NULL,NULL),(22,'222409',1,41.00,'2018-12-11 20:54:17','2019-01-16 21:00:00','2019-01-16 22:00:00',NULL,NULL,10,NULL,NULL,NULL),(23,'019860',1,460.00,'2018-12-11 20:55:01','2019-01-17 21:00:00','2019-01-18 07:00:00',NULL,NULL,10,NULL,NULL,NULL),(24,'798363',1,105.00,'2018-12-11 20:55:43','2019-01-18 07:30:00','2019-01-18 11:00:00',NULL,NULL,10,NULL,NULL,NULL),(25,'882727',1,656.00,'2018-12-11 20:56:33','2019-01-20 17:00:00','2019-01-21 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(26,'782120',1,90.00,'2018-12-11 20:58:40','2019-01-22 14:00:00','2019-01-22 16:30:00',NULL,NULL,10,NULL,NULL,NULL),(27,'392730',1,445.50,'2018-12-11 20:59:18','2019-01-22 18:00:00','2019-01-23 07:30:00',NULL,NULL,10,NULL,NULL,NULL),(28,'701386',1,246.00,'2018-12-11 21:00:24','2019-01-25 17:00:00','2019-01-25 23:00:00',NULL,NULL,10,NULL,NULL,NULL),(29,'832111',1,144.00,'2018-12-11 21:17:32','2019-01-26 04:00:00','2019-01-26 08:00:00',NULL,NULL,10,NULL,NULL,NULL),(30,'390959',1,792.00,'2018-12-11 21:18:10','2019-01-27 15:15:00','2019-01-28 15:15:00',NULL,NULL,10,NULL,NULL,NULL),(31,'538201',1,35.00,'2018-12-11 21:18:43','2019-01-28 22:30:00','2019-01-28 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(32,'005181',1,105.00,'2018-12-11 21:19:52','2019-01-29 14:30:00','2019-01-29 18:15:00',NULL,NULL,10,NULL,NULL,NULL),(33,'133764',1,612.00,'2018-12-11 21:20:28','2019-02-01 09:00:00','2019-02-02 02:00:00',NULL,NULL,10,NULL,NULL,NULL),(34,'602977',1,26.00,'2018-12-11 21:23:16','2019-02-02 21:30:00','2019-02-02 22:00:00',NULL,NULL,10,NULL,NULL,NULL),(35,'039242',1,60.00,'2018-12-11 21:30:45','2019-01-01 14:00:00','2019-01-01 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(36,'832819',1,543.25,'2018-12-11 21:32:15','2019-01-02 19:15:00','2019-01-03 08:30:00',NULL,NULL,10,NULL,NULL,NULL),(37,'078090',1,76.00,'2018-12-11 21:32:54','2019-01-04 14:00:00','2019-01-04 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(38,'963597',1,18.75,'2018-12-11 21:39:36','2019-01-06 21:30:00','2019-01-06 22:15:00',NULL,NULL,10,NULL,NULL,NULL),(39,'818231',1,60.00,'2018-12-11 21:41:59','2019-01-06 21:00:00','2019-01-06 23:00:00',NULL,NULL,10,NULL,NULL,NULL),(40,'696977',1,50.00,'2018-12-11 21:42:39','2019-01-07 16:00:00','2019-01-07 18:00:00',NULL,NULL,10,NULL,NULL,NULL),(41,'644768',1,720.00,'2018-12-11 21:43:18','2019-01-08 07:45:00','2019-01-09 07:45:00',NULL,NULL,10,NULL,NULL,NULL),(42,'774945',1,31.25,'2018-12-11 21:43:54','2019-01-09 22:30:00','2019-01-09 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(43,'002549',1,540.00,'2018-12-11 21:44:39','2019-01-09 15:00:00','2019-01-10 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(44,'618029',1,12.50,'2018-12-11 21:45:11','2019-01-11 14:00:00','2019-01-11 14:30:00',NULL,NULL,10,NULL,NULL,NULL),(45,'069027',1,25.00,'2018-12-11 21:45:46','2019-01-11 20:45:00','2019-01-11 21:45:00',NULL,NULL,10,NULL,NULL,NULL),(46,'142220',1,456.00,'2018-12-11 21:46:24','2019-01-12 22:00:00','2019-01-13 10:00:00',NULL,NULL,10,NULL,NULL,NULL),(47,'340071',1,25.00,'2018-12-11 21:46:53','2019-01-14 21:30:00','2019-01-14 22:30:00',NULL,NULL,10,NULL,NULL,NULL),(48,'632021',1,49.50,'2018-12-11 21:57:23','2019-01-15 21:30:00','2019-01-15 23:00:00',NULL,NULL,10,NULL,NULL,NULL),(49,'642107',1,555.00,'2018-12-11 21:57:56','2019-01-17 07:30:00','2019-01-18 02:00:00',NULL,NULL,10,NULL,NULL,NULL),(50,'686106',1,138.00,'2018-12-11 21:58:32','2019-01-18 14:00:00','2019-01-18 17:00:00',NULL,NULL,10,NULL,NULL,NULL),(51,'593734',1,206.25,'2018-12-11 21:59:41','2019-01-19 13:30:00','2019-01-19 21:45:00',NULL,NULL,10,NULL,NULL,NULL),(52,'083373',1,697.50,'2018-12-11 22:02:19','2019-01-20 04:15:00','2019-01-21 03:30:00',NULL,NULL,10,NULL,NULL,NULL),(53,'632138',1,135.00,'2018-12-11 23:10:25','2019-01-21 17:45:00','2019-01-21 22:15:00',NULL,NULL,10,NULL,NULL,NULL),(54,'824384',1,712.50,'2018-12-11 23:11:26','2019-01-22 14:00:00','2019-01-23 13:45:00',NULL,NULL,10,NULL,NULL,NULL),(55,'518325',1,299.25,'2018-12-11 23:12:28','2019-01-23 15:30:00','2019-01-23 20:45:00',NULL,NULL,10,NULL,NULL,NULL),(56,'008884',1,420.00,'2018-12-11 23:13:14','2019-01-25 20:30:00','2019-01-26 10:30:00',NULL,NULL,10,NULL,NULL,NULL),(57,'943763',1,190.00,'2018-12-11 23:13:58','2019-01-26 11:00:00','2019-01-26 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(58,'668370',1,645.00,'2018-12-11 23:14:39','2019-01-27 20:30:00','2019-01-28 18:00:00',NULL,NULL,10,NULL,NULL,NULL),(59,'061200',1,12.50,'2018-12-11 23:15:23','2019-01-30 21:00:00','2019-01-30 21:30:00',NULL,NULL,10,NULL,NULL,NULL),(60,'600873',1,720.00,'2018-12-11 23:16:00','2019-01-31 08:45:00','2019-02-01 08:45:00',NULL,NULL,10,NULL,NULL,NULL),(61,'133208',1,56.00,'2018-12-11 23:16:52','2019-02-01 14:00:00','2019-02-01 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(62,'036003',1,962.00,'2018-12-11 23:17:19','2019-02-02 19:30:00','2019-02-03 14:00:00',NULL,NULL,10,NULL,NULL,NULL),(63,'775961',1,67.50,'2018-12-11 23:27:41','2019-01-14 20:45:00','2019-01-14 23:00:00',NULL,NULL,10,NULL,NULL,NULL),(64,'478653',1,624.00,'2018-12-11 23:29:06','2019-01-12 20:15:00','2019-01-13 08:15:00',NULL,NULL,10,NULL,NULL,NULL),(65,'050734',1,323.00,'2018-12-11 23:30:24','2019-01-13 18:00:00','2019-01-13 22:45:00',NULL,NULL,10,NULL,NULL,NULL),(66,'014915',1,12.50,'2018-12-11 23:30:57','2019-01-11 21:30:00','2019-01-11 22:00:00',NULL,NULL,10,NULL,NULL,NULL),(67,'170856',1,60.00,'2018-12-11 23:32:22','2019-01-11 14:00:00','2019-01-11 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(68,'531168',1,712.50,'2018-12-11 23:33:49','2019-01-09 20:30:00','2019-01-10 20:15:00',NULL,NULL,10,NULL,NULL,NULL),(69,'062578',1,128.25,'2018-12-11 23:36:51','2019-01-05 20:00:00','2019-01-05 22:15:00',NULL,NULL,10,NULL,NULL,NULL),(70,'115436',1,630.00,'2018-12-20 09:36:51','2019-02-12 01:45:00','2019-02-13 00:15:00',NULL,NULL,10,NULL,NULL,NULL),(71,'727284',1,535.50,'2018-12-20 10:55:42','2019-01-01 18:00:00','2019-01-02 09:45:00',NULL,NULL,10,NULL,NULL,NULL),(72,'208528',1,127.50,'2018-12-20 10:56:14','2019-01-02 20:00:00','2019-01-02 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(73,'074293',1,988.00,'2018-12-20 10:56:46','2019-01-03 11:00:00','2019-01-04 06:00:00',NULL,NULL,10,NULL,NULL,NULL),(74,'933524',1,88.00,'2018-12-20 10:57:33','2019-01-06 14:00:00','2019-01-06 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(75,'730674',1,104.00,'2018-12-20 10:58:25','2019-01-07 14:00:00','2019-01-07 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(76,'350037',1,68.00,'2018-12-20 10:59:00','2019-01-09 18:00:00','2019-01-09 19:00:00',NULL,NULL,10,NULL,NULL,NULL),(77,'194494',1,741.00,'2018-12-20 11:01:15','2019-01-15 18:45:00','2019-01-16 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(78,'049652',1,104.00,'2018-12-20 11:01:44','2019-01-16 21:00:00','2019-01-16 23:00:00',NULL,NULL,10,NULL,NULL,NULL),(79,'404854',1,82.00,'2018-12-20 11:02:17','2019-01-18 14:00:00','2019-01-18 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(80,'251922',1,100.00,'2018-12-20 11:55:21','2019-01-16 14:00:00','2019-01-16 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(81,'769516',1,435.00,'2018-12-20 11:56:38','2019-01-19 14:00:00','2019-01-20 04:30:00',NULL,NULL,10,NULL,NULL,NULL),(82,'842964',1,184.50,'2018-12-20 11:57:17','2019-01-21 15:00:00','2019-01-21 19:30:00',NULL,NULL,10,NULL,NULL,NULL),(83,'277275',1,306.25,'2018-12-20 12:32:29','2019-01-23 10:30:00','2019-01-23 22:45:00',NULL,NULL,10,NULL,NULL,NULL),(84,'324362',1,600.00,'2018-12-20 12:33:02','2019-01-24 07:00:00','2019-01-25 03:00:00',NULL,NULL,10,NULL,NULL,NULL),(85,'912185',1,840.50,'2018-12-20 12:33:46','2019-01-25 06:30:00','2019-01-26 03:00:00',NULL,NULL,10,NULL,NULL,NULL),(86,'344760',1,41.00,'2018-12-20 12:34:23','2019-01-27 14:30:00','2019-01-27 15:30:00',NULL,NULL,10,NULL,NULL,NULL),(87,'722672',1,980.50,'2018-12-20 12:35:19','2019-01-27 07:30:00','2019-01-28 02:00:00',NULL,NULL,10,NULL,NULL,NULL),(88,'295557',1,50.00,'2018-12-20 12:35:58','2019-01-29 14:00:00','2019-01-29 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(89,'679343',1,164.00,'2018-12-20 12:37:37','2019-01-30 20:00:00','2019-01-31 00:00:00',NULL,NULL,10,NULL,NULL,NULL),(90,'928100',1,420.00,'2018-12-20 12:38:07','2019-01-31 21:30:00','2019-02-01 11:30:00',NULL,NULL,10,NULL,NULL,NULL),(91,'885261',1,255.00,'2018-12-20 12:45:27','2019-01-01 19:30:00','2019-01-02 03:00:00',3,'',10,NULL,NULL,NULL),(92,'539091',1,105.00,'2018-12-20 12:46:04','2019-01-03 14:30:00','2019-01-03 18:15:00',NULL,NULL,10,NULL,NULL,NULL),(93,'096910',1,102.00,'2018-12-20 12:46:54','2019-01-04 16:00:00','2019-01-04 19:00:00',NULL,NULL,10,NULL,NULL,NULL),(94,'790169',1,198.00,'2018-12-20 12:47:48','2019-01-04 09:00:00','2019-01-04 15:00:00',NULL,NULL,10,NULL,NULL,NULL),(95,'703132',1,816.00,'2018-12-20 12:53:22','2019-01-06 20:00:00','2019-01-07 20:00:00',NULL,NULL,10,NULL,NULL,NULL),(96,'978499',1,553.00,'2018-12-20 12:54:22','2019-01-08 14:00:00','2019-01-09 09:45:00',NULL,NULL,10,NULL,NULL,NULL),(97,'632544',1,84.00,'2018-12-20 12:54:53','2019-01-09 15:00:00','2019-01-09 18:00:00',NULL,NULL,10,NULL,NULL,NULL),(98,'299732',1,144.00,'2018-12-20 12:58:37','2019-01-10 12:00:00','2019-01-10 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(99,'869175',1,784.00,'2018-12-20 12:59:11','2019-01-11 17:00:00','2019-01-12 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(100,'649848',1,60.00,'2018-12-20 12:59:41','2019-01-13 14:00:00','2019-01-13 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(101,'047103',1,912.00,'2018-12-20 13:00:14','2019-01-14 09:00:00','2019-01-15 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(102,'703382',1,503.75,'2018-12-20 13:01:10','2019-01-15 19:15:00','2019-01-16 03:00:00',NULL,NULL,10,NULL,NULL,NULL),(103,'103934',1,98.00,'2018-12-20 13:01:48','2019-01-16 14:00:00','2019-01-16 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(104,'390114',1,136.00,'2018-12-20 13:02:18','2019-01-17 13:45:00','2019-01-17 17:45:00',NULL,NULL,10,NULL,NULL,NULL),(105,'391309',1,142.50,'2018-12-20 13:03:11','2019-01-18 19:00:00','2019-01-18 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(106,'364971',1,72.00,'2018-12-20 13:28:32','2019-01-19 14:00:00','2019-01-19 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(107,'492240',1,63.00,'2018-12-20 13:29:05','2019-01-19 22:00:00','2019-01-19 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(108,'323304',1,99.00,'2018-12-20 13:39:30','2019-01-20 14:00:00','2019-01-20 16:45:00',NULL,NULL,10,NULL,NULL,NULL),(109,'095250',1,195.00,'2018-12-20 13:41:24','2019-01-20 15:00:00','2019-01-20 18:45:00',NULL,NULL,10,NULL,NULL,NULL),(110,'703086',1,76.50,'2018-12-20 13:42:23','2019-01-21 05:30:00','2019-01-21 07:45:00',NULL,NULL,10,NULL,NULL,NULL),(111,'469942',1,78.00,'2018-12-20 13:42:48','2019-01-21 22:15:00','2019-01-21 23:45:00',NULL,NULL,10,NULL,NULL,NULL),(112,'588560',1,1104.00,'2018-12-20 13:43:17','2019-01-23 19:30:00','2019-01-24 19:30:00',NULL,NULL,10,NULL,NULL,NULL),(113,'004304',1,758.50,'2018-12-20 13:43:54','2019-01-26 22:15:00','2019-01-27 16:45:00',NULL,NULL,10,NULL,NULL,NULL),(114,'252946',1,552.00,'2018-12-20 13:44:59','2019-01-28 10:45:00','2019-01-28 22:45:00',NULL,NULL,10,NULL,NULL,NULL),(115,'379716',1,922.50,'2018-12-20 13:46:03','2019-01-30 11:15:00','2019-01-31 09:45:00',NULL,NULL,10,NULL,NULL,NULL),(116,'447260',1,60.00,'2018-12-20 13:46:38','2019-01-31 14:00:00','2019-01-31 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(117,'804889',1,70.00,'2018-12-20 13:47:23','2019-02-01 14:00:00','2019-02-01 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(118,'860305',1,82.00,'2018-12-20 13:47:52','2019-02-02 14:00:00','2019-02-02 16:00:00',NULL,NULL,10,NULL,NULL,NULL),(119,'216665',1,869.25,'2018-12-20 13:48:24','2019-02-03 17:45:00','2019-02-04 09:00:00',NULL,NULL,10,NULL,NULL,NULL),(120,'233148',1,7.00,'2019-02-10 06:38:40','2019-02-10 07:45:00','2019-02-10 08:00:00',NULL,NULL,10,NULL,NULL,NULL),(121,'667867',1,280.50,'2019-02-10 10:09:17','2019-02-10 16:30:00','2019-02-11 00:45:00',NULL,NULL,10,NULL,NULL,NULL),(122,'395223',1,280.50,'2019-02-10 10:09:19','2019-02-10 16:30:00','2019-02-11 00:45:00',NULL,NULL,10,NULL,NULL,NULL),(123,'464823',1,7.00,'2019-02-13 08:19:00','2019-02-13 09:00:00','2019-02-13 09:15:00',NULL,NULL,10,NULL,NULL,NULL),(131,'229931',1,9.75,'2019-02-17 11:30:00','2019-02-17 12:30:00','2019-02-17 12:45:00',NULL,NULL,10,NULL,NULL,NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bike_on_reservation`
--

LOCK TABLES `bike_on_reservation` WRITE;
/*!40000 ALTER TABLE `bike_on_reservation` DISABLE KEYS */;
INSERT INTO `bike_on_reservation` VALUES (20,4),(21,7),(20,8),(25,8),(28,8),(30,8),(26,9),(29,9),(31,9),(65,10),(68,10),(70,10),(36,11),(38,11),(57,12),(62,12),(23,13),(36,13),(60,14),(38,15),(12,16),(14,16),(66,17),(69,17),(41,18),(44,18),(49,19),(50,19),(52,19),(53,19),(27,20),(1,21),(2,21),(6,21),(7,21),(58,22),(63,22),(6,23),(17,23),(18,23),(9,24),(10,24),(7,25),(19,25),(29,26),(52,26),(1,27),(29,27),(2,28),(63,28),(12,29),(20,29),(9,30),(21,30),(12,31),(76,32),(28,33),(29,33),(78,34),(79,34),(73,35),(74,35),(42,36),(46,36),(59,37),(61,37),(65,37),(73,38),(33,39),(34,39),(33,40),(34,41),(42,41),(75,42),(3,43),(26,43),(33,44),(33,45),(11,46),(13,46),(33,46),(11,47),(13,48),(33,48),(33,49),(67,49),(11,50),(51,50),(54,50),(10,51),(10,52),(17,52),(49,53),(50,53),(1,54),(10,54),(1,55),(14,55),(55,55),(2,56),(17,56),(49,57),(50,57),(52,57),(18,58),(27,58),(18,59),(10,60),(25,60),(12,61),(28,62),(29,62),(61,62),(76,62),(59,63),(65,63),(23,64),(30,64),(23,65),(30,65),(71,65),(34,66),(3,67),(35,67),(42,68),(57,68),(9,69),(14,69),(15,69),(13,70),(16,71),(56,72),(22,73),(46,73),(4,74),(22,74),(31,75),(46,75),(31,76),(46,76),(62,76),(23,77),(30,77),(31,78),(46,78),(58,79),(62,79),(24,80),(71,80),(58,81),(59,81),(23,82),(33,82),(33,83),(2,84),(17,84),(2,85),(23,85),(23,86),(58,86),(16,87),(56,87),(58,87),(59,88),(30,89),(42,89),(10,90),(25,90),(72,91),(5,92),(72,93),(59,94),(61,94),(32,95),(77,96),(36,97),(36,98),(77,98),(43,99),(45,99),(47,99),(3,100),(35,100),(3,101),(35,101),(44,101),(23,102),(30,102),(43,102),(45,102),(68,103),(70,103),(74,103),(64,104),(11,105),(51,105),(47,106),(54,107),(54,108),(7,109),(54,109),(32,110),(6,111),(70,111),(1,112),(14,112),(43,112),(57,113),(71,113),(1,114),(14,114),(43,114),(6,115),(41,115),(2,116),(17,116),(1,117),(10,117),(25,117),(6,118),(41,118),(14,119),(30,119),(42,119),(60,120),(48,121),(64,122),(60,123),(72,131),(74,131);
/*!40000 ALTER TABLE `bike_on_reservation` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station_on_reservation`
--

LOCK TABLES `station_on_reservation` WRITE;
/*!40000 ALTER TABLE `station_on_reservation` DISABLE KEYS */;
INSERT INTO `station_on_reservation` VALUES (24,4),(24,7),(37,8),(31,9),(88,10),(43,11),(80,12),(27,13),(72,14),(26,15),(17,16),(85,17),(54,18),(61,19),(40,20),(3,21),(73,22),(30,23),(14,24),(25,25),(3,26),(27,27),(28,28),(63,29),(36,30),(29,31),(93,32),(63,33),(93,34),(98,35),(53,36),(73,37),(72,38),(43,39),(21,40),(30,41),(91,42),(5,43),(8,44),(72,45),(13,46),(27,47),(29,48),(87,49),(68,50),(40,51),(93,52),(3,53),(27,54),(62,55),(28,56),(28,57),(91,58),(5,59),(62,60),(84,61),(27,62),(21,63),(69,64),(83,65),(96,66),(42,67),(97,68),(12,69),(81,70),(13,71),(63,72),(21,73),(5,74),(10,75),(93,76),(27,77),(29,78),(21,79),(27,80),(3,81),(63,82),(21,83),(23,84),(23,85),(30,86),(21,87),(28,88),(63,89),(63,90),(83,91),(5,92),(30,93),(73,94),(33,95),(93,96),(63,97),(29,98),(53,99),(14,100),(36,101),(27,102),(80,103),(76,104),(72,105),(21,106),(73,107),(29,108),(21,109),(27,110),(94,111),(69,112),(62,113),(83,114),(33,115),(72,116),(24,117),(28,118),(27,119),(13,120),(53,121),(53,122),(24,123),(99,131);
/*!40000 ALTER TABLE `station_on_reservation` ENABLE KEYS */;
UNLOCK TABLES;

#sets global scheduler to enable mysql events, events allow us to have a function that would run in a specific time specified by user
SET GLOBAL event_scheduler = ON;

#sets the delimiter to something else than ";", this allows us to write multiple statements inside an event function
DELIMITER $$

#drops event, used for testing
DROP EVENT IF EXISTS autoupdate$$

CREATE EVENT autoupdate
ON SCHEDULE EVERY 15 MINUTE
/* ---------------CHANGETHIS ---------------*/
STARTS '2019-03-26 18:30:00'
DO
BEGIN

DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE res_id INT DEFAULT 0;
DECLARE res_id_station INT DEFAULT 0;
DECLARE res_id_starttime DATETIME DEFAULT NOW();
DECLARE bi_id INT DEFAULT 0;
DECLARE bi_id_type INT DEFAULT 0;
DECLARE new_bi_id INT DEFAULT 0;
DECLARE ins_t_count INT DEFAULT 0;
DECLARE ins_c_count INT DEFAULT 0;
DECLARE ins_c_type INT DEFAULT 0;
DECLARE done INT DEFAULT FALSE;
DECLARE bikes_in_res CURSOR FOR Select bor_bike_id FROM bike_on_reservation WHERE bor_reservation_id = res_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


#changes reservations that did not unlock on time to past reservation and giving fine if the user did not unlock after 15 minutes of their starting reservation time
UPDATE reservation SET res_type = 1, fine_cost = 5, fine_desc = 'late for start of reservation, did not unlock bike on time', fined_at = now() WHERE now() >= DATE_ADD(starttime, INTERVAL 15 MINUTE) AND res_type = 3;

#changes reservations that did not lock on time to past reservation and giving fine if the user did not lock after 15 minutes of their ending reservation time
UPDATE reservation SET res_type = 1, fine_cost = 5, fine_desc = 'late for end of reservation, did not lock bike on time', fined_at = now() WHERE now() >= DATE_ADD(endtime, INTERVAL 15 MINUTE) AND res_type = 2;



Select count(*) FROM reservation WHERE (now() >= endtime AND res_type = 2) OR (now() >= starttime AND res_type = 3) INTO n;

SET i = 0;

WHILE i < n DO
SET res_id = (Select reservation_id FROM reservation WHERE (now() >= endtime AND res_type = 2) OR (now() >= starttime AND res_type = 3) LIMIT i,1);
SET res_id_station = (SELECT end_station_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = res_id);
SET res_id_starttime = (SELECT starttime FROM reservation WHERE reservation_id = res_id);
SELECT concat('Current Reservation Id being checked: ', res_id);
Select bor_bike_id FROM bike_on_reservation WHERE bor_reservation_id = res_id;

	IF (SELECT res_type FROM reservation WHERE reservation_id = res_id) = 3 THEN
	OPEN bikes_in_res;
	read_loop: LOOP
		FETCH bikes_in_res INTO bi_id;
		SET bi_id_type = (Select bike_type FROM bike WHERE bike_id = bi_id);

		IF done THEN
      			LEAVE read_loop;
    		END IF;

		IF (SELECT count(*) FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_stationedat = (SELECT end_station_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = res_id) AND bike_type = bi_id_type  AND bike_status = 1) > 0 THEN

		SET new_bi_id = (SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_stationedat = (SELECT end_station_id FROM stationroutes, station_on_reservation WHERE sor_route_id = route_id AND sor_reservation_id = res_id) AND bike_type = bi_id_type  AND bike_status = 1 LIMIT 1);

		ELSEIF (SELECT count(*) FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_type = bi_id_type AND bike_status = 1) > 0 THEN

		SET new_bi_id = (SELECT bike_id FROM bike WHERE bike_id NOT IN (SELECT bike_id FROM bike, reservation, bike_on_reservation WHERE bor_bike_id = bike_id AND bor_reservation_id = reservation_id  AND (res_type = 2 OR res_type = 3)) AND bike_type = bi_id_type AND bike_status = 1 LIMIT 1);

		UPDATE bike SET bike_stationedat = res_id_station WHERE bike_id = new_bi_id;


		ELSE

		SET new_bi_id = (SELECT bike_id FROM bike WHERE bike_status = 4 AND bike_type = bi_id_type LIMIT 1);

		UPDATE bike SET bike_stationedat = res_id_station, bike_status = 1 WHERE bike_id = new_bi_id;

		END IF;

	SELECT concat('Current Bike ID being changed: ', bi_id);
	SELECT concat('Bike ID of Current Bike ID being changed: ', bi_id_type);
	SELECT concat('Current New Bike ID being changed: ', new_bi_id);


	UPDATE bike_on_reservation, reservation SET bor_bike_id = new_bi_id WHERE reservation_id = bor_reservation_id AND starttime >= (SELECT endtime FROM reservation WHERE reservation_id = res_id) AND bor_bike_id = bi_id;

	UPDATE bike SET bike_status = 5 WHERE bike_id = bi_id;

	Select bor_bike_id FROM bike_on_reservation WHERE bor_reservation_id = res_id;

	END LOOP read_loop;
	CLOSE bikes_in_res;
	SET done = FALSE;

	ELSE
	OPEN bikes_in_res;
	read_loop: LOOP
		FETCH bikes_in_res INTO bi_id;

		IF done THEN
    	  		LEAVE read_loop;
    		END IF;

    	IF (SELECT count(*) FROM bike_on_reservation, reservation WHERE bor_reservation_id = reservation_id AND res_type = 3 AND starttime > res_id_starttime AND bor_bike_id = bi_id ORDER BY starttime LIMIT 1) > 0 THEN

 	UPDATE bike SET bike_stationedat = res_id_station WHERE bike_id = bi_id;
		END IF;

	END LOOP read_loop;
	CLOSE bikes_in_res;
	SET done = FALSE;
	END IF;

SET i = i + 1;
END WHILE;


select count(*) FROM type_of_bike INTO ins_t_count;
SET ins_c_count = 0;


WHILE ins_c_count < ins_t_count DO

	SET ins_c_type = (select bike_type_id FROM type_of_bike LIMIT ins_c_count,1);
	IF (Select count(*) FROM bike WHERE bike_status = 4 AND bike_type = ins_c_type) < 20 THEN

	INSERT INTO `bike` (bike_type,travel_count,bike_status,bike_stationedat) VALUES
	(ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL),
	(ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL),
	(ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL), (ins_c_type,0,4,NULL);

	END IF;
	SET ins_c_count = ins_c_count + 1;
END WHILE;


#checks if the last fine was given more than 7 days, set account as inactive, i used SECOND instead of DAY to check since there are cases where the user was fined at 3:00 pm, but when the seventh day comes, he would set as inactive directly at 12:00 am. The user would be fined at 6 days and 15 hours instead of 7
UPDATE auth_user SET is_active = 0 WHERE id = (select c_id FROM reservation WHERE TIMESTAMPDIFF(SECOND, fined_at, now) > 604800 GROUP BY c_id);


END$$

DELIMITER ;
/* THE FOLLOWING WERE USED FOR THE DEMONSTRATION
/*

ALTER TABLE bike ADD UID varchar(255);
UPDATE bike SET UID = 'PaxDOxg1gAdRFRtiig1XQ4xxDjl2',bike_stationedat=NULL,bike_status=3 WHERE (bike_id = 7);
insert into reservation (res_code,res_type,res_cost,res_date,starttime,endtime,c_id) VALUES (120783,2,255.00,'2019-03-24 11:00:00'
,'2019-03-26 06:15:00','2019-03-26 18:00:00',20);
insert into station_on_reservation VALUES (47,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into bike_on_reservation VALUES (7,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));

insert into reservation (res_code,res_type,res_cost,res_date,starttime,endtime,c_id) VALUES (136541,3,9.00,'2019-03-14 11:00:00'
/* ---------------CHANGETHIS TO UNLOCK TIME THAT SHOULD BE MISSED ---------------
,'2019-03-26 19:00:00'
,'2019-03-26 20:00:00',19);
insert into station_on_reservation VALUES (14,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into bike_on_reservation VALUES (15,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
/* FUTURE RESERVATION WAY IN THE FUTURE
insert into reservation (res_code,res_type,res_cost,res_date,starttime,endtime,c_id) VALUES (192437,3,9.00,'2019-03-14 11:20:00'
,'2019-03-29 14:45:00','2019-03-29 18:00:00',17);
insert into station_on_reservation VALUES (35,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into bike_on_reservation VALUES (15,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));

UPDATE bike SET bike_stationedat=NULL,bike_status=3 WHERE (bike_id = 68);
insert into reservation (res_code,res_type,res_cost,res_date,starttime,endtime,c_id) VALUES (120756,2,255.00,'2019-03-24 11:30:00','2019-03-25 06:15:00'
/* ---------------CHANGETHIS TO LOCK TIME THAT SHOULD BE MISSED---------------
,'2019-03-26 18:45:00',19);
insert into station_on_reservation VALUES (92,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into bike_on_reservation VALUES (68,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into reservation (res_code,res_type,res_cost,res_date,starttime,endtime,c_id) VALUES (136542,3,9.00,'2019-03-14 11:45:00'
,'2019-03-30 14:45:00','2019-03-30 15:00:00',17);
insert into station_on_reservation VALUES (25,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
insert into bike_on_reservation VALUES (68,(SELECT reservation_id FROM reservation ORDER BY reservation_id DESC LIMIT 1));
