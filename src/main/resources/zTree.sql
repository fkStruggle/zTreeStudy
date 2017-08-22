/*
Navicat MySQL Data Transfer

Source Server         : zTree
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : zTree

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2017-07-09 23:53:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wg_anonymous_dynamic`
-- ----------------------------
DROP TABLE IF EXISTS `zt_dept`;
CREATE TABLE `zt_dept` (
  `deptId` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `deptName` varchar(10) NOT NULL COMMENT '部门名称',
  `deptParentId` varchar(140) default NULL COMMENT '上级部门id',
  `creteTime` datetime default NULL COMMENT '部门创建',
  PRIMARY KEY (`deptId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门信息表';

-- ----------------------------
-- Records of wg_anonymous_dynamic
-- ----------------------------
INSERT INTO `zt_dept` VALUES ('1', '航天大队', '0', '2017-08-16 17:42:41');
INSERT INTO `zt_dept` VALUES ('2', '信息所', '6', '2017-08-17 17:43:04');
INSERT INTO `zt_dept` VALUES ('3', '保卫处', '1', '2017-08-16 17:43:23');
INSERT INTO `zt_dept` VALUES ('4', '人事处', '1', '2017-08-22 17:43:37');
INSERT INTO `zt_dept` VALUES ('5', '人事处二组', '4', '2017-08-24 17:43:54');
INSERT INTO `zt_dept` VALUES ('6', '人事处一组', '4', '2017-08-18 13:28:50');
INSERT INTO `zt_dept` VALUES ('7', '一组西侧', '6', '2017-08-18 13:29:14');
INSERT INTO `zt_dept` VALUES ('8', '一组东侧', '5', '2017-08-18 13:29:38');

