package com.fk.ztree.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.fk.ztree.common.util.Constant;
import com.fk.ztree.common.util.ResponseMsg;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.ZtDeptService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/dept")
public class ZtDeptController
{

  @Autowired
  private ZtDeptService deptService;

  @RequestMapping(value ="/getDepts", method=(RequestMethod.GET))
  @ResponseBody
  public ResponseMsg getDepts()
  {
    List depts = null;
    ResponseMsg res = new ResponseMsg(true, Constant.successCode, "初始化树成功", null);
    try {
      depts = this.deptService.getDepts();
      //json = JSONArray.
      res.setData(depts);
    } catch (ServiceException e) {
      e.printStackTrace();
      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null);
    }

    return res;
  }
}