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
-- Table structure for table `t_trafficmenu`
--

DROP TABLE IF EXISTS `t_trafficmenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trafficmenu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) DEFAULT NULL COMMENT '目录名称',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级ID',
  PRIMARY KEY (`id`),
  KEY `FK_PID` (`pid`),
  CONSTRAINT `FK_PID` FOREIGN KEY (`pid`) REFERENCES `t_trafficmenu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='交规目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trafficmenu`
--

LOCK TABLES `t_trafficmenu` WRITE;
/*!40000 ALTER TABLE `t_trafficmenu` DISABLE KEYS */;
INSERT INTO `t_trafficmenu` VALUES (1,'交规解读',NULL),(7,'驾驶证与机动车管理',1),(8,'申领驾驶证1',7),(9,'驾驶证的使用',7),(10,'机动车管理',7),(11,'道路通行规定',1),(12,'道路通行原则',11),(13,'道路通行规定',11),(14,'高速公路管理规定',11),(15,'交通信号',1),(16,'交通信号灯',15),(17,'交通标志',15),(18,'交通标线',15),(19,'交通警察手势',15),(20,'道路交通事故处理',1),(21,'交通事故现场处置',20),(22,'自行协商事故处理',20),(23,'事故现场的强制撤离',20),(24,'机动车交通事故责任强制保险',20),(27,'驾驶证基本常识',8),(28,'机动车驾驶证申领条件',8),(29,'初次申领机动车驾驶证的车型',8),(30,'机动车驾驶人考试内容',8),(31,'驾驶人考试要求1',8),(32,'法律责任',1),(33,'有效期满换证',9),(34,'转入换证',9),(35,'变更换证',9),(36,'驾驶证遗失补证',9),(37,'违法记分分值及考试',9),(38,'驾驶证实习期',9),(39,'驾驶证审验',9),(40,'驾驶人体检',9),(41,'驾驶证注销',9),(42,'违法处罚',9),(43,'右侧通行原则',12),(44,'分道通行',12),(45,'优先通行',12),(46,'安全通行',12),(47,'无划分车道的道路通行',12),(48,'机动车分类',10),(49,'机动车管理制度',10),(50,'法律责任',32);
/*!40000 ALTER TABLE `t_trafficmenu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-15 11:27:11
