package com.guoleMIS.dao.order;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.OrderDetailVO;
import com.guoleMIS.vo.OrderVO;

public interface OrderDao {

	/**
	 * 根据OrderId查询订单
	 * @param order
	 * @return OrderVO
	 * @throws Exception
	 */
	public OrderVO getOrderByOrderId(int orderNo);
	
	/**
	 * 根据参数查询订单列表
	 * @param where条件
	 * @return List<OrderVO>
	 */
	public List<OrderVO> queryOrderList(String where);
	/**
	 * 根据参数查询订单列表总数
	 * @param where条件
	 * @return List<OrderVO>
	 */
	public int queryOrderListCount(String where);
	
	/**
	 * 更新订单的状态
	 * @param userId,balance
	 * @return boolean
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int modifyOrderState(Map param) throws Exception;
}
