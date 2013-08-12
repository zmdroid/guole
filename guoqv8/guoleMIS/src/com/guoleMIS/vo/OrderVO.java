package com.guoleMIS.vo;

import java.util.Date;
import java.util.List;

/**
 * 订单实体信息
 * @author 005
 *
 */
public class OrderVO {

	/**
	 * 订单编号
	 */
	private int id;
	/**
	 * 用户编号
	 */
	private int userId;
	/**
	 * 用户名称
	 */
	private String carName;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 送货地址
	 */
	private String address;
	/**
	 * 送货联系人
	 */
	private String linkMan;
	/**
	 * 送货联系电话
	 */
	private String linkPhone;
	/**
	 * 支付方式(0：送货上门 1：在线付款)
	 */
	private int payment;
	public static final int ORDRE_PAYMENT_DOOR=0;
	public static final int ORDRE_PAYMENT_ONLINE=1;
	/**
	 * 订单总金额
	 */
	private double money;
	/**
	 * 订单状态(0:未付款 1:已付款 2:交易成功 3:交易失败)
	 */
	private int state;
	public static final int ORDER_STATE_NOT_PAYMENT=0;
	public static final int ORDER_STATE_PAYMENT_END=1;
	public static final int ORDER_STATE_SUCCESS=2;
	public static final int ORDER_STATE_FAIL=3;
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 订单详情信息
	 */
	private List<OrderDetailVO> orderDetailList;
	
	
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
	public String getCarName() {
		return carName;
	}
	public void setCarName(String carName) {
		this.carName = carName;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
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
	public List<OrderDetailVO> getOrderDetailList() {
		return orderDetailList;
	}
	public void setOrderDetailList(List<OrderDetailVO> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}
	
	
}
