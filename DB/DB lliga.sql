--
-- Current Database: `lliga`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `lliga` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `lliga`;

--
-- Table structure for table `equips`
--

DROP TABLE IF EXISTS `equips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equips` (
  `id_equip` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `ciutat` varchar(45) NOT NULL,
  `web` varchar(250) DEFAULT 'sin web oficial',
  `punts` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_equip`),
  UNIQUE KEY `nombre_UNIQUE` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equips`
--

LOCK TABLES `equips` WRITE;
/*!40000 ALTER TABLE `equips` DISABLE KEYS */;
INSERT INTO `equips` VALUES (1,'Regal Barcelona','Barcelona','http://www.fcbarcelona.com/web/index_idiomes.html',10),(2,'Real Madrid','Madrid','http://www.realmadrid.com/cs/Satellite/es/1193040472450/SubhomeEquipo/Baloncesto.htm',9),(3,'P.E. Valencia','Valencia','http://www.valenciabasket.com/',11),(4,'Caja Laboral','Vitoria','http://www.baskonia.com/prehomes/prehomes.asp?id_prehome=69',22),(5,'Gran Canaria','Las Palmas','http://www.acb.com/club.php?id=CLA',14),(6,'CAI Zaragoza','Zaragoza','http://basketzaragoza.net/',23);
/*!40000 ALTER TABLE `equips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadors`
--

DROP TABLE IF EXISTS `jugadors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jugadors` (
  `id_jugador` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `cognom` varchar(45) DEFAULT NULL,
  `posicio` varchar(45) DEFAULT NULL,
  `id_capita` int(11) DEFAULT NULL,
  `data_alta` datetime DEFAULT NULL,
  `salari` int(11) DEFAULT NULL,
  `equip` int(11) DEFAULT NULL,
  `alçada` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_jugador`),
  KEY `fequipo` (`equip`),
  CONSTRAINT `fequipo` FOREIGN KEY (`equip`) REFERENCES `equips` (`id_equip`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadors`
--

LOCK TABLES `jugadors` WRITE;
/*!40000 ALTER TABLE `jugadors` DISABLE KEYS */;
INSERT INTO `jugadors` VALUES (1,'Juan Carlos','Navarro','escolta',1,'2010-01-10 00:00:00',130000,1,'1.96'),(2,'Felipe','Reyes','Pivot',2,'2009-02-20 00:00:00',132000,2,'2.04'),(3,'Victor','Claver','Alero',3,'2009-03-08 00:00:00',99000,3,'2.08'),(4,'Rafa ','Martinez','ala-pivot',4,'2010-11-11 00:00:00',51000,3,'1.91'),(5,'Fernando','San Emeterio','Alero',6,'2008-09-22 00:00:00',60000,4,'1.99'),(6,'Mirza','Teletovic','Pivot',6,'2010-05-13 00:00:00',77000,4,'2.06'),(7,'Sergio ','Llull','Escolta',2,'2011-10-29 00:00:00',100000,2,'1.90'),(8,'Victor ','Sada','Base',1,'2012-01-01 00:00:00',80000,1,'1.92'),(9,'Carlos','Suarez','Alero',2,'2011-02-19 00:00:00',66000,2,'2.03'),(10,'Xavi ','Rey','Pivot',14,'2008-10-12 00:00:00',104500,5,'2.09'),(11,'Carlos ','Cabezas','Base',13,'2012-01-21 00:00:00',105000,6,'1.86'),(12,'Pablo ','Aguilar','Alero',13,'2011-06-14 00:00:00',51700,6,'2.03'),(13,'Rafa','Hettsheimeir','Pivot',13,'2008-04-15 00:00:00',58300,6,'2.08'),(14,'Sitapha','Savané','Pivot',14,'2011-07-27 00:00:00',66000,5,'2.01'),(15,'anonimo','anonimo','Ala-pivot',2,'2012-01-01 00:00:00',4000,3,'2.00'),(22,'j1',NULL,NULL,NULL,NULL,NULL,2,'2.00'),(23,'j2',NULL,NULL,NULL,NULL,NULL,2,NULL);
/*!40000 ALTER TABLE `jugadors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partits`
--

DROP TABLE IF EXISTS `partits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partits` (
  `id_partit` int(11) NOT NULL AUTO_INCREMENT,
  `elocal` int(11) NOT NULL,
  `evisitant` int(11) NOT NULL,
  `resultat` varchar(45) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `arbit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_partit`),
  KEY `flocal` (`elocal`),
  KEY `fvisitante` (`evisitant`),
  CONSTRAINT `flocal` FOREIGN KEY (`elocal`) REFERENCES `equips` (`id_equip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fvisitante` FOREIGN KEY (`evisitant`) REFERENCES `equips` (`id_equip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partits`
--

LOCK TABLES `partits` WRITE;
/*!40000 ALTER TABLE `partits` DISABLE KEYS */;
INSERT INTO `partits` VALUES (1,1,2,'100-100','2011-10-10','4\r'),(2,2,3,'90-91','2011-11-17','5\r'),(3,3,4,'88-77','2011-11-23','6\r'),(4,1,6,'66-78','2011-11-30','6\r'),(5,2,4,'90-90','2012-01-12','7\r'),(6,4,5,'79-83','2012-01-19','3\r'),(7,3,6,'91-88','2012-02-22','3\r'),(8,5,4,'90-66','2012-04-27','2\r'),(9,6,5,'110-70','2012-05-30','1'),(10,3,5,'88-77','2011-09-01','2');
/*!40000 ALTER TABLE `partits` ENABLE KEYS */;
UNLOCK TABLES;
