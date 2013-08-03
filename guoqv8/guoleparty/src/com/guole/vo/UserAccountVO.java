package com.guole.vo;

/**
 * 用户虚拟账户信息
 * @author mingzhou
 * @version V1.0
 * @createTime   2013-8-2
 * @history  版本	修改者	   时间	修改内容
 */
public class UserAccountVO {
	
	private int id;//虚拟账户编号
	
	private int userId;//用户编号
	
    private  int accounttype;//账户类型
    
    public static int USERACCOUNT_ACCOUNTTYPE_1 = 1;//个人
    
    public static int USERACCOUNT_ACCOUNTTYPE_2 = 2;//公司
	
    private String paypassword;//支付密码
	
    private int state;//账户状态
    
    public static int USERACCOUNT_STATE_1 = 1;//待审核
    
    public static int USERACCOUNT_STATE_2 = 2;//审核通过
    
    public static int USERACCOUNT_STATE_3 = 3;//审核拒绝
    
    public static int USERACCOUNT_STATE_4 =4;//冻结
	
	private double balance;//账户余额

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

	public int getAccounttype() {
		return accounttype;
	}

	public void setAccounttype(int accounttype) {
		this.accounttype = accounttype;
	}

	public String getPaypassword() {
		return paypassword;
	}

	public void setPaypassword(String paypassword) {
		this.paypassword = paypassword;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

}