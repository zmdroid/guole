package com.guoleMIS.dao.finance;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.RefundVO;

public interface RefundDao {
	/**
	 * 
	 * 获取返款记录
	 * @param _parameter where条件
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	List<RefundVO> queryRefund(String _parameter);
	
	/**
	 * 
	 * 获取返款记录总页数
	 * @param _parameter where条件
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	int queryRefundCountPage(String _parameter);
	
	/**
	 * 
	 * 根据返款ID获取返款详细信息
	 * @param id
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	RefundVO queryRefundDetail(int id);
	
	/**
	 * 插入一个退款单
	 * @param refundVO退款单
	 * @return boolean
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public boolean insertRefund(RefundVO refundVO) throws Exception;
}
