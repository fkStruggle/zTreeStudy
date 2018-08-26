CREATE TABLE `merchant_legal` (
  `legal_id` varchar(32) NOT NULL COMMENT '商户法人id',
  `member_id` varchar(32) NOT NULL COMMENT '商户id',
  `certification_name` varchar(20) DEFAULT NULL COMMENT '商户法人名字',
  `legal_mobile` varchar(11) DEFAULT NULL COMMENT '法人手机号',
  `legal_address` varchar(20) DEFAULT NULL COMMENT '法人地址',
  `certification_card` varchar(20) DEFAULT NULL COMMENT '商户法人身份证号',
  `flawholder` varchar(300) DEFAULT NULL COMMENT '法人持证件照图片',
  `flawholder_name` varchar(400) DEFAULT NULL COMMENT '法人持证件照名称',
 
  PRIMARY KEY (`legal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户法人信息表';
