/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost
 Source Database       : orderBak

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : utf-8

 Date: 03/13/2019 21:13:06 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `t_address`
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `province` varchar(10) DEFAULT NULL,
  `city` varchar(10) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `is_default` varchar(1) DEFAULT NULL COMMENT '1.默认 0不默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_base`
-- ----------------------------
DROP TABLE IF EXISTS `t_base`;
CREATE TABLE `t_base` (
  `base_money` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
--  Records of `t_base`
-- ----------------------------
BEGIN;
INSERT INTO `t_base` VALUES ('5000');
COMMIT;

-- ----------------------------
--  Table structure for `t_carriage`
-- ----------------------------
DROP TABLE IF EXISTS `t_carriage`;
CREATE TABLE `t_carriage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tran_money` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `t_carriage`
-- ----------------------------
BEGIN;
INSERT INTO `t_carriage` VALUES ('2', '100');
COMMIT;

-- ----------------------------
--  Table structure for `t_color`
-- ----------------------------
DROP TABLE IF EXISTS `t_color`;
CREATE TABLE `t_color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `imgUrl` varchar(100) DEFAULT NULL,
  `descrip` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_company`
-- ----------------------------
DROP TABLE IF EXISTS `t_company`;
CREATE TABLE `t_company` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL COMMENT '公司名称',
  `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
  `address` varchar(100) DEFAULT NULL COMMENT '联系地址',
  `business` varchar(100) DEFAULT NULL COMMENT '主营业务',
  `level` varchar(10) DEFAULT NULL COMMENT '企业星级',
  `remark` varchar(255) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `telphone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `tax` varchar(30) DEFAULT NULL COMMENT '税号',
  `card` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  `brand` varchar(20) DEFAULT NULL COMMENT '品牌',
  `colorImg` varchar(100) DEFAULT NULL,
  `bank` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_confirm`
-- ----------------------------
DROP TABLE IF EXISTS `t_confirm`;
CREATE TABLE `t_confirm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `confirmDate` int(2) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `remark2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `t_confirm`
-- ----------------------------
BEGIN;
INSERT INTO `t_confirm` VALUES ('7', '11', '', null), ('8', '18', '', null), ('9', '28', '', null), ('10', '25', '', null);
COMMIT;

-- ----------------------------
--  Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` varchar(200) DEFAULT NULL,
  `flag` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL COMMENT '公司id',
  `address_id` int(10) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `start_date` datetime DEFAULT NULL COMMENT '下单时间',
  `confirm_date` datetime DEFAULT NULL COMMENT '订单确认时间，管理员确认订单',
  `pill_date` datetime DEFAULT NULL COMMENT '付款时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态 1：新订单 2已报价 3已付款 4确认收货  5已提交采购',
  `amount` decimal(15,5) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `locked` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  `percent` varchar(255) DEFAULT NULL,
  `confirm_id` int(11) DEFAULT NULL,
  `urgent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `num` int(10) DEFAULT NULL COMMENT '数量',
  `price` decimal(15,3) DEFAULT NULL COMMENT '单价',
  `defaultFlag` varchar(1) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `amount` decimal(10,3) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_order_mapping`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping` (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `product` varchar(50) DEFAULT NULL COMMENT '产品大类名称',
  `type` varchar(50) DEFAULT NULL COMMENT '种类',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `base` varchar(10) DEFAULT NULL COMMENT '基础采购量',
  `remark` varchar(255) DEFAULT NULL,
  `childProName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKA91FC0242CA5FA05` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_product_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_product_detail`;
CREATE TABLE `t_product_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) DEFAULT NULL,
  `sub_product` varchar(50) DEFAULT NULL COMMENT '小类名称',
  `format_num` int(11) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `format` varchar(50) DEFAULT NULL COMMENT '规格',
  `material` varchar(20) DEFAULT NULL COMMENT '材质',
  `remark` varchar(255) DEFAULT NULL,
  `selected` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `product` tinyblob,
  `mapper` tinyblob,
  `base_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK752CA4CC19BC13A0` (`product_id`) USING BTREE,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_product_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_product_type`;
CREATE TABLE `t_product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `base` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK1797FE757CEC5ADF` (`parent_id`) USING BTREE,
  CONSTRAINT `FK1797FE757CEC5ADF` FOREIGN KEY (`parent_id`) REFERENCES `t_product_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `t_supllier_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime DEFAULT NULL COMMENT '发货时间',
  `confirm_date` datetime DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态, 1新订单 2: 审核  3已付款 4已收货',
  `amount` decimal(10,5) DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_supllier_order_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order_detail`;
CREATE TABLE `t_supllier_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `conpany_id` int(10) DEFAULT NULL COMMENT '供应商ID,详情与具体供应商关联，可能出现一个商品从多家供应商采购的情况',
  `supllier_order_id` int(10) DEFAULT NULL COMMENT '供应商订单ID',
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品分类id',
  `num` int(10) DEFAULT NULL COMMENT '订单数量',
  `initnum` int(11) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL COMMENT '供应商报价',
  `status` varchar(1) DEFAULT NULL COMMENT '标注是否为主数据  1代表主数据不可删除，2代表拆分订单，可删除',
  `address` varchar(150) DEFAULT NULL COMMENT '收货地址',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- ----------------------------
--  Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT '1管理员 2供应商 3客户',
  `user_name` varchar(30) DEFAULT NULL,
  `user_pwd` varchar(50) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Records of `t_user`
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES ('14', null, '1', 'admin', 'e3ceb5881a0a1fdaad01296d7554868d', null, '222222');
COMMIT;

-- ----------------------------
--  Table structure for `t_user_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_product`;
CREATE TABLE `t_user_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) NOT NULL COMMENT '公司id ，拟定一家公司关联一个大类',
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `status` varchar(10) DEFAULT NULL COMMENT '是否默认',
  `role_id` int(10) DEFAULT NULL COMMENT '角色id， 判断是客户还是供应商',
  `price` decimal(10,3) DEFAULT NULL COMMENT '价钱',
  `sup_markup` decimal(10,3) DEFAULT NULL,
  `markup` decimal(10,3) unsigned zerofill DEFAULT '0000000.000' COMMENT '管理员追加',
  `percent` double DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `imgUrl` varchar(50) DEFAULT NULL,
  `supMarkup` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mapper` (`product_detail_id`) USING BTREE,
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
