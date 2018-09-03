package com.fk.ztree.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fk.ztree.common.pojo.User;
import com.fk.ztree.common.util.Constant;
import com.fk.ztree.common.util.Page;
import com.fk.ztree.common.util.ResponseMsg;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.UserService;
import com.fk.ztree.utils.MD5Util;


@Controller
@RequestMapping("/user")
public class UserAction {
	private static final Logger logger = Logger.getLogger(UserAction.class);
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/saveUser")
	@ResponseBody
	public  JSONObject saveUser(String user){
		JSONObject jsonObj = new JSONObject();
		user ="{'name':'test','nickName':'xs','userState':'1','idType':'1','mobile':'13598653215'}";
		try{
			userService.saveUser(user);
			jsonObj.put("msg", "新增用户成功");
			jsonObj.put("code", "0000");
		}catch(Exception e){
			logger.error("新增用户失败:"+e.getMessage());
			jsonObj.put("msg", "新增用户失败");
			jsonObj.put("code", "1111");
		}
		return jsonObj;
		
	}
	
	@RequestMapping(value="/updateUser")
	@ResponseBody
	public  JSONObject updateUser(String user){
		JSONObject jsonObj = new JSONObject();
		user ="{'name':'test','nickName':'xs','userState':'1','idType':'1','mobile':'13598653214'}";
		try{
			userService.updateUser(user);
			jsonObj.put("msg", "修改用户成功");
			jsonObj.put("code", "0000");
		}catch(Exception e){
			logger.error("修改用户失败:"+e.getMessage());
			jsonObj.put("code", "1111");
			jsonObj.put("msg", "修改用户失败");
		}
		return jsonObj;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/findUserByInfo")
	@ResponseBody
	public JSONObject findUserByInfo(String info){
		//user ="{'fid':'85b96329-a344-4ec5-a082-8f57f010b68b','name':'test1','nickName':'xs1','userState':'0','idType':'4'}";
		JSONObject jsonObj = new JSONObject();
		Map<String,String> map = new HashMap<String,String>();
		//TODO json格式字符串转成map
		map = (Map<String, String>) JSON.parse(info);
		String pass = map.get("password");
		if(StringUtils.isNotBlank(pass)){
			//加密后比较
			map.put("password", MD5Util.md5Password(pass));
		}
		try{
			String user = userService.findUserByInfo(map);
			jsonObj.put("user", user);
			jsonObj.put("code", "0000");
		}catch(Exception e){
			logger.error("查询用户失败:"+e.getMessage());
			jsonObj.put("code", "1111");
			jsonObj.put("msg", "查询用户失败");
			
		}
		return jsonObj;
	}
	
	@RequestMapping(value="/wxAuth")
	@ResponseBody
	public JSONObject wxAuth(String code){
		JSONObject jsonObj = new JSONObject();
		code = "110";
		try{
			String wxuser = userService.loginWeixin(code);
			if(wxuser.contains("rdSessionKey")){
				jsonObj.put("code", "0000");
			}else{
				jsonObj.put("code", "1111");
			}
			jsonObj.put("wxuser",wxuser);
		}catch(Exception e){
			logger.error("微信授权登录失败:"+e.getMessage());
			jsonObj.put("code", "1111");
			jsonObj.put("msg", "微信授权登录失败");
		}
		
		return jsonObj;
	}
	
    @RequestMapping("/findUsersPage")
    @ResponseBody
    public JSONObject findUsersPage(@ModelAttribute("page") Page page,@ModelAttribute("user") User user) {
    	JSONObject jsonObj = new JSONObject();
        List<User> users = null;
        ResponseMsg res = new ResponseMsg(true, Constant.successCode, "查看成功", null);
        if(page == null|| page.getCurrentPage()==0){
            page = new Page();
            page.setCurrentPage(1);
        }
        try {
        	page.setCondition(user);
        	users = userService.findUsersPage(page);
            res.setData(users);
        } catch (ServiceException e) {
        	jsonObj.put("code", "1111");
        	jsonObj.put("msg", "分页查询用户失败");
            e.printStackTrace();
            logger.error("分页查询用户失败:"+e.getMessage());
        }
        jsonObj.put("res",res);
        jsonObj.put("page", page);
        jsonObj.put("code", "0000");
        return jsonObj;
    }


}
