package com.fk.ztree.system.service;

import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.util.exception.ServiceException;
import java.util.List;

public  interface ZtDeptService
{
  public abstract List<ZtDept> getDepts()
    throws ServiceException;
}