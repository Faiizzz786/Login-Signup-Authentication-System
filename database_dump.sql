/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: aspasionassignment
-- ------------------------------------------------------
-- Server version	11.7.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `jwt_tokens`
--

DROP TABLE IF EXISTS `jwt_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jwt_tokens` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(512) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKk20989lyj7640rme2nh3vvni1` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jwt_tokens`
--

LOCK TABLES `jwt_tokens` WRITE;
/*!40000 ALTER TABLE `jwt_tokens` DISABLE KEYS */;
INSERT INTO `jwt_tokens` VALUES
(11,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc1NzIzNywiZXhwIjoxNzQzNzYwODM3fQ.deIjey09O_IgbdXc02KezMONoOT_c5F26kmqFPTAmU8','2025-04-04 14:30:37.753000','faizanadil786092@gmail.com'),
(12,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc1NzU4NywiZXhwIjoxNzQzNzYxMTg3fQ.CO2Tn6od_OsaRRxKhhaQgMoPSc3eZkkaOMWKpvUGaZo','2025-04-04 14:36:27.866000','faizanadil786092@gmail.com'),
(13,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc1NzY3NiwiZXhwIjoxNzQzNzYxMjc2fQ.nzn1gdwdali9ppUu8acWtD2SYE-Ail9U3gT1vPeHHZM','2025-04-04 14:37:56.941000','faizanadil786092@gmail.com'),
(14,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc1ODc2NywiZXhwIjoxNzQzNzYyMzY3fQ.wFinZuQlzj3l8iNw2dHnV6fBpCNXmgPeOqLAf6qgy1o','2025-04-04 14:56:07.064000','faizanadil786092@gmail.com'),
(15,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc1OTAwMywiZXhwIjoxNzQzNzYyNjAzfQ.g2295nIKZbABW8jDcpZo7W2yj3Wm9RCUlgMAzTaJghc','2025-04-04 15:00:03.379000','faizanadil786092@gmail.com'),
(16,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc2MTY3NywiZXhwIjoxNzQzNzY1Mjc3fQ.XrBNayl_hFa5jnE6cNnUvbXQWRFZ-2YLs2tOSTbfwiA','2025-04-04 15:44:37.927000','faizanadil786092@gmail.com'),
(17,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYWl6YW5hZGlsNzg2MDkyQGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc2MTcxOSwiZXhwIjoxNzQzNzY1MzE5fQ.O0UBny1DWLD3A4I-2csMfLe4NJCBoeFNc9VCwLK0DIs','2025-04-04 15:45:19.304000','faizanadil786092@gmail.com'),
(18,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkZWVwYWtjaG91ZGhhcnk5ODM2QGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc3NzYwNCwiZXhwIjoxNzQzNzgxMjA0fQ.EAHswc1M_f9SkDeRq8o4Sec3woLB2LznVRcqlspMJVA','2025-04-04 20:10:04.031000','deepakchoudhary9836@gmail.com'),
(19,'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkZWVwYWtjaG91ZGhhcnk5ODM2QGdtYWlsLmNvbSIsImlhdCI6MTc0Mzc3NzYzMiwiZXhwIjoxNzQzNzgxMjMyfQ.v-iR7OxA10Des-jFhsCQHaocwY9AEmSK4st5Up9cM34','2025-04-04 20:10:32.483000','deepakchoudhary9836@gmail.com');
/*!40000 ALTER TABLE `jwt_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempt`
--

DROP TABLE IF EXISTS `login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempt` (
  `email` varchar(255) NOT NULL,
  `failed_attempts` int(11) NOT NULL,
  `lock_time` datetime(6) DEFAULT NULL,
  `locked` bit(1) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempt`
--

LOCK TABLES `login_attempt` WRITE;
/*!40000 ALTER TABLE `login_attempt` DISABLE KEYS */;
INSERT INTO `login_attempt` VALUES
('deepakchoudhary9836@gmail.com',0,NULL,0x00),
('faizanadil786092@gmail.com',6,'2025-04-04 15:50:12.538000',0x01),
('razaf191@gmail.com',2,NULL,0x00);
/*!40000 ALTER TABLE `login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_token`
--

LOCK TABLES `password_reset_token` WRITE;
/*!40000 ALTER TABLE `password_reset_token` DISABLE KEYS */;
INSERT INTO `password_reset_token` VALUES
(19,'faizanadil786092@gmail.com','2025-04-04 20:17:14.917000','c8d1e9f1-4882-4cb2-b259-3455a906afe9'),
(20,'faizanadil786092@gmail.com','2025-04-04 20:17:23.378000','5dc69d08-7b48-4d77-b602-a0c81474131e'),
(21,'btech10150.21@bitmesra.ac.in','2025-04-04 20:32:41.288000','6c6ab2e8-54ae-460a-ace5-1f2e0202d41e'),
(22,'faizanadil786092@gmail.com','2025-04-04 20:48:27.567000','6e092336-3ef5-4e89-bd04-19027835b64e'),
(23,'deepakchoudhary9836@gmail.com','2025-04-04 21:10:20.099000','257dfa19-eb42-4bd9-aab4-6e4af48bb77d');
/*!40000 ALTER TABLE `password_reset_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `verification_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(3,'razaf919@gmail.com','$2a$10$twzcVgJuNUHhKVsu5NQo3ehaxHL/LAitbz2O3PIYMtlgtmTv3GKme','Md Faizan Raza Adil','06202024843',1,NULL),
(5,'rippedodyssey@gmail.com','$2a$10$dvNMW15UVKhXkUtmQ6Qt0eFvWMWrAeZE4r8ltEWJDmaIOHru2eywG','Md Faizan Raza Adil','06202024843',0,'f673af23-cd42-4738-bd6d-fb9e650b3c87'),
(21,'faizanadil786092@gmail.com','$2a$10$ogbRNozZbVvq17mmYeAVM.yzNxS.TxZg.w.XvXVLDDX9qd0QqZodq','Md Faizan Raza Adil','06202024843',1,NULL),
(22,'btech10150.21@bitmesra.ac.in','$2a$10$yYfOralYD0jKDVUaiTLAzewQlBMj6R/8xjbYWJxOc8iWlZ9O8J0hK','Md Faizan Raza Adil','06202024843',0,'6b438042-9ef2-4064-bccb-40ee8d1fd842'),
(23,'razaf191@gmail.com','$2a$10$Mtv0.l/ksWnVKS5Je62RZOCG5ZByGCOcf1DDiduNrAotw1Ht6ZB3m','razazf','6202024843',0,'cd26227b-0e40-4baf-a19a-af22cd3be988'),
(24,'deepakchoudhary9836@gmail.com','$2a$10$qaa7r9Wx8OFh/a.0v4slTuan8v55wyDj.9cSf.KThXBkEC9TL7I12','deepak','9090786654',1,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-04-04 20:13:49
