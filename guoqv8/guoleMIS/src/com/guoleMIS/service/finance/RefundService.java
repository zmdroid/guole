package com.guoleMIS.service.finance;

import com.guoleMIS.vo.RefundVO;

/**
 * 返款服务
 * @author 005
 *
 */
public interface RefundService {
	
	/**
	 * 查询返款列表
	 * @param bill 查询条件
	 * @return
	 */
	Object[] getRefundList(int pageIndex,int refundId,
			String backtime,  int orderId,int reason);
	
	/**
	 * 根据Id查询返款详细
	 * @param id 返款Id
	 * @return
	 */
	RefundVO getRefundDetail(int id);
}
