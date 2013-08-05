package com.guoleMIS.vo;

import java.util.Date;

/**
 * 线路VO
 * @author ken
 * @version 1.0
 * @createtime 2013-6-25
 *		版本		修改者	时间		修改内容
 *
 */
public class LineVO {
	private int id;
	private int rankingId;
	private int supplierId;
	private String supplierName;
	private String fundations;
	private String corname;
	private String userName;//供应商名称
	private String name;
	private String busiType;
	private String lineType;
	private String toplace;
	private String views;
	private String fromplace;
	private String toTransport;
	private String fromTransport;
	private int days;
	private int nights;
	private String travelDocPath;
	private String travelDocName;
	private String topic;
	private String linker;
	private String linkphone;
	private String productType;
	private String features;
	/**
	 * 行程信息
	 */
	private String routeinfo;
	private int deadline;
	private String state = "5";
	private String propics;
	private String[] pics;
	private String attention;
	private String bookinfo="";
	private String costinfo="";
	private String visainfo;
	private String extra;
	private Date publishTime;
	private Date updateTime;
	private int sortNo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBusiType() {
		return busiType;
	}
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}
	public String getLineType() {
		return lineType;
	}
	public void setLineType(String lineType) {
		this.lineType = lineType;
	}
	public String getToplace() {
		return toplace;
	}
	public void setToplace(String toplace) {
		this.toplace = toplace;
	}
	public String getViews() {
		return views;
	}
	public void setViews(String views) {
		this.views = views;
	}
	public String getFromplace() {
		return fromplace;
	}
	public void setFromplace(String fromplace) {
		this.fromplace = fromplace;
	}
	public String getToTransport() {
		return toTransport;
	}
	public void setToTransport(String toTransport) {
		this.toTransport = toTransport;
	}
	public String getFromTransport() {
		return fromTransport;
	}
	public void setFromTransport(String fromTransport) {
		this.fromTransport = fromTransport;
	}
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public int getNights() {
		return nights;
	}
	public void setNights(int nights) {
		this.nights = nights;
	}
	public String getTravelDocPath() {
		return travelDocPath;
	}
	public void setTravelDocPath(String travelDocPath) {
		this.travelDocPath = travelDocPath;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public String getLinker() {
		return linker;
	}
	public void setLinker(String linker) {
		this.linker = linker;
	}
	public String getLinkphone() {
		return linkphone;
	}
	public void setLinkphone(String linkphone) {
		this.linkphone = linkphone;
	}
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	public String getFeatures() {
		return features;
	}
	public void setFeatures(String features) {
		this.features = features;
	}
	public int getDeadline() {
		return deadline;
	}
	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPropics() {
		return propics;
	}
	public void setPropics(String propics) {
		this.propics = propics;
	}
	public String getAttention() {
		return attention;
	}
	public void setAttention(String attention) {
		this.attention = attention;
	}
	public String getBookinfo() {
		return bookinfo;
	}
	public void setBookinfo(String bookinfo) {
		this.bookinfo = bookinfo;
	}
	public String getCostinfo() {
		return costinfo;
	}
	public void setCostinfo(String costinfo) {
		this.costinfo = costinfo;
	}
	public String getVisainfo() {
		return visainfo;
	}
	public void setVisainfo(String visainfo) {
		this.visainfo = visainfo;
	}
	public String getExtra() {
		return extra;
	}
	public void setExtra(String extra) {
		this.extra = extra;
	}
	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public int getSortNo() {
		return sortNo;
	}
	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}
	public int getRankingId() {
		return rankingId;
	}
	public void setRankingId(int rankingId) {
		this.rankingId = rankingId;
	}

	public String getCorname() {
		return corname;
	}
	public void setCorname(String corname) {
		this.corname = corname;
	}
	public String getFundations() {
		return fundations;
	}
	public void setFundations(String fundations) {
		this.fundations = fundations;
	}

	public String getTravelDocName() {
		return travelDocName;
	}
	public void setTravelDocName(String travelDocName) {
		this.travelDocName = travelDocName;
	}
	public String getRouteinfo() {
		return routeinfo;
	}
	public void setRouteinfo(String routeinfo) {
		this.routeinfo = routeinfo;
	}
	public String[] getPics() {
		return pics;
	}
	public void setPics(String[] pics) {
		this.pics = pics;
	}
	
}
