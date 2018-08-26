package com.fk.ztree.system.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fk.ztree.common.mapper.UserMapper;
import com.fk.ztree.common.pojo.User;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.UserService;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User findUserByInfo(Map params) throws ServiceException {
        return userMapper.findUserByInfo(params);
    }
}