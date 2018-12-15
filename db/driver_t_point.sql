-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: driver
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.04.1

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
-- Table structure for table `t_point`
--

DROP TABLE IF EXISTS `t_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_point` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) DEFAULT NULL COMMENT '知识点名称',
  `ibid` bigint(20) DEFAULT NULL COMMENT '所属题库',
  `descs` varchar(255) DEFAULT NULL COMMENT '知识点描述',
  PRIMARY KEY (`id`),
  KEY `FK_ibid` (`ibid`),
  CONSTRAINT `FK_ibid` FOREIGN KEY (`ibid`) REFERENCES `t_itembank` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='知识点(考点)表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_point`
--

LOCK TABLES `t_point` WRITE;
/*!40000 ALTER TABLE `t_point` DISABLE KEYS */;
INSERT INTO `t_point` VALUES (1,'道路交通安全法律、法规',1,'科目一知识点'),(2,'道路交通信号及含义',1,'科目一知识点'),(3,'安全行车、文明驾驶知识',1,'科目一知识点。。。。。。。。。'),(4,'违法行为综合判断与案例分析',4,'小车科目四知识点'),(5,'安全行车常识',4,'小车科目四知识点'),(6,'常见交通标志、标线和交警手势信号辨识',4,'小车科目四知识点'),(7,'驾驶职业道德和文明常识',4,'小车科目四知识点'),(9,'恶劣气候和复杂道路条件下驾驶常识',4,'小车科目四知识点'),(10,'机动车驾驶操作相关基础知识',1,'科目一知识点');
/*!40000 ALTER TABLE `t_point` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-15 11:27:12
