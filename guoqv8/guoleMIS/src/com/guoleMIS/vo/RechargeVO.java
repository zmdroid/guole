package com.guoleMIS.vo;

import java.util.Date;

/**
 * 充值单VO
 * @author xubo.wang
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public class RechargeVO {
	/**
	 * 充值单号
	 */
	private int rechargeId;
	
	/**
	 * 运营平台
	 */
	private int oper;
	
	/**
	 * 充值方式(1.支付宝 2.线下)
	 */
	private int type;
	
	/**
	 * 充值用户id
	 */
	private int userId;
	
	/**
	 * 机构名称(当时交易公司名)
	 */
	private String corName;
	
	/**
	 * 帐号名称(当时交易用户名)
	 */
	private String userName;
	
	/**
	 * 金额
	 */
	private double moneynum;
	
	
	/**
	 * 提交时间
	 */
	private Date optime;
	
	/**
	 * 状态{0:申请,1:通过,2:拒绝,}
	 */
	private int state;
	
	/**
	 * 最后一次状态修改时间
	 */
	private Date lastUpdateTime;
	
	/**
	 * 备注
	 */
	private String remark;

	public int getRechargeId() {
		return rechargeId;
	}

	public void setRechargeId(int rechargeId) {
		this.rechargeId = rechargeId;
	}

	public int getOper() {
		return oper;
	}

	public void setOper(int oper) {
		this.oper = oper;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getCorName() {
		return corName;
	}

	public void setCorName(String corName) {
		this.corName = corName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public double getMoneynum() {
		return moneynum;
	}

	public void setMoneynum(double moneynum) {
		this.moneynum = moneynum;
	}

	public Date getOptime() {
		return optime;
	}

	public void setOptime(Date optime) {
		this.optime = optime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
