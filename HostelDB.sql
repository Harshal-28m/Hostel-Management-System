-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: hostelmanagement_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  `room_no` int(11) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `prn` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`student_id`),
  KEY `fk_complaint_student_idx` (`student_id`),
  KEY `fk_complaint_room_idx` (`room_no`),
  KEY `fk_complaint_prn_idx` (`prn`),
  CONSTRAINT `fk_complaint_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (1,10,'Harshal Mali',103,'water problem','water is not clean ',NULL),(4,11,'Arya Ganesh Mali',101,'Room Cleaning','Room cleaning is not done regularly.',NULL),(5,12,'Manish Rajram Bhagat ',101,'Mosquito Problem','There are too many mosquitoes at night.',NULL);
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_no` int(11) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `available` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`room_no`),
  UNIQUE KEY `room_no_UNIQUE` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,'ac ',2,'Occupied'),(102,'non-ac',3,'Occupied'),(103,'ac',2,'not available'),(104,'non-ac',3,'Occupied'),(105,'ac',2,'not available'),(106,'non-ac',3,'Occupied'),(107,'ac',4,'not available');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `room_no` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `course` varchar(45) DEFAULT NULL,
  `parents_no` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `paid_fee` int(11) DEFAULT NULL,
  `pending_fee` int(11) DEFAULT NULL,
  `academicyear` varchar(45) DEFAULT NULL,
  `prn` bigint(20) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (10,'Harshal Mali','hmali5411@gmail.com','1234','01234567890','103','100ft raod shamrao nagar sangli','Kolhapur','BBA','1234569871','2005-06-28',12,24000,24000,0,'2025-26',101,'FY',NULL,NULL),(11,'Arya Ganesh Mali','arya@gmail.com','1234','7894561230','101','Trimurty colony','Pune','MBA','1247782000','2000-12-01',9,18000,10000,8000,'2025-26',102,'FY',NULL,NULL),(12,'Manish Rajram Bhagat ','manish@gmail.com','7894','01234567890','101','Shamrao Nagar Sangli','Jaysingpur','BCA','5412477210','2002-08-22',3,6000,6000,0,'2025-26',103,'FY',NULL,NULL),(13,'shreyash','shreyash@gmail.com','123','1452369520','101','rajwada chowk solapur','solapur','MBA','1235412011','2002-05-12',6,12000,6000,6000,'2025-26',104,'FY',NULL,NULL),(14,'Yash Mali','yash@gmailcom','1234','8654712572','102','Vithhal nagar','sangli','BCA','1475236950','2006-06-19',3,6000,2000,4000,'2025-26',105,'FY',NULL,NULL),(15,'Rohit Rajesh Sharma','rohit@gmail.com','123','1236501452','104','100ft raod shamrao nagar Kolhapur','Kolhapur','MCA','1254123054','2005-11-01',6,12000,12000,0,'2026-27',106,'FY',NULL,NULL),(16,'riya rajesh jadhav','riya@gmail.com','123','1236541254','106','scfhgacvjh','Kolhapur','BBA','1234569871','2004-11-11',6,12000,12000,0,'2026-27',107,'FY',NULL,'1775106842791_Harshal Photo.jpeg');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-06 11:42:44
