package com.guole.vo;

import java.util.Date;

/**
 * 企业申请实体
 * @author 005
 *
 */
public class ApplyCompanyInfoVO {
	
	private int id;//编号
	private int userId;//用户编号
	private Date applyTime;//申请时间
	private int aduitBy;//审核人
	private Date aduitTime;//审核时间
	private int state;//状态
	
	public static final int APPLY_COMPANY_STATE_ING=1;
	public static final int APPLY_COMPANY_STATE_SUCCESS=2;
	public static final int APPLY_COMPANY_STATE_FAIL=3;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	public int getAduitBy() {
		return aduitBy;
	}
	public void setAduitBy(int aduitBy) {
		this.aduitBy = aduitBy;
	}
	public Date getAduitTime() {
		return aduitTime;
	}
	public void setAduitTime(Date aduitTime) {
		this.aduitTime = aduitTime;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
}
