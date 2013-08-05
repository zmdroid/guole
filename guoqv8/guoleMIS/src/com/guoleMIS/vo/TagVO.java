package com.guoleMIS.vo;

/**
 * 标签信息
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-05
 * @history  版本	修改者	   时间	修改内容
 */
public class TagVO {
	
	private int id;//标签编号
	
	private String name;//标签名称
	
	private String remark;//标签说明
	
	private String status;//标签状态
	
	public static String TAG_STATUS_0 = "0";//无效
	    
	public static String TAG_STATUS_1 = "1";//有效
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
