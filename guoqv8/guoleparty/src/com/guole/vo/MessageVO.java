package com.guole.vo;

import java.util.Date;
/**
 * 消息
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class MessageVO {
	public int id;// 消息编号
	
	public String content;// 消息内容
	
	public Date publishTime;//发布时间
	
	private int fromBy;//发送人
	
	public int receiver;//接受者

    private int type;//消息类型
	
	public static int NOTIFY_TYPE_0 = 0;//系统自动触发
	    
	public static int NOTIFY_TYPE_1 =1;//后台手动发送

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}

	public int getFromBy() {
		return fromBy;
	}

	public void setFromBy(int fromBy) {
		this.fromBy = fromBy;
	}

	public int getReceiver() {
		return receiver;
	}

	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	
}
