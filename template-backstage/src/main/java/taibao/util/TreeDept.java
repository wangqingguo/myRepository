package com.weitu.permission.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TreeDept {

	private int id ;
	private String deptId ;
	private String deptName ;
	private String parentId ;
	private Integer sortCode ;
	private Integer enabled ;
	private String createTime ;
	private String description ;
	
	private List<TreeDept> children = new ArrayList<TreeDept>();

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public Integer getSortCode() {
		return sortCode;
	}

	public void setSortCode(Integer sortCode) {
		this.sortCode = sortCode;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<TreeDept> getChildren() {
		return children;
	}

	public void setChildren(List<TreeDept> children) {
		this.children = children;
	}
	
	
	
	
}
