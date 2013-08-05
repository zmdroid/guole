package com.guoleMIS.consts;

public class Consts {
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
	 * 线路状态 - 过期下架
	 */
	public static final String LINE_STATE_EXPIRE = "1";
	/**
	 * 线路状态 - 手动下架
	 */
	public static final String LINE_STATE_ARTIFICIAL = "2";
	/**
	 * 线路状态 - 违规下架
	 */
	public static final String LINE_STATE_INFRINGE = "3";
	/**
	 * 线路状态 - 在售
	 */
	public static final String LINE_STATE_SELLING = "4";
	/**
	 * 线路状态 - 待售
	 */
	public static final String LINE_STATE_PRESELL = "5";
	/**
	 * 线路状态 - 审核不通过
	 */
	public static final String LINE_STATE_REFUSE = "6";
	
	/**
	 * 线路类型 - 跟团游
	 */
	public static final String LINE_TYPE_GROUP = "1";
	/**
	 * 线路类型 - 自由行
	 */
	public static final String LINE_TYPE_FREE = "2";
	/**
	 * 线路类型 - 地接
	 */
	public static final String LINE_TYPE_NATIVE = "3";
}
