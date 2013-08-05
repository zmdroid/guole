package com.guoleMIS.vo;

import com.guoleMIS.util.Validate;



public class LineStateQueryVO {
	/**
	 * 发布人编号
	 */
	private int userId;
	
	/**
	 * 关键字
	 */
	private String keyword;
	
	/**
	 * 状态
	 */
	private int state;
	
	/**
	 * 发布时间
	 */
	private String publishTime;

	/**
	 * 业务区域
	 */
	private int busiType;
	
	/**
	 * 所有业务区域
	 */
	private static final int AREA_TYPE_ALL = -1;

	/**
	 * 获取查询字符串
	 * @return
	 */
	public String getQuery() {
		StringBuffer sql = new StringBuffer();
		
		if(state==0)//全部非上线状态的记录
			sql.append(" t.state != 4 and ");
		else{
			sql.append(" t.state=" + state + " and ");
		}
		appendNoStateSql(sql);
		String rs = sql.toString();
		return rs.equals("")?"1=1":rs;
	}
	
	/**
	 * 连接不需要除状态外的查询条件
	 * @param sql
	 */
	private void appendNoStateSql(StringBuffer sql) {
		//sql.append(" supplierId=" + userId);
		sql.append(" 1=1 ");
		if (AREA_TYPE_ALL != busiType) {
			sql.append(" and t.busiType=" + busiType);
		}

		if (!Validate.isEmpty(keyword)) {
			if (Validate.isNumber(keyword)) {
				sql.append(" and id=" + Integer.parseInt(keyword.trim()));
				return;
			}else{
				sql.append(" and name like '%"+ keyword +"%'");
			}
		}
		
		if (!Validate.isEmpty(publishTime)) {
			sql.append(" and datediff(publishTime, '"+ publishTime +"') = 0");
		}
	}
	
	/**
	 * 获取查询字符串
	 * @return
	 */
	public String getOffShelfQuery() {
		StringBuffer sql = new StringBuffer();
		appendNoStateSql(sql);
		return sql.toString();
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(String publishTime) {
		this.publishTime = publishTime;
	}

	public int getBusiType() {
		return busiType;
	}

	public void setBusiType(int busiType) {
		this.busiType = busiType;
	}
	
}
