package com.fk.ztree.system.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fk.ztree.system.service.UserService;


@Controller
@RequestMapping("/user")
public class UserAction {
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/saveUser")
	public void saveUser(String user){
		user ="{'name':'test','nickName':'xs','userState':'1','idType':'1','mobile':'13598653214'}";
		userService.saveUser(user);
	}
	
	@RequestMapping(value="/updateUser")
	public void updateUser(String user){
		user ="{'fid':'85b96329-a344-4ec5-a082-8f57f010b68b','name':'test1','nickName':'xs1','userState':'0','idType':'4'}";
		userService.updateUser(user);
	}
	
	@RequestMapping(value="/findUserByInfo")
	@ResponseBody
	public String findUserByInfo(String info){
		//user ="{'fid':'85b96329-a344-4ec5-a082-8f57f010b68b','name':'test1','nickName':'xs1','userState':'0','idType':'4'}";
		Map<String,String> map = new HashMap<String,String>();
		map.put("mobile", "13598653214");
		String user = userService.findUserByInfo(map);
		return user;
	}
	
	@RequestMapping(value="/wxAuth")
	@ResponseBody
	public String wxAuth(String code){
		code = "110";
		String user = userService.loginWeixin(code);
		return user;
	}

}
