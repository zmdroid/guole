package com.guole.vo;

import java.util.Date;

public class GroupbuyInfoVO {
	/**
	 * 编号
	 */
	private int recordNo;
	
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 图片地址
	 */
	private String image;
	
	/**
	 * 开始时间
	 */
	private Date startTime;
	
	/**
	 * 结束时间
	 */
	private Date endTime;
	
	/**
	 * 原价
	 */
	private String value;
	
	/**
	 * 现价
	 */
	private String price;
	
	/**
	 * 折扣
	 */
	private String rebate;
	
	/**
	 * 节省钱数
	 */
	private String save;
	
	/**
	 * 已卖出
	 */
	private String bought;
	
	/**
	 * 类别名称
	 */
	private String subcategory;
	/**
	 * 类别编号
	 */
	private int typeCode;
	/**
	 * 商品描述
	 */
	private String remark;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 下线时间
	 */
	private Date offlineTime;
	
	/**
	 * 是否上线 默认：1即上线; 0: 下线)
	 */
	private int onLine;
	
	public int getRecordNo() {
		return recordNo;
	}

	public void setRecordNo(int recordNo) {
		this.recordNo = recordNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRebate() {
		return rebate;
	}

	public void setRebate(String rebate) {
		this.rebate = rebate;
	}

	public String getSave() {
		return save;
	}

	public void setSave(String save) {
		this.save = save;
	}

	public String getBought() {
		return bought;
	}

	public void setBought(String bought) {
		this.bought = bought;
	}

	public String getSubcategory() {
		return subcategory;
	}

	public void setSubcategory(String subcategory) {
		this.subcategory = subcategory;
	}

	public int getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(int typeCode) {
		this.typeCode = typeCode;
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

	public Date getOfflineTime() {
		return offlineTime;
	}

	public void setOfflineTime(Date offlineTime) {
		this.offlineTime = offlineTime;
	}

	public int getOnLine() {
		return onLine;
	}

	public void setOnLine(int onLine) {
		this.onLine = onLine;
	}
	
}
