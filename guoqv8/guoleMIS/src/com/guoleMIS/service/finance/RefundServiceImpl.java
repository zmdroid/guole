package com.guoleMIS.service.finance;

import java.util.List;

import com.guoleMIS.dao.finance.RefundDao;
import com.guoleMIS.service.finance.RefundService;
import com.guoleMIS.vo.BillVO;
import com.guoleMIS.vo.RefundVO;

public class RefundServiceImpl implements RefundService {

	private RefundDao refundDao;

	@Override
	public Object[] getRefundList(int pageIndex,int refundId,
			String backtime,  int orderId,int reason) {
		// TODO Auto-generated method stub
		//拼装条件
		StringBuffer where = new StringBuffer();
		if(refundId > 0){
			where.append("id = ").append(refundId).append(" and ");
		}else if(orderId>0){
			where.append(" orderId = ").append(orderId).append(" and ");
		}else{
			if(reason>0){
				where.append(" reason = ").append(reason).append(" and ");
			}
			if(backtime!=null){
				String[] times = backtime.split(",");
				where.append(" (currtime >= '").append(times[0]).append("' and currtime <= '").append(times[1]).append("') and ");
			}
		}
		//查询分页
		int records = refundDao.queryRefundCountPage(where.toString());
		
		int pageSize = 10;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where.append("1=1 order by id desc limit ").append((pageIndex-1)*pageSize).append(",").append(pageSize);
		List<RefundVO> refund = refundDao.queryRefund(where.toString());
		return new Object[]{pageCount,refund};
	}
	
	@Override
	public RefundVO getRefundDetail(int id) {
		// TODO Auto-generated method stub
		return refundDao.queryRefundDetail(id);
	}

	public RefundDao getRefundDao() {
		return refundDao;
	}

	public void setRefundDao(RefundDao refundDao) {
		this.refundDao = refundDao;
	}



}
