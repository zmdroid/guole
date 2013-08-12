package com.guoleMIS.vo;

/**
 * 消息信息
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-06
 * @history  版本	修改者	   时间	修改内容
 */
public class NotifyVO {
	
    private int id;//消息编号
	
	private String content;//消息内容
	
	private int fromBy;//发送人
	
	private String fromByName;//发送人姓名
	
	private int receiver;//接收人

	private String receiverName;//接收人姓名
	
	private String publishTime;//发送时间

	private String startDate;//发送起始时间
	
	private String endDate;//发送截止时间
	
    private String type;//消息类型
	
	public static String NOTIFY_TYPE_0 = "0";//系统自动触发
	    
	public static String NOTIFY_TYPE_1 = "1";//后台手动发送
	
	public static String NOTIFY_TYPE_2 = "2";//买家询价
	
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

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getFromByName() {
		return fromByName;
	}

	public void setFromByName(String fromByName) {
		this.fromByName = fromByName;
	}

}
