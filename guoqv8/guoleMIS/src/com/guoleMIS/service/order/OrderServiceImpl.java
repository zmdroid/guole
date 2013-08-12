package com.guoleMIS.service.order;

import java.util.List;

import com.guoleMIS.dao.order.OrderDao;
import com.guoleMIS.vo.OrderVO;

public class OrderServiceImpl implements OrderService{

	private OrderDao orderDao;
	@Override
	public OrderVO getOrderByOrderId(int orderNo) {
		// TODO Auto-generated method stub
		return orderDao.getOrderByOrderId(orderNo);
	}
	
	@Override
	public Object[] getOrderList(int pageIndex,int orderNo,int userId,String createtime,String state) {
		// TODO Auto-generated method stub
		//查询分页
		StringBuffer where = new StringBuffer();
		if(orderNo>0){
			where.append("o.orderNo=").append(orderNo).append(" and ");
		}else{
			if(userId>0){
				where.append("o.userId=").append(userId).append(" and ");
			}
			if(createtime!=null){
				String[] times = createtime.split(",");
				where.append(" (o.createTime >= '").append(times[0]).append("' and o.createTime <= '").append(times[1]).append("') and ");
			}
		}
		if(Integer.parseInt(state)>=0){
			where.append("o.state=").append(state).append(" and ");
		}
		int records = orderDao.queryOrderListCount(where.toString());
				
		int pageSize = 10;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where.append("1=1 order by o.id desc limit ").append((pageIndex-1)*pageSize).append(",").append(pageSize);
		List<OrderVO> order = orderDao.queryOrderList(where.toString());
		return new Object[]{pageCount,order};
	}
	
	public OrderDao getOrderDao() {
		return orderDao;
	}
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}


}
