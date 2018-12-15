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
-- Table structure for table `t_question_wrong`
--

DROP TABLE IF EXISTS `t_question_wrong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_question_wrong` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question` bigint(20) DEFAULT NULL COMMENT '试题ID',
  `user` bigint(20) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`),
  KEY `FK_wrong_question` (`question`),
  KEY `FK_wrong_user` (`user`),
  CONSTRAINT `FK_wrong_question` FOREIGN KEY (`question`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_wrong_user` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='错题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_question_wrong`
--

LOCK TABLES `t_question_wrong` WRITE;
/*!40000 ALTER TABLE `t_question_wrong` DISABLE KEYS */;
INSERT INTO `t_question_wrong` VALUES (1,5,2),(2,13,2),(4,3,2),(5,6,2),(6,12,2),(7,2,2),(8,15,2),(9,2,7),(10,99,2),(11,149,2),(12,115,2),(13,157,2),(14,44,2),(15,36,2),(16,39,2);
/*!40000 ALTER TABLE `t_question_wrong` ENABLE KEYS */;
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
