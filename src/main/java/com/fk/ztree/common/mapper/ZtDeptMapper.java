package com.fk.ztree.common.mapper;

import com.fk.ztree.common.pojo.ZtDept;
import com.fk.ztree.common.pojo.ZtDeptExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ZtDeptMapper {
    int countByExample(ZtDeptExample example);

    int deleteByExample(ZtDeptExample example);

    int deleteByPrimaryKey(Long deptid);

    int insert(ZtDept record);

    int insertSelective(ZtDept record);

    List<ZtDept> selectByExample(ZtDeptExample example);

    ZtDept selectByPrimaryKey(Long deptid);

    int updateByExampleSelective(@Param("record") ZtDept record, @Param("example") ZtDeptExample example);

    int updateByExample(@Param("record") ZtDept record, @Param("example") ZtDeptExample example);

    int updateByPrimaryKeySelective(ZtDept record);

    int updateByPrimaryKey(ZtDept record);
    
    List<ZtDept> selectDepts();
    
    //拖拽更新
    void updateByDrag(@Param("deptIds")String [] deptIds,@Param("deptparentid") String deptparentid);
}