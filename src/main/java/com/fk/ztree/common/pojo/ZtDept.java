package com.fk.ztree.common.pojo;

import java.util.Date;

public class ZtDept {
    private Long deptid;

    private String deptname;

    private Long deptparentid;

    private Date cretetime;
    //TODO修改机构
    
    private String icon;

    public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Long getDeptid() {
        return deptid;
    }

    public void setDeptid(Long deptid) {
        this.deptid = deptid;
    }

    public String getDeptname() {
        return deptname;
    }

    public void setDeptname(String deptname) {
        this.deptname = deptname;
    }

    public Long getDeptparentid() {
        return deptparentid;
    }

    public void setDeptparentid(Long deptparentid) {
        this.deptparentid = deptparentid;
    }

    public Date getCretetime() {
        return cretetime;
    }

    public void setCretetime(Date cretetime) {
        this.cretetime = cretetime;
    }
}