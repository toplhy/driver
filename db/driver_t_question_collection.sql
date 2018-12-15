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
-- Table structure for table `t_question_collection`
--

DROP TABLE IF EXISTS `t_question_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_question_collection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question` bigint(20) DEFAULT NULL COMMENT '收藏试题ID',
  `createtime` datetime DEFAULT NULL COMMENT '收藏时间',
  `user` bigint(20) DEFAULT NULL COMMENT '收藏人',
  PRIMARY KEY (`id`),
  KEY `FK_question` (`question`),
  KEY `FK_user` (`user`),
  CONSTRAINT `FK_question` FOREIGN KEY (`question`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_user` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='试题收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_question_collection`
--

LOCK TABLES `t_question_collection` WRITE;
/*!40000 ALTER TABLE `t_question_collection` DISABLE KEYS */;
INSERT INTO `t_question_collection` VALUES (3,13,'2017-04-22 20:58:57',2),(4,12,'2017-04-22 21:01:20',2),(5,41,'2017-05-14 15:50:38',2),(6,39,'2017-06-13 16:53:25',2);
/*!40000 ALTER TABLE `t_question_collection` ENABLE KEYS */;
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
