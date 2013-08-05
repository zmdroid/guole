package com.guoleMIS.vo;

/**
 * 产品类型
 * @author 005
 *
 */
public class ProductTypeVO {

	private int id;//编号
	private String ptype;//父类型
	private String typeName;//类型名称
	private String remark;//描述
	private int state;//状态0:无效，1:有效
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	
}
