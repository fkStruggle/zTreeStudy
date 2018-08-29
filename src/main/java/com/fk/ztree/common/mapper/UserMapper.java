package com.fk.ztree.common.mapper;

import com.fk.ztree.common.pojo.User;
import com.fk.ztree.common.pojo.UserExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    long countByExample(UserExample example);

    int deleteByExample(UserExample example);

    int deleteByPrimaryKey(String fid);

    int insert(User record);

    int insertSelective(User record);

    List<User> selectByExample(UserExample example);

    User selectByPrimaryKey(String fid);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    int updateByExample(@Param("record") User record, @Param("example") UserExample example);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    /**
     * 
    * @Title: findUserByInfo 
    * @Description: 根据条件查询用户信息 
    * @param @param 用户id，手机号，微信识别码
    * @return User    返回用户
     */
    User findUserByInfo(Map<String,String> params);
}