package com.fk.ztree.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fk.ztree.common.pojo.User;
import com.fk.ztree.common.pojo.UserDetail;
import com.fk.ztree.common.pojo.UserDetailExample;
import com.fk.ztree.common.util.Page;

public interface UserDetailMapper {
    long countByExample(UserDetailExample example);

    int deleteByExample(UserDetailExample example);

    int deleteByPrimaryKey(String fid);

    int insert(UserDetail record);

    int insertSelective(UserDetail record);

    List<UserDetail> selectByExample(UserDetailExample example);

    UserDetail selectByPrimaryKey(String fid);

    int updateByExampleSelective(@Param("record") UserDetail record, @Param("example") UserDetailExample example);

    int updateByExample(@Param("record") UserDetail record, @Param("example") UserDetailExample example);

    int updateByPrimaryKeySelective(UserDetail record);

    int updateByPrimaryKey(UserDetail record);
    
    /**
     * 
    * @Title: updateByMemberId 
    * @Description: 根据用户id信息更新用户详情 
    * @param record 用户详情
    * @return int    数量
     */
    int updateByMemberId(UserDetail record);
    
}