package com.guole.vo;

import java.util.Date;
/**
 * 用户关联的送货地址
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-12
 *		版本		修改者	时间		修改内容
 *
 */
public class LinkAddrVO {
	
/**
 * 编号
 */
	private Integer id;
	/**
	 * 用户编号
	 */
	private int userId;
	
	/**
	 * 送货地址
	 */
	private String address;
	/**
	 * 联系人
	 */
	private String linkMan;
	/**
	 * 联系电话
	 */
	private String linkPhone;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkPhone() {
		return linkPhone;
	}
	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}
	
}
