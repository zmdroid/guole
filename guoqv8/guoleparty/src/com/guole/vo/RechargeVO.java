package com.guole.vo;

import java.util.Date;

/**
 * 充值单VO
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class RechargeVO {
	private Integer rechargeId       ;
	private Integer oper          ;//运营平台
	private Integer type          ;//充值方式(1.支付宝 2.线下 3.银行转账)
	private Integer userId        ;//充值用户id
	private String corName		 ;//公司名称(当前交易的用户公司名称，如果为个人则值为个人)
	private String userName      ;//帐号名称(当时交易用户名)
	private Double moneynum      ;//金额
	private Date optime        ;//提交时间
	private Integer state         ;//状态(1:申请 2:重值成功 3:充值失败)
	private Date lastUpdateTime;//最后一次状态修改时间
	private String remark        ;//备注
	
	public Integer getRechargeId() {
		return rechargeId;
	}
	public void setRechargeId(Integer rechargeId) {
		this.rechargeId = rechargeId;
	}
	public Integer getOper() {
		return oper;
	}
	public void setOper(Integer oper) {
		this.oper = oper;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
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
	public Date getOptime() {
		return optime;
	}
	public void setOptime(Date optime) {
		this.optime = optime;
	}
	
	public Double getMoneynum() {
		return moneynum;
	}
	public void setMoneynum(Double moneynum) {
		this.moneynum = moneynum;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
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
