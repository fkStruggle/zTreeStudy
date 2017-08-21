package com.fk.ztree.system.service.impl;

import com.fk.ztree.common.mapper.ZtDeptMapper;
import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.ZtDeptService;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZtDeptServiceImpl implements ZtDeptService
{

  @Autowired
  private ZtDeptMapper ztDeptMapper;

  public List<ZtDept> getDepts()
    throws ServiceException
  {
    List depts = null;
    try {
      depts = this.ztDeptMapper.selectDepts();
    } catch (Exception e) {
      e.printStackTrace();
      throw new ServiceException("Service层异常:查询机构发生错误");
    }
    return depts;
  }

@Override
public void updateDepParIdByDrag(String[] deptIds, String deptParId)
		throws ServiceException {
	try{
		ztDeptMapper.updateByDrag(deptIds, deptParId);
	}catch(Exception e){
		e.printStackTrace();
		throw new ServiceException("Service层异常:拖拽发生错误");
	}
}

@Override
public void deleteBydeptId(String deptParId) throws ServiceException {
	try{
		ztDeptMapper.deleteByPrimaryKey(Long.valueOf(deptParId));
	}catch(Exception e){
		e.printStackTrace();
		throw new ServiceException("Service层异常:删除发生错误");
	}
}

@Override
public void insDept(ZtDept ztDept) throws ServiceException {
	try{
		ztDept.setCretetime(new Date());
		ztDeptMapper.insert(ztDept);
	}catch(Exception e){
		e.printStackTrace();
		throw new ServiceException("Service层异常:新增机构错误");
	}
	
}

@Override
public void EditDept(ZtDept ztDept) throws ServiceException {
	try{
		ztDeptMapper.updateByPrimaryKey(ztDept);
	}catch(Exception e){
		e.printStackTrace();
		throw new ServiceException("Service层异常:编辑机构错误");
	}
}
}