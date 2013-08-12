package com.guoleMIS.service.finance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.dao.finance.BillDao;
import com.guoleMIS.dao.member.MemberInfoDao;
import com.guoleMIS.service.finance.PlatFormAccountService;
import com.guoleMIS.vo.BillVO;
import com.guoleMIS.vo.MemberAccountVO;

public class PlatFormAccountServiceImpl implements PlatFormAccountService {
	
	private BillDao billDao;
	private MemberInfoDao memberInfoDao;

	public BillDao getBillDao() {
		return billDao;
	}
	
	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}
	
	
	public MemberInfoDao getMemberInfoDao() {
		return memberInfoDao;
	}

	public void setMemberInfoDao(MemberInfoDao memberInfoDao) {
		this.memberInfoDao = memberInfoDao;
	}

	@Override
	public String getPlatFormTotal() {
		// TODO Auto-generated method stub
		try {
			
			MemberAccountVO accountVO = memberInfoDao.getMemberAccountByUserId(-1);
			return String.format("%.2f",memberInfoDao.getUserAccountBalanceTotal()+accountVO.getBalance());
		} catch (Exception e) {
			// TODO: handle exception
			return "";
		}
	}

	@Override
	public String getPlatFormMoney() {
		// TODO Auto-generated method stub
		MemberAccountVO accountVO =  memberInfoDao.getMemberAccountByUserId(-1);
		return accountVO.getBalance()+"";
	}

	@Override
	public String getUserAccountMoney() {
		// TODO Auto-generated method stub
		return String.format("%.2f",memberInfoDao.getUserAccountBalanceTotal());
	}

	@Override
	public List<BillVO> getPlantFormBill(int pageIndex,String timeRange,int type) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		if(type>0){
			sb.append(" b.tradetype=").append(type).append(" and ");
		}
		if(timeRange!=null){
			String[] times = timeRange.split(",");
			sb.append(" (b.currtime >= '").append(times[0]).append("' and b.currtime <= '").append(times[1]).append("') and ");
		}
		sb.append(" 1=1 order by b.sn desc limit ").append((pageIndex-1)*10).append(",").append(10);;
		List<BillVO> bills = billDao.queryBill(sb.toString());
		return bills;
	}

	@Override
	public int getPlantFormBillCountPage(String timeRange,int type) {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		if(type>0){
			sb.append(" b.tradetype=").append(type).append(" and ");
		}
		if(timeRange!=null){
			String[] times = timeRange.split(",");
			sb.append(" (b.currtime >= '").append(times[0]).append("' and b.currtime <= '").append(times[1]).append("') and ");
		}
		sb.append(" 1=1 and ");
		int records = billDao.queryBillPageCount(sb.toString());
		int pageSize = 10;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		return pageCount;
	}
}
