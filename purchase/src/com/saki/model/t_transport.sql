/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost
 Source Database       : order

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : utf-8

 Date: 08/31/2018 15:00:58 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_transport`
-- ----------------------------
DROP TABLE IF EXISTS `t_transport`;
CREATE TABLE `t_transport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `transname` varchar(30) DEFAULT NULL,
  `transno` varchar(50) DEFAULT NULL,
  `telphone` varchar(20) DEFAULT NULL,
  `driver` varchar(10) DEFAULT NULL,
  `driverphone` varchar(20) DEFAULT NULL,
  `money` decimal(10,3) DEFAULT NULL,
  `payflag` varchar(1) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `orderName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
