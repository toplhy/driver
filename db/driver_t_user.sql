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
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `aviator` varchar(100) DEFAULT NULL COMMENT '用户头像',
  `createtime` datetime DEFAULT NULL COMMENT '添加时间',
  `lastlogin` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'lhy','e10adc3949ba59abbe56e057f20f883e','lhy@163.com','15732632290','lhy1492002668422艺.JPG','2017-03-04 19:39:44','2017-06-13 17:10:47'),(2,'liang','e10adc3949ba59abbe56e057f20f883e','liang@163.com','15732632290','liang1493040771560user5.jpg','2017-03-05 19:41:03','2017-06-13 16:51:58'),(7,'hong','e10adc3949ba59abbe56e057f20f883e','hong@163.com','15732632290',NULL,'2017-03-12 12:43:53','2017-04-30 22:23:40'),(9,'user','e10adc3949ba59abbe56e057f20f883e','user@163.com','15732632290',NULL,'2017-03-19 15:36:33',NULL),(10,'admin','e10adc3949ba59abbe56e057f20f883e','admin@163.com','15732632291','admin1495963170605qrcode_for_gh_20d960bf5c07_430.jpg','2017-03-21 23:11:48','2017-05-29 17:03:56'),(11,'hongyi','e10adc3949ba59abbe56e057f20f883e','hongyi@163.com','15732632290',NULL,'2017-04-06 23:20:43',NULL),(12,'lianghongyi','e10adc3949ba59abbe56e057f20f883e','lianghongyi@163.com','15732632290',NULL,'2017-04-12 21:52:09',NULL),(13,'administer','e10adc3949ba59abbe56e057f20f883e','admin@163.com','15732632290',NULL,'2017-05-29 17:08:51',NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
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
