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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$kCJBCXnabLY4$xNxqQ6/JqmFgcz3hEmqJdVPwCtH9nsrCPv+CLi70sVA=','2019-01-12 13:25:15.362509',1,'tootyredsuperuser','','','tootyredsuperuser@superuser.com',1,1,'2019-01-10 05:02:00.527453'),(10,'pbkdf2_sha256$120000$0ATBH3RyTMRt$16qW0g5mm2t+POuN49OiT2PETodgoWnYtaMmrDpBUsU=','2019-01-14 05:37:54.813794',0,'sarahm13654','sarah','marium','sarahm13654@gmail.com',0,1,'2019-01-12 13:26:13.805550');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-10 06:08:21.187311','2','test',1,'[{\"added\": {}}]',4,1),(2,'2019-01-10 06:12:40.723125','3','testing',1,'[{\"added\": {}}]',4,1),(3,'2019-01-10 06:12:51.838719','1','UserProfile object (1)',3,'',8,1),(4,'2019-01-10 06:13:11.797289','2','test',3,'',4,1),(5,'2019-01-10 06:13:11.977301','3','testing',3,'',4,1),(6,'2019-01-10 08:09:37.662283','4','test1',3,'',4,1),(7,'2019-01-10 08:09:37.826200','5','test2',3,'',4,1),(8,'2019-01-10 08:32:58.051430','6','test1',3,'',4,1),(9,'2019-01-11 14:33:37.709782','7','sarahm@gmail.com',3,'',4,1),(10,'2019-01-12 13:25:40.345624','8','sarahm13654',3,'',4,1),(11,'2019-01-12 13:25:40.519376','9','sarahm1365429',3,'',4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ;
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
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 ;
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
INSERT INTO `django_session` VALUES ('0hxedk42y5f7gcmxwkul9quhnk9a61ry','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-02-14 18:52:54.266709'),('0myxxuy9o203jt8tzc008f6pobn44lt7','NjkxMThjYWI4NTk5MzRkODE5ZTkyNDIxN2QxNmZjMWJjODg3NDMxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2E4ZjMwMzliMjg3ZTAzMmZiMjUxZWM4ZGI2NDJlMjhhZWUyOGNmNyJ9','2019-01-28 05:37:54.969756'),('14dlm19t0jjw3ka286ijox1333qduza2','MmU1NTc2YjAxODdiYmZkZTQ1NWQyMmFkZDQ3ZGFhM2M5NTRmZDdkYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2ZmRhMWM0MjgwOGI2NjBjYmI1MjJiODdjYjFkMmQ1MTAyMjljYmI1In0=','2019-01-24 18:43:09.941549'),('lnmcidfh8r3hnsfcx98jkvz0827eh4x7','ZjE4ZWNiNjE5ZDY4NzcwOWMzODY0MDAyMzRjY2IyZTIyZjE2ODFkMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTJiODNiNTJjZjMyMDk1NzhlZjM2YTk1Mzk4NzFlODYwYzVlODJkNyJ9','2019-01-27 02:49:23.097662');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_userprofile`
--

LOCK TABLES `home_userprofile` WRITE;
/*!40000 ALTER TABLE `home_userprofile` DISABLE KEYS */;
INSERT INTO `home_userprofile` VALUES (8,'',10,NULL,NULL);
/*!40000 ALTER TABLE `home_userprofile` ENABLE KEYS */;
UNLOCK TABLES;



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

-- Dump completed on 2019-01-14 10:42:27


CREATE TABLE acc_status(
acc_status_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(20) NOT NULL
)ENGINE = INNODB;


CREATE TABLE customer(
customer_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
cfirst_name VARCHAR(20) NOT NULL,
clast_name VARCHAR(20) NOT NULL,
c_email VARCHAR(20) NOT NULL,
c_contact_no int(11) NOT NULL,
c_username VARCHAR(20) NOT NULL UNIQUE,
c_password VARCHAR(20) NOT NULL,
c_acc_status ENUM('active', 'blocked'),
c_acc_creation_date DATETIME
CONSTRAINT fk_c_acc_status_id FOREIGN KEY (c_acc_status) REFERENCES acc_status(acc_status_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;



CREATE TABLE operator(
operator_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
ofirst_name VARCHAR(20) NOT NULL,
olast_name VARCHAR(20) NOT NULL,
o_email VARCHAR(20) NOT NULL,
o_contact_no int(11) NOT NULL,
o_username VARCHAR(20) NOT NULL UNIQUE,
o_password VARCHAR(20) NOT NULL
)ENGINE = INNODB;



CREATE TABLE manager(
manager_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
mfirst_name VARCHAR(20) NOT NULL,
mlast_name VARCHAR(20) NOT NULL,
m_email VARCHAR(20) NOT NULL,
m_contact_no int(11) NOT NULL,
m_username VARCHAR(20) NOT NULL UNIQUE,
m_password VARCHAR(20) NOT NULL
)ENGINE = INNODB;

-- we might not use this one since svet said we aint storing credit card details but ill include it just in case
CREATE TABLE creditcardinfo(
card_id INTEGER(5) AUTO_INCREMENT PRIMARY KEY,
card_info INTEGER(16) NOT NULL,
card_exp_date DATE NOT NULL
)ENGINE = INNODB;

CREATE TABLE complaints(
complaint_id INTEGER(5) AUTO_INCREMENT PRIMARY KEY,
complaint_type VARCHAR(20) NOT NULL,
complaint_desc VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE reservation_type(
res_type_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
res_type_name VARCHAR(20) NOT NULL
)ENGINE = INNODB;

CREATE TABLE equipment_gear(
gear_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
gear_name VARCHAR(20) NOT NULL,
gear_cost INTEGER(11) NOT NULL
)ENGINE = INNODB;

CREATE TABLE customer_rating(
rating_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
rating_value INTEGER(1) NOT NULL
)ENGINE = INNODB;

CREATE TABLE reservation(
reservation_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
res_type INTEGER(11) NOT NULL,
res_cost INTEGER(11) NOT NULL,
gear_type INTEGER(11) NOT NULL,
res_date VARCHAR(50) NOT NULL,
starttime DATETIME NOT NULL,
endtime DATETIME NOT NULL,
totalduration INTEGER(5) NOT NULL,
c_rating INTEGER(11),
CONSTRAINT fk_res_type FOREIGN KEY (res_type) REFERENCES reservation_type(res_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_gear_type FOREIGN KEY (gear_type) REFERENCES equipment_gear(gear_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_c_rating FOREIGN KEY (c_rating) REFERENCES customer_rating(rating_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;


CREATE TABLE station(
station_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(100) NOT NULL,
rack_capacity INTEGER(11) NOT NULL,
num_racks_available INTEGER(11) NOT NULL,
info VARCHAR(100) NOT NULL,
name VARCHAR(50) NOT NULL,
lon DECIMAL(30,16) NOT NULL,
lat DECIMAL(30,15) NOT NULL,
is_active BOOLEAN NOT NULL,
image VARCHAR(30) NOT NULL,
fine_cost DECIMAL(11,2), -- can be null if no fine, combined the fine table from the er diagram into the station since its a one to one relationship anyways
fine_desc VARCHAR(50)
)ENGINE = INNODB;

INSERT INTO `station` (lon,address,rack_capacity,name,lat,num_racks_available,image,info,is_active) VALUES
  (-3.21358,'1 Greenbank Cres, Edinburgh EH10 5TE, UK',15,'Braidburn Valley Park',55.9191,7,'BraidburnValleyPark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.21438,'Edinburgh EH3 5PA, UK',15,'Inverleith Park',55.96653,7,'inverleithpark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.19839,'Princes St, Edinburgh EH2 2HG, UK',15,'Princes Street Gardens',55.951752,7,'princesstreetgardens.jpg','THIS IS THE INFO PART',TRUE),
  (-3.19186,'Melville Dr, Edinburgh EH9 1ND, UK',12,'The Meadows',55.93994,7,'themeadows.JPG','THIS IS THE INFO PART',TRUE),
  (-3.15847,'Lochend Rd S, Edinburgh EH7 6BP, UK',25,'Lochend Park',55.96131,10,'lochendpark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.16212,'Links Gardens, Edinburgh EH6 7QR, UK',8,'Leith Links',55.97174,3,'leithlinks.png','THIS IS THE INFO PART',TRUE),
  (-3.14636,'Old Church Ln, Duddingston Village, Edinburgh EH15 3PX, UK',15,'Dr Neil''s Garden',55.94172,7,'DrNeilGarden.jpg','THIS IS THE INFO PART',TRUE),
  (-3.16834,'Stanedykehead, Alnwickhill EH16 6TN, UK',15,'Seven Acre Park',55.90584,7,'SevenAcrePark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.248529,'1 Greenbank Cres, Edinburgh EH10 5TE, UK',15,'Saughton Park And Gardens',55.934132,7,'SaughtonParkAndGardens.jpg','THIS IS THE INFO PART',TRUE),
  (-3.30343,'73 Glasgow Rd, Edinburgh EH12 8LJ, UK',15,'Gyle Park',55.94155,7,'GylePark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.13123,'Mountcastle Dr N, Edinburgh EH8 7SE, UK',12,'Figgate Park',55.95157,5,'figgatepark.jpg','THIS IS THE INFO PART',TRUE),
  (-3.30092,'32 Barnton Ave, Edinburgh EH4 6JH, UK',15,'The Bruntsfield Links Golfing Society',55.96843,7,'TheBruntsfieldLinksGolfing.jpg','THIS IS THE INFO PART',TRUE),
  (-3.25772,'24 Ravelston Dykes Rd, Edinburgh EH4 3NZ, UK',15,'Ravelston Golf Club',55.95435,7,'ravelstongolfclub.jpg','THIS IS THE INFO PART',TRUE),
  (-3.13853,'Craigmillar Castle Rd, Edinburgh EH16 4SY, UK',10,'Craigmillar Castle',55.92638,4,'craigmillarcastle.jpg','THIS IS THE INFO PART',TRUE);

CREATE TABLE checkuplog(
 clog_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
 clog_count INTEGER(11) NOT NULL,
 checkup_date DATETIME NOT NULL,
 checkup_desc VARCHAR(50) NOT NULL,
 checkuplog_station_id INTEGER(11) NOT NULL,
 CONSTRAINT fk_checkuplog_station_id FOREIGN KEY (checkuplog_station_id) REFERENCES station(station_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;



CREATE TABLE stationfootage(
footage_id INTEGER(5) AUTO_INCREMENT PRIMARY KEY,
footage_date VARCHAR(20) NOT NULL,
footage_link VARCHAR(20) NOT NULL,
footage_station_id INTEGER(11) NOT NULL,
CONSTRAINT fk_footage_station_id FOREIGN KEY (footage_station_id) REFERENCES station(station_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;

CREATE TABLE type_of_bike(
bike_type_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
bike_info VARCHAR(100) NOT NULL,
bike_model VARCHAR(20) NOT NULL, -- im not sure what we refered "bike model" in the requirements, but if its the brand for the bike, then just change to ENUM and put your values on it
bike_type VARCHAR(20) NOT NULL, -- used this website for the types, add or remove values if you want https://thebicycleescape.com/resources/types-of-bikes/
bike_cost DECIMAL(11,2) NOT NULL,
bike_image VARCHAR(30) NOT NULL
)ENGINE = INNODB;

INSERT INTO `type_of_bike` (bike_info,bike_model,bike_type,bike_cost,bike_image) VALUES
  ('This is the info about the bike','Shimano XT','Mountain Bike',2,'shimano.jpg'),
  ('Size weight blah blahThis is the info about the bike','Fuji X','Tandem Bike',4,'tandem.png'),
  ('This is the info about the bike','Fuji Crank T ','Road Bike',1.25,'fui.png'),
  ('This is the info about the bike','VeloPlus','Wheelchair Bike',3.5,'veloplus.png');

CREATE TABLE status_of_bike(
  bike_status_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
  bike_status_name VARCHAR(20) NOT NULL
  )ENGINE = INNODB;

CREATE TABLE bike(
bike_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
bike_type INTEGER(11) NOT NULL, -- im not sure what we refered "bike model" in the requirements, but if its the brand for the bike, then just change to ENUM and put your values on it
travel_count DECIMAL(8,2) NOT NULL, -- up to you to what you want this to be (km, miles, etc), also change the values for decimal to your liking
bike_status INTEGER(11) NOT NULL,
bike_stationedat INTEGER(11),
CONSTRAINT fk_bike_station_id FOREIGN KEY (bike_stationedat) REFERENCES station(station_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_bike_type FOREIGN KEY (bike_type) REFERENCES type_of_bike(bike_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_bike_status FOREIGN KEY (bike_status) REFERENCES status_of_bike(bike_status_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;

CREATE TABLE maintenancelog(
 mlog_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
 mlog_count INTEGER(11) NOT NULL,
 maintenance_date DATETIME NOT NULL,
 maintenance_desc VARCHAR(50) NOT NULL,
 mechanic_name VARCHAR(50)  NOT NULL, -- dont know if we need this but i added it just in case, delete if you want to
 maintenance_bike_id INTEGER(11) NOT NULL,
 CONSTRAINT fk_maintenance_bike_id FOREIGN KEY (maintenance_bike_id) REFERENCES bike(bike_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;

CREATE TABLE bike_on_reservation(
bor_bike_id INTEGER(11) NOT NULL,
bor_reservation_id INTEGER(11) NOT NULL,
PRIMARY KEY (bor_bike_id, bor_reservation_id),
CONSTRAINT fk_bor_bike_id FOREIGN KEY (bor_bike_id) REFERENCES bike(bike_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_bor_reservation_id FOREIGN KEY (bor_reservation_id) REFERENCES reservation(reservation_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;

CREATE TABLE station_on_reservation(
sor_start_station_id INTEGER(11) NOT NULL,
sor_end_station_id INTEGER(11) NOT NULL,
sor_reservation_id INTEGER(11) NOT NULL,
PRIMARY KEY (sor_start_station_id, sor_end_station_id, sor_reservation_id),
CONSTRAINT fk_start_station_id FOREIGN KEY (sor_start_station_id) REFERENCES station(station_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_end_station_id FOREIGN KEY (sor_end_station_id) REFERENCES station(station_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_sor_reservation_id FOREIGN KEY (sor_reservation_id) REFERENCES reservation(reservation_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE = INNODB;
