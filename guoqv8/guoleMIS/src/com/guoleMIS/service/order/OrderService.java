package com.guoleMIS.service.order;

import com.guoleMIS.vo.OrderVO;


public interface OrderService {

	OrderVO getOrderByOrderId(int orderNo);
	
	Object[] getOrderList(int pageIndex,int orderNo,int userId,String createtime,String state);
}
