/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : order

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-07-13 17:05:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_company
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES ('3', '测试客户·', '联系人', '地址', '焊丝', '', '', '3', 'kh', '1111', '11', '111', null);
INSERT INTO `t_company` VALUES ('4', '测试供货商', '1', '地址', '板材', '一星', '', '2', 'gh', '1', '1', '111', '121');
INSERT INTO `t_company` VALUES ('5', '测试客户2', '王五', '地址********', '魔石, ', null, '', '2', 'kh2', '1582231231231', '1111', '123123123123', '111');
INSERT INTO `t_company` VALUES ('12', '111', '11', '111', '111', '', '', '2', '111', '111', '111', '111', 'tiffnty');
INSERT INTO `t_company` VALUES ('13', '测试注册', '1111', '1123', '111', '', '', '2', '123', '1111', '1111', '111', 'oracle');

-- ----------------------------
-- Table structure for t_confirm
-- ----------------------------
DROP TABLE IF EXISTS `t_confirm`;
CREATE TABLE `t_confirm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `confirmDate` int(2) DEFAULT NULL,
  `remark` varchar(10) DEFAULT NULL,
  `remark2` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_confirm
-- ----------------------------
INSERT INTO `t_confirm` VALUES ('1', '5', '', null);
INSERT INTO `t_confirm` VALUES ('2', '25', '', null);
INSERT INTO `t_confirm` VALUES ('4', '15', '1', null);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL COMMENT '公司id',
  `confirm_id` int(5) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `start_date` datetime DEFAULT NULL COMMENT '下单时间',
  `confirm_date` datetime DEFAULT NULL COMMENT '订单确认时间，管理员确认订单',
  `pill_date` datetime DEFAULT NULL COMMENT '付款时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态 1：新订单 2已报价 3已付款 4确认收货  5已提交采购',
  `amount` decimal(10,5) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `locked` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL COMMENT '1、发票已开，2、发票已收',
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  `percent` varchar(255) DEFAULT NULL,
  `urgent` varchar(1) DEFAULT NULL COMMENT '是否紧急订单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1', '3', null, 'KH20180605001', '2018-06-05 10:49:49', null, '2018-06-06 09:34:00', '2018-06-15 13:54:45', '4', '0.00000', null, '测试客户·', '1', '1', '2018-06-15 12:46:49', null, '100', null);
INSERT INTO `t_order` VALUES ('2', '3', null, 'KH20180606001', '2018-06-06 11:00:50', null, '2018-06-15 12:48:52', null, '5', '0.00000', null, '测试客户·', '1', null, null, null, '100', null);
INSERT INTO `t_order` VALUES ('3', '3', null, 'KH20180615001', '2018-06-15 13:01:10', null, null, null, '2', '0.00000', null, '测试客户·', '0', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('4', '3', null, 'KH20180615002', '2018-06-15 13:04:19', null, '2018-06-15 13:22:39', '2018-06-15 13:47:22', '4', '0.00000', null, '测试客户·', '1', null, null, null, '100', null);
INSERT INTO `t_order` VALUES ('5', '3', null, 'KH20180615003', '2018-06-15 13:13:38', null, '2018-06-15 13:23:04', null, '5', '0.00000', null, '测试客户·', '1', null, null, null, '100', null);
INSERT INTO `t_order` VALUES ('6', '3', null, 'KH20180703001', '2018-07-03 14:27:19', null, null, null, '2', '0.00000', null, '测试客户·', '1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('7', '3', null, 'KH20180703002', '2018-07-03 14:30:55', null, '2018-07-06 14:47:22', null, '5', '0.00000', null, '测试客户·', '1', null, null, null, '90', null);
INSERT INTO `t_order` VALUES ('8', '3', null, 'KH20180703003', '2018-07-03 14:36:27', null, '2018-07-06 13:40:17', null, '3', '0.00000', null, '测试客户·', null, null, null, null, '30', null);
INSERT INTO `t_order` VALUES ('9', '3', null, 'KH20180706001', '2018-07-06 11:53:10', null, '2018-07-06 14:01:55', null, '5', '0.00000', null, '测试客户·', '1', null, null, null, '10', null);
INSERT INTO `t_order` VALUES ('10', '3', null, 'KH20180711001', '2018-07-11 16:59:16', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, null);
INSERT INTO `t_order` VALUES ('11', '3', null, 'KH20180711002', '2018-07-11 17:13:34', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, null);
INSERT INTO `t_order` VALUES ('12', '3', null, 'KH20180713001', '2018-07-13 15:46:17', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, null);
INSERT INTO `t_order` VALUES ('13', '3', null, 'KH20180713002', '2018-07-13 15:53:07', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('14', '3', null, 'KH20180713003', '2018-07-13 15:57:37', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('15', '3', null, 'KH20180713004', '2018-07-13 15:58:51', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('16', '3', null, 'KH20180713005', '2018-07-13 15:59:44', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('17', '3', null, 'KH20180713006', '2018-07-13 16:00:50', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('18', '3', null, 'KH20180713007', '2018-07-13 16:01:18', null, null, null, '1', '0.00000', null, '测试客户·', null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `num` int(10) DEFAULT NULL COMMENT '数量',
  `price` decimal(10,0) DEFAULT NULL COMMENT '单价',
  `brand` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES ('1', '1', '2', '100', null, null, null);
INSERT INTO `t_order_detail` VALUES ('2', '1', '6', '100', null, null, null);
INSERT INTO `t_order_detail` VALUES ('3', '3', '2', '0', null, null, null);
INSERT INTO `t_order_detail` VALUES ('4', '3', '1', '0', null, null, null);
INSERT INTO `t_order_detail` VALUES ('5', '2', '1', '10', null, null, null);
INSERT INTO `t_order_detail` VALUES ('6', '3', '2', '1000', null, null, null);
INSERT INTO `t_order_detail` VALUES ('7', '4', '2', '2000', null, null, null);
INSERT INTO `t_order_detail` VALUES ('8', '5', '1', '1000', null, null, null);
INSERT INTO `t_order_detail` VALUES ('9', '6', '2', '100', '70', 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('10', '7', '1', '111', null, '1111', null);
INSERT INTO `t_order_detail` VALUES ('11', '8', '1', '1', null, '111', null);
INSERT INTO `t_order_detail` VALUES ('12', '8', '1', '1', null, '', null);
INSERT INTO `t_order_detail` VALUES ('16', '8', '4', '1', null, '', null);
INSERT INTO `t_order_detail` VALUES ('17', '9', '2', '1000', null, 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('18', '6', '1', '20', '20', 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('19', '10', '1', '1111', '20', 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('20', '11', '1', '1', '20', 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('21', '11', '4', '1', '0', 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('22', '12', '1', '2', null, 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('23', '13', '1', '999', null, 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('24', '15', '4', '123', null, 'tiffnty', null);
INSERT INTO `t_order_detail` VALUES ('25', '16', '1', '111', null, 'tiffnty', '1111');
INSERT INTO `t_order_detail` VALUES ('26', '17', '1', '777', null, 'tiffnty', '777');
INSERT INTO `t_order_detail` VALUES ('27', '18', '1', '123', null, 'tiffnty', '32131');

-- ----------------------------
-- Table structure for t_order_mapping
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping` (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_mapping
-- ----------------------------
INSERT INTO `t_order_mapping` VALUES ('1', '1', '1');
INSERT INTO `t_order_mapping` VALUES ('1', '1', '2');
INSERT INTO `t_order_mapping` VALUES ('1', '1', '3');
INSERT INTO `t_order_mapping` VALUES ('1', '2', '4');
INSERT INTO `t_order_mapping` VALUES ('1', '3', '5');
INSERT INTO `t_order_mapping` VALUES ('1', '4', '6');
INSERT INTO `t_order_mapping` VALUES ('1', '5', '7');
INSERT INTO `t_order_mapping` VALUES ('2', '5', '8');
INSERT INTO `t_order_mapping` VALUES ('1', '6', '9');
INSERT INTO `t_order_mapping` VALUES ('2', '6', '10');
INSERT INTO `t_order_mapping` VALUES ('1', '7', '11');
INSERT INTO `t_order_mapping` VALUES ('2', '7', '12');
INSERT INTO `t_order_mapping` VALUES ('4', '7', '13');
INSERT INTO `t_order_mapping` VALUES ('5', '7', '14');
INSERT INTO `t_order_mapping` VALUES ('1', '8', '15');
INSERT INTO `t_order_mapping` VALUES ('2', '8', '16');
INSERT INTO `t_order_mapping` VALUES ('4', '8', '17');
INSERT INTO `t_order_mapping` VALUES ('5', '8', '18');
INSERT INTO `t_order_mapping` VALUES ('1', '9', '19');
INSERT INTO `t_order_mapping` VALUES ('2', '9', '20');
INSERT INTO `t_order_mapping` VALUES ('4', '9', '21');
INSERT INTO `t_order_mapping` VALUES ('5', '9', '22');
INSERT INTO `t_order_mapping` VALUES ('2', '10', '23');
INSERT INTO `t_order_mapping` VALUES ('5', '10', '24');
INSERT INTO `t_order_mapping` VALUES ('2', '11', '25');
INSERT INTO `t_order_mapping` VALUES ('5', '11', '26');
INSERT INTO `t_order_mapping` VALUES ('2', '12', '27');
INSERT INTO `t_order_mapping` VALUES ('5', '12', '28');
INSERT INTO `t_order_mapping` VALUES ('2', '10', '29');
INSERT INTO `t_order_mapping` VALUES ('5', '10', '30');
INSERT INTO `t_order_mapping` VALUES ('2', '11', '31');
INSERT INTO `t_order_mapping` VALUES ('5', '11', '32');
INSERT INTO `t_order_mapping` VALUES ('2', '12', '33');
INSERT INTO `t_order_mapping` VALUES ('5', '12', '34');
INSERT INTO `t_order_mapping` VALUES ('2', '10', '35');
INSERT INTO `t_order_mapping` VALUES ('5', '10', '36');
INSERT INTO `t_order_mapping` VALUES ('2', '11', '37');
INSERT INTO `t_order_mapping` VALUES ('5', '11', '38');
INSERT INTO `t_order_mapping` VALUES ('2', '11', '39');
INSERT INTO `t_order_mapping` VALUES ('5', '11', '40');
INSERT INTO `t_order_mapping` VALUES ('9', '11', '41');
INSERT INTO `t_order_mapping` VALUES ('7', '12', '42');
INSERT INTO `t_order_mapping` VALUES ('7', '10', '43');
INSERT INTO `t_order_mapping` VALUES ('7', '11', '44');
INSERT INTO `t_order_mapping` VALUES ('2', '12', '45');
INSERT INTO `t_order_mapping` VALUES ('5', '12', '46');
INSERT INTO `t_order_mapping` VALUES ('7', '12', '47');
INSERT INTO `t_order_mapping` VALUES ('9', '12', '48');
INSERT INTO `t_order_mapping` VALUES ('2', '13', '49');
INSERT INTO `t_order_mapping` VALUES ('5', '13', '50');
INSERT INTO `t_order_mapping` VALUES ('7', '13', '51');
INSERT INTO `t_order_mapping` VALUES ('9', '13', '52');

-- ----------------------------
-- Table structure for t_product
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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKA91FC0242CA5FA05` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('8', null, '焊丝', '', '公斤', null, null);
INSERT INTO `t_product` VALUES ('9', null, '磨具', '', '片', null, null);
INSERT INTO `t_product` VALUES ('10', '8', '二保焊丝', '二保焊丝', null, '1', null);
INSERT INTO `t_product` VALUES ('11', '8', '埋弧焊丝', '埋弧焊丝', null, '5', null);
INSERT INTO `t_product` VALUES ('12', '9', '百叶轮', '百叶轮', null, '1', null);
INSERT INTO `t_product` VALUES ('13', '8', '药芯焊丝', '药芯焊丝', null, '1', null);
INSERT INTO `t_product` VALUES ('14', '9', '切割片机', '切割片机', null, '1', null);
INSERT INTO `t_product` VALUES ('15', '9', '切割片机', '切割片机', '', null, '品牌名');
INSERT INTO `t_product` VALUES ('16', null, '1111', null, '111', '', '222');
INSERT INTO `t_product` VALUES ('18', '16', '测试二级', null, '', '100', '');

-- ----------------------------
-- Table structure for t_product_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_product_detail`;
CREATE TABLE `t_product_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) DEFAULT NULL,
  `sub_product` varchar(50) DEFAULT NULL COMMENT '小类名称',
  `format` varchar(50) DEFAULT NULL COMMENT '规格',
  `material` varchar(20) DEFAULT NULL COMMENT '材质',
  `remark` varchar(255) DEFAULT NULL,
  `selected` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `product` tinyblob,
  `mapper` tinyblob,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK752CA4CC19BC13A0` (`product_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product_detail
-- ----------------------------
INSERT INTO `t_product_detail` VALUES ('1', '10', '1.2', '20KG/盒', 'ER50-6', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('2', '10', '4.0', '25kg/盒', 'HO8A', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('3', '10', '1.2', '15kg/盒', 'HY-E711(Q)', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('4', '12', '60#', '300片/箱', '煅烧砂', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('5', '12', '80#', '300片/箱', '煅烧砂', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('6', '12', '100#', '300片/箱', '煅烧砂', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('7', '12', '120#', '300片/箱', '煅烧砂', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('8', '14', '400#', '25片/箱', '', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('9', '14', '350#', '25片/箱', '', null, '0', null, 0xACED000573720017636F6D2E73616B692E6D6F64656C2E5450726F647563740D726E633FE784E70200074C0004626173657400124C6A6176612F6C616E672F537472696E673B4C000269647400134C6A6176612F6C616E672F496E74656765723B4C0008706172656E74496471007E00014C000770726F6475637471007E00014C000672656D61726B71007E00014C00047479706571007E00014C0004756E697471007E0001787070707070707070, null);
INSERT INTO `t_product_detail` VALUES ('15', '15', '测试三级', '22', '22', '123', '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('16', '18', '123 ', '123', '123', '备注', '0', null, null, null);

-- ----------------------------
-- Table structure for t_product_type
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
-- Records of t_product_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_supllier_order
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime DEFAULT NULL COMMENT '发货时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态, 1新订单 2: 审核  3已付款 4已收货',
  `amount` decimal(10,5) DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL COMMENT '1、发票已开，2、发票已收',
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order
-- ----------------------------
INSERT INTO `t_supllier_order` VALUES ('9', 'GH20180615001', null, '3', '3210.00000', null, null, null, null);
INSERT INTO `t_supllier_order` VALUES ('11', 'GH20180706001', null, '2', '111.00000', null, null, null, null);
INSERT INTO `t_supllier_order` VALUES ('13', 'GH20180706002', null, '2', '2121.00000', null, null, null, null);

-- ----------------------------
-- Table structure for t_supllier_order_detail
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
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order_detail
-- ----------------------------
INSERT INTO `t_supllier_order_detail` VALUES ('21', '4', '9', '1', '1010', '1010', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('22', '4', '9', '2', '2100', '2100', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('23', '4', '9', '6', '100', '100', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('25', null, '11', '1', '111', '111', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('28', '4', '13', '1', '1121', '1121', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('29', '4', '13', '2', '1000', '1000', '0.000', '1', null);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT '1管理员 2供应商 3客户',
  `user_name` varchar(30) DEFAULT NULL,
  `user_pwd` varchar(50) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('14', null, '1', 'admin', '670b14728ad9902aecba32e22fa4f6bd', '管理员');
INSERT INTO `t_user` VALUES ('17', '3', '3', 'kh', '670b14728ad9902aecba32e22fa4f6bd', '测试客户·');
INSERT INTO `t_user` VALUES ('18', '4', '2', 'gh', '670b14728ad9902aecba32e22fa4f6bd', '测试供货商');
INSERT INTO `t_user` VALUES ('19', '5', '2', 'kh2', '670b14728ad9902aecba32e22fa4f6bd', '测试客户2');
INSERT INTO `t_user` VALUES ('25', '11', '2', 'gh2', '670b14728ad9902aecba32e22fa4f6bd', '供应商2');
INSERT INTO `t_user` VALUES ('26', '12', '2', '111', '670b14728ad9902aecba32e22fa4f6bd', '111');
INSERT INTO `t_user` VALUES ('27', '13', '2', '123', '670b14728ad9902aecba32e22fa4f6bd', '测试注册');

-- ----------------------------
-- Table structure for t_user_product
-- ----------------------------
DROP TABLE IF EXISTS `t_user_product`;
CREATE TABLE `t_user_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) NOT NULL COMMENT '公司id ，拟定一家公司关联一个大类',
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `status` varchar(10) DEFAULT NULL COMMENT '是否默认',
  `role_id` int(10) DEFAULT NULL COMMENT '角色id， 判断是客户还是供应商',
  `price` decimal(7,3) DEFAULT NULL COMMENT '价钱',
  `markup` decimal(7,3) unsigned zerofill DEFAULT '0000.000' COMMENT '管理员追加',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mapper` (`company_id`,`product_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_product
-- ----------------------------
INSERT INTO `t_user_product` VALUES ('83', '3', '1', '', '3', null, null);
INSERT INTO `t_user_product` VALUES ('84', '3', '4', '0', '3', null, null);
INSERT INTO `t_user_product` VALUES ('106', '4', '2', '0', '2', '10.000', '0010.000');
INSERT INTO `t_user_product` VALUES ('107', '4', '5', '1', '2', '20.000', '0010.000');
INSERT INTO `t_user_product` VALUES ('108', '4', '6', '0', '2', '2.000', null);
INSERT INTO `t_user_product` VALUES ('109', '4', '9', null, '2', '2.000', null);
INSERT INTO `t_user_product` VALUES ('112', '14', '1', null, '2', null, null);
INSERT INTO `t_user_product` VALUES ('113', '12', '1', '1', '2', '10.000', '0010.000');
INSERT INTO `t_user_product` VALUES ('115', '12', '4', '1', '2', '0.000', null);
INSERT INTO `t_user_product` VALUES ('120', '12', '2', '1', '2', '35.000', '0035.000');
INSERT INTO `t_user_product` VALUES ('121', '12', '3', null, '2', '0.000', '0010.000');
INSERT INTO `t_user_product` VALUES ('127', '12', '5', '0', '2', '0.000', null);
INSERT INTO `t_user_product` VALUES ('128', '12', '6', '1', '2', '0.000', '0020.000');
INSERT INTO `t_user_product` VALUES ('164', '12', '8', null, '2', '11.000', null);
INSERT INTO `t_user_product` VALUES ('165', '12', '9', null, '2', '0.000', '0010.000');
INSERT INTO `t_user_product` VALUES ('175', '3', '2', null, '3', '0.000', null);
INSERT INTO `t_user_product` VALUES ('176', '4', '1', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('216', '4', '16', null, '2', '0.000', '0000.000');
