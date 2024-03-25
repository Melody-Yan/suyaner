/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.3.0 : Database - librarydb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`librarydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `librarydb`;

/*Table structure for table `借阅表` */

DROP TABLE IF EXISTS `借阅表`;

CREATE TABLE `借阅表` (
  `借阅号` int NOT NULL,
  `条码` char(20) NOT NULL,
  `读者编号` char(6) NOT NULL,
  `借阅日期` date DEFAULT NULL,
  `还书日期` date DEFAULT NULL,
  `借阅状态` char(6) DEFAULT NULL,
  PRIMARY KEY (`借阅号`),
  KEY `读者编号` (`读者编号`),
  KEY `条码` (`条码`),
  CONSTRAINT `借阅表_ibfk_1` FOREIGN KEY (`读者编号`) REFERENCES `读者表` (`读者编号`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `借阅表_ibfk_2` FOREIGN KEY (`条码`) REFERENCES `库存表` (`条码`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `借阅表` */

insert  into `借阅表`(`借阅号`,`条码`,`读者编号`,`借阅日期`,`还书日期`,`借阅状态`) values (100001,'123413','0001','2020-11-05',NULL,'借阅');

/*Table structure for table `图书表` */

DROP TABLE IF EXISTS `图书表`;

CREATE TABLE `图书表` (
  `书号` char(10) NOT NULL,
  `书名` char(20) NOT NULL,
  `类别` char(10) NOT NULL,
  `作者` char(10) NOT NULL,
  `出版社` varchar(20) NOT NULL,
  `单价` float(5,2) DEFAULT NULL,
  `数量` int DEFAULT NULL,
  PRIMARY KEY (`书号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `图书表` */

insert  into `图书表`(`书号`,`书名`,`类别`,`作者`,`出版社`,`单价`,`数量`) values ('A0120','庄子','文学','庄周','吉林大学出版社',18.50,5),('A0134','唐诗三百首','文学','李平','安徽科学出版社',28.00,10),('B1101','西方经济学史','财经','莫竹芩','海南出版社',39.80,8),('B2213','商业博弈','财经','孔英','北京大学出版社',39.00,15),('C1269','数据结构','计算机','李刚','高等教育出版社',29.00,20);

/*Table structure for table `库存表` */

DROP TABLE IF EXISTS `库存表`;

CREATE TABLE `库存表` (
  `条码` char(20) NOT NULL,
  `书号` char(10) NOT NULL,
  `位置` varchar(20) NOT NULL,
  `库存状态` char(10) DEFAULT NULL,
  PRIMARY KEY (`条码`),
  CONSTRAINT `库存表_chk_1` CHECK ((`库存状态` in (_utf8mb3'在馆',_utf8mb3'借出',_utf8mb3'丢失')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `库存表` */

insert  into `库存表`(`条码`,`书号`,`位置`,`库存状态`) values ('123412','A0120','1-A-56','在馆'),('123413','A0120','1-A-57','借出');

/*Table structure for table `读者类型表` */

DROP TABLE IF EXISTS `读者类型表`;

CREATE TABLE `读者类型表` (
  `类别号` char(2) NOT NULL COMMENT '主键',
  `类名` char(10) NOT NULL,
  `可借数量` int DEFAULT NULL,
  `可借天数` int DEFAULT NULL,
  PRIMARY KEY (`类别号`),
  CONSTRAINT `读者类型表_chk_1` CHECK (((0 <= `可借数量`) <= 30))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='readerType';

/*Data for the table `读者类型表` */

insert  into `读者类型表`(`类别号`,`类名`,`可借数量`,`可借天数`) values ('1','学生',10,20);

/*Table structure for table `读者表` */

DROP TABLE IF EXISTS `读者表`;

CREATE TABLE `读者表` (
  `读者编号` char(6) NOT NULL COMMENT '主键',
  `姓名` char(10) NOT NULL,
  `类别号` char(2) NOT NULL,
  `单位` varchar(20) DEFAULT NULL,
  `有效性` char(10) DEFAULT NULL,
  PRIMARY KEY (`读者编号`),
  KEY `类别号` (`类别号`),
  CONSTRAINT `读者表_ibfk_1` FOREIGN KEY (`类别号`) REFERENCES `读者类型表` (`类别号`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='reader';

/*Data for the table `读者表` */

insert  into `读者表`(`读者编号`,`姓名`,`类别号`,`单位`,`有效性`) values ('0001','张小东','1','软件学院','有效');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
