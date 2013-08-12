package com.guoleMIS.vo;

import java.util.Date;

/**
 * 充值/提现单日志VO
 * @author ken
 * @version 1.0
 * @createtime 2013-5-29
 *		版本		修改者	时间		修改内容
 *
 */
public class BillLogVO {
	private int id;
	private int orderNo       ;
	private int operId          ;//操作人员id
	private int optype          ;//操作人类型(1前台 2后台)
	private String op      ;//操作码
	private double moneynum      ;//金额
	private Date optime        ;//提交时间
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getOperId() {
		return operId;
	}
	public void setOperId(int operId) {
		this.operId = operId;
	}
	public int getOptype() {
		return optype;
	}
	public void setOptype(int optype) {
		this.optype = optype;
	}
	public String getOp() {
		return op;
	}
	public void setOp(String op) {
		this.op = op;
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


	
	
}
