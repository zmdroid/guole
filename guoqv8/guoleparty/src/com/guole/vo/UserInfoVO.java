package com.guole.vo;

/**
 * 用户信息
 * @author mingzhou
 * @version V1.0
 * @createTime   2013-8-2
 * @history  版本	修改者	   时间	修改内容
 */
public class UserInfoVO {
	
	private int userId;//用户编号
	
	private String name;//用户姓名
	
	private String avatar;//用户头像
	
	private String qq;//用户QQ
	
	private String email;//用户邮箱
	
	private String mobile;//用户手机
	
	private String integration;//用户积分
	
	private String corname;//公司名称
	private int cornum;//公司名称
	private String coraddr;//公司地址
	private String corLinkMan;//公司联系人
    private String corLinkphone;//公司联系电话
    private String corEmail;//公司联系邮箱
	
    private String userAccount;//登陆账号
	
	private String pwd;//登陆密码
	
    private int usertype;//用户类型
    
    public static int USER_TYPE_1 = 1;//个人
    
    public static int USER_TYPE_2 = 2;//企业
    
    private int cardId;//会员卡编号
		
    private int state;//用户状态
    
    public static int USER_STATE_1 = 1;//待审核
    
    public static int USER_STATE_2 = 2;//审核通过
    
    public static int USER_STATE_3 = 3;//审核拒绝
    
    public static int USER_STATE_4 = 4;//冻结

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getIntegration() {
		return integration;
	}

	public void setIntegration(String integration) {
		this.integration = integration;
	}

	public String getCorname() {
		return corname;
	}

	public void setCorname(String corname) {
		this.corname = corname;
	}

	public String getCoraddr() {
		return coraddr;
	}

	public void setCoraddr(String coraddr) {
		this.coraddr = coraddr;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getUsertype() {
		return usertype;
	}

	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getCornum() {
		return cornum;
	}

	public void setCornum(int cornum) {
		this.cornum = cornum;
	}

	public String getCorLinkMan() {
		return corLinkMan;
	}

	public void setCorLinkMan(String corLinkMan) {
		this.corLinkMan = corLinkMan;
	}

	public String getCorLinkphone() {
		return corLinkphone;
	}

	public void setCorLinkphone(String corLinkphone) {
		this.corLinkphone = corLinkphone;
	}

	public String getCorEmail() {
		return corEmail;
	}

	public void setCorEmail(String corEmail) {
		this.corEmail = corEmail;
	}

	public int getCardId() {
		return cardId;
	}

	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
    
    
}