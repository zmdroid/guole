package com.guoleMIS.vo;

import java.util.Date;

/**
 * 资讯VO
 * @author 005
 *
 */
public class InformationVO {

	/**
	 * 编号
	 */
	private int id;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 发布人
	 */
	private int userId;
	/**
	 * 内容路径
	 */
	private String content;
	/**
	 * 主图
	 */
	private String picUrl;
	/**
	 * 来源
	 */
	private String source;
	/**
	 * 发布日期
	 */
	private Date publishTime;
	
	/**
	 * 类型 1：资讯 2：公告
	 */
	private int type;
	/**
	 * 状态 0:下架 1：上架
	 */
	private int state;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
