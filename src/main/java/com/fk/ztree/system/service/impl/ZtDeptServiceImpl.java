package com.fk.ztree.system.service.impl;

import com.fk.ztree.common.mapper.ZtDeptMapper;
import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.util.exception.ServiceException;
import com.fk.ztree.system.service.ZtDeptService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ZtDeptServiceImpl
  implements ZtDeptService
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
}