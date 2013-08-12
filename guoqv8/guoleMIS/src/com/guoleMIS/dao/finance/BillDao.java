package com.guoleMIS.dao.finance;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.BillVO;

/**
 * 账单操作DAO
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
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
	public int insertBill(BillVO bill);
	
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
	
	/**
	 * 查询流水
	 * @return
	 * @throws Exception
	 */
	public BillVO queryBillInfo(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 根据sn获取流水信息
	 * @param sn 流水NO
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-3
	 *		版本		修改者	时间		修改内容
	 */
	BillVO queryBillDetail(String _parameter);
}
