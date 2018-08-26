package com.fk.ztree.system.service;

import java.util.Map;

import com.fk.ztree.common.pojo.User;
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
    public User findUserByInfo(Map params) throws ServiceException;

}