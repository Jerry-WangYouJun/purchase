/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50130
Source Host           : localhost:3306
Source Database       : order

Target Server Type    : MYSQL
Target Server Version : 50130
File Encoding         : 65001

Date: 2018-07-25 13:58:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_company`
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES ('1', '青岛精工电子衡器有限公司', '王经理', '青岛市即墨区华山镇西桥头村', '汽车衡', '五星', '', '3', 'JGDZ2018', '13606345010', '913702822647245478', '700000295881', '');
INSERT INTO `t_company` VALUES ('2', '德州恒远焊材有限公司', '韩总', '德州运河经济开发区鑫源大道19号', '气体保护焊丝', '五星', '', '2', 'DZHY2018', '05345013823', '91371400672246054M', '1612002119025982277', '德恒运隆');
INSERT INTO `t_company` VALUES ('3', '测试客户', '联系人1', '卡萨布兰卡', '业务1', '五星', '', '3', 'kh1', '1582231231', '111', '123123123234123123', '');
INSERT INTO `t_company` VALUES ('4', '测试供应商1', '供货商', '敖德萨多', '业务', '五星', '', '2', 'gh1', '15822312312', '123', '199283472348', 'gy1');
INSERT INTO `t_company` VALUES ('5', '11123', '111', '111', '111', '一星', '', '2', '111', '111', '111', '111', '1111');
INSERT INTO `t_company` VALUES ('6', '众联焊割', '王经理', '1111111111111111111', '111111111', '五星', '', '2', '111111111111', '111111111111', '111111111111111111111111111', '111111111111111111', '平台分配');

-- ----------------------------
-- Table structure for `t_confirm`
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
INSERT INTO `t_confirm` VALUES ('2', '10', '', null);
INSERT INTO `t_confirm` VALUES ('3', '22', '', null);

-- ----------------------------
-- Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL COMMENT '公司id',
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
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  `percent` varchar(255) DEFAULT NULL,
  `confirm_id` int(11) DEFAULT NULL,
  `urgent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('2', '1', 'KH20180710001', '2018-07-10 22:20:03', null, '2018-07-10 22:22:50', '2018-07-10 22:24:51', '4', '0.00000', null, '青岛精工电子衡器有限公司', '1', '2', '2018-07-10 22:26:17', '2018-07-10 22:27:28', '100', null, null);
INSERT INTO `t_order` VALUES ('4', '1', 'KH20180710002', '2018-07-10 22:34:07', null, null, null, '1', '0.00000', null, '青岛精工电子衡器有限公司', '1', null, null, null, null, null, null);
INSERT INTO `t_order` VALUES ('5', '1', 'KH20180710003', '2018-07-10 22:59:38', null, '2018-07-15 11:33:08', null, '3', '0.00000', null, '青岛精工电子衡器有限公司', '0', '2', '2018-07-15 11:43:49', '2018-07-15 12:13:24', '100', null, null);
INSERT INTO `t_order` VALUES ('6', '1', 'KH20180715001', '2018-07-15 16:01:58', null, '2018-07-15 16:02:26', null, '5', '0.00000', null, '青岛精工电子衡器有限公司', '1', null, null, null, '100', null, null);
INSERT INTO `t_order` VALUES ('7', '1', 'KH20180715002', '2018-07-15 16:03:43', null, '2018-07-15 16:04:02', null, '5', '0.00000', null, '青岛精工电子衡器有限公司', '1', null, null, null, '100', null, null);
INSERT INTO `t_order` VALUES ('8', '1', 'KH20180715003', '2018-07-15 16:09:27', null, '2018-07-15 16:09:41', '2018-07-23 13:12:03', '4', '0.00000', null, '青岛精工电子衡器有限公司', '1', null, null, null, '100', null, null);
INSERT INTO `t_order` VALUES ('9', '3', 'KH20180722001', '2018-07-22 02:10:52', '2018-07-22 00:00:00', '2018-07-22 02:18:20', '2018-07-22 02:19:55', '4', '0.00000', null, '测试客户', null, '2', '2018-07-22 02:18:45', '2018-07-22 02:19:50', '100', '3', null);
INSERT INTO `t_order` VALUES ('10', '3', 'KH20180722002', '2018-07-22 02:16:22', null, '2018-07-22 02:18:31', '2018-07-22 02:23:43', '5', '0.00000', null, '测试客户', null, '1', '2018-07-23 12:32:27', '2018-07-22 02:23:58', '100', null, '1');
INSERT INTO `t_order` VALUES ('11', '3', 'KH20180723001', '2018-07-23 10:53:27', null, '2018-07-23 13:25:41', null, '3', '0.00000', null, '测试客户', null, null, null, null, '100', '2', null);
INSERT INTO `t_order` VALUES ('13', '1', 'KH20180723002', '2018-07-23 13:17:51', null, null, null, '1', '0.00000', null, '青岛精工电子衡器有限公司', null, null, null, null, null, null, '1');
INSERT INTO `t_order` VALUES ('14', '1', 'KH20180723003', '2018-07-23 13:35:58', null, '2018-07-23 13:40:03', null, '3', '0.00000', null, '青岛精工电子衡器有限公司', null, null, null, null, '100', '1', null);
INSERT INTO `t_order` VALUES ('15', '3', 'KH20180725001', '2018-07-25 09:33:40', null, null, null, '1', '0.00000', null, '测试客户', null, null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for `t_order_detail`
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES ('1', '1', '1', '1', '55', '', null);
INSERT INTO `t_order_detail` VALUES ('2', '2', '2', '1100', '33', '金桥', null);
INSERT INTO `t_order_detail` VALUES ('3', '3', '2', '1111', '11', '11', null);
INSERT INTO `t_order_detail` VALUES ('4', '4', '2', '111', '111', '111', null);
INSERT INTO `t_order_detail` VALUES ('5', '4', '8', '111', '111', '111', null);
INSERT INTO `t_order_detail` VALUES ('6', '4', '1', '111111', '111111', '111', null);
INSERT INTO `t_order_detail` VALUES ('7', '4', '1', '1111', '1111', '1111', null);
INSERT INTO `t_order_detail` VALUES ('8', '5', '2', '33', '222', '333', null);
INSERT INTO `t_order_detail` VALUES ('9', '6', '10', '100', '0', '德恒运隆', null);
INSERT INTO `t_order_detail` VALUES ('10', '7', '10', '300', '0', '德恒运隆', null);
INSERT INTO `t_order_detail` VALUES ('11', '8', '1', '1000', '1010', '德恒运隆', null);
INSERT INTO `t_order_detail` VALUES ('12', '9', '4', '10', '0', '4', '');
INSERT INTO `t_order_detail` VALUES ('13', '10', '4', '100', null, '2', '');
INSERT INTO `t_order_detail` VALUES ('14', '11', '4', '999', '0', '2', '');
INSERT INTO `t_order_detail` VALUES ('15', '12', '4', '1000', '20', '4', '');
INSERT INTO `t_order_detail` VALUES ('16', '13', '2', '1000', null, '2', '');
INSERT INTO `t_order_detail` VALUES ('17', '13', '8', '20000', null, '4', '');
INSERT INTO `t_order_detail` VALUES ('18', '14', '1', '100000', '0', '2', '');
INSERT INTO `t_order_detail` VALUES ('19', '15', '4', '9', null, '4', '');
INSERT INTO `t_order_detail` VALUES ('20', '15', '4', '2', null, '4', '');

-- ----------------------------
-- Table structure for `t_order_mapping`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping` (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_mapping
-- ----------------------------
INSERT INTO `t_order_mapping` VALUES ('5', '1', '1');
INSERT INTO `t_order_mapping` VALUES ('6', '2', '2');
INSERT INTO `t_order_mapping` VALUES ('6', '3', '3');
INSERT INTO `t_order_mapping` VALUES ('7', '3', '4');
INSERT INTO `t_order_mapping` VALUES ('6', '4', '5');
INSERT INTO `t_order_mapping` VALUES ('7', '4', '6');
INSERT INTO `t_order_mapping` VALUES ('8', '4', '7');

-- ----------------------------
-- Table structure for `t_product`
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('8', null, '焊丝', '', '公斤', null, null);
INSERT INTO `t_product` VALUES ('9', '0', '磨具', null, '片', '0', '');
INSERT INTO `t_product` VALUES ('10', '8', '气体保焊丝', null, '', '100', '');
INSERT INTO `t_product` VALUES ('11', '8', '埋弧焊丝', '埋弧焊丝', null, '55', null);
INSERT INTO `t_product` VALUES ('12', '9', '百叶轮', '百叶轮', null, '1', null);
INSERT INTO `t_product` VALUES ('13', '8', '药芯焊丝', '药芯焊丝', null, '1', null);
INSERT INTO `t_product` VALUES ('14', '9', '切割片机', '切割片机', null, '1', null);
INSERT INTO `t_product` VALUES ('15', '9', '切割片机', '切割片机', '', null, '品牌名');
INSERT INTO `t_product` VALUES ('17', '8', '测试焊丝', null, '', '0', '');
INSERT INTO `t_product` VALUES ('18', '8', '抛光片', null, '片', '100', '');
INSERT INTO `t_product` VALUES ('19', '8', '埋弧焊丝', null, '', '100', '');
INSERT INTO `t_product` VALUES ('20', '0', '油漆', null, '公斤', '1000', '');
INSERT INTO `t_product` VALUES ('21', '0', '11', null, '111', '0', '111');
INSERT INTO `t_product` VALUES ('22', '20', '红漆', null, '', '10', '');

-- ----------------------------
-- Table structure for `t_product_detail`
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product_detail
-- ----------------------------
INSERT INTO `t_product_detail` VALUES ('1', '10', '1.2', '20KG/盒', 'ER50-6', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('2', '10', '4.0', '25kg/盒', 'HO8A', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('3', '10', '1.2', '15kg/盒', 'HY-E711(Q)', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('4', '12', '60#', '300片/箱', '煅烧砂', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('5', '12', '80#', '300片/箱', '煅烧砂', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('6', '12', '100#', '300片/箱', '煅烧砂', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('7', '12', '120#', '300片/箱', '煅烧砂', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('8', '14', '400#', '25片/箱', '', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('9', '14', '350#', '25片/箱', '', null, '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('10', '10', 'Φ1.0', '20KG/盒', 'ER50-6', '', '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('12', '17', '测试测试', '111', '', '', '0', null, null, null);
INSERT INTO `t_product_detail` VALUES ('13', '10', '0.8', '20KG/盒', 'ER70-6', '', '0', null, null, null);

-- ----------------------------
-- Table structure for `t_product_type`
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
-- Table structure for `t_supllier_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime DEFAULT NULL COMMENT '发货时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态, 1新订单 2: 审核  3已付款 4已收货',
  `amount` decimal(10,5) DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order
-- ----------------------------
INSERT INTO `t_supllier_order` VALUES ('3', 'GH20180715001', null, '2', '400.00000', null, null, null, null);
INSERT INTO `t_supllier_order` VALUES ('4', 'GH20180715002', null, '2', '1400.00000', null, null, null, null);
INSERT INTO `t_supllier_order` VALUES ('5', 'GH20180722001', null, '4', '10.00000', null, '2', '2018-07-22 02:22:01', '2018-07-22 02:23:04');

-- ----------------------------
-- Table structure for `t_supllier_order_detail`
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order_detail
-- ----------------------------
INSERT INTO `t_supllier_order_detail` VALUES ('5', '2', '3', '10', '400', '400', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('6', '2', '4', '1', '1000', '1000', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('7', '2', '4', '10', '400', '400', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('8', '4', '5', '4', '10', '10', '0.000', '1', null);

-- ----------------------------
-- Table structure for `t_user`
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('14', null, '1', 'admin', '670b14728ad9902aecba32e22fa4f6bd', '管理员');
INSERT INTO `t_user` VALUES ('15', '1', '3', 'JGDZ2018', 'e10adc3949ba59abbe56e057f20f883e', '青岛精工电子衡器有限公司');
INSERT INTO `t_user` VALUES ('16', '2', '2', 'DZHY2018', '670b14728ad9902aecba32e22fa4f6bd', '德州恒远焊材有限公司');
INSERT INTO `t_user` VALUES ('17', '3', '3', 'kh1', '202cb962ac59075b964b07152d234b70', '测试客户');
INSERT INTO `t_user` VALUES ('18', '4', '2', 'gh1', '202cb962ac59075b964b07152d234b70', '测试供应商1');
INSERT INTO `t_user` VALUES ('19', '5', '2', '111', '698d51a19d8a121ce581499d7b701668', '11123');
INSERT INTO `t_user` VALUES ('20', '6', '2', '111111111111', '670b14728ad9902aecba32e22fa4f6bd', '众联焊割');

-- ----------------------------
-- Table structure for `t_user_product`
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
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_product
-- ----------------------------
INSERT INTO `t_user_product` VALUES ('265', '1', '4', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('266', '1', '5', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('267', '1', '6', '0', '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('268', '1', '7', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('278', '1', '9', '0', '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('304', '3', '4', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('312', '3', '5', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('322', '4', '4', null, '2', '20.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('323', '4', '8', null, '2', '100.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('354', '2', '13', null, '2', '0.000', '0009.000');
INSERT INTO `t_user_product` VALUES ('379', '2', '12', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('380', '2', '1', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('381', '2', '2', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('382', '2', '3', '1', '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('383', '2', '10', null, '2', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('395', '1', '8', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('404', '1', '1', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('405', '1', '2', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('406', '1', '3', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('407', '1', '10', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('408', '1', '13', null, '3', '0.000', '0000.000');
INSERT INTO `t_user_product` VALUES ('415', '1', '12', null, '3', '0.000', '0000.000');
