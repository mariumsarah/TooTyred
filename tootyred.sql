-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: tootyred
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add users',7,'add_users'),(26,'Can change users',7,'change_users'),(27,'Can delete users',7,'delete_users'),(28,'Can view users',7,'view_users'),(29,'Can add user profile',8,'add_userprofile'),(30,'Can change user profile',8,'change_userprofile'),(31,'Can delete user profile',8,'delete_userprofile'),(32,'Can view user profile',8,'view_userprofile');
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
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$kCJBCXnabLY4$xNxqQ6/JqmFgcz3hEmqJdVPwCtH9nsrCPv+CLi70sVA=','2019-01-10 18:43:09.815640',1,'tootyredsuperuser','','','tootyredsuperuser@superuser.com',1,1,'2019-01-10 05:02:00.527453');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-10 06:08:21.187311','2','test',1,'[{\"added\": {}}]',4,1),(2,'2019-01-10 06:12:40.723125','3','testing',1,'[{\"added\": {}}]',4,1),(3,'2019-01-10 06:12:51.838719','1','UserProfile object (1)',3,'',8,1),(4,'2019-01-10 06:13:11.797289','2','test',3,'',4,1),(5,'2019-01-10 06:13:11.977301','3','testing',3,'',4,1),(6,'2019-01-10 08:09:37.662283','4','test1',3,'',4,1),(7,'2019-01-10 08:09:37.826200','5','test2',3,'',4,1),(8,'2019-01-10 08:32:58.051430','6','test1',3,'',4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'home','userprofile'),(7,'home','users'),(6,'sessions','session');
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
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-01-09 13:47:15.448537'),(2,'auth','0001_initial','2019-01-09 13:47:55.538450'),(3,'admin','0001_initial','2019-01-09 13:48:05.896131'),(4,'admin','0002_logentry_remove_auto_add','2019-01-09 13:48:06.041491'),(5,'admin','0003_logentry_add_action_flag_choices','2019-01-09 13:48:06.174982'),(6,'contenttypes','0002_remove_content_type_name','2019-01-09 13:48:14.386457'),(7,'auth','0002_alter_permission_name_max_length','2019-01-09 13:48:19.254579'),(8,'auth','0003_alter_user_email_max_length','2019-01-09 13:48:20.016108'),(9,'auth','0004_alter_user_username_opts','2019-01-09 13:48:20.113928'),(10,'auth','0005_alter_user_last_login_null','2019-01-09 13:48:31.244265'),(11,'auth','0006_require_contenttypes_0002','2019-01-09 13:48:31.323119'),(12,'auth','0007_alter_validators_add_error_messages','2019-01-09 13:48:31.472839'),(13,'auth','0008_alter_user_username_max_length','2019-01-09 13:48:36.139624'),(14,'auth','0009_alter_user_last_name_max_length','2019-01-09 13:48:48.318172'),(15,'sessions','0001_initial','2019-01-09 13:48:52.593941'),(16,'home','0001_initial','2019-01-09 15:36:51.572408'),(17,'home','0002_userprofile','2019-01-10 05:44:46.392227'),(18,'home','0003_userprofile_creditcardexpirationdate','2019-01-10 05:45:35.366400'),(19,'home','0004_userprofile_creditcardtype','2019-01-10 05:47:39.365758');
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
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('14dlm19t0jjw3ka286ijox1333qduza2','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-01-24 18:43:09.941549');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `example`
--

DROP TABLE IF EXISTS `example`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `example` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_userprofile`
--

LOCK TABLES `home_userprofile` WRITE;
/*!40000 ALTER TABLE `home_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `home_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stationstable`
--

DROP TABLE IF EXISTS `stationstable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stationstable` (
  `lon` decimal(30,16) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `lat` decimal(30,15) DEFAULT NULL,
  `num_bikes_available` int(11) DEFAULT NULL,
  `last_reported` int(11) DEFAULT NULL,
  `is_installed` bit(1) DEFAULT NULL,
  `num_docks_available` int(11) DEFAULT NULL,
  `station_id` int(11) DEFAULT NULL,
  `is_renting` bit(1) DEFAULT NULL,
  `is_returning` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stationstable`
--

LOCK TABLES `stationstable` WRITE;
/*!40000 ALTER TABLE `stationstable` DISABLE KEYS */;
INSERT INTO `stationstable` VALUES (-3.1883110727223993,'George Square',25,'George Square',55.943084063011130,10,1547134338,_binary '',9,171,_binary '',_binary ''),(-3.1914209989898836,'Waverley Bridge',19,'Waverley Bridge',55.951344398844620,4,1547134338,_binary '',15,183,_binary '',_binary ''),(-3.1902577700938080,'High Street',14,'City Chambers',55.950109330178990,4,1547134338,_binary '',9,189,_binary '',_binary ''),(-3.1841785354060903,'Waverley Court, East Market Street',7,'Waverley Court',55.951734496983440,4,1547134338,_binary '',2,225,_binary '',_binary ''),(-3.1739235543155930,'Dalkeith Road, Edinburgh EH16 5BB',10,'Royal Commonwealth Pool',55.939000247888764,2,1547134338,_binary '',8,246,_binary '',_binary ''),(-3.2071011721072864,'Charlotte Square',13,'Charlotte Square',55.952335461616390,0,1547134338,_binary '',11,247,_binary '',_binary ''),(-3.1886654928728150,'Bristo Square, Potterrow',37,'Bristo Square',55.946004189640780,5,1547134338,_binary '',31,248,_binary '',_binary ''),(-3.2092475016246453,'116 Fountainbridge',10,'Fountainbridge',55.943356927645510,2,1547134338,_binary '',7,249,_binary '',_binary ''),(-3.1741155906215680,'Entrance to Scottish Government Office',13,'Victoria Quay',55.977637787726984,4,1547134338,_binary '',6,250,_binary '',_binary ''),(-3.1875269194623570,'Waverley Station Concourse',16,'Waverley Station',55.952641035774384,11,1547134338,_binary '',4,251,_binary '',_binary ''),(-3.1738308300878090,'James Hutton Road',7,'Kings Buildings 1',55.924185406676960,4,1547134338,_binary '',3,252,_binary '',_binary ''),(-3.1716462453634904,'Entrance to Sanderson Building',10,'Kings Building 2',55.923202155166640,1,1547134338,_binary '',8,253,_binary '',_binary ''),(-3.1753845849070785,'James Dewar Road',26,'Kings Building 3',55.923478807846635,10,1547134338,_binary '',16,254,_binary '',_binary ''),(-3.1769018141649212,'Kings Buildings Bus Stop and turning circle',7,'Kings Buildings 4',55.922000870606260,2,1547134338,_binary '',5,255,_binary '',_binary ''),(-3.1816823409318430,'Regent Road',16,'St Andrews House',55.953164332423840,7,1547134338,_binary '',9,256,_binary '',_binary ''),(-3.1168881187301167,'Westbank Street',13,'Portobello',55.957004308392506,7,1547134338,_binary '',4,257,_binary '',_binary ''),(-3.2080701822277433,'1, Dean Bank Lane',7,'Stockbridge',55.958565585897230,3,1547134338,_binary '',1,258,_binary '',_binary ''),(-3.1927736686587878,'St Andrew Square',10,'St Andrew Square',55.954748812176420,2,1547134338,_binary '',7,259,_binary '',_binary ''),(-3.1972658564195626,'Lauriston Place',16,'Lauriston Place',55.944771652335476,7,1547134338,_binary '',9,260,_binary '',_binary ''),(-3.1810053147805775,'Junction Brunswick Street and Elm Row',13,'Brunswick Place',55.960929747664000,7,1547134338,_binary '',3,261,_binary '',_binary ''),(-3.1962835850629290,'Broughton Road',10,'Canonmills',55.962804087597640,5,1547134338,_binary '',3,262,_binary '',_binary ''),(-3.1715859343115653,'18 Holyrood Park Road',13,'Pollock Halls',55.939963469723715,5,1547134338,_binary '',7,264,_binary '',_binary ''),(-3.1827388507464320,'Between Melville Terrace and Sciennes',13,'Meadows East',55.939809466328285,6,1547134338,_binary '',4,265,_binary '',_binary ''),(-3.1794726703882360,'Albert Place',15,'Shrubhill',55.962537272461360,5,1547134338,_binary '',3,273,_binary '',_binary ''),(-3.2036782907171073,'Riego Street',30,'Riego Street',55.945159896857184,3,1547134338,_binary '',20,275,_binary '',_binary ''),(-3.2234280553759618,'Near Waitrose Car Park Entrance',20,'Waitrose, Comely Bank',55.959504176688824,7,1547134338,_binary '',9,277,_binary '',_binary ''),(-3.1668846170233564,'Vanburgh Place',37,'Leith Links',55.969198569109540,9,1547134338,_binary '',17,284,_binary '',_binary ''),(-3.1763512638052590,'Ocean Drive',25,'Ocean Terminal',55.981286014792985,7,1547134338,_binary '',14,285,_binary '',_binary ''),(-3.2031839065252825,'Castle Street',19,'Castle Street',55.951500737349754,6,1547134338,_binary '',13,289,_binary '',_binary ''),(-3.2064353296459560,'Corner of Bruntsfield Terrace',13,'Bruntsfield',55.937158712766770,1,1547134338,_binary '',8,290,_binary '',_binary ''),(-3.2020378290551434,'Lady Lawson Street',13,'Castle Terrace',55.946766486722390,1,1547134338,_binary '',11,296,_binary '',_binary ''),(-3.1335103358171637,'Little France',16,'Royal Infirmary',55.924295174984614,3,1547134338,_binary '',13,297,_binary '',_binary ''),(-3.1945919307650000,'Meadow Place',15,'Meadow Place',55.940300457434470,3,1547134338,_binary '',10,340,_binary '',_binary ''),(-3.1980311823861030,'Warrender Park Road',27,'Warrender Park Road',55.938363058645024,4,1547134338,_binary '',18,341,_binary '',_binary ''),(-3.2022945366760496,'Whitehouse Loan',27,'Whitehouse Loan',55.936329049382870,6,1547134338,_binary '',19,342,_binary '',_binary ''),(-3.1986713267040160,'Thirlestane Road',32,'Thirlestane Road',55.935365108217170,2,1547134338,_binary '',30,343,_binary '',_binary ''),(-3.1942522028861050,'Marchmont Crescent',17,'Marchmont Crescent',55.936397496743666,1,1547134338,_binary '',15,344,_binary '',_binary ''),(-3.2108032288005006,'2 Colinton Road',25,'Colinton Road',55.934034801869515,3,1547134338,_binary '',22,345,_binary '',_binary ''),(-3.2097387366352450,'212 Morningside Road',15,'Morningside Road',55.927985513563130,9,1547134338,_binary '',2,346,_binary '',_binary ''),(-3.1826705111947150,'Simon Square',27,'Simon Square',55.944867799682754,7,1547134338,_binary '',18,347,_binary '',_binary ''),(-3.2236342639564555,'30 Queensferry Road',7,'Orchard Brae House',55.955082768790950,3,1547134338,_binary '',3,349,_binary '',_binary ''),(-3.2225242918653976,'Dalry Road',27,'Dalry Road Lidl',55.941754301444796,12,1547134338,_binary '',11,350,_binary '',_binary ''),(-3.2214309824260000,'Dalry road',15,'Dalry Road Co-op',55.942714715564190,9,1547134338,_binary '',3,351,_binary '',_binary ''),(-3.2206029955273150,'Dundee Terrace',22,'Dundee Terrace',55.939729424154630,7,1547134338,_binary '',11,352,_binary '',_binary ''),(-3.2171441917087122,'Gibson Terrace',17,'Gibson Terrace',55.940492621995680,0,1547134338,_binary '',10,353,_binary '',_binary ''),(-3.2078157175304796,'South Trinity Road',25,'South Trinity Road',55.971268912190844,11,1547134338,_binary '',10,354,_binary '',_binary ''),(-3.2020735606114386,'Inverleith Row',25,'Inverleith Row',55.964145597867244,11,1547134338,_binary '',11,355,_binary '',_binary ''),(-3.1873292019624840,'East London Street',25,'East London Street',55.959943391323520,4,1547134338,_binary '',17,356,_binary '',_binary ''),(-3.1851887678931234,'Macdonald Road',25,'Macdonald Road',55.963995150971236,3,1547134338,_binary '',19,357,_binary '',_binary ''),(-3.1766864147848537,'Leith Walk',25,'Leith Walk',55.965039805077320,17,1547134338,_binary '',5,358,_binary '',_binary ''),(-3.1996352215008983,'Lauriston Place',10,'Novotel',55.944896459715345,0,1547134338,_binary '',10,365,_binary '',_binary '');
/*!40000 ALTER TABLE `stationstable` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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

-- Dump completed on 2019-01-11  6:59:08
