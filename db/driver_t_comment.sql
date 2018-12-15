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
-- Table structure for table `t_comment`
--

DROP TABLE IF EXISTS `t_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question` bigint(20) DEFAULT NULL COMMENT '试题ID',
  `user` bigint(20) DEFAULT NULL COMMENT '评论人',
  `content` text COMMENT '评论内容',
  `createtime` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `FK_comm_question` (`question`),
  KEY `FK_comm_user` (`user`),
  CONSTRAINT `FK_comm_question` FOREIGN KEY (`question`) REFERENCES `t_question` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_comm_user` FOREIGN KEY (`user`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='用户评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_comment`
--

LOCK TABLES `t_comment` WRITE;
/*!40000 ALTER TABLE `t_comment` DISABLE KEYS */;
INSERT INTO `t_comment` VALUES (1,2,2,'啊是的购房计划的款式风格和实际得分 士大夫','2017-04-25 21:17:34'),(7,15,2,'So easy！！！','2017-04-25 21:52:32'),(8,2,7,'什么意思，你说清楚','2017-04-25 21:53:33'),(9,5,7,'明显是追究刑事责任么','2017-04-25 22:09:15'),(10,12,7,'违法行为','2017-04-25 22:09:58'),(11,13,2,'这张图片中有三个字，其中第一个第三个分别是厚和晋，第二个我不认识，谁能告知一下，万分感谢。','2017-04-25 22:11:57'),(12,41,2,'hgjgk','2017-05-14 15:50:48'),(13,39,2,'gdffd','2017-06-13 16:53:20');
/*!40000 ALTER TABLE `t_comment` ENABLE KEYS */;
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
