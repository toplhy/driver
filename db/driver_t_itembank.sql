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
-- Table structure for table `t_itembank`
--

DROP TABLE IF EXISTS `t_itembank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_itembank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) DEFAULT NULL COMMENT '题库名称',
  `drivertype` varchar(50) DEFAULT NULL COMMENT '题库对应驾照',
  `descs` varchar(255) DEFAULT NULL COMMENT '题库描述',
  `state` tinyint(1) DEFAULT NULL COMMENT '题库状态',
  `singnum` int(3) DEFAULT NULL COMMENT '单选题数量',
  `singscore` double DEFAULT NULL COMMENT '单选题分值',
  `multnum` int(3) DEFAULT NULL COMMENT '多选题数量',
  `multscore` double DEFAULT NULL COMMENT '多选题分值',
  `duration` int(3) DEFAULT NULL COMMENT '考试时间',
  `totalscore` double DEFAULT NULL COMMENT '总分',
  `passscore` double DEFAULT NULL COMMENT '及格分',
  PRIMARY KEY (`id`),
  KEY `FK_prid` (`singnum`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='题库表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_itembank`
--

LOCK TABLES `t_itembank` WRITE;
/*!40000 ALTER TABLE `t_itembank` DISABLE KEYS */;
INSERT INTO `t_itembank` VALUES (1,'科目一','小车','适用于申领C1/C2/C3驾照的练习者的题库...',1,80,1,20,1,45,100,90),(4,'科目四','小车','科目四科目四科目四科目四科目四科目四',1,40,2,10,2,30,100,90),(5,'科目一','客车','客车科目一科目一',1,80,1,20,1,45,100,90),(6,'科目一','货车','货车科目一题库',1,80,1,20,1,45,100,90),(7,'123123','摩托车','sdfdsfsfs',1,20,1,20,1,60,40,10);
/*!40000 ALTER TABLE `t_itembank` ENABLE KEYS */;
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
