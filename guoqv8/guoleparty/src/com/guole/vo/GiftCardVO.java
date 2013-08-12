package com.guole.vo;

import java.util.Date;

public class GiftCardVO {
	/**
	 * 编号
	 */
	private int id;
	
	/**
	 * 卡类型
	 */
	private int cardType;
	/**
	 * 卡号
	 */
	private String cardNum;
	/**
	 * 密码
	 */
	private String pwd;
	/**
	 * 状态 (1:正常 2:关闭)
	 */
	private int state;
	
	/**
	 * 描述
	 */
	private String  remark;
	/**
	 * 礼品卷的创建时间
	 */
	private Date createTime;
	/**
	 * 礼品卷的使用时间
	 */
	private Date useTime;
	
	/**
	 * 礼品卡使用人
	 */
	private int userId;
	
	/**
	 * 卡内现有金额 
	 */
	private double money;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCardNum() {
		return cardNum;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUseTime() {
		return useTime;
	}
	public void setUseTime(Date useTime) {
		this.useTime = useTime;
	}
	public int getCardType() {
		return cardType;
	}
	public void setCardType(int cardType) {
		this.cardType = cardType;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	
	
}
