/*
Navicat MySQL Data Transfer

Source Server         : 本地链接
Source Server Version : 50162
Source Host           : localhost:3306
Source Database       : db_venue_management

Target Server Type    : MYSQL
Target Server Version : 50162
File Encoding         : 65001

Date: 2021-06-30 00:10:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `news`
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('1', '2021-06-29 17:17:40', '懒羊羊游泳馆开业了！', '懒羊羊游泳馆开业了！懒羊羊游泳馆开业了！懒羊羊游泳馆开业了！懒羊羊游泳馆开业了！');
INSERT INTO `news` VALUES ('2', '2021-06-29 17:18:36', '喜羊羊游泳馆开业了！', '喜羊羊游泳馆开业了！喜羊羊游泳馆开业了！');

-- ----------------------------
-- Table structure for `place`
-- ----------------------------
DROP TABLE IF EXISTS `place`;
CREATE TABLE `place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `ename` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `introduction` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of place
-- ----------------------------
INSERT INTO `place` VALUES ('6', '篮球馆场', 'Lan Qiu Guan', '浦东体育馆C区', '篮球馆场篮球馆场');

-- ----------------------------
-- Table structure for `placestadium`
-- ----------------------------
DROP TABLE IF EXISTS `placestadium`;
CREATE TABLE `placestadium` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_place` (`pid`),
  CONSTRAINT `fk_place` FOREIGN KEY (`pid`) REFERENCES `place` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of placestadium
-- ----------------------------
INSERT INTO `placestadium` VALUES ('4', '篮球馆A场地', '3', '10', '6');
INSERT INTO `placestadium` VALUES ('5', '篮球馆B场地', '1', '10', '6');

-- ----------------------------
-- Table structure for `reserve`
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rs_user` (`uid`),
  CONSTRAINT `rs_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reserve
-- ----------------------------
INSERT INTO `reserve` VALUES ('1', '2021-06-29 18:23:35', '篮球馆场篮球馆A场地', '10', '审核通过', '7');
INSERT INTO `reserve` VALUES ('4', '2021-06-29 18:36:44', '篮球馆场篮球馆A场地', '10', '审核通过', '7');
INSERT INTO `reserve` VALUES ('5', '2021-06-29 18:40:45', '篮球馆场篮球馆A场地', '30', '审核通过', '7');

-- ----------------------------
-- Table structure for `reserveitem`
-- ----------------------------
DROP TABLE IF EXISTS `reserveitem`;
CREATE TABLE `reserveitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `piid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_planItem` (`piid`),
  KEY `fk_reserve` (`rid`),
  CONSTRAINT `fk_planItem` FOREIGN KEY (`piid`) REFERENCES `stadiumplanitem` (`id`),
  CONSTRAINT `fk_reserve` FOREIGN KEY (`rid`) REFERENCES `reserve` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reserveitem
-- ----------------------------
INSERT INTO `reserveitem` VALUES ('1', '3', '1');
INSERT INTO `reserveitem` VALUES ('4', '4', '4');
INSERT INTO `reserveitem` VALUES ('5', '5', '5');
INSERT INTO `reserveitem` VALUES ('6', '6', '5');
INSERT INTO `reserveitem` VALUES ('7', '7', '5');

-- ----------------------------
-- Table structure for `stadiumplan`
-- ----------------------------
DROP TABLE IF EXISTS `stadiumplan`;
CREATE TABLE `stadiumplan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inode` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `psid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_placeStadium` (`psid`),
  CONSTRAINT `fk_placeStadium` FOREIGN KEY (`psid`) REFERENCES `placestadium` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stadiumplan
-- ----------------------------
INSERT INTO `stadiumplan` VALUES ('1', '0', '2021-06-29', '4');
INSERT INTO `stadiumplan` VALUES ('2', '1', '2021-06-29', '4');
INSERT INTO `stadiumplan` VALUES ('3', '2', '2021-06-29', '4');
INSERT INTO `stadiumplan` VALUES ('4', '0', '2021-06-29', '5');
INSERT INTO `stadiumplan` VALUES ('5', '0', '2021-06-30', '4');
INSERT INTO `stadiumplan` VALUES ('6', '1', '2021-06-30', '4');
INSERT INTO `stadiumplan` VALUES ('7', '2', '2021-06-30', '4');
INSERT INTO `stadiumplan` VALUES ('8', '0', '2021-07-01', '4');
INSERT INTO `stadiumplan` VALUES ('9', '1', '2021-07-01', '4');
INSERT INTO `stadiumplan` VALUES ('10', '2', '2021-07-01', '4');
INSERT INTO `stadiumplan` VALUES ('11', '0', '2021-06-30', '5');
INSERT INTO `stadiumplan` VALUES ('12', '0', '2021-07-01', '5');

-- ----------------------------
-- Table structure for `stadiumplanitem`
-- ----------------------------
DROP TABLE IF EXISTS `stadiumplanitem`;
CREATE TABLE `stadiumplanitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `beg` time DEFAULT NULL,
  `end` time DEFAULT NULL,
  `inode` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `spid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stadiumPlan` (`spid`),
  CONSTRAINT `fk_stadiumPlan` FOREIGN KEY (`spid`) REFERENCES `stadiumplan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stadiumplanitem
-- ----------------------------
INSERT INTO `stadiumplanitem` VALUES ('1', '08:00:00', '09:00:00', '0', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('2', '09:00:00', '10:00:00', '1', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('3', '10:00:00', '11:00:00', '2', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('4', '11:00:00', '12:00:00', '3', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('5', '12:00:00', '13:00:00', '4', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('6', '13:00:00', '14:00:00', '5', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('7', '14:00:00', '15:00:00', '6', '已预约', '1');
INSERT INTO `stadiumplanitem` VALUES ('8', '15:00:00', '16:00:00', '7', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('9', '16:00:00', '17:00:00', '8', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('10', '17:00:00', '18:00:00', '9', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('11', '18:00:00', '19:00:00', '10', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('12', '19:00:00', '20:00:00', '11', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('13', '20:00:00', '21:00:00', '12', '空闲', '1');
INSERT INTO `stadiumplanitem` VALUES ('14', '08:00:00', '09:00:00', '0', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('15', '09:00:00', '10:00:00', '1', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('16', '10:00:00', '11:00:00', '2', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('17', '11:00:00', '12:00:00', '3', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('18', '12:00:00', '13:00:00', '4', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('19', '13:00:00', '14:00:00', '5', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('20', '14:00:00', '15:00:00', '6', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('21', '15:00:00', '16:00:00', '7', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('22', '16:00:00', '17:00:00', '8', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('23', '17:00:00', '18:00:00', '9', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('24', '18:00:00', '19:00:00', '10', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('25', '19:00:00', '20:00:00', '11', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('26', '20:00:00', '21:00:00', '12', '空闲', '2');
INSERT INTO `stadiumplanitem` VALUES ('27', '08:00:00', '09:00:00', '0', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('28', '09:00:00', '10:00:00', '1', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('29', '10:00:00', '11:00:00', '2', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('30', '11:00:00', '12:00:00', '3', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('31', '12:00:00', '13:00:00', '4', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('32', '13:00:00', '14:00:00', '5', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('33', '14:00:00', '15:00:00', '6', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('34', '15:00:00', '16:00:00', '7', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('35', '16:00:00', '17:00:00', '8', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('36', '17:00:00', '18:00:00', '9', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('37', '18:00:00', '19:00:00', '10', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('38', '19:00:00', '20:00:00', '11', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('39', '20:00:00', '21:00:00', '12', '空闲', '3');
INSERT INTO `stadiumplanitem` VALUES ('40', '08:00:00', '09:00:00', '0', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('41', '09:00:00', '10:00:00', '1', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('42', '10:00:00', '11:00:00', '2', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('43', '11:00:00', '12:00:00', '3', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('44', '12:00:00', '13:00:00', '4', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('45', '13:00:00', '14:00:00', '5', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('46', '14:00:00', '15:00:00', '6', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('47', '15:00:00', '16:00:00', '7', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('48', '16:00:00', '17:00:00', '8', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('49', '17:00:00', '18:00:00', '9', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('50', '18:00:00', '19:00:00', '10', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('51', '19:00:00', '20:00:00', '11', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('52', '20:00:00', '21:00:00', '12', '空闲', '4');
INSERT INTO `stadiumplanitem` VALUES ('53', '08:00:00', '09:00:00', '0', '已预约', '5');
INSERT INTO `stadiumplanitem` VALUES ('54', '09:00:00', '10:00:00', '1', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('55', '10:00:00', '11:00:00', '2', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('56', '11:00:00', '12:00:00', '3', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('57', '12:00:00', '13:00:00', '4', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('58', '13:00:00', '14:00:00', '5', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('59', '14:00:00', '15:00:00', '6', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('60', '15:00:00', '16:00:00', '7', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('61', '16:00:00', '17:00:00', '8', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('62', '17:00:00', '18:00:00', '9', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('63', '18:00:00', '19:00:00', '10', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('64', '19:00:00', '20:00:00', '11', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('65', '20:00:00', '21:00:00', '12', '空闲', '5');
INSERT INTO `stadiumplanitem` VALUES ('66', '08:00:00', '09:00:00', '0', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('67', '09:00:00', '10:00:00', '1', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('68', '10:00:00', '11:00:00', '2', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('69', '11:00:00', '12:00:00', '3', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('70', '12:00:00', '13:00:00', '4', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('71', '13:00:00', '14:00:00', '5', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('72', '14:00:00', '15:00:00', '6', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('73', '15:00:00', '16:00:00', '7', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('74', '16:00:00', '17:00:00', '8', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('75', '17:00:00', '18:00:00', '9', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('76', '18:00:00', '19:00:00', '10', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('77', '19:00:00', '20:00:00', '11', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('78', '20:00:00', '21:00:00', '12', '空闲', '6');
INSERT INTO `stadiumplanitem` VALUES ('79', '08:00:00', '09:00:00', '0', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('80', '09:00:00', '10:00:00', '1', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('81', '10:00:00', '11:00:00', '2', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('82', '11:00:00', '12:00:00', '3', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('83', '12:00:00', '13:00:00', '4', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('84', '13:00:00', '14:00:00', '5', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('85', '14:00:00', '15:00:00', '6', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('86', '15:00:00', '16:00:00', '7', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('87', '16:00:00', '17:00:00', '8', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('88', '17:00:00', '18:00:00', '9', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('89', '18:00:00', '19:00:00', '10', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('90', '19:00:00', '20:00:00', '11', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('91', '20:00:00', '21:00:00', '12', '空闲', '7');
INSERT INTO `stadiumplanitem` VALUES ('92', '08:00:00', '09:00:00', '0', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('93', '09:00:00', '10:00:00', '1', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('94', '10:00:00', '11:00:00', '2', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('95', '11:00:00', '12:00:00', '3', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('96', '12:00:00', '13:00:00', '4', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('97', '13:00:00', '14:00:00', '5', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('98', '14:00:00', '15:00:00', '6', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('99', '15:00:00', '16:00:00', '7', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('100', '16:00:00', '17:00:00', '8', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('101', '17:00:00', '18:00:00', '9', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('102', '18:00:00', '19:00:00', '10', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('103', '19:00:00', '20:00:00', '11', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('104', '20:00:00', '21:00:00', '12', '空闲', '8');
INSERT INTO `stadiumplanitem` VALUES ('105', '08:00:00', '09:00:00', '0', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('106', '09:00:00', '10:00:00', '1', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('107', '10:00:00', '11:00:00', '2', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('108', '11:00:00', '12:00:00', '3', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('109', '12:00:00', '13:00:00', '4', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('110', '13:00:00', '14:00:00', '5', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('111', '14:00:00', '15:00:00', '6', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('112', '15:00:00', '16:00:00', '7', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('113', '16:00:00', '17:00:00', '8', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('114', '17:00:00', '18:00:00', '9', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('115', '18:00:00', '19:00:00', '10', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('116', '19:00:00', '20:00:00', '11', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('117', '20:00:00', '21:00:00', '12', '空闲', '9');
INSERT INTO `stadiumplanitem` VALUES ('118', '08:00:00', '09:00:00', '0', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('119', '09:00:00', '10:00:00', '1', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('120', '10:00:00', '11:00:00', '2', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('121', '11:00:00', '12:00:00', '3', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('122', '12:00:00', '13:00:00', '4', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('123', '13:00:00', '14:00:00', '5', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('124', '14:00:00', '15:00:00', '6', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('125', '15:00:00', '16:00:00', '7', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('126', '16:00:00', '17:00:00', '8', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('127', '17:00:00', '18:00:00', '9', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('128', '18:00:00', '19:00:00', '10', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('129', '19:00:00', '20:00:00', '11', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('130', '20:00:00', '21:00:00', '12', '空闲', '10');
INSERT INTO `stadiumplanitem` VALUES ('131', '08:00:00', '09:00:00', '0', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('132', '09:00:00', '10:00:00', '1', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('133', '10:00:00', '11:00:00', '2', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('134', '11:00:00', '12:00:00', '3', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('135', '12:00:00', '13:00:00', '4', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('136', '13:00:00', '14:00:00', '5', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('137', '14:00:00', '15:00:00', '6', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('138', '15:00:00', '16:00:00', '7', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('139', '16:00:00', '17:00:00', '8', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('140', '17:00:00', '18:00:00', '9', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('141', '18:00:00', '19:00:00', '10', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('142', '19:00:00', '20:00:00', '11', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('143', '20:00:00', '21:00:00', '12', '空闲', '11');
INSERT INTO `stadiumplanitem` VALUES ('144', '08:00:00', '09:00:00', '0', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('145', '09:00:00', '10:00:00', '1', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('146', '10:00:00', '11:00:00', '2', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('147', '11:00:00', '12:00:00', '3', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('148', '12:00:00', '13:00:00', '4', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('149', '13:00:00', '14:00:00', '5', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('150', '14:00:00', '15:00:00', '6', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('151', '15:00:00', '16:00:00', '7', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('152', '16:00:00', '17:00:00', '8', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('153', '17:00:00', '18:00:00', '9', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('154', '18:00:00', '19:00:00', '10', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('155', '19:00:00', '20:00:00', '11', '空闲', '12');
INSERT INTO `stadiumplanitem` VALUES ('156', '20:00:00', '21:00:00', '12', '空闲', '12');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', '115432035@qq.com');
INSERT INTO `user` VALUES ('7', '1710272236', '123456', '115432035@qq.com');
INSERT INTO `user` VALUES ('8', '1710272235', '123456', '844891239@qq.com');
