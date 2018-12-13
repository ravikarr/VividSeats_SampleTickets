-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: stadium
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventname` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `totalrows` int(11) NOT NULL,
  `eachrowseatsdefault` int(11) NOT NULL,
  `pricedefault` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'laxman','test',2,10,2);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seats` (
  `eventid` int(11) NOT NULL,
  `rownumber` int(11) NOT NULL,
  `totalseats` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`eventid`,`rownumber`),
  CONSTRAINT `fk_seats_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES (1,1,10,2),(1,2,10,2);
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userInformation`
--

DROP TABLE IF EXISTS `userInformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userInformation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userInformation`
--

LOCK TABLES `userInformation` WRITE;
/*!40000 ALTER TABLE `userInformation` DISABLE KEYS */;
INSERT INTO `userInformation` VALUES (1,'laxman','12345','admin'),(2,'laxman1','test','123'),(3,'test333','undefined','customer'),(4,'laxman345','test','123'),(5,'laxman345tttt','test','123'),(6,'laxmantest','undefined','customer'),(7,'laxmantest1','undefined','seller'),(8,'laxmantest2','undefined','seller'),(9,'laxmantest3','12345','seller'),(10,'laxmantest4','12345','customer');
/*!40000 ALTER TABLE `userInformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_seats_information`
--

DROP TABLE IF EXISTS `user_seats_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_seats_information` (
  `uid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  `rownumber` int(11) NOT NULL,
  `seatnumber` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`eid`,`rownumber`,`seatnumber`),
  KEY `fk_user_seats_information_2_idx` (`eid`),
  CONSTRAINT `fk_user_seats_information_1` FOREIGN KEY (`uid`) REFERENCES `userInformation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_seats_information_2` FOREIGN KEY (`eid`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_seats_information`
--

LOCK TABLES `user_seats_information` WRITE;
/*!40000 ALTER TABLE `user_seats_information` DISABLE KEYS */;
INSERT INTO `user_seats_information` VALUES (10,1,2,9),(10,1,2,10);
/*!40000 ALTER TABLE `user_seats_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-14  2:03:28
