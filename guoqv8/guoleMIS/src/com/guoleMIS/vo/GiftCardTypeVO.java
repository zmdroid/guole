package com.guoleMIS.vo;

import java.util.Date;

public class GiftCardTypeVO {
	/**
	 * 编号
	 */
	private int id;
	
	/**
	 * 卡名
	 */
	private String name;
	/**
	 * 卡金额
	 */
	private int money;
	/**
	 * 状态 (1:正常 2:关闭)
	 */
	private int state;
	/**
	 * 描述
	 */
	private String  remark;
	/**
	 * 主图
	 */
	private String img;
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
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
}
