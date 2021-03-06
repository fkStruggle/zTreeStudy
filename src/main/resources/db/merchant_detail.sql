CREATE TABLE `merchant_detail` (
  `detail_id` varchar(32) NOT NULL COMMENT '商户详情ID',
  `member_id` varchar(32) NOT NULL COMMENT '商户id',
  `fmer_code` varchar(16) DEFAULT NULL COMMENT '商户编码',
  `fmer_pcode` varchar(16) DEFAULT NULL COMMENT '上级商户编码',  
  `fmerchant_name` varchar(30) NOT NULL COMMENT '商户名称',
  `fporg_id` varchar(64) DEFAULT NULL COMMENT '所属机构编号',
  `fporg_name` varchar(64) DEFAULT NULL COMMENT '所属机构名称',
  `fpriority` int(1) DEFAULT NULL COMMENT '优先级',
  `fselected` int(1) not null DEFAULT '0' COMMENT '0非精选，1精选',
   
  

--支付相关  
  `fzfbindustry_id` varchar(32) DEFAULT NULL COMMENT '支付宝所属行业ID',
  `fzfbsettlerate` decimal(10,6) DEFAULT NULL COMMENT '支付宝结算费率',
  `fpassway_ids` varchar(200) DEFAULT NULL COMMENT '通道类型',
  `fappid` varchar(32) DEFAULT NULL COMMENT '子商户号（微信）',
   `ftoken` varchar(40) DEFAULT NULL COMMENT '第三方授权令牌(支付宝)',
  `fwxindustry_id` varchar(32) DEFAULT NULL COMMENT '微信所属行业',
  `fwxsettlerate` decimal(10,6) DEFAULT NULL COMMENT '微信结算费率',
   `fshow_wxsettlerate` varchar(30) DEFAULT NULL COMMENT '显示微信结算费率',
  `fshow_zfbsettlerate` varchar(30) DEFAULT NULL COMMENT '显示支付宝结算费率',
  `fstore_id` varchar(100) DEFAULT NULL COMMENT '支付宝商户门店编号',
  `fis_authorize` decimal(2,0) DEFAULT '0' COMMENT '商户是否授权给支付宝,0未授权,1已授权',
  `fzfbpid` varchar(20) DEFAULT NULL COMMENT '支付宝pid',
  `fzfbenabled` decimal(2,0) DEFAULT '0' COMMENT '支付宝是否启用，0不启用，1启用',
  `fwxenabled` decimal(2,0) DEFAULT '0' COMMENT '微信是否启用，0不启用，1启用',
  `fcategory` varchar(255) DEFAULT NULL COMMENT '类目',
  `fmemberCardId` varchar(32) DEFAULT NULL COMMENT '会员卡id',

  
--  证件相关
  `facctype` decimal(2,0) DEFAULT NULL COMMENT '账户类型',
  `fdeposite` varchar(20) DEFAULT NULL COMMENT '开户银行',
  `fbankno` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `fbranch_nmae` varchar(50) DEFAULT NULL COMMENT '开户支行名称',
  `fbranch_region` varchar(50) DEFAULT NULL COMMENT '开户支行所属地区',
  `fcompany` varchar(30) DEFAULT NULL COMMENT '企业名称',
  `facctholder` varchar(32) DEFAULT NULL COMMENT '开户人',
  `fidentitp` varchar(20) DEFAULT NULL COMMENT '持卡人证件类型',
  `fidentino` varchar(20) DEFAULT NULL COMMENT '持卡人证件号码',
  `fholderaddress` varchar(20) DEFAULT NULL COMMENT '持卡人地址',
  `fholderphone` varchar(20) DEFAULT NULL COMMENT '持卡人手机号',
  `fidendtstart` datetime DEFAULT NULL COMMENT '证件有效期起',
  `fidendtend` datetime DEFAULT NULL COMMENT '证件有效期止',
  `ffront` varchar(300) DEFAULT NULL COMMENT '身份证正面照片',
  `fback` varchar(300) DEFAULT NULL COMMENT '身份证反面照片',
  `fbuslicence_name` varchar(400) DEFAULT NULL COMMENT '营业执照图片名称',
  `forgcode_name` varchar(400) DEFAULT NULL COMMENT '组织代码图片名称',
  `ffrontid_name` varchar(400) DEFAULT NULL COMMENT '身份证正面图片名称',
  `fbackid_name` varchar(400) DEFAULT NULL COMMENT '身份证反面图片名称',
  `fspequalifione_name` varchar(400) DEFAULT NULL COMMENT '特殊资质一图片名称',
  `fspequalifitwo_name` varchar(400) DEFAULT NULL COMMENT '特殊资质二图片名称',
  `fspequalifithree_name` varchar(400) DEFAULT NULL COMMENT '特殊资质三图片名称',
  `fspequalififour_name` varchar(400) DEFAULT NULL COMMENT '特殊资质四图片名称',
  `fspequalififive_name` varchar(400) DEFAULT NULL COMMENT '特殊资质五图片名称',
  `ffront_name` varchar(400) DEFAULT NULL COMMENT '身份证正面照片名称',
  `fback_name` varchar(400) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '身份证反面照片名称',
  
-- 未知信息（原商户保留）
  `fsalesman` varchar(20) DEFAULT NULL COMMENT '业务员', 
  `fauditstate` decimal(2,0) DEFAULT '0' COMMENT '进件状态 0 未提交 1审核中 2未通过 3账户验证 4签约完成 5上线中',
  `factivestate` varchar(1) DEFAULT NULL COMMENT '激活状态 0 未激活 1 激活',
  `fremarks_ads` varchar(100) DEFAULT NULL COMMENT '进件状态备注',
  `fremarks_act` varchar(100) DEFAULT NULL COMMENT '激活状态备注',
  `fmessage` varchar(400) DEFAULT NULL COMMENT '返回信息',
  `fstatus` decimal(3,0) DEFAULT NULL COMMENT '状态码',
  `fstore_detail` varchar(255) DEFAULT NULL COMMENT '门店明细',
  `fuse_scene` varchar(255) DEFAULT NULL COMMENT '使用场景',
  `fnet` varchar(255) DEFAULT NULL COMMENT '是否网签',
  
-- 登录相关信息
  `fmember_login_num` int(11) DEFAULT '1' COMMENT '登录次数',
  `fmember_login_time` bigint(13) DEFAULT NULL COMMENT '当前登录时间',
  `fmember_old_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',

  
  `fcreator_id` varchar(32) DEFAULT NULL COMMENT '创建人',
  `fcreate_time` datetime DEFAULT NULL COMMENT '创建时间',
  `flast_edit_time` datetime DEFAULT NULL COMMENT '修改时间',
  `flast_editor_id` varchar(32) DEFAULT NULL COMMENT '修改人',
  `fdeleted` int(11) DEFAULT '0' COMMENT '删除标识：0-未删除，1-已删除',
  `fdelete_user_id` varchar(32) DEFAULT NULL COMMENT '删除人',
  `fmark_deleted_time` datetime(6) DEFAULT NULL COMMENT '删除时间',

  PRIMARY KEY (`detail_id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户详细信息';