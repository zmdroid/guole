package com.guole.dao.bill;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guole.vo.BillVO;

/**
 * 账单操作DAO
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface BillDao {
	/**
	 * 插入账单
	 * @param bill
	 * @return
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public boolean insertBill(BillVO bill);
	
	/**
	 * 查询分页
	 * @param conditions
	 * @return
	 */
	public int queryBillPageCount(String conditions);
	/**
	 * 查询账单
	 * @param bill 查询条件
	 * @return
	 */
	public List<BillVO> queryBill(String conditions);
}
