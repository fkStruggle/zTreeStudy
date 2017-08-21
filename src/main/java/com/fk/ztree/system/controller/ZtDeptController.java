package com.fk.ztree.system.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.util.Constant;
import com.fk.ztree.common.util.ResponseMsg;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.ZtDeptService;

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
    List<ZtDept> depts = null;
    ResponseMsg res = new ResponseMsg(true, Constant.successCode, "初始化树成功", null);
    try {
      depts = deptService.getDepts();
      for(ZtDept zt :depts){
    	  zt.setIcon("../../../zTreeStudy/css/zTree/zTreeStyle/img/diy/1_open.png");
      }
      //json = JSONArray.
      res.setData(depts);
    } catch (ServiceException e) {
      e.printStackTrace();
      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null);
    }

    return res;
  }
  @RequestMapping(value="/upDePaIdByDrag",method=RequestMethod.POST)
  @ResponseBody
  public ResponseMsg updateDeptParIdByDrag(@RequestParam(value="deptIds[]")String[] deptIds,
		  @RequestParam(value="newParaentId") String newParaentId,HttpServletRequest request){
	  ResponseMsg res = new ResponseMsg(true, Constant.successCode, "初始化树成功", null);
	  //request.getParameter("deptIds");
	  //request.getParameter("newParaentId");
	  //String[] deptIds = null;
	  try{
		  String [] str =new String[deptIds.length];
		  for(int i =0;i<deptIds.length;i++){
			  str[i] = String.valueOf(deptIds[i]);
		  }
		  deptService.updateDepParIdByDrag(str, String.valueOf(newParaentId));
	  }catch(ServiceException e){
		  e.printStackTrace();
	      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null); 
	  }
	return res;
  }
  @RequestMapping(value="/delDeptById",method=RequestMethod.POST)
  @ResponseBody
  public ResponseMsg delDeptById(@RequestParam(value="deptId") String deptId){
	 ResponseMsg res = new ResponseMsg(true, Constant.successCode, "删除树成功", null);;
	  //TODO如果存在下级机构，不允许删除
	 try{
		 deptService.deleteBydeptId(deptId);
	 }catch(ServiceException e){
		  e.printStackTrace();
	      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null); 
	 }
	 return res; 
  }
  @RequestMapping(value="/insDept",method = RequestMethod.POST)
  @ResponseBody
  public ResponseMsg insDept(@RequestBody ZtDept ztDept){
	  ResponseMsg res = new ResponseMsg(true, Constant.successCode, "新增机构成功", null);;
	 try{
		 deptService.insDept(ztDept);
	 }catch(ServiceException e){
		  e.printStackTrace();
	      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null); 
	 }
	 return res; 
  }
  @RequestMapping(value="/editDept",method =RequestMethod.POST)
  @ResponseBody
  public ResponseMsg editDept(@RequestBody ZtDept ztDept){
	  ResponseMsg res = new ResponseMsg(true, Constant.successCode, "修改机构成功", null);;
		 try{
			 deptService.EditDept(ztDept);
		 }catch(ServiceException e){
			  e.printStackTrace();
		      res = new ResponseMsg(false, Constant.errorCode, e.getMessage(), null); 
		 }
		 return res; 
  }
}