-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: localhost    Database: GoatsRace
-- ------------------------------------------------------
-- Server version	8.0.30

drop database if exists GoatsRace;
create database GoatsRace;
use GoatsRace;

--
-- Table structure for table `goat`
--

DROP TABLE IF EXISTS `goat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goat` (
  `dorsal` smallint NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) DEFAULT NULL,
  `metersSoFar` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`dorsal`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goat`
--

LOCK TABLES `goat` WRITE;
/*!40000 ALTER TABLE `goat` DISABLE KEYS */;
INSERT INTO `goat` VALUES (1,'JOSEP ANTONI AGUILÓ PONS',0),(2,'ADRIÁN AGUILÓ RUIZ',0),(3,'ALEX ALAMEDA PETERSEN',0),(4,'IGNASI ALZINA AMER',0),(5,'MARIA MAGDALENA CRESPÍ FERRIOL',0),(6,'ANTONIO FERNANDEZ MUÑOZ',0),(7,'ANDREU GARCÍA BENNASAR',0),(8,'MIQUEL JAUME ROTGER',0),(9,'ESTEVE LLOBERA SUAU',0),(10,'ÓSCAR MEZQUITA SANS',0),(11,'ANDREU PONS BESTARD',0),(12,'RICARDO POYATO VENTAYOL',0),(13,'JOAN SÁNCHEZ SASTRE',0),(14,'MARC SANS VERA',0);
/*!40000 ALTER TABLE `goat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `race` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dorsal` smallint DEFAULT NULL,
  `meters` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dorsal` (`dorsal`),
  CONSTRAINT `race_ibfk_1` FOREIGN KEY (`dorsal`) REFERENCES `goat` (`dorsal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;
