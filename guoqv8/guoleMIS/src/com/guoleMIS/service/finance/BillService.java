package com.guoleMIS.service.finance;

import java.util.List;

import com.guoleMIS.vo.BillVO;

public interface BillService {
	/**
	 * 根据业务类型和ID查询流水
	 * @param tradeId
	 * @param tradetype
	 * @return
	 * @throws Exception
	 */
	public BillVO getBillInfo(int tradeId, int tradetype) throws Exception;
	
	/**
	 * 查询佣金列表
	 * @param bill 查询条件
	 * @return
	 */
	Object[] getBillList(int pageIndex,String tradetypes,int billNo,String timeRange,int tradeId);
	
	/**
	 * 查询流水列表
	 * @param bill 查询条件
	 * @return
	 */
	public List<BillVO> getDetailList(String startDate,String endDate,int pageIndex,int tradeType,int userId,int tradeId);
	
    int queryBillPageCount(String startDate, String endDate, int tradeType, int userId, int tradeId);

	/**
	 * 根据Id查询佣金详细信息
	 * @param sn 流水Id,tradetype,业务ID,type流水类型
	 * @return
	 */
	BillVO getBillDetail(int tradeId,int tradetype,int type);
	
	/**
	 * 根据tradeId获取流水列表
	 */
	List<BillVO> getBillListForTradeId(int tradeId);
}
