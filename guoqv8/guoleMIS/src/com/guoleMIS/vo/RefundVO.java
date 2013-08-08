package com.guoleMIS.vo;

/**
 * 返款单VO
 * @author 005
 *
 */
public class RefundVO {

	private int id;
	private int orderNo;//订单编号
	private int receiver;//接受返款用户编号
	private double moneynum;//返款金额
	private String backtime;//返款时间
	private String reason;//返款原因
	
	private String userName;//接受返款用户名称
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public int getReceiver() {
		return receiver;
	}
	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}
	public double getMoneynum() {
		return moneynum;
	}
	public void setMoneynum(double moneynum) {
		this.moneynum = moneynum;
	}
	public String getBacktime() {
		return backtime;
	}
	public void setBacktime(String backtime) {
		this.backtime = backtime;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
}
