package com.fk.ztree.system.service.impl;

import java.util.Map;

import javax.json.JsonObject;

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

@Service
public class UserServiceImpl implements UserService {
	private static final Logger log = Logger.getLogger(UserServiceImpl.class);
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserDetailMapper userDetailMapper;

    @Override
    public String findUserByInfo(Map<String, String> params) throws ServiceException {
    	User user = userMapper.findUserByInfo(params);
    	String userStr = "";
    	if(user != null){
    		userStr =  JSONObject.toJSONString(user, SerializerFeature.WriteNullStringAsEmpty, SerializerFeature.WriteNullBooleanAsFalse);
    	}else{
    		 userStr = "{'warn':'用户信息不存在'}";

    	}
        return userStr;
    }
    @Transactional(propagation =Propagation.REQUIRED)
	@Override
	public void saveUser(String userStr) throws ServiceException {
		User user = JSON.parseObject(userStr, new TypeReference<User>() {});
		try{
			int size = userMapper.insertSelective(user);
			if(size>0){
				UserDetail userDetail = JSON.parseObject(userStr, new TypeReference<UserDetail>() {});
				userDetailMapper.insertSelective(userDetail);
			}
		}catch(Exception e){
			log.error("新增用户失败");
			throw new ServiceException("新增用户失败");
		}
		
		
	}
}