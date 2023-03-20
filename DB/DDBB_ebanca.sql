CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ebanca` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ebanca`;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `codigo_cliente` int(11) NOT NULL,
  `dni` int(11) NOT NULL,
  `nombre` char(20) NOT NULL,
  `apellido1` char(20) NOT NULL,
  `apellido2` char(20) DEFAULT NULL,
  `direccion` char(50) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE KEY `SID_cliente_1` (`codigo_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,12345678,'Alberto','Hernandez',NULL,NULL),(2,87654321,'Pep','Córcoles','Guasp',null),(3,11223344,'Carlos','Cerdá',null,null);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas` (
  `tipo` char(1) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `saldo` int(11) NOT NULL,
  `cod_cuenta` int(11) NOT NULL,
  PRIMARY KEY (`cod_cuenta`),
  UNIQUE KEY `ID_cuenta_IND` (`cod_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES ('1','2010-01-11',2333,0),('1','2010-01-11',-4000,1),('1','2010-01-11',-6000,2),('1','2010-01-11',10700,3),('1','2010-11-03',11700,4),('1','2010-11-03',-13000,5),('1','2013-11-03',13200,6),('1','2013-11-03',13000,7);
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimientos` (
  `fecha` datetime NOT NULL,
  `cantidad` decimal(4,0) NOT NULL,
  `dni` int(11) NOT NULL,
  `cod_cuenta` int(11) NOT NULL,
  `id_movimiento` int(11) NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  UNIQUE KEY `ID_movimiento_IND` (`fecha`,`dni`,`cod_cuenta`),
  KEY `REF_movim_cuent_IND` (`cod_cuenta`),
  KEY `REF_movim_clien_IND` (`dni`),
  KEY `cuenta` (`cod_cuenta`),
  KEY `cliente` (`dni`),
  CONSTRAINT `cliente` FOREIGN KEY (`dni`) REFERENCES `clientes` (`dni`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cuenta` FOREIGN KEY (`cod_cuenta`) REFERENCES `cuentas` (`cod_cuenta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
INSERT INTO `movimientos` VALUES ('2012-08-05 00:00:00','100',12345678,5,0),('2012-08-05 00:00:00','320',87654321,6,1),('2012-08-05 00:00:00','100',11223344,3,3),('2012-08-05 00:00:00','100',12345678,2,4),('2012-08-05 00:00:00','100',11223344,1,5),('2012-03-05 00:00:00','200',12345678,4,6);
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiene`
--

DROP TABLE IF EXISTS `tiene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tiene` (
  `dni` int(11) NOT NULL,
  `cod_cuenta` int(11) NOT NULL,
  PRIMARY KEY (`dni`,`cod_cuenta`),
  UNIQUE KEY `ID_tiene_IND` (`dni`,`cod_cuenta`),
  KEY `EQU_tiene_cuent_IND` (`cod_cuenta`),
  CONSTRAINT `fk1_cliente` FOREIGN KEY (`dni`) REFERENCES `clientes` (`dni`),
  CONSTRAINT `fk2_cuenta` FOREIGN KEY (`cod_cuenta`) REFERENCES `cuentas` (`cod_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiene`
--

LOCK TABLES `tiene` WRITE;
/*!40000 ALTER TABLE `tiene` DISABLE KEYS */;
INSERT INTO tiene VALUES (12345678,1),(87654321,1),(87654321,2),(11223344,2),(11223344,4),(11223344,5),(11223344,6),(87654321,7);
/*!40000 ALTER TABLE `tiene` ENABLE KEYS */;
UNLOCK TABLES;
