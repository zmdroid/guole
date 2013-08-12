package com.guoleMIS.vo;

import java.util.Date;

/**
 * 账单流水VO
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
 *		版本		修改者	时间		修改内容
 *
 */
public class BillVO {
	private long sn          ;//交易流水号
	private int userId      ;//用户id
	private int tradeId     ;//业务id
	private int tradetype   ;//交易类型(充值、交易、返款)
	private int tradechannel;//交易方式(1.平台内 2.线下 3.支付宝 4.礼品卡)
	private Date currtime    ;//当前时间
	private double money       ;//交易金额
	private int type     ;//流水类型(1.收入/2.支出)
	private double balance;//余额
	
	private String userName;//当前流水用户名称
	private String usertype;//当前流水用户名称
	
	public long getSn() {
		return sn;
	}
	public void setSn(long sn) {
		this.sn = sn;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getTradeId() {
		return tradeId;
	}
	public void setTradeId(int tradeId) {
		this.tradeId = tradeId;
	}
	public int getTradetype() {
		return tradetype;
	}
	public void setTradetype(int tradetype) {
		this.tradetype = tradetype;
	}
	public int getTradechannel() {
		return tradechannel;
	}
	public Date getCurrtime() {
		return currtime;
	}
	public void setCurrtime(Date currtime) {
		this.currtime = currtime;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public void setTradechannel(int tradechannel) {
		this.tradechannel = tradechannel;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	
	
}
