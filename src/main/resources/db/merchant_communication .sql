CREATE TABLE `merchant_communication` (
  `communication_id` varchar(32) NOT NULL COMMENT '申请认证编号',
  `member_id` varchar(32) NOT NULL COMMENT '商户id',
  `fprovince` varchar(15) DEFAULT NULL COMMENT '商户所在省',
  `fcity` varchar(10) DEFAULT NULL COMMENT '商户所在市',
  `faddress` varchar(80) DEFAULT NULL COMMENT '商户详细地址',
  `fcustomertel` varchar(15) DEFAULT NULL COMMENT '客服电话',
  `flng` decimal(20,10) DEFAULT NULL COMMENT '商户所在经度（地理位置）',
  `flat` decimal(20,10) DEFAULT NULL COMMENT '商户所在纬度（地理位置）',
  
  `flinkman` varchar(10) NOT NULL COMMENT '联系人姓名',
  `flkmphone` varchar(11) NOT NULL COMMENT '联系人手机',
  `flkmemail` varchar(22) DEFAULT NULL COMMENT '联系人邮箱',
  `flkwx` varchar(32) DEFAULT NULL COMMENT '联系人微信',
  `flkzw` varchar(8) DEFAULT NULL COMMENT '联系人职位',
 
  PRIMARY KEY (`communication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户通讯信息表';
