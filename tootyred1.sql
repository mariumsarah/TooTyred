
DROP DATABASE tootyred;
CREATE DATABASE tootyred;
USE tootyred;
SET NAMES utf8 ;

DROP TABLE IF EXISTS `auth_user`;
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

LOCK TABLES `auth_user` WRITE;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$120000$kCJBCXnabLY4$xNxqQ6/JqmFgcz3hEmqJdVPwCtH9nsrCPv+CLi70sVA=','2019-02-19 20:52:09',1,'jaden12345','Jaden','Roulette','tootyredsuperuser@superuser.com',1,1,'2019-01-10 05:02:01'),
(2,'pbkdf2_sha256$120000$0ATBH3RyTMRt$16qW0g5mm2t+POuN49OiT2PETodgoWnYtaMmrDpBUsU=','2019-02-25 07:52:58',0,'sarahm13654','sarah','marium','sarahm13654@gmail.com',0,1,'2019-01-12 13:26:14'),
(3,'pbkdf2_sha256$120000$MGKoZ4xCC1US$JnofFiaDgQ1o6+z+4lYPzi4+JdAmHZFWTZoU7V0DrPs=','2019-02-25 07:54:58',0,'smith12345','John','Smith','johnsmith@stafftootyreduser.com',1,1,'2019-01-24 08:54:32');
UNLOCK TABLES;
/*'priya.bhaskar@hotmail.com'
/*'alwankazi@hotmail.com'
'name_wtf@yahoo.com'
/*'alwankazi99@gmail.com'
/*'sm48@hw.ac.uk' */
--
-- Table structure for table `bike`
--
--
-- Table structure for table `station`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--
/* ------------------------ */;
LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES
(1,'1 Greenbank Cres, Edinburgh EH10 5TE, UK','It is located in South Edinburgh in the Morningside/Oxgangs area.It is located in South Edinburgh in the Morningside/Oxgangs area. ','Braidburn Valley Park',-3.2135800000000000,55.919100000000000,1,'BraidburnValleyPark.jpg'),
(2,'Edinburgh EH3 5PA, UK','The pretty park near Washington Lake,Spread over 34 acres, it also has a delightful formal garden in classic style','Inverleith Park',-3.2143800000000000,55.966530000000000,1,'inverleithpark.jpg'),
(3,'Princes St, Edinburgh EH2 2HG, UK','Princes Street Gardens are two adjacent public parks in the centre of Edinburgh','Princes Street Gardens',-3.1983900000000000,55.951752000000000,1,'princesstreetgardens.jpg'),
(4,'Melville Dr, Edinburgh EH9 1ND, UK','The Meadows is a large public park in Edinburgh, Scotland, to the south of the city centre.','The Meadows',-3.1918600000000000,55.939940000000000,1,'themeadows.JPG'),
(5,'Lochend Rd S, Edinburgh EH7 6BP, UK','The park meant for all kids in townIt is located in South Edinburgh in the Morningside/Oxgangs area.','Lochend Park',-3.1584700000000000,55.961310000000000,1,'lochendpark.jpg'),
(6,'Links Gardens, Edinburgh EH6 7QR, UK','The link that connects to the metroSpread over 34 acres, it also has a delightful formal garden in classic style','Leith Links',-3.1621200000000000,55.971740000000000,1,'leithlinks.png'),
(7,'Old Church Ln, Duddingston Village, Edinburgh EH15 3PX, UK','The old Neils garden founded in the late 90s','Dr Neils Garden',-3.1463600000000000,55.941720000000000,1,'DrNeilGarden.jpg'),
(8,'Stanedykehead, Alnwickhill EH16 6TN, UK','The largest park to visit is righ here.Spread over 34 acres, it also has a delightful formal garden in classic style','Seven Acre Park',-3.1683400000000000,55.905840000000000,1,'SevenAcrePark.jpg'),
(9,'1 Greenbank Cres, Edinburgh EH10 5TE, UK','Spread over 34 acres, it also has a delightful formal garden in classic style ','Saughton Park And Gardens',-3.2485290000000000,55.934132000000000,1,'SaughtonParkAndGardens.jpg'),
(10,'24 Ravelston Dykes Rd, Edinburgh EH4 3NZ, UK','We are a 9 hole golf course situated within 1.5 miles f the centre of Edinburgh, ','Ravelston Golf Club',-3.2577200000000000,55.954350000000000,1,'ravelstongolfclub.jpg');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

/* ------------------------ */;

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
INSERT INTO `status_of_bike` VALUES
(1,'stationed'),
(2,'OutOfservice'),
(3,'active'),
(4,'stored'),
(5,'tracked');
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
/* ------------------------ */;
LOCK TABLES `type_of_bike` WRITE;
/*!40000 ALTER TABLE `type_of_bike` DISABLE KEYS */;
INSERT INTO `type_of_bike` VALUES
(1,'A mountain bike or mountain bicycle (abbreviated Mtn Bike or MTB[1]) is a bicycle designed for off-road cycling. ','Shimano XT','Mountain Bike',2.00,'shimano.png'),
(2,'The tandem bicycle or twin is a form of bicycle designed to be ridden by more than one person.','Fuji X','Tandem Bike',4.00,'tandem.png'),
(3,'The road bike is used  for traveling at speed on paved roads. All the way from the west! Get this bike and swift away in speed to the destination of your choice.  ','Fuji Crank T ','Road Bike',1.25,'road.png'),
(4,'Wheelchair bikes has an advanced wheelchair design enabling easy and comfortable pedaling to ensure maximum maneuverability with minimum effort.','VeloPlus','Wheelchair Bike',3.50,'veloplus.png');
/*!40000 ALTER TABLE `type_of_bike` ENABLE KEYS */;
UNLOCK TABLES;
/* ------------------------ */;

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
/* ------------------------ */;
LOCK TABLES `bike` WRITE;
/*!40000 ALTER TABLE `bike` DISABLE KEYS */;
INSERT INTO `bike` VALUES (3,0,1,1),
(3,0,1,1),
(3,0,1,1),
(1,0,1,1),
(1,0,1,1),
(2,0,1,1),
(2,0,1,1),
(4,0,1,1),
(3,0,1,2),
(3,0,1,2),
(3,0,1,2),
(1,0,1,2),
(1,0,1,2),
(2,0,1,2),
(2,0,1,2),
(4,0,1,2),
(3,0,1,3),
(3,0,1,3),
(3,0,1,3),
(1,0,1,3),
(1,0,1,3),
(2,0,1,3),
(2,0,1,3),
(4,0,1,3),
(3,0,1,4),
(3,0,1,4),
(3,0,1,4),
(1,0,1,4),
(1,0,1,4),
(2,0,1,4),
(2,0,1,4),
(4,0,1,4),
(3,0,1,5),
(3,0,1,5),
(3,0,1,5),
(1,0,1,5),
(1,0,1,5),
(2,0,1,5),
(2,0,1,5),
(4,0,1,5),
(3,0,1,6),
(3,0,1,6),
(3,0,1,6),
(1,0,1,6),
(1,0,1,6),
(2,0,1,6),
(2,0,1,6),
(4,0,1,6),
(3,0,1,7),
(3,0,1,7),
(3,0,1,7),
(1,0,1,7),
(1,0,1,7),
(2,0,1,7),
(2,0,1,7),
(4,0,1,7),
(3,0,1,8),
(3,0,1,8),
(3,0,1,8),
(1,0,1,8),
(1,0,1,8),
(2,0,1,8),
(2,0,1,8),
(4,0,1,8),
(3,0,1,9),
(3,0,1,9),
(3,0,1,9),
(1,0,1,9),
(1,0,1,9),
(2,0,1,9),
(2,0,1,9),
(4,0,1,9),
(3,0,1,10),
(3,0,1,10),
(3,0,1,10),
(1,0,1,10),
(1,0,1,10),
(2,0,1,10),
(2,0,1,10),
(4,0,1,10);
/*!40000 ALTER TABLE `bike` ENABLE KEYS */;
UNLOCK TABLES;
/* ------------------------ */;
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
INSERT INTO `reservation_type` VALUES (1,'past'),(2,'ongoing'),(3,'future'),(4,'stored'),(5,'tracked');
/*!40000 ALTER TABLE `reservation_type` ENABLE KEYS */;
UNLOCK TABLES;
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
  `feedback` text DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ;


DROP TABLE IF EXISTS `bike_on_reservation`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bike_on_reservation` (
  `bor_bike_id` int(11) NOT NULL,
  `bor_reservation_id` int(11) NOT NULL,
  PRIMARY KEY (`bor_bike_id`,`bor_reservation_id`),
  KEY `fk_bor_reservation_id` (`bor_reservation_id`),
  CONSTRAINT `fk_bor_bike_id` FOREIGN KEY (`bor_bike_id`) REFERENCES `bike` (`bike_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bor_reservation_id` FOREIGN KEY (`bor_reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

DROP TABLE IF EXISTS `django_admin_log`;
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

LOCK TABLES `django_admin_log` WRITE;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-10 06:08:21','2','test',1,'[{\"added\": {}}]',4,1),(2,'2019-01-10 06:12:41','3','testing',1,'[{\"added\": {}}]',4,1),(3,'2019-01-10 06:12:52','1','UserProfile object (1)',3,'',8,1),(4,'2019-01-10 06:13:12','2','test',3,'',4,1),(5,'2019-01-10 06:13:12','3','testing',3,'',4,1),(6,'2019-01-10 08:09:38','4','test1',3,'',4,1),(7,'2019-01-10 08:09:38','5','test2',3,'',4,1),(8,'2019-01-10 08:32:58','6','test1',3,'',4,1),(9,'2019-01-11 14:33:38','7','sarahm@gmail.com',3,'',4,1),(10,'2019-01-12 13:25:40','8','sarahm13654',3,'',4,1),(11,'2019-01-12 13:25:41','9','sarahm1365429',3,'',4,1),(12,'2019-01-24 08:54:33','11','johnsmith',1,'[{\"added\": {}}]',4,1),(13,'2019-01-24 09:42:49','11','johnsmith',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',4,1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `django_content_type`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 ;

LOCK TABLES `django_content_type` WRITE;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(16,'home','accstatus'),(12,'home','bike'),(17,'home','bikeonreservation'),(13,'home','biketype'),(18,'home','checkuplog'),(19,'home','complaints'),(20,'home','creditcardinfo'),(22,'home','customerrating'),(24,'home','maintenancelog'),(27,'home','reservation'),(28,'home','reservationtype'),(11,'home','station'),(29,'home','stationfootage'),(30,'home','stationonreservation'),(31,'home','stationroutes'),(10,'home','stationstable'),(14,'home','statusofbike'),(15,'home','typeofbike'),(8,'home','userprofile'),(7,'home','users'),(6,'sessions','session');
UNLOCK TABLES;

DROP TABLE IF EXISTS `django_migrations`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 ;

LOCK TABLES `django_migrations` WRITE;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-01-09 13:47:15'),(2,'auth','0001_initial','2019-01-09 13:47:56'),(3,'admin','0001_initial','2019-01-09 13:48:06'),(4,'admin','0002_logentry_remove_auto_add','2019-01-09 13:48:06'),(5,'admin','0003_logentry_add_action_flag_choices','2019-01-09 13:48:06'),(6,'contenttypes','0002_remove_content_type_name','2019-01-09 13:48:14'),(7,'auth','0002_alter_permission_name_max_length','2019-01-09 13:48:19'),(8,'auth','0003_alter_user_email_max_length','2019-01-09 13:48:20'),(9,'auth','0004_alter_user_username_opts','2019-01-09 13:48:20'),(10,'auth','0005_alter_user_last_login_null','2019-01-09 13:48:31'),(11,'auth','0006_require_contenttypes_0002','2019-01-09 13:48:31'),(12,'auth','0007_alter_validators_add_error_messages','2019-01-09 13:48:31'),(13,'auth','0008_alter_user_username_max_length','2019-01-09 13:48:36'),(14,'auth','0009_alter_user_last_name_max_length','2019-01-09 13:48:48'),(15,'sessions','0001_initial','2019-01-09 13:48:53'),(16,'home','0001_initial','2019-01-09 15:36:52'),(17,'home','0002_userprofile','2019-01-10 05:44:46'),(18,'home','0003_userprofile_creditcardexpirationdate','2019-01-10 05:45:35'),(19,'home','0004_userprofile_creditcardtype','2019-01-10 05:47:39'),(21,'home','0005_stationstable','2019-01-24 08:56:42'),(22,'home','0006_station','2019-01-24 08:56:43'),(23,'home','0007_bike_biketype','2019-01-24 08:56:43'),(24,'home','0008_statusofbike_typeofbike','2019-01-24 08:56:43'),(25,'home','0009_auto_20190121_0954','2019-01-24 08:56:43'),(26,'home','0010_auto_20190123_2233','2019-01-24 08:56:43');
UNLOCK TABLES;

DROP TABLE IF EXISTS `django_session`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

LOCK TABLES `django_session` WRITE;
INSERT INTO `django_session` VALUES ('0hxedk42y5f7gcmxwkul9quhnk9a61ry','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-02-14 18:52:54'),('0myxxuy9o203jt8tzc008f6pobn44lt7','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-01-28 05:37:55'),('0njrnwa01p4jbkhyz13sko8l90s6z5pz','YTFjYzliYzIxNmRkN2ExZjRlYTc1YzZhYWViYjI0MzZjYmViN2QwMDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNhOGYzMDM5YjI4N2UwMzJmYjI1MWVjOGRiNjQyZTI4YWVlMjhjZjciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-02-23 18:45:36'),('14dlm19t0jjw3ka286ijox1333qduza2','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-01-24 18:43:10'),('1wnwc71i3hq0efjev9x4ic8v6eca7r67','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-24 13:59:57'),('4f4l66d6fklyosr0vwi3czeq4fao76gf','YjVhNzQ4YjM5NzExMjAxZDFjNTNlYjA2MzM5MDZmMzU5ZWIwYTk0Nzp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ2ZWNiZmZlODAzOWI0ODg3MDNlMDM2YjgyNmJhNDZjYTUyY2UxNmYiLCJfYXV0aF91c2VyX2lkIjoiMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-02-22 11:37:46'),('658uyo2ex2bv04rvnvwgyijrlm5i3b9v','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-23 11:34:01'),('6rmamyim14kkml4pwn8tjq621kdqfzxh','NThkZmU2Y2QxZDcxY2Q3NGU5NTdkYTcyZWY0NDA2Y2E1MjE1ZTQ3NDp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfaGFzaCI6IjhkMTRhOTcwMDNiNDI1MjQ2ZjE5Y2FjNWU3YWUyNTJlNGE1N2UwZTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-03-01 19:51:09'),('9vkev3fy4mv1txtjj6mpguy80ncx33y7','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-24 16:34:27'),('aoh953przl3evcsjt0eqg2jlupfdqf0s','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-27 20:14:04'),('b7k57bkafg9tksl3c1m71e0vtwhg7bbk','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-21 08:18:01'),('b9wyjpmgq9tfpttlnx112gb1l7gc8ke9','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 19:54:48'),('brtvshmt7rkk799idoscrw6cn37mvmoq','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-02-21 14:21:07'),('bu0fs3s34bk3kx1oj9mc6yt13wtk836n','YTFjYzliYzIxNmRkN2ExZjRlYTc1YzZhYWViYjI0MzZjYmViN2QwMDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNhOGYzMDM5YjI4N2UwMzJmYjI1MWVjOGRiNjQyZTI4YWVlMjhjZjciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2019-03-08 09:20:54'),('bx0a2gcxuljx0sdtvdch5w3njhavn8us','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 20:29:16'),('gar08a33b9mccz1xxhavzr3yyg8zwf2y','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-03-03 11:36:02'),('gcnx29vwsd0ayfl4vw7r7hl4kgfnp8y1','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-07 10:02:34'),('i79vlhwu6krwohzvvy5u02dsmn1ho2mu','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-03-11 07:54:58'),('l2g64jkxzx1f7sypkm94ax6wl4e2cpon','MWQzYzdjZjM2ZWVkMWFkYTdiZmU4ZTM0Njg4OWRiYjNkMDZiMmQwNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDZlY2JmZmU4MDM5YjQ4ODcwM2UwMzZiODI2YmE0NmNhNTJjZTE2ZiJ9','2019-02-22 20:31:20'),('lnmcidfh8r3hnsfcx98jkvz0827eh4x7','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-01-27 02:49:23'),('luptrct3k2pgvkfzp9vje79dj4dsn2xt','YjA3NzhmMWUzMDMwYmYyNTk2MjBjYTM0ZWZiN2E0ZTc5MTc1ZmE2NTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ2ZWNiZmZlODAzOWI0ODg3MDNlMDM2YjgyNmJhNDZjYTUyY2UxNmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxMyJ9','2019-02-24 14:16:49'),('m1nobez33qf9248al38uwq3g8c5jgfeh','ZDVlY2Q4M2NiZGM1OWZlYjA2OTk4YzZhODAyMTFkZTgyYTc4M2U2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyIsIl9hdXRoX3VzZXJfaWQiOiIxMCJ9','2019-02-23 12:43:08'),('nxh3c915d5z0a6knisjbu7dn7p1v2or9','N2I4ZTk2MDA3YjA1NjE5NmMzYWUyNDIwZjMwMTJhNTU3ZDc4NzVmZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmZkYTFjNDI4MDhiNjYwY2JiNTIyYjg3Y2IxZDJkNTEwMjI5Y2JiNSIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2019-03-03 18:33:31'),('tp6m83sj3w5tvfet5syafvreiv7lfgli','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-23 11:34:01'),('woi7qlqef931suyd2sfuh3ibkkfpvdgc','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-02-21 02:18:23'),('zjok5mt2pis9qu91jpaf7lrtirgf6nw1','MDczMWI0ZTYwMzFjNjNiOTk3OGQxMzBmZWYzZGM5OTJlNjRjMDYxODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxNGE5NzAwM2I0MjUyNDZmMTljYWM1ZTdhZTI1MmU0YTU3ZTBlNCIsIl9hdXRoX3VzZXJfaWQiOiIxMSJ9','2019-02-24 18:46:19');
UNLOCK TABLES;

DROP TABLE IF EXISTS `stationroutes`;
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 ;

LOCK TABLES `stationroutes` WRITE;
INSERT INTO `stationroutes` VALUES (1,1,1,1),(2,1,2,3.7),(3,1,3,2.7),(4,1,4,2),(5,1,5,4.7),(6,1,6,4.9),(7,1,7,4.2),(8,1,8,2.6),(9,1,9,2.8),(10,1,10,4.3),(11,2,1,3.7),(12,2,2,1),(13,2,3,1.4),(14,2,4,2.4),(15,2,5,2.9),(16,2,6,2.8),(17,2,7,4.4),(18,2,8,5.5),(19,2,9,4.1),(20,2,10,2.3),(21,3,1,2.7),(22,3,2,1.4),(23,3,3,1),(24,3,4,1.1),(25,3,5,2.1),(26,3,6,2.2),(27,3,7,2.8),(28,3,8,4.0),(29,3,9,2.9),(30,3,10,2.7),(31,4,1,2),(32,4,2,2.4),(33,4,3,1.1),(34,4,4,1),(35,4,5,2.6),(36,4,6,3.0),(37,4,7,2.2),(38,4,8,3.1),(39,4,9,2.8),(40,4,10,3.4),(41,5,1,4.7),(42,5,2,2.9),(43,5,3,2.1),(44,5,4,2.6),(45,5,5,1),(46,5,6,1),(47,5,7,2.0),(48,5,8,5.4),(49,5,9,5.0),(50,5,10,5.5),(51,6,1,4.9),(52,6,2,2.8),(53,6,3,2.2),(54,6,4,3),(55,6,5,1),(56,6,6,1),(57,6,7,2.7),(58,6,8,5.5),(59,6,9,6.8),(60,6,10,5.0),(61,7,1,4.2),(62,7,2,4.4),(63,7,3,2.8),(64,7,4,2.2),(65,7,5,2.0),(66,7,6,2.7),(67,7,7,1),(68,7,8,3.6),(69,7,9,4.9),(70,7,10,7.4),(71,8,1,2.6),(72,8,2,5.5),(73,8,3,4.0),(74,8,4,3.1),(75,8,5,5.4),(76,8,6,5.5),(77,8,7,3.6),(78,8,8,1),(79,8,9,5.8),(80,8,10,6.3),(81,9,1,2.8),(82,9,2,4.1),(83,9,3,2.9),(84,9,4,2.8),(85,9,5,5.0),(86,9,6,6.8),(87,9,7,4.9),(88,9,8,5.8),(89,9,9,1),(90,9,10,1.8),(91,10,1,4.3),(92,10,2,2.3),(93,10,3,2.7),(94,10,4,3.4),(95,10,5,5.5),(96,10,6,5.0),(97,10,7,7.4),(98,10,8,6.3),(99,10,9,1.8),(100,10,10,1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `station_on_reservation`;
SET character_set_client = utf8mb4 ;
CREATE TABLE `station_on_reservation` (
  `sor_route_id` int(11) NOT NULL,
  `sor_reservation_id` int(11) NOT NULL,
  PRIMARY KEY (`sor_route_id`,`sor_reservation_id`),
  KEY `fk_sor_reservation_id` (`sor_reservation_id`),
  CONSTRAINT `fk_sor_reservation_id` FOREIGN KEY (`sor_reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_sor_route_id` FOREIGN KEY (`sor_route_id`) REFERENCES `stationroutes` (`route_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

DROP TABLE IF EXISTS `contactUs`;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `contactUs` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `fn` varchar(30) NOT NULL,
  `ln` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `message` varchar(200) NOT NULL,
  PRIMARY KEY (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
