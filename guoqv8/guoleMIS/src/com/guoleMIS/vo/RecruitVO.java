package com.guoleMIS.vo;

import java.util.Date;

/**
 * 招聘VO
 * @author 005
 *
 */
public class RecruitVO {

	/**
	 * 编号
	 */
	private int id;
	/**
	 * 发布人Id
	 */
	private int userId;
	/**
	 * 招聘职位
	 */
	private String position;
	/**
	 * 地点 省
	 */
	private String province;
	/**
	 * 地点 市
	 */
	private String city;
	/**
	 * 地点 县
	 */
	private String district;
	/**
	 * 类型
	 */
	private int type;
	/**
	 * 薪资 低
	 */
	private double lowSalary;
	/**
	 * 薪资 高
	 */
	private double hightSalary;
	/**
	 * 截止日期
	 */
	private Date dateLimit;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 联系人
	 */
	private String linkMan;
	/**
	 * 联系电话
	 */
	private String linkPhone;
	/**
	 * 发布日期
	 */
	private Date publishTime;
	/**
	 * 状态
	 */
	private int state;
	
	//附加信息
	private String companyName;
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
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getLowSalary() {
		return lowSalary;
	}
	public void setLowSalary(double lowSalary) {
		this.lowSalary = lowSalary;
	}
	public double getHightSalary() {
		return hightSalary;
	}
	public void setHightSalary(double hightSalary) {
		this.hightSalary = hightSalary;
	}
	public Date getDateLimit() {
		return dateLimit;
	}
	public void setDateLimit(Date dateLimit) {
		this.dateLimit = dateLimit;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	
}
