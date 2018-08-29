package com.fk.ztree.system.service;

import java.util.Map;

import com.fk.ztree.common.util.exception.ServiceException;

/**
 * 
* <p>Title:UserService </p>
* <p>Description: 用户信息操作 </p>
* <p>Company: </p> 
* @author fangkun
* @date 2018年8月26日
 */
public interface UserService {
    
    /**
     * 
    * @Title: findUserByInfo 
    * @Description: 根据条件查询用户信息 
    * @param @param 用户id，手机号，微信识别码
    * @return User    返回用户
     */
    public String findUserByInfo(Map<String, String> params) throws ServiceException;
    
    /**
     * 
    * @Title: saveUser  
    * @Description: 保存用户与详情信息
    * @param @param json格式字符串
    * @return void
     */
    public String saveUser(String userStr)throws ServiceException;
    
    /**
     * 
    * @Title: loginWeixin 
    * @Description: 小程序微信登录 
    * @param  code 微信临时登录凭证
    * @return String    3rd_session 
    * @throws
     */
    public String loginWeixin(String code);
    
    /**
     * 
    * @Title: updateUser  
    * @Description: 更新用户与详情信息
    * @param @param json格式字符串
    * @return void
     */
    public void updateUser(String userStr)throws ServiceException;
    
    

}