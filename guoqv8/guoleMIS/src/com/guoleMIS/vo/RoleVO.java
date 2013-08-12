package com.guoleMIS.vo;

import java.util.List;

/**
 * 角色
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public class RoleVO {
	private int id;
	private String name;
	private String detail;
	
	private List<PermissionVO> permission;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public List<PermissionVO> getPermission() {
		return permission;
	}
	public void setPermission(List<PermissionVO> permission) {
		this.permission = permission;
	}
	
	
}
