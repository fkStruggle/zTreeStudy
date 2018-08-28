package com.fk.ztree.system.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpRequest;
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
import com.fk.ztree.utils.RedisOperator;

@Service
public class UserServiceImpl implements UserService {
	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserDetailMapper userDetailMapper;
    
    @Autowired
	private RedisOperator  redisTemplate;

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
		String userId = UUID.randomUUID().toString();
		user.setFid(userId);
		try{
			int size = userMapper.insertSelective(user);
			if(size>0){
				UserDetail userDetail = JSON.parseObject(userStr, new TypeReference<UserDetail>() {});
				userDetail.setFid(UUID.randomUUID().toString());
				//用户标识
				userDetail.setUserId(userId);
				//注册时间
				userDetail.setRegTime(new Date());
				userDetailMapper.insertSelective(userDetail);
			}
		}catch(Exception e){
			logger.error("新增用户失败");
			throw new ServiceException("新增用户失败");
		}
	}
	@Override
	public String loginWeixin(String code) {
		    String jsCode = code;
		    JSONObject objret = new JSONObject();
		    if (jsCode == null || "".equals(jsCode)) {
		      logger.info("缺少必要参数");
		      //renderJson(new OutRoot().setCode("100").setMsg(SYS.PARAMETER_FAIL));
		    } else {
		      //List<Record> record = appInfoService.selectAppInfo();
		      String appId = ConstantCommon.appId;
		      String appSecret = ConstantCommon.secret;
		      if (appId == null || "".equals(appId) || appSecret == null || "".equals(appSecret)) {
		        logger.info("缺少必要参数");
		        //renderJson(new OutRoot().setCode("100").setMsg(SYS.PARAMETER_FAIL));
		      } else {
		        String url = "https://api.weixin.qq.com/sns/jscode2session";
		        String httpUrl = url + "?appid=" + appId + "&secret=" + appSecret + "&js_code=" + jsCode
		            + "&grant_type=authorization_code";
		        JSONObject ret = HttpClientUtil.sendGetJson(url);
		        //logger.info("微信返回的结果 {}", ret);
		        if (ret == null || "".equals(ret)) {
		          logger.info("网络超时");
		          //renderJson(new OutRoot().setCode("101").setMsg(SYS.CONTACT_FAIL));
		        } else {
		          JSONObject obj = ret;
		          if (obj.containsKey("errcode")) {
		            String errcode = obj.get("errcode").toString();
		           // logger.info("微信返回的错误码{}", errcode);
		           // renderJson(new OutRoot().setCode("101").setMsg(SYS.CONTACT_FAIL));
		          } else if (obj.containsKey("session_key")) {
		            logger.info("调微信成功");
		            // 开始处理userInfo
		            String openId = obj.get("openid").toString();
		            //User tbMember = new User();
		            
		            //tbMember.set("weixin_openid", openId);
		            System.out.println("openId==" + openId);
		            Map<String,String> map =new HashMap<String,String>();
		            map.put("wxOpenid", openId);
		            // 先查询openId存在不存在，存在不入库，不存在就入库
		            String memberStr = this.findUserByInfo(map);
		            if (!memberStr.contains("warn")){
		              logger.info("openId已经存在，不需要插入");
		            } else {
		             /* JSONObject rawDataJson = obj;
		              String nickName = rawDataJson.getString("nickName");
		              String avatarUrl = rawDataJson.getString("avatarUrl");
		              String gender = rawDataJson.getString("gender");
		              String province = rawDataJson.getString("province");
		              String city = rawDataJson.getString("city");
		              String country = rawDataJson.getString("country");*/
		              
		              //tbMember.setWxOpenid(openId);
		              //Long openId2 = tbMemberService.addMember(tbMember);
		              String userStr = "{'wxOpenid':'"+openId+"'}";
		              this.saveUser(userStr);
		              
		              logger.info("openId不存在，插入数据库");
		            }
		            // (1) 获得sessionkey
		            String sessionKey = obj.get("session_key").toString();
		            logger.info("sessionKey==" + sessionKey);
		            logger.info("openId==" + openId);
		            // (2) 得到sessionkey以后存到缓存，key值采用不会重复的uuid
		            String rsession = UUID.randomUUID().toString();
		            //Cache tokenCache = Redis.use("redis_00");
		            // (3) 首先根据openId，取出来之前存的openId对应的sessionKey的值。
		            String oldSeesionKey = redisTemplate.get(openId);
		            if (oldSeesionKey != null && !"".equals(oldSeesionKey)) {
		              logger.info("oldSeesionKey==" + oldSeesionKey);
		              // (4) 删除之前openId对应的缓存,即rsession
		              redisTemplate.del(oldSeesionKey);
		              //logger.info("老的openId删除以后==" + tokenCache.getJedis().get(oldSeesionKey));
		            }
		            // (5) 开始缓存新的sessionKey： key --> uuid， value --> sessionObj
		            JSONObject sessionObj = new JSONObject();
		            sessionObj.put("openId", openId);
		            sessionObj.put("sessionKey", sessionKey);
		            redisTemplate.set(rsession, sessionObj.toJSONString(),1000 * 60 * 30);
		 
		            // (6) 开始缓存新的openId与session对应关系 ： key --> openId , value --> rsession
		            redisTemplate.set(openId, rsession);
		 
		            String newOpenId = redisTemplate.get(openId);
		            String newrSession = redisTemplate.get(rsession);
		            logger.info("新的openId==" + newOpenId);
		            logger.info("新的newrSession==" + newrSession);
		            // (7) 把新的sessionKey返回给小程序
		           
		            objret.put("rdSessionKey", rsession);
		            objret.put("errno", 0);
		            //renderJson(objret);
		          }
		 
		        }
		      }
		    }
			return objret.toString();
	}
}