package com.guoleMIS.dao.orderdetail;

import java.util.List;

import com.guoleMIS.vo.OrderDetailVO;

public interface OrderDetailDao {

	/**
	 * 更具订单id获取订单详情
	 */
	List<OrderDetailVO> qurOrderDetailByOrderId(int orderId);
}
