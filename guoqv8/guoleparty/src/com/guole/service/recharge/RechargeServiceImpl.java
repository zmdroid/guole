package com.guole.service.recharge;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guole.consts.Consts;
import com.guole.dao.bill.BillDao;
import com.guole.dao.recharge.RechargeDao;
import com.guole.vo.BillVO;
import com.guole.vo.RechargeVO;


public class RechargeServiceImpl implements RechargeService {
	Logger log = Logger.getLogger(RechargeServiceImpl.class);
	private RechargeDao rechargeDao;
	private BillDao billDao;//账单服务
	
	@Override
	public boolean recharge(RechargeVO vo) {
		rechargeDao.insertRecharge(vo);
		return true;
	}
	
	@Override
	public RechargeVO getRecharge(int userId, int orderNo) {
		return rechargeDao.queryRechargeById(orderNo);
	}
	

	@Override
	public Object[] getRechargeList(int userId,int pageIndex, String timeRange, String types,char state) {
		//拼装条件
		String where = "userId = "+userId+" and ";
		if(types!=null && types.length()>0){
			where += "type in ("+types+") and ";
		}
		if(timeRange!=null){
			String[] times = timeRange.split(",");
			where += "(optime >= '"+times[0]+"' and optime <= '"+times[1]+"') and ";
		}
		if(state!=0){
			where += "state="+state+" and ";
		}
		//查询分页
		int records = rechargeDao.queryRechargeCount(where);
		
		int pageSize = 20;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where += "1=1 order by optime desc limit "+(pageIndex-1)*pageSize+","+pageSize;
		List<RechargeVO> recharge = rechargeDao.queryRecharge(where);
		return new Object[]{pageCount,recharge};
	}
	

	public RechargeDao getRechargeDao() {
		return rechargeDao;
	}

	public void setRechargeDao(RechargeDao rechargeDao) {
		this.rechargeDao = rechargeDao;
	}

	public BillDao getBillDao() {
		return billDao;
	}

	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}
	
}
