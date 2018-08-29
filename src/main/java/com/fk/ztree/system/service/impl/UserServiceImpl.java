package com.fk.ztree.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.fk.ztree.common.mapper.UserDetailMapper;
import com.fk.ztree.common.mapper.UserMapper;
import com.fk.ztree.common.pojo.User;
import com.fk.ztree.common.pojo.UserDetail;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.UserService;
import com.fk.ztree.utils.ConstantCommon;
import com.fk.ztree.utils.HttpClientUtil;
import com.fk.ztree.utils.MD5Util;
import com.fk.ztree.utils.RedisOperator;

@Service
public class UserServiceImpl implements UserService {
	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserDetailMapper userDetailMapper;

	@Autowired
	private RedisOperator redisTemplate;

	@Override
	public String findUserByInfo(Map<String, String> params) throws ServiceException {
		User user = userMapper.findUserByInfo(params);
		String userStr = "";
		if (user != null) {
			userStr = JSONObject.toJSONString(user, SerializerFeature.WriteNullStringAsEmpty,
					SerializerFeature.WriteNullBooleanAsFalse);
		} else {
			userStr = "{'warn':'用户信息不存在'}";

		}
		return userStr;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public String saveUser(String userStr) throws ServiceException {
		User user = JSON.parseObject(userStr, new TypeReference<User>() {
		});
		String userId = UUID.randomUUID().toString();
		user.setUserState(true);
		user.setFid(userId);
		//生成登录id
		user.setLoginId(userId.substring(0,8));
		if (StringUtils.isNotBlank(user.getPassword())) {
			user.setPassword(MD5Util.md5Password(user.getPassword()));
		}
		try {
			int size = userMapper.insertSelective(user);
			if (size > 0) {
				UserDetail userDetail = JSON.parseObject(userStr, new TypeReference<UserDetail>() {
				});
				userDetail.setFid(UUID.randomUUID().toString());
				// 用户标识
				userDetail.setUserId(userId);
				// 注册时间
				userDetail.setRegTime(new Date());
				userDetailMapper.insertSelective(userDetail);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("新增用户失败");
			throw new ServiceException("新增用户失败");
		}
		return userId;
	}

	@Override
	public String loginWeixin(String jsCode) {
		String userId = "";
		JSONObject objret = new JSONObject();
		if (jsCode == null || "".equals(jsCode)) {
			logger.error("code不能为空");
			objret.put("errno", 1);
			objret.put("errMsg", "请检查code");
			return objret.toString();
		} else {
			String appId = ConstantCommon.APPID;
			String appSecret = ConstantCommon.SECRET;
			if (appId == null || "".equals(appId) || appSecret == null || "".equals(appSecret)) {
				logger.error("appId或secret不能为空");
				objret.put("errno", 1);
				objret.put("errMsg", "服务器异常");
				return objret.toString();
			} else {
				String url = ConstantCommon.SESSIONHOST;
				String httpUrl = url + "?appid=" + appId + "&secret=" + appSecret + "&js_code=" + jsCode
						+ "&grant_type=authorization_code";
				JSONObject ret = HttpClientUtil.sendGetJson(httpUrl);
				if (ret == null || "".equals(ret)) {
					logger.error("网络超时");
					objret.put("errno", 1);
					objret.put("errMsg", "服务器异常");
					return objret.toString();
				} else {
					JSONObject obj = ret;
					if (obj.containsKey("errcode")) {
						String errcode = obj.get("errcode").toString();
						logger.error("微信返回的错误码:" + errcode);
						objret.put("errno", 1);
						objret.put("errMsg", "服务器异常");
						return objret.toString();
					} else if (obj.containsKey("session_key")) {
						// 开始处理userInfo
						String openId = obj.get("openid").toString();
						Map<String, String> map = new HashMap<String, String>();
						map.put("wxOpenid", openId);
						// 先查询openId存在不存在，存在不入库，不存在就入库
						String memberStr = this.findUserByInfo(map);
						if (!memberStr.contains("warn")) {
							logger.info("openId已经存在，不需要插入");
						} else {
							String userStr = "{'wxOpenid':'" + openId + "'}";
							this.saveUser(userStr);
						}
						// (1) 获得sessionkey
						String sessionKey = obj.get("session_key").toString();
						// (2) 得到sessionkey以后存到缓存，key值采用不会重复的uuid
						String rsession = UUID.randomUUID().toString();
						// (3) 首先根据openId，取出来之前存的openId对应的sessionKey的值。
						String oldSeesionKey = redisTemplate.get(openId);
						if (oldSeesionKey != null && !"".equals(oldSeesionKey)) {
							// (4) 删除之前openId对应的缓存,即rsession
							redisTemplate.del(oldSeesionKey);
						}
						// (5) 开始缓存新的sessionKey： key --> uuid， value -->
						// sessionObj
						JSONObject sessionObj = new JSONObject();
						sessionObj.put("openId", openId);
						sessionObj.put("sessionKey", sessionKey);
						redisTemplate.set(rsession, sessionObj.toJSONString(), 1000 * 60 * 30);
						// (6) 开始缓存新的openId与session对应关系 ： key --> openId , value
						// --> rsession
						redisTemplate.set(openId, rsession);
						// (7) 把新的sessionKey返回给小程序
						objret.put("rdSessionKey", rsession);
						// 更新用
						objret.put("userId", userId);
						objret.put("errno", 0);
					}

				}
			}
		}
		return objret.toString();
	}
    
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public void updateUser(String userStr) throws ServiceException {
		User user = JSON.parseObject(userStr, new TypeReference<User>() {
		});
		if (StringUtils.isNotBlank(user.getPassword())) {
			user.setPassword(MD5Util.md5Password(user.getPassword()));
		}
		try {
			int size = userMapper.updateByPrimaryKeySelective(user);
			if (size > 0) {
				UserDetail userDetail = JSON.parseObject(userStr, new TypeReference<UserDetail>() {
				});
				userDetail.setUserId(user.getFid());
				userDetailMapper.updateByMemberId(userDetail);
			}
		} catch (Exception e) {
			logger.error("更新用户失败");
			throw new ServiceException("更新用户失败");
		}
	}


	public void setRedisTemplate(RedisOperator redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

}