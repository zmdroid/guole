package com.guole.consts;

public class Consts {
	
	/**
	 * 空集合json表示
	 */
	public static final String NULL_LIST = "[]";
	
	
	/**
	 * 当前登陆用户信息
	 */
	public static final String CURRENT_USER_INFO = "current_user_info";
	
	public static final String READ_COOKIES = "1";
	
	/**
	 * 用户类型  - 个人
	 */
	public static final int USER_TYPE_HUMAN = 1;
	
	/**
	 * 用户类型  - 企业
	 */
	public static final int USER_TYPE_COMPANY = 2;
	
	/**
	 * 跳转标记 - 跳转到登录页面
	 */
	public static final String STRUTS_FORWARD_LOGIN = "login";
	
	/**
	 * 跳转标记 - 跳转到个人管理页面
	 */
	public static final String STRUTS_FORWARD_HUMAN = "human";
	
	/**
	 * 跳转标记 - 跳转到公司管理页面
	 */
	public static final String STRUTS_FORWARD_COMPANY = "company";
	
	/**
	 * ************充值/提现 状态*********
	 * 申请(默认)
	 * 成功
	 * 失败
	 */
	public static final int WITHDRAWING_STATE_APPLY = 0;
	public static final int WITHDRAWING_STATE_CN_REFUSE = 1;
	public static final int WITHDRAWING_STATE_CN_APPROVE = 2;
	
	/**
	 * 账单流水交易类型
	 */
	public static final int BILL_TRADETYPE_RECHARGE = 1;
	public static final int BILL_TRADETYPE_LINE = 2;
	public static final int BILL_TRADETYPE_REFUND = 3;
	
	/**
	 * 充值/返款/账单流水交易方式
	 */
	public static final int RECHARGE_TYPE_ALIPAY = 3;
	public static final int RECHARGE_TYPE_OFFLINE = 2;
	public static final int RECHARGE_TYPE_GIFTCARD = 4;
	public static final int RECHARGE_TYPE_PLATFORM =1;
	
	/**
	 * 流水类型
	 * 收入
	 * 支出
	 */
	public static final int BILL_TYPE_INCOME = 1;
	public static final int BILL_TYPE_PAY = 2;
	
	/**
	 * 消息未读信息数KEY
	 */
	public static final String POSTBOX_UNREAD_FORMAT  = "user:%s:unread";
}
