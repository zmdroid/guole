package com.guoleMIS.dao.finance;

import java.util.List;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.dao.finance.RefundDao;
import com.guoleMIS.vo.RefundVO;

public class RefundDaoImpl extends BaseDaoImpl implements RefundDao{

	@Override
	public List<RefundVO> queryRefund(String _parameter) {
		// TODO Auto-generated method stub
		return this.sqlSessionTemplate.selectList("queryRefund", _parameter);
	}

	@Override
	public int queryRefundCountPage(String _parameter) {
		// TODO Auto-generated method stub
		return this.sqlSessionTemplate.selectOne("queryRefundCountPage", _parameter);
	}

	@Override
	public RefundVO queryRefundDetail(int id) {
		// TODO Auto-generated method stub
		return this.sqlSessionTemplate.selectOne("queryRefundDetail", id);
	}

	@Override
	public boolean insertRefund(RefundVO refundVO) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
}
