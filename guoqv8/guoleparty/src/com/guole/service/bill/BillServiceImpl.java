package com.guole.service.bill;

import java.util.List;

import com.guole.dao.bill.BillDao;
import com.guole.vo.BillVO;

public class BillServiceImpl implements BillService {
	private BillDao billDao;

	@Override
	public boolean add(BillVO bill) {
		return billDao.insertBill(bill);
	}

	@Override
	public Object[] getBillList(int userId,int pageIndex,String tradetypes,String timeRange,String moneyRange,int tradeId,String types) {
		//拼装条件
		String where = "userId = "+userId+" and ";
		if(tradetypes!=null){
			where += "tradetype in ("+tradetypes+") and ";
		}
		if(types!=null){
			where += "type in ("+types+") and ";
		}
		if(timeRange!=null){
			String[] times = timeRange.split(",");
			where += "(currtime >= '"+times[0]+"' and currtime <= '"+times[1]+"') and ";
		}
		if(moneyRange!=null){
			String[] moneys = moneyRange.split(",");
			where += "(money > '"+moneys[0]+"' and money < '"+moneys[1]+"') and ";
		}
		//查询分页
		int records = billDao.queryBillPageCount(where);
		
		int pageSize = 3;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where += "1=1 order by sn desc limit "+(pageIndex-1)*pageSize+","+pageSize;
		List<BillVO> bill = billDao.queryBill(where);
		return new Object[]{pageCount,bill};
	}

	public BillDao getBillDao() {
		return billDao;
	}

	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}

	
}
