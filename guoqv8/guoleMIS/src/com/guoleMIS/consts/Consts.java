package com.guoleMIS.consts;

public class Consts {
	
	/**
	 * 空列表
	 */
	public static final String NULL_LIST="[]";
	
	/**
	 * 当前登陆用户信息
	 */
	public static final String CURRENT_USER_INFO = "current_user_info";
	public static final String CURRENT_USER_PERMISSION = "current_user_permission";

	/**
	 * 后台账户类型
	 */
	public static final int MANAGER_TYPE_NORMAL = 1;
	public static final int MANAGER_TYPE_FROZEN = 2;
	
	/*
	 * 消息未读信息数KEY
	 */
	public static final String POSTBOX_UNREAD_FORMAT  = "user:%s:unread";
	
	
	/**
	 * 充值单状态
	 * 申请
	 * 通过
	 * 拒绝
	 * 
	 */
	public static final int RECHARGEVO_STATE_APPLY=0;
	public static final int RECHARGEVO_STATE_SUCCESS=1;
	public static final int RECHARGEVO_STATE_FAILS=2;
	
	
	/**
	 * 账单流水交易类型
	 */
	public static final int BILL_TRADETYPE_RECHARGE = 1;
	public static final int BILL_TRADETYPE_LINE = 2;
	public static final int BILL_TRADETYPE_REFUND = 3;
	/**
	 * 流水类型
	 * 收入
	 * 支出
	 */
	public static final char BILL_TYPE_INCOME = 1;
	public static final char BILL_TYPE_PAY = 2;
	
	/**
	 * 前台
	 */
	public static final int PLATFORM_TPM = 1;
	
	/**
	 * 后台
	 */
	public static final int PLATFORM_OPERATOR = 1;
}
