/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : easylife

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2015-12-10 11:34:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_costrecord`
-- ----------------------------
DROP TABLE IF EXISTS `t_costrecord`;
CREATE TABLE `t_costrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cost` float NOT NULL,
  `costFor` varchar(255) DEFAULT NULL,
  `costdate` date DEFAULT NULL,
  `mark` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_costrecord
-- ----------------------------
INSERT INTO `t_costrecord` VALUES ('5', '10', '买菜', '2015-11-04', '买菜', '1', '2', null, '0');
INSERT INTO `t_costrecord` VALUES ('6', '40', '买菜', '2015-11-05', '买菜', '1', '2', '/upload/costrecord/04cf33cc-6150-4328-af0e-f5e7be015775.png', '0');
INSERT INTO `t_costrecord` VALUES ('7', '32', '买菜', '2015-11-04', '买菜', '1', '1', null, '0');
INSERT INTO `t_costrecord` VALUES ('8', '250', '饮水机', '2015-11-07', '饮水机饮水机饮水机', '1', '2', null, '0');
INSERT INTO `t_costrecord` VALUES ('9', '100', '买菜+买米', '2015-11-07', '菜+20斤米', '1', '1', null, '0');
INSERT INTO `t_costrecord` VALUES ('10', '37', '买菜', '2015-11-08', '买菜', '1', '2', '/upload/costrecord/6aadaa54-74a8-4bc8-a71c-8325a5a50936.png', '0');
INSERT INTO `t_costrecord` VALUES ('11', '50', '买零食', '2015-11-09', '买零食', '1', '3', '/upload/costrecord/a557de52-bb8b-415c-bf33-d4a57dd395a4.png', '0');
INSERT INTO `t_costrecord` VALUES ('12', '222', '222', '2015-11-10', '222', '1', '1', '/upload/costrecord/5643b8c7-c89b-4a9d-931e-7b077be4f9e2.png', '0');
INSERT INTO `t_costrecord` VALUES ('13', '0', null, '2015-11-06', null, '1', '', null, null);
INSERT INTO `t_costrecord` VALUES ('14', '10', 'sdasd', '2015-12-07', 'sdasdasd', '0', '1', null, '0');
INSERT INTO `t_costrecord` VALUES ('15', '20', '222', '2015-12-08', '23123', '1', '1', null, '0');
INSERT INTO `t_costrecord` VALUES ('16', '25', '123131', '2015-12-08', '11111', '1', '2', null, '0');
INSERT INTO `t_costrecord` VALUES ('17', '555', '555', '2015-12-08', '555', '0', '2', 'upload/costrecord/44c45812-9f90-4649-b8ea-64412f5a2856.png', '0');
INSERT INTO `t_costrecord` VALUES ('18', '666', '666', '2015-12-09', '666', '0', '3', 'upload/costrecord/e0c453df-2971-402b-b47d-f3a0985aa5ea.png', '0');
INSERT INTO `t_costrecord` VALUES ('19', '111', '111', '2015-12-08', '111', '0', '1', 'upload/costrecord/1ee9fca7-13d5-4486-84de-5a213aa5ca6f.png', '0');
INSERT INTO `t_costrecord` VALUES ('20', '222', '222', '2015-12-08', '222', '0', '3', 'upload/costrecord/b4fdec1e-66b0-487b-aa7a-696d6bb775a4.png', '0');
INSERT INTO `t_costrecord` VALUES ('21', '333', '333', '2015-12-07', '333', '0', '3', 'upload/costrecord/87769068-265a-47eb-b122-22ca1179b0e7.png', '0');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `curLoginDate` datetime DEFAULT NULL,
  `curLoginIp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginIp` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `registerDate` datetime DEFAULT NULL,
  `sex` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `friends` varchar(255) DEFAULT NULL,
  `trueName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '2015-12-07 14:50:10', '0:0:0:0:0:0:0:1', '471026023@qq.com', '2015-12-04 15:46:05', '0:0:0:0:0:0:0:1', 'e10adc3949ba59abbe56e057f20f883e', '15947513264', '2015-11-03 11:23:46', '1', '1', '1', '流水无痕', null, '韩晓军');
INSERT INTO `t_user` VALUES ('2', null, null, null, null, null, null, null, null, '1', '1', '1', null, null, '胡丰盛');
INSERT INTO `t_user` VALUES ('3', null, null, null, null, null, null, null, null, '1', '1', '1', null, null, '李洪亮');
