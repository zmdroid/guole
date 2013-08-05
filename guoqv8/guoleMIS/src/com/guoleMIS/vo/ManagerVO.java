package com.guoleMIS.vo;

import java.util.List;

/**
 * 管理人员VO
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public class ManagerVO {
	private int id           ;
	private String userAccount  ;
	private String pwd          ;
	private String userName     ;
	private String tel          ;
	private String email        ;
	private int accountStatus;
	
	private List<RoleVO> role;//拥有的角色
	
	private List<PermissionVO> permission;//登录后拥有的所有权限
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAccountStatus() {
		return accountStatus;
	}
	public void setAccountStatus(int accountStatus) {
		this.accountStatus = accountStatus;
	}
	public List<RoleVO> getRole() {
		return role;
	}
	public void setRole(List<RoleVO> role) {
		this.role = role;
	}
	public List<PermissionVO> getPermission() {
		return permission;
	}
	public void setPermission(List<PermissionVO> permission) {
		this.permission = permission;
	}
	
	
}
