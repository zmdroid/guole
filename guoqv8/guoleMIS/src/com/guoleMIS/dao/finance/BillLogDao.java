package com.guoleMIS.dao.finance;

import java.util.List;

/**
 * 账单操作日志
 * @author ken
 * @version 1.0
 * @createtime 2013-5-29
 *		版本		修改者	时间		修改内容
 *
 */
public interface BillLogDao<T> {
	/**
	 * 插入日志
	 * @param logVO
	 * @return
	 */
	int insertLog(T logVO);
	
	/**
	 * 查询日志
	 * @param conditions
	 * @return
	 */
	List<T> queryLog(String conditions);
	
	/**
	 * 查询日志数量
	 * @param conditions
	 * @return
	 */
	int queryLogCount(String conditions);
}
