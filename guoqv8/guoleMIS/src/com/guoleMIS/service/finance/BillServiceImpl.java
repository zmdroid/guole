package com.guoleMIS.service.finance;

import java.util.HashMap;
import java.util.List;

import com.guoleMIS.dao.finance.BillDao;
import com.guoleMIS.service.finance.BillService;
import com.guoleMIS.util.Config;
import com.guoleMIS.vo.BillVO;

public class BillServiceImpl implements BillService {
	
	private BillDao billDao;

	private final static Config config = Config.getInstance();
	
	/**
	 * 根据业务类型和ID查询流水
	 * @param tradeId
	 * @param tradetype
	 * @return
	 * @throws Exception
	 */
	@Override
	public BillVO getBillInfo(int tradeId, int tradetype) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("tradeId", tradeId);
		map.put("tradetype", tradetype);
		
		return billDao.queryBillInfo(map);
	}
	
	private String getConditions(String startDate, String endDate, int tradeType, int userId, int tradeId){
		//拼装条件
		String where = "  ";
		if(tradeType != -1){
			where += " tradetype ="+tradeType+" and ";
		}
		if(userId != -1){
			where += " b.userId="+userId+" and ";
		}
		if(tradeId != 0){
			where += " tradeId="+tradeId+" and ";
		}
		if(startDate != null && !startDate.equals("")){
			where += " currtime >= '"+startDate+"' and ";
		}
		if(endDate != null && !endDate.equals("")){
			where += " currtime <= '"+endDate+"' and ";
		}
		return where;
	}
	
	@Override
	public int queryBillPageCount(String startDate, String endDate, int tradeType, int userId, int tradeId) {
		//拼装条件
		String where = getConditions(startDate, endDate, tradeType, userId, tradeId);
		return billDao.queryBillPageCount(where);
	}
	
	@Override
	public List<BillVO> getDetailList(String startDate, String endDate,int pageIndex, int tradeType, int userId, int tradeId) {
		//拼装条件
		String where = getConditions(startDate, endDate, tradeType, userId, tradeId);
		int pageSize = Integer.parseInt(config.getString("page.size"));
		//查询当前页数据
		where += " 1=1 order by sn desc limit "+(pageIndex-1)*pageSize+","+pageSize;
		return billDao.queryBill(where);
	}
	
	@Override
	public Object[] getBillList(int pageIndex, String tradetype,
			int billNo,String timeRange,  int tradeId) {
		// TODO Auto-generated method stub
		//拼装条件
		StringBuffer where = new StringBuffer();
		where.append(" b.userId=-1 and ");//平台ID=0
		if(tradetype!=null){
			where.append("b.tradetype = ").append(tradetype).append(" and ");
		}
		if(billNo>0){
			where.append(" b.sn = ").append(billNo).append(" and ");
		}else if(tradeId>0){
			where.append(" b.tradeId = ").append(tradeId).append(" and ");
		}else{
			if(timeRange!=null){
				String[] times = timeRange.split(",");
				where.append(" (b.currtime >= '").append(times[0]).append("' and b.currtime <= '").append(times[1]).append("') and ");
			}
		}
		//查询分页
		int records = billDao.queryBillPageCount(where.toString());
		
		int pageSize = 10;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where.append("1=1 order by b.sn desc limit ").append((pageIndex-1)*pageSize).append(",").append(pageSize);
		List<BillVO> bill = billDao.queryBill(where.toString());
		return new Object[]{pageCount,bill};
	}
	
	@Override
	public BillVO getBillDetail(int tradeId,int tradetype,int type) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		sb.append("tradeId=").append(tradeId).append(" and ").append("tradetype = ").append(tradetype).append(" and ").append("type=").append(type).append(" and ");
		return billDao.queryBillDetail(sb.toString());
	}
	
	@Override
	public List<BillVO> getBillListForTradeId(int tradeId) {
		// TODO Auto-generated method stub
		return billDao.queryBill("tradeId="+tradeId+" and tradetype>=3");
	}
	

	
	public BillDao getBillDao() {
		return billDao;
	}
	
	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}
}
