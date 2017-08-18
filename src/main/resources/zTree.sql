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

