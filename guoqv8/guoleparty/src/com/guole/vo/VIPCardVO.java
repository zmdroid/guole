package com.guole.vo;

/**
 * 会员卡实体信息
 * @author 005
 *
 */
public class VIPCardVO {

	private int cardId;//编号
	private String name;//会员卡名称
	private double discount ;//会员卡折扣
	private String remark;//备注
	private String mainPic;//卡片的图片
	private int state;//卡的状态1:正常2:关闭
	
	private static final int VIPCARD_STATE_OPEN=1;
	private static final int VIPCARD_STATE_CLOSE=2;
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getMainPic() {
		return mainPic;
	}
	public void setMainPic(String mainPic) {
		this.mainPic = mainPic;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
