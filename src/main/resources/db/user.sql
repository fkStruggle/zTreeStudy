CREATE TABLE `user` (
	`fid` VARCHAR (42) NOT NULL COMMENT '用户ID',
	`name` VARCHAR (18) DEFAULT NULL COMMENT '用户名称',
	`nick_name` VARCHAR (8) DEFAULT NULL COMMENT '昵称',
	`head_portrait` VARCHAR (200) DEFAULT NULL COMMENT '头像',
	`mobile` VARCHAR (11) DEFAULT NULL COMMENT '电话',
	`login_id` VARCHAR (8) DEFAULT NULL COMMENT '登录id',
	--`id_card` VARCHAR (18) DEFAULT NULL COMMENT '身份证号',
	`password` VARCHAR (60) DEFAULT NULL COMMENT '登录密码',
	`level` TINYINT (2) COMMENT '等级',
	`wx_openid` VARCHAR (50) DEFAULT NULL COMMENT '微信三方登录唯一标识',
	`user_state` TINYINT (1) DEFAULT '1' COMMENT '用户状态 1为开启 0为关闭',
	UNIQUE KEY `UK_user_mobile` (`mobile`),
	UNIQUE KEY `UK_user_loginid` (`login_id`),
	PRIMARY KEY (`fid`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '用户基本信息（登录用）';

CREATE TABLE `user_detail` (
	`fid` VARCHAR (42) NOT NULL COMMENT '详情ID',
	`user_id` VARCHAR (42) NOT NULL COMMENT '用户id',
    `id_type` TINYINT (2)  COMMENT '证件类型',
	`id_card` VARCHAR (18) DEFAULT NULL COMMENT '证件号',
	`address` VARCHAR (60) DEFAULT NULL COMMENT '通讯地址',	
	`e_mail` VARCHAR (20) DEFAULT NULL COMMENT '邮箱',
	`reg_time` datetime not NULL COMMENT '注册日期',
	UNIQUE KEY `UK_user_userId` (`user_id`),
	PRIMARY KEY (`fid`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT = '用户详情';