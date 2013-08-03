package com.guole.service.bill;

import com.guole.vo.BillVO;


/**
 * 账单流水操作
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
 *		版本		修改者	时间		修改内容
 *
 */
public interface BillService {
	
	/**
	 * 增加一个新流水
	 * @param bill
	 * @return
	 */
	boolean add(BillVO bill);
	
	/**
	 * 查询流水列表
	 * @param bill 查询条件
	 * @return
	 */
	Object[] getBillList(int userId,int pageIndex,String tradetypes,String timeRange,String moneyRange,int tradeId,String types);
}
