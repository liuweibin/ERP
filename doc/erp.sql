/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : erp

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2014-07-01 18:17:19
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `agents_group_role_resource_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `agents_group_role_resource_tbl`;
CREATE TABLE `agents_group_role_resource_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL COMMENT '角色ID',
  `resource_id` int(11) unsigned NOT NULL COMMENT '用户组ID',
  PRIMARY KEY (`id`),
  KEY `resource_id` (`resource_id`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE,
  CONSTRAINT `agents_group_role_resource_tbl_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `agents_user_group_role_tbl` (`id`),
  CONSTRAINT `agents_group_role_resource_tbl_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `agents_resource_tbl` (`id`),
  CONSTRAINT `agents_group_role_resource_tbl_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `agents_user_group_role_tbl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='代理商用户组角色关系表';

-- ----------------------------
-- Records of agents_group_role_resource_tbl
-- ----------------------------
INSERT INTO `agents_group_role_resource_tbl` VALUES ('178', '2', '5');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('179', '2', '18');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('180', '2', '7');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('181', '2', '4');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('182', '2', '8');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('183', '2', '16');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('184', '2', '19');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('185', '2', '17');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('186', '2', '15');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('187', '2', '6');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('188', '2', '11');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('189', '2', '2');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('195', '1', '2');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('196', '1', '19');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('197', '1', '18');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('198', '1', '13');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('199', '1', '9');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('200', '1', '14');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('201', '1', '25');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('202', '1', '22');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('204', '1', '11');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('205', '1', '12');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('206', '1', '16');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('207', '1', '27');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('208', '1', '5');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('209', '1', '17');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('210', '1', '20');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('211', '1', '4');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('213', '1', '15');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('214', '1', '21');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('215', '1', '6');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('216', '1', '26');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('217', '1', '8');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('218', '1', '7');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('219', '1', '28');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('220', '1', '29');
INSERT INTO `agents_group_role_resource_tbl` VALUES ('221', '1', '30');

-- ----------------------------
-- Table structure for `agents_resource_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `agents_resource_tbl`;
CREATE TABLE `agents_resource_tbl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号,Key,自增',
  `pid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL COMMENT '资源名称',
  `url` varchar(100) NOT NULL COMMENT '资源url',
  `enabled` int(2) NOT NULL DEFAULT '1' COMMENT '是否可用（可用：1，不可用：0）',
  `remark` varchar(64) DEFAULT NULL COMMENT '注解',
  `create_time` varchar(32) DEFAULT NULL COMMENT '创建时间，格式如下:yyyy-mm-dd hh:mi:si',
  `order` int(2) DEFAULT NULL COMMENT '显示顺序',
  `isNode` int(2) DEFAULT '0' COMMENT '是否有子节点(0:没有子节点，1有子节点)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='代理商资源表';

-- ----------------------------
-- Records of agents_resource_tbl
-- ----------------------------
INSERT INTO `agents_resource_tbl` VALUES ('2', '16', 'goodsSales', '/goodsSales/realityGoodsSalesPage.do', '1', '实体商品查询', '', '0', '0');
INSERT INTO `agents_resource_tbl` VALUES ('3', '19', 'empGroupPage', '/empManage.do?type=empGroupPage', '1', '员工分组管理', '', '6', '0');
INSERT INTO `agents_resource_tbl` VALUES ('4', '19', 'accountRecordQuery', '/accountRecord.do?type=accountRecordQuery', '1', '财务记录查询', null, '3', '0');
INSERT INTO `agents_resource_tbl` VALUES ('5', '17', 'transferPoint', '/account.do?type=transferPoint', '1', '转信用点', null, '2', '0');
INSERT INTO `agents_resource_tbl` VALUES ('6', '17', 'buyCredit', '/credit/toBuyCredit.do', '1', '购买信用点', null, '3', '0');
INSERT INTO `agents_resource_tbl` VALUES ('7', '18', 'memberManager', '/agentsManage.do?type=memberManager&tab=1', '1', '下级基本信息', '', '2', '0');
INSERT INTO `agents_resource_tbl` VALUES ('8', '19', 'goodsPriceTbl', '/goodsManager/goodsPriceTbl/getByParamsPage.do', '1', '商品进价查询', null, '0', '0');
INSERT INTO `agents_resource_tbl` VALUES ('9', '19', 'tradingRecord', '/tradingRecord.do?queryTime=all', '1', '交易记录查询', null, '1', '0');
INSERT INTO `agents_resource_tbl` VALUES ('10', '19', 'empManage', '/empManage.do?type=empManage', '1', '员工管理', null, '5', '0');
INSERT INTO `agents_resource_tbl` VALUES ('11', '19', 'customUser', '/customUser.do?type=customUser', '1', '客户管理', null, '5', '0');
INSERT INTO `agents_resource_tbl` VALUES ('12', '17', 'correctOrder', '/correctOrder/correctOrderView.do', '1', '冲  正', null, null, '0');
INSERT INTO `agents_resource_tbl` VALUES ('13', '19', 'correctOrderList', '/correctOrder/correctOrderListView.do', '1', '冲正记录查询', null, '3', '0');
INSERT INTO `agents_resource_tbl` VALUES ('14', '15', 'gamesPage', '/goodsManager/commonGoodsPage.do', '1', '常用商品', null, null, '0');
INSERT INTO `agents_resource_tbl` VALUES ('15', '0', 'common', '/tradingRecord/printTest.do', '0', '常用', null, '0', '1');
INSERT INTO `agents_resource_tbl` VALUES ('16', '0', 'query', '', '1', '商品查询', null, '1', '1');
INSERT INTO `agents_resource_tbl` VALUES ('17', '0', 'operate', '', '1', '操作', null, '2', '1');
INSERT INTO `agents_resource_tbl` VALUES ('18', '0', 'my', '', '1', '下级', null, '3', '1');
INSERT INTO `agents_resource_tbl` VALUES ('19', '0', 'client', '', '1', '我的账户', null, '4', '1');
INSERT INTO `agents_resource_tbl` VALUES ('20', '19', 'supplierManage', '/supplier/supplierManageNew.do', '1', '供货/退货管理', null, '4', '0');
INSERT INTO `agents_resource_tbl` VALUES ('21', '19', 'myBaseInfo', '/account.do?type=baseInfoPage', '1', '我的信息', null, '5', '0');
INSERT INTO `agents_resource_tbl` VALUES ('22', '18', 'agentsInfoPage', '/agentsManage.do?type=memberManager&tab=2', '1', '下级账务', null, '0', '0');
INSERT INTO `agents_resource_tbl` VALUES ('25', '18', '', '/agentsManage.do?type=memberManager&tab=3', '1', '下级商品', null, '1', '0');
INSERT INTO `agents_resource_tbl` VALUES ('26', '18', '', '/agentsManage.do?type=memberManager&tab=4', '1', '下级订单', '', '3', '0');
INSERT INTO `agents_resource_tbl` VALUES ('27', '18', 'agentRegister', '/agentsManage.do?type=memberManager&tab=5', '1', '下级代理商注册', null, '4', '0');
INSERT INTO `agents_resource_tbl` VALUES ('28', '19', '', '/accountRecord.do?type=dayAccount', '1', '日对账', null, '0', '0');
INSERT INTO `agents_resource_tbl` VALUES ('29', '16', 'virtualGoodsSales', '/goodsSales/virtualGoodsSalesPage.do', '1', '虚拟商品查询', null, '1', '0');
INSERT INTO `agents_resource_tbl` VALUES ('30', '19', '', '/accountRecord.do?type=gdCzTj', '1', '广东充值统计', null, null, '0');

-- ----------------------------
-- Table structure for `agents_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `agents_tbl`;
CREATE TABLE `agents_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号,Key,自增',
  `agents_code` varchar(8) DEFAULT NULL COMMENT '代理商编号(全局唯一)',
  `parent_id` int(11) NOT NULL COMMENT '代理商上级ID,-1表示总经销商',
  `name` varchar(48) NOT NULL COMMENT '代理商名称',
  `id_number` varchar(32) NOT NULL COMMENT '身份证号码',
  `type` smallint(6) DEFAULT NULL COMMENT '代理商类别：1：直属经销商2：非直属经销商,3为总代理',
  `max_sub_agents` int(11) DEFAULT NULL COMMENT '可发展下家数',
  `balance` int(11) DEFAULT '0' COMMENT '余额（信用点）可用余额= balance-bail',
  `bail` int(11) DEFAULT '0' COMMENT '保证金',
  `balance_alarm` int(11) DEFAULT NULL COMMENT '余额告警',
  `super_password` varchar(48) DEFAULT NULL COMMENT '超级密码, 涉及资金的需要主管临时授权',
  `audit_status` smallint(6) DEFAULT '0' COMMENT '0:未审核1:审核通过、2:审核未通过、3:删除',
  `area_id` int(10) unsigned DEFAULT NULL COMMENT '所属地区ID',
  `batch_level_id` int(11) unsigned NOT NULL COMMENT '批价级别',
  `shop_type_id` int(11) unsigned DEFAULT NULL COMMENT '店铺类型ID',
  `linkman` varchar(32) DEFAULT NULL COMMENT '联系人',
  `fixed_phone` varchar(16) DEFAULT NULL COMMENT '固定电话',
  `mobile_phone` varchar(16) DEFAULT NULL COMMENT '手机',
  `qq` varchar(16) DEFAULT NULL COMMENT 'QQ',
  `email` varchar(32) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL COMMENT '详细地址',
  `linkman_second` varchar(32) DEFAULT NULL,
  `fixed_phone_second` varchar(16) DEFAULT NULL COMMENT '固定电话2',
  `mobile_phone_second` varchar(16) DEFAULT NULL COMMENT '手机2',
  `qq_second` varchar(16) DEFAULT NULL COMMENT 'QQ2',
  `email_second` varchar(32) DEFAULT NULL COMMENT '邮件地址2',
  `address_second` varchar(128) DEFAULT NULL COMMENT '详细地址2',
  `registered_time` varchar(32) DEFAULT NULL,
  `username_register` varchar(48) DEFAULT NULL COMMENT '代理商注册登陆用户名，审核通过后写入agents_user_tbl',
  `password_register` varchar(48) DEFAULT NULL COMMENT '代理商注册登陆密码，审核通过后写入agents_user_tbl',
  `node_key` varchar(128) DEFAULT NULL COMMENT '节点索引，用来查询',
  `node_level` int(11) DEFAULT NULL COMMENT '节点等级，表示当前节点到根节点的距离，参考代理商树形结构举例',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(32) DEFAULT NULL COMMENT '创建时间，格式如下:yyyy-mm-dd hh:mi:si',
  `arer_id_defaul` int(10) DEFAULT '-1' COMMENT '所属地区ID充值时默认取的值',
  PRIMARY KEY (`id`),
  KEY `area_id` (`area_id`) USING BTREE,
  KEY `batch_level_id` (`batch_level_id`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `shop_type_id` (`shop_type_id`) USING BTREE,
  KEY `agent_code` (`agents_code`) USING BTREE,
  CONSTRAINT `agents_tbl_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area_tbl` (`id`),
  CONSTRAINT `agents_tbl_ibfk_2` FOREIGN KEY (`batch_level_id`) REFERENCES `batch_level_tbl` (`id`),
  CONSTRAINT `agents_tbl_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `agents_tbl` (`id`),
  CONSTRAINT `agents_tbl_ibfk_4` FOREIGN KEY (`shop_type_id`) REFERENCES `shop_type_tbl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='代理商表';

-- ----------------------------
-- Records of agents_tbl
-- ----------------------------
INSERT INTO `agents_tbl` VALUES ('-1', '-1', '-1', '', '', '1', '500', '0', '0', '0', '', '1', '1', '1', '1', '', '', '', '', '', '', '', '', '', '', '', '', '2013-06-14 06:48:27', '', '', '-', '0', '', '2013-06-21 03:13:15', '0');
INSERT INTO `agents_tbl` VALUES ('1', 'A0000001', '-1', '总代理', '421116198803115334', '3', '500', '49500', '0', '100000', '25d55ad283aa400af464c76d713c07ad', '1', '1', '1', '4', 'xiaozhang', '0211111231', '18623421434', '9876543', '3788367@qq.com', '123', '345', null, null, '234', 'wer', 'ew', '2013-06-14 06:48:27', 'dzt', '', '1-', '1', 'werewrwrewr', '2013-06-08 12:12:12', '7');
INSERT INTO `agents_tbl` VALUES ('2', 'A0000002', '1', '翼通通讯宇翔经营部', '441423198201260075', '1', '500', '50600', '0', '111100', '25d55ad283aa400af464c76d713c07ad', '1', '1', '2', '3', '杜宇翔', '1', '13427917122', '75020810', '75020810@qq.com', '深圳市光明新区公明镇马山头', null, null, null, null, null, null, '2014-04-22 08:56:40', '13427917512', 'c2610f901735286e712ef0a11df1535b', '1-2-', '2', null, '2014-04-22 08:56:40', '12');
INSERT INTO `agents_tbl` VALUES ('3', 'A0000003', '1', '13800138000', '441423200808151714', '1', '50', '12500', '0', '50000', '25d55ad283aa400af464c76d713c07ad', '1', '1', '2', '1', '', '', '13800138000', '', '', '', null, null, null, null, null, null, '2014-04-29 13:56:35', '13800138000', 'e10adc3949ba59abbe56e057f20f883e', '1-3-', '2', null, '2014-04-29 13:56:35', '1');
INSERT INTO `agents_tbl` VALUES ('4', 'A0000004', '1', '13800138000', '441423200808151714', '1', '50', '0', '0', '50000', '25d55ad283aa400af464c76d713c07ad', '3', '1', '2', '1', '', '', '13800138000', '', '', '', null, null, null, null, null, null, '2014-04-29 13:57:54', '13800138001', 'e10adc3949ba59abbe56e057f20f883e', '1-4-', '2', null, '2014-04-29 13:57:54', '1');
INSERT INTO `agents_tbl` VALUES ('5', 'A0000005', '1', 'zl', '420116198801115337', '1', '20', '1400', '0', '2000', '25d55ad283aa400af464c76d713c07ad', '1', '14', '2', '1', '', '', '18916290156', '', '', '', null, null, null, null, null, null, '2014-05-23 10:23:31', '18916290156', 'e10adc3949ba59abbe56e057f20f883e', '1-5-', '2', null, '2014-05-23 10:23:31', '14');
INSERT INTO `agents_tbl` VALUES ('6', 'A0000006', '1', 'hwg', '420117199901215224', '1', '20', '200', '0', '2000', '25d55ad283aa400af464c76d713c07ad', '1', '1', '2', '1', '', '', '18916290156', '', '', '', null, null, null, null, null, null, '2014-05-23 10:41:46', '13761502011', 'e10adc3949ba59abbe56e057f20f883e', '1-6-', '2', null, '2014-05-23 10:41:46', '1');
INSERT INTO `agents_tbl` VALUES ('7', 'A0000007', '1', 'hwg2', '420117199901215224', '1', '20', '12300', '0', '2000', '25d55ad283aa400af464c76d713c07ad', '1', '1', '2', '1', '', '', '18916290156', '', '', '', null, null, null, null, null, null, '2014-05-23 10:42:51', '13761502012', 'e10adc3949ba59abbe56e057f20f883e', '1-7-', '2', null, '2014-05-23 10:42:51', '1');
INSERT INTO `agents_tbl` VALUES ('8', 'A0000008', '5', 'zl-2', '420116198702215332', '2', '5', '0', '0', '500', '25d55ad283aa400af464c76d713c07ad', '1', '14', '3', '3', '', '', '13751502011', '', '', '', null, null, null, null, null, null, '2014-05-23 10:56:05', '13751502011', 'e10adc3949ba59abbe56e057f20f883e', '1-5-8-', '3', null, '2014-05-23 10:56:05', '0');

-- ----------------------------
-- Table structure for `agents_user_group_role_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `agents_user_group_role_tbl`;
CREATE TABLE `agents_user_group_role_tbl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号,Key,自增',
  `agents_code` varchar(8) NOT NULL COMMENT '代理商编号（-1表示共用组）',
  `group_code` varchar(32) NOT NULL COMMENT '用户组编号',
  `group_name` varchar(48) NOT NULL COMMENT '用户组名',
  `status` smallint(1) NOT NULL COMMENT '状态：0：停用 、1：启用',
  `remark` varchar(64) DEFAULT NULL,
  `create_time` varchar(32) NOT NULL COMMENT '创建时间，格式如下:yyyy-mm-dd hh:mi:si',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='代理商用户组角色表';

-- ----------------------------
-- Records of agents_user_group_role_tbl
-- ----------------------------
INSERT INTO `agents_user_group_role_tbl` VALUES ('1', '-1', 'G0000000000000000000000000000001', '默认代理商组', '1', '默认代理商组', '2013-06-18 05:04:58');
INSERT INTO `agents_user_group_role_tbl` VALUES ('2', '-2', 'G0000000000000000000000000000002', '默认员工组', '1', '默认员工组', '2013-06-18 05:04:58');

-- ----------------------------
-- Table structure for `agents_user_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `agents_user_tbl`;
CREATE TABLE `agents_user_tbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号,Key,自增',
  `agents_id` int(11) NOT NULL COMMENT '代理商ID',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组ID',
  `username` varchar(48) NOT NULL COMMENT '代理商登陆用户名',
  `password` varchar(48) NOT NULL COMMENT '代理商登陆密码',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机号码',
  `real_name` varchar(48) DEFAULT NULL COMMENT '真实姓名',
  `user_type` smallint(6) DEFAULT NULL COMMENT '用户类型 0:代理商,1:普通操作用户',
  `login_type` smallint(6) DEFAULT NULL COMMENT '登录类型 0:WEB:1手机',
  `bind_type` smallint(6) DEFAULT '0' COMMENT 'PC 绑定，0:不绑定，1：IP地址，2：mac地址',
  `bind_value` varchar(32) DEFAULT NULL COMMENT '绑定值',
  `mobile_bind_type` smallint(6) DEFAULT '0' COMMENT '手机 绑定，0:不绑定，1：设备编号，2：mac地址',
  `mobile_bind_value` varchar(32) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL COMMENT '账户状态（0表示冻结，1表示正常使用）',
  `last_login_time` varchar(32) DEFAULT NULL COMMENT '最后一次登陆时间',
  `last_login_ip` varchar(32) DEFAULT NULL COMMENT '最后一次登陆IP',
  `last_login_type` smallint(32) DEFAULT NULL COMMENT '登录类型 0:WEB:1手机',
  `last_modify_pwd_time` varchar(32) DEFAULT NULL COMMENT '最后修改密码时间',
  `remark` varchar(64) DEFAULT NULL,
  `create_time` varchar(32) DEFAULT NULL COMMENT '创建时间，格式如下:yyyy-mm-dd hh:mi:si',
  `agents_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`agents_id`),
  KEY `agents_id` (`agents_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  CONSTRAINT `agents_user_tbl_ibfk_1` FOREIGN KEY (`agents_id`) REFERENCES `agents_tbl` (`id`),
  CONSTRAINT `agents_user_tbl_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `agents_user_group_role_tbl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='代理商用户表（前台）';

-- ----------------------------
-- Records of agents_user_tbl
-- ----------------------------
INSERT INTO `agents_user_tbl` VALUES ('1', '1', '1', '13751867590', 'e10adc3949ba59abbe56e057f20f883e', '13333333333', 'link', '0', '0', '0', '', '0', '', '1', '2014-06-24 09:50:20', '192.168.1.105', '0', '2014-06-20 15:56:18', '123', '2013-08-06 11:11:27', 'A0000001');
INSERT INTO `agents_user_tbl` VALUES ('2', '2', '1', '13427917512', 'e10adc3949ba59abbe56e057f20f883e', '13427917512', '杜宇翔', '0', null, '0', null, '0', null, '1', '2014-06-24 09:43:15', '192.168.1.105', null, null, null, '2014-04-22 08:56:40', null);
INSERT INTO `agents_user_tbl` VALUES ('3', '3', '1', '13800138000', 'e10adc3949ba59abbe56e057f20f883e', '13800138000', '', '0', null, '0', null, '0', null, '1', '2014-05-21 09:00:50', '192.168.1.106', null, null, null, '2014-04-29 13:56:35', null);
INSERT INTO `agents_user_tbl` VALUES ('4', '4', '1', '13800138001', 'e10adc3949ba59abbe56e057f20f883e', '13800138000', '', '0', null, '0', null, '0', null, '1', null, null, null, null, null, '2014-04-29 13:57:54', null);
INSERT INTO `agents_user_tbl` VALUES ('5', '5', '1', '18916290156', 'e10adc3949ba59abbe56e057f20f883e', '18916290156', '', '0', null, '0', null, '0', null, '1', '2014-05-23 10:54:37', '127.0.0.1', null, null, null, '2014-05-23 10:23:31', null);
INSERT INTO `agents_user_tbl` VALUES ('6', '6', '1', '13761502011', 'e10adc3949ba59abbe56e057f20f883e', '18916290156', '', '0', null, '0', null, '0', null, '1', '2014-06-17 11:18:08', '192.168.1.108', null, null, null, '2014-05-23 10:41:46', null);
INSERT INTO `agents_user_tbl` VALUES ('7', '7', '1', '13761502012', 'e10adc3949ba59abbe56e057f20f883e', '18916290156', '', '0', null, '0', null, '0', null, '1', '2014-06-12 11:16:09', '192.168.1.105', null, null, null, '2014-05-23 10:42:51', null);
INSERT INTO `agents_user_tbl` VALUES ('8', '8', '1', '13751502011', 'e10adc3949ba59abbe56e057f20f883e', '13751502011', '', '0', null, '0', null, '0', null, '1', '2014-06-13 10:16:18', '192.168.1.108', null, null, null, '2014-05-23 10:56:05', null);
