package com.fk.ztree.system.service;

import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.util.exception.ServiceException;
import java.util.List;

public  interface ZtDeptService
{
  public List<ZtDept> getDepts() throws ServiceException;
  
  public void updateDepParIdByDrag(String[] deptIds,String deptParId) throws ServiceException;
  
  public void deleteBydeptId(String deptParId) throws ServiceException;
  
  public void insDept(ZtDept ztDept) throws ServiceException;
  
  public void EditDept(ZtDept ztDept) throws ServiceException;
}