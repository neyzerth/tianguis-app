-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: tianguisapp
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `code` varchar(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `disable` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('ALIME','Alimentos y Bebidas',0),('ARTES','Artesan√≠as',0),('ROPA','Ropa y Accesorios',0),('HOGAR','Hogar y Decoraci√≥n',0),('JARDI','Jardiner√≠a',0),('ELEC','Electronica',0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `item` bigint NOT NULL,
  `user` bigint NOT NULL,
  PRIMARY KEY (`item`,`user`),
  KEY `fk_Favorite_user` (`user`),
  CONSTRAINT `fk_Favorite_item` FOREIGN KEY (`item`) REFERENCES `item` (`id`),
  CONSTRAINT `fk_Favorite_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (2,2),(5,2),(4,3),(1,4),(3,4);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `url` varchar(514) NOT NULL,
  `order` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tianguis` bigint DEFAULT NULL,
  `item` bigint DEFAULT NULL,
  `stand` bigint DEFAULT NULL,
  `user` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Image_tianguis` (`tianguis`),
  KEY `fk_Image_item` (`item`),
  KEY `fk_Image_stand` (`stand`),
  KEY `fk_image_1_idx` (`user`),
  CONSTRAINT `fk_image_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_Image_item` FOREIGN KEY (`item`) REFERENCES `item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_stand` FOREIGN KEY (`stand`) REFERENCES `stand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_tianguis` FOREIGN KEY (`tianguis`) REFERENCES `tianguis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'1_item5.jpg',0,'2024-03-05 22:00:00',NULL,5,NULL,2),(2,'2_tacos1.jpg',1,'2024-05-03 17:00:00',NULL,1,NULL,1),(3,'3_tacos2.jpg',2,'2024-05-03 17:05:00',NULL,1,NULL,1),(4,'4_pulsera1.jpg',1,'2024-05-03 17:59:00',NULL,2,NULL,2),(5,'5_jeans1.jpg',1,'2024-05-03 19:00:00',NULL,3,NULL,3),(6,'6_sofa1.jpg',1,'2024-05-03 20:00:00',NULL,4,NULL,4),(7,'7_suculenta1.jpg',1,'2024-05-03 20:59:00',NULL,5,NULL,5),(8,'8_smartphone1.jpg',1,'2024-05-03 22:00:00',NULL,6,NULL,6),(9,'9_quesadillas1.jpg',1,'2024-05-03 23:00:00',NULL,7,NULL,1),(10,'10_collar1.jpg',1,'2024-05-03 23:59:00',NULL,8,NULL,2),(11,'11_playera1.jpg',1,'2024-05-04 01:00:00',NULL,9,NULL,3),(12,'12_tacos3.jpg',3,'2024-06-03 16:00:00',NULL,1,NULL,1),(13,'13_pulsera2.jpg',2,'2024-06-03 17:00:00',NULL,2,NULL,2),(14,'14_jeans2.jpg',2,'2024-06-03 17:59:00',NULL,3,NULL,3),(15,'15_sofa2.jpg',2,'2024-06-03 19:00:00',NULL,4,NULL,4),(16,'16_suculenta2.jpg',2,'2024-06-03 20:00:00',NULL,5,NULL,5),(17,'17_smartphone2.jpg',2,'2024-06-03 20:59:00',NULL,6,NULL,6),(18,'18_quesadillas2.jpg',2,'2024-06-03 22:00:00',NULL,7,NULL,1),(19,'19_collar2.jpg',2,'2024-06-03 23:00:00',NULL,8,NULL,2),(20,'20_playera2.jpg',2,'2024-06-03 23:59:00',NULL,9,NULL,3),(21,'21_maceta1.jpg',1,'2024-05-04 02:00:00',NULL,10,NULL,5),(22,'22_audifonos1.jpg',1,'2024-05-04 02:59:00',NULL,11,NULL,6),(23,'23_tamales1.jpg',1,'2024-05-04 04:00:00',NULL,12,NULL,1),(24,'24_aretes1.jpg',1,'2024-05-04 05:00:00',NULL,13,NULL,2),(25,'25_pantalones1.jpg',1,'2024-05-04 05:59:00',NULL,14,NULL,3),(26,'26_sabila1.jpg',1,'2024-06-03 14:59:00',NULL,15,NULL,5),(27,'27_tianguis_otay.jpg',1,'2024-05-03 17:00:00',1,NULL,NULL,1),(28,'28_tianguis_presa.jpg',1,'2024-05-03 17:59:00',2,NULL,NULL,1),(29,'29_tianguis_dominical.jpg',1,'2024-05-03 19:00:00',3,NULL,NULL,1),(30,'30_tianguis_la_bola.jpg',1,'2024-05-03 20:00:00',4,NULL,NULL,1),(31,'31_tianguis_salesianos.jpg',1,'2024-05-03 20:59:00',5,NULL,NULL,1),(32,'32_stand_antojitos.jpg',1,'2024-05-03 22:00:00',NULL,NULL,1,1),(33,'33_stand_artesanias.jpg',1,'2024-05-03 23:00:00',NULL,NULL,2,1),(34,'34_stand_plantas.jpg',1,'2024-05-03 23:59:00',NULL,NULL,5,1),(35,'35_stand_ropa.jpg',1,'2024-05-04 01:00:00',NULL,NULL,3,1),(36,'36_stand_muebles.jpg',NULL,'2024-05-04 02:00:00',NULL,NULL,4,1),(37,'37_stand_celuphones.jpg',NULL,'2024-05-04 02:59:00',NULL,NULL,6,1),(38,'38_jhondue.jpg',NULL,'2025-03-10 07:00:00',NULL,NULL,NULL,6),(39,'default.jpg',NULL,'2025-03-10 07:00:00',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` varchar(1028) DEFAULT NULL,
  `price` decimal(5,2) NOT NULL,
  `selled` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  `stand` bigint DEFAULT NULL,
  `owner` bigint NOT NULL,
  `status` varchar(5) DEFAULT NULL,
  `category` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Item_stand` (`stand`),
  KEY `fk_Item_category` (`category`),
  KEY `fk_Item_owner` (`owner`),
  KEY `fk_Item_status` (`status`),
  CONSTRAINT `fk_Item_category` FOREIGN KEY (`category`) REFERENCES `category` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_stand` FOREIGN KEY (`stand`) REFERENCES `stand` (`id`),
  CONSTRAINT `fk_Item_status` FOREIGN KEY (`status`) REFERENCES `status` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_suggestion`
--

DROP TABLE IF EXISTS `schedule_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_suggestion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `new_open_time` time DEFAULT NULL,
  `new_close_time` time DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `tianguis_suggestion` bigint NOT NULL,
  `user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_suggestion_user_idx` (`user`),
  KEY `fk_suggestion_schedule_idx` (`tianguis_suggestion`),
  CONSTRAINT `fk_suggestion_schedule` FOREIGN KEY (`tianguis_suggestion`) REFERENCES `tianguis_suggestion` (`id`),
  CONSTRAINT `fk_suggestion_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_suggestion`
--

LOCK TABLES `schedule_suggestion` WRITE;
/*!40000 ALTER TABLE `schedule_suggestion` DISABLE KEYS */;
INSERT INTO `schedule_suggestion` VALUES (1,'saturday','07:30:00','16:30:00','2024-03-05 10:00:00',1,2),(2,'wednesday','08:00:00','17:00:00','2024-03-05 11:00:00',2,4),(3,'monday','09:00:00','18:00:00','2024-03-06 11:00:00',2,4),(4,'tuesday','10:00:00','19:00:00','2024-03-07 11:00:00',2,4),(5,'sunday','11:00:00','20:00:00','2024-03-08 11:00:00',2,4);
/*!40000 ALTER TABLE `schedule_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stand`
--

DROP TABLE IF EXISTS `stand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` varchar(514) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  `owner` bigint NOT NULL,
  `category` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Stand_owner` (`owner`),
  KEY `fk_Stand_category` (`category`),
  KEY `idx_Stand_name` (`name`),
  CONSTRAINT `fk_Stand_category` FOREIGN KEY (`category`) REFERENCES `category` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stand`
--

LOCK TABLES `stand` WRITE;
/*!40000 ALTER TABLE `stand` DISABLE KEYS */;
INSERT INTO `stand` VALUES (1,'Antojitos Mar√≠a','Comida tradicional','2024-01-01 16:00:00',0,1,'ALIME'),(2,'Artesan√≠as M√©xico','Arte popular','2024-01-02 17:00:00',0,3,'ARTES'),(3,'Ropa Usada','Ropa de segunda mano','2024-01-03 18:00:00',0,6,'ROPA'),(4,'Muebles Viejitos','Muebles antiguos','2024-01-04 19:00:00',0,6,'HOGAR'),(5,'Plantas y M√°s','Vivero m√≥vil','2024-01-05 20:00:00',0,5,'JARDI'),(6,'Celuphones','Electronica y m√°s','2025-03-06 08:00:00',0,6,'ELEC');
/*!40000 ALTER TABLE `stand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stand_location`
--

DROP TABLE IF EXISTS `stand_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stand_location` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(500) DEFAULT NULL,
  `location` point NOT NULL /*!80003 SRID 4326 */,
  `tianguis_dependece` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  `tianguis` bigint DEFAULT NULL,
  `stand_info` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Stand_Location_tianguis` (`tianguis`),
  KEY `fk_Stand_Location_stand_info` (`stand_info`),
  KEY `idx_Stand_Location_address` (`address`),
  CONSTRAINT `fk_Stand_Location_stand_info` FOREIGN KEY (`stand_info`) REFERENCES `stand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_Location_tianguis` FOREIGN KEY (`tianguis`) REFERENCES `tianguis` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stand_location`
--

LOCK TABLES `stand_location` WRITE;
/*!40000 ALTER TABLE `stand_location` DISABLE KEYS */;
INSERT INTO `stand_location` VALUES (1,'Calle de la Industria 123 Local 1',_binary '\Ê\0\0\0\0\0˛\‘x\È&=]¿[B>\Ë\ŸD@@',1,'2024-03-05 18:00:00',0,1,1),(2,'Calle de la Industria 123 Local 2',_binary '\Ê\0\0\0\0\0öwú¢#=]¿\˜\‰a°\÷D@@',1,'2024-03-05 19:00:00',0,1,2),(3,'Avenida Tecnologico 456 Local 3',_binary '\Ê\0\0\0\0\0™`TR\'<]¿YÜ8\÷\≈E@@',1,'2024-03-05 20:00:00',0,2,5),(4,'Calle Fronteriza 789 Local 4',_binary '\Ê\0\0\0\0\0/\›$Å=]¿\HPD@@',1,'2024-03-05 21:00:00',0,2,4),(5,'Calle Fronteriza 789 Local 5',_binary '\Ê\0\0\0\0\0\ZQ\⁄|=]¿£í:MD@@',0,'2024-03-05 22:00:00',0,3,5),(6,'Calle Fronteriza 789 Local 6',_binary '\Ê\0\0\0\0\0\ZQ\⁄|=]¿£í:MD@@',0,'2024-03-06 22:00:00',0,3,1),(7,'Altiplano',_binary '\Ê\0\0\0\0\0\ZQ\⁄|=]¿£í:MD@@',0,'2024-03-07 22:00:00',0,5,6);
/*!40000 ALTER TABLE `stand_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stand_schedule`
--

DROP TABLE IF EXISTS `stand_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stand_schedule` (
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `stand` bigint NOT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  `tianguis_dependence` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`day`,`stand`),
  KEY `fk_schedule_stand_location_idx` (`stand`),
  CONSTRAINT `fk_schedule_stand_location` FOREIGN KEY (`stand`) REFERENCES `stand_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stand_schedule`
--

LOCK TABLES `stand_schedule` WRITE;
/*!40000 ALTER TABLE `stand_schedule` DISABLE KEYS */;
INSERT INTO `stand_schedule` VALUES ('monday',7,'07:00:00','18:00:00',0),('saturday',5,'10:00:00','17:00:00',0),('saturday',7,NULL,NULL,1),('sunday',5,'10:00:00','17:00:00',0),('sunday',6,NULL,NULL,1),('sunday',7,NULL,NULL,1);
/*!40000 ALTER TABLE `stand_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `code` varchar(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `disable` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestion_response`
--

DROP TABLE IF EXISTS `suggestion_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggestion_response` (
  `suggestion` bigint NOT NULL,
  `user` bigint NOT NULL,
  `approve` tinyint NOT NULL,
  PRIMARY KEY (`suggestion`,`user`),
  KEY `fk_tianguis_suggestion_idx` (`user`),
  CONSTRAINT `fk_suggestion_user_response` FOREIGN KEY (`suggestion`) REFERENCES `tianguis_suggestion` (`id`),
  CONSTRAINT `fk_tianguis_base_suggestion` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestion_response`
--

LOCK TABLES `suggestion_response` WRITE;
/*!40000 ALTER TABLE `suggestion_response` DISABLE KEYS */;
INSERT INTO `suggestion_response` VALUES (1,3,1),(1,5,1),(2,1,0),(2,3,1);
/*!40000 ALTER TABLE `suggestion_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tianguis`
--

DROP TABLE IF EXISTS `tianguis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tianguis` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `location` multilinestring NOT NULL /*!80003 SRID 4326 */,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_Tianguis_name` (`name`),
  KEY `idx_Tianguis_address` (`address`),
  SPATIAL KEY `idx_Tianguis_location` (`location`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tianguis`
--

LOCK TABLES `tianguis` WRITE;
/*!40000 ALTER TABLE `tianguis` DISABLE KEYS */;
INSERT INTO `tianguis` VALUES (1,'Tianguis Otay Centenario','Calle de la Industria 123 Otay Centenario',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0∞\Áå(=]¿\˜\‰a°\÷D@@\ÈH.ˇ!=]¿æü\Z/\›D@@Ö\ÎQ∏=]¿îáÖZ\”D@@','2024-03-05 18:00:00','2024-03-05 18:00:00',0),(2,'Mercado La Presa','Avenida Tecnologico 456 La Presa',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0æ0ô*<]¿\ˆ(\\è\¬E@@˘1\ÊÆ%<]¿Ω\„\…E@@„•õ\ƒ <]¿í\ÀHøE@@','2024-03-05 19:00:00','2024-03-05 19:00:00',0),(3,'Tianguis Dominical Otay','Calle Fronteriza 789 Otay',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0ì:MÑ=]¿£í:MD@@\ÃHø}=]¿jM\ÛéSD@@∂\Û˝\‘x=]¿?5^∫ID@@','2024-03-05 20:00:00','2024-03-05 20:00:00',0),(4,'Tianguis La Bola','Boulevard Altiplano Altiplano 22204',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ê£≤\‚ö6]¿RC\‡˙B@@0\Ÿ\Zl≥6]¿\ZœºΩC@@J›é¿6]¿b\‘\Œ\Í\'C@@∑âÆo\Œ6]¿8eDf9C@@dî\Û∏\ﬂ6]¿¥v\’fC@@2;S*\‰6]¿rê]\qC@@\Ë\ÛúT\Ï6]¿∂\È*FâC@@\0\0\0\0\0\0*u\“\’6]¿íÄ>C@@C∫ø\Õ6]¿\Ú©(IJC@@\0\0\0\0\0\020H\ÿ6]¿\¬\‰QcSC@@äq˝ˇ\“6]¿\ø\ı£ZC@@\0\0\0\0\0\0\°-b\‰6]¿\¯æ\‚qC@@F>\Á6]¿¢æ\0\ÒmC@@','2024-03-05 21:00:00','2024-03-05 21:00:00',0),(5,'Tianguis Salesianos','Av. Melchor Ocampo Valle Verde',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0P¯íŒ®6]¿\"çò¥A@@RNl.é7]¿x©#\«\ÃB@@\0\0\0\0\0\0\Ì\"-[u7]¿n\’√ÆB@@(\„K&k7]¿¸<l\\\∆B@@`sò\'Ç7]¿.\˜Wé\‚B@@\0\0\0\0\0\0\÷&±~k7]¿∞\Z\Ò∏¢B@@CÖå\n7]¿¿∂öiöB@@\0\0\0\0\0\0$a`s7]¿\Ï˝?W´B@@vL9îx7]¿W…ΩûB@@\0\0\0\0\0\0\“+–≠z7]¿tæµB@@é~ª\∆}7]¿j∏]t≠B@@\0\0\0\0\0\0¶k4Ç7]¿vG\˜æB@@\◊bﬁÉ7]¿¥\È.y∫B@@','2024-03-05 22:00:00','2024-03-05 22:00:00',0);
/*!40000 ALTER TABLE `tianguis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tianguis_schedule`
--

DROP TABLE IF EXISTS `tianguis_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tianguis_schedule` (
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL,
  `tianguis` bigint NOT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  PRIMARY KEY (`day`,`tianguis`),
  KEY `idx_Schedule_Day_day` (`day`),
  KEY `fk_Schedule_Day_tianguis` (`tianguis`),
  CONSTRAINT `fk_Schedule_Day_tianguis` FOREIGN KEY (`tianguis`) REFERENCES `tianguis` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tianguis_schedule`
--

LOCK TABLES `tianguis_schedule` WRITE;
/*!40000 ALTER TABLE `tianguis_schedule` DISABLE KEYS */;
INSERT INTO `tianguis_schedule` VALUES ('monday',1,'07:00:00','16:00:00'),('monday',2,'12:00:00','21:00:00'),('monday',4,'09:00:00','17:00:00'),('wednesday',4,'09:00:00','17:00:00'),('friday',1,'07:00:00','16:00:00'),('friday',5,'09:00:00','17:00:00'),('saturday',1,'07:00:00','16:00:00'),('saturday',2,'07:00:00','14:00:00'),('saturday',3,'09:30:00','18:00:00'),('saturday',4,'09:00:00','17:00:00'),('saturday',5,'08:30:00','16:00:00'),('sunday',1,'07:00:00','16:00:00'),('sunday',2,'07:00:00','14:00:00'),('sunday',3,'09:30:00','18:00:00'),('sunday',5,'08:30:00','16:00:00');
/*!40000 ALTER TABLE `tianguis_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tianguis_suggestion`
--

DROP TABLE IF EXISTS `tianguis_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tianguis_suggestion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `new_name` varchar(128) DEFAULT NULL,
  `new_address` varchar(500) DEFAULT NULL,
  `new_location` multilinestring NOT NULL /*!80003 SRID 4326 */,
  `points` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  `tianguis_base` bigint NOT NULL,
  `user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_Tianguis_name` (`new_name`),
  KEY `idx_Tianguis_address` (`new_address`),
  SPATIAL KEY `idx_Tianguis_location` (`new_location`),
  KEY `fk_tianguis_suggestion_1_idx` (`tianguis_base`),
  KEY `fk_tianguis_user_suggestion_idx` (`user`),
  CONSTRAINT `fk_tianguis_suggestion` FOREIGN KEY (`tianguis_base`) REFERENCES `tianguis` (`id`),
  CONSTRAINT `fk_tianguis_user_suggestion` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tianguis_suggestion`
--

LOCK TABLES `tianguis_suggestion` WRITE;
/*!40000 ALTER TABLE `tianguis_suggestion` DISABLE KEYS */;
INSERT INTO `tianguis_suggestion` VALUES (1,NULL,'Calle Nueva 200 Otay',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0wæü\Z/=]¿ÜZ”º\„D@@˛\‘x\È&=]¿MåJ\ÍD@@\ÈH.ˇ!=]¿\"˝\ˆu\‡D@@',5,'2024-03-05 18:00:00',0,1,2),(2,'Mercado Extendido La Presa','Avenida Tecnologico 600 La Presa',_binary '\Ê\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',3,'2024-03-05 19:00:00',0,2,4);
/*!40000 ALTER TABLE `tianguis_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `role` enum('seller','customer') NOT NULL DEFAULT 'seller',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` tinyint NOT NULL DEFAULT '0',
  `photo` bigint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_User_email` (`email`),
  KEY `fk_user_avatar_idx` (`photo`),
  CONSTRAINT `fk_user_avatar` FOREIGN KEY (`photo`) REFERENCES `image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Ana','Garc√≠a Perez','ana@example.com','e38ad214943daad1d64c102faec29de4afe9da3d','526641047883','seller','2024-01-01 16:00:00',0,39),(2,'Luis Felipe','Hern√°ndez Sanchez','luis@example.com','2aa60a8ff7fcd473d321e0146afd9e26df395147','526641012787','customer','2024-01-02 17:15:00',0,39),(3,'Mar√≠a Jose','L√≥pez Herrera','maria@example.com','1119cfd37ee247357e034a08d844eea25f6fd20f','526639466532','seller','2024-01-03 18:30:00',0,39),(4,'Pedro','Mart√≠nez','pedro@example.com','a1d7584daaca4738d499ad7082886b01117275d8','526641234669','customer','2024-01-04 19:45:00',0,39),(5,'Carmen','D√≠az','carmen@example.com','edba955d0ea15fdef4f61726ef97e5af507430c0','523327499647','seller','2024-01-05 20:00:00',0,39),(6,'Jhon','Due','jhondue@example.com','92381651897164b19be06d9c8c35bba28ec049d4','016195551234','seller','2025-03-06 08:00:00',0,38),(7,'Andres','Lopez','amlo@example.com','b915e772dda6b8d399bb55e48b2fe8fd7d206a95','525510247336','customer','2025-03-06 08:00:00',0,39),(8,'Test','User','test@example.com','a240a1757ef2e0abf3f252dccec6895fc90d6385','1234567890','customer','2025-03-22 20:16:32',0,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `has_password` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    SET NEW.password = SHA1(NEW.password);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    IF NEW.password IS NOT NULL AND NEW.password != '' THEN
        SET NEW.password = SHA1(NEW.password);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_user_update` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
    IF NEW.password != OLD.password AND NEW.password IS NOT NULL AND NEW.password != '' THEN
        SET NEW.password = SHA1(NEW.password);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'tianguisapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-22 13:21:43
