package com.guoleMIS.dao.finance;

import java.util.List;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.dao.finance.RechargeLogDao;
import com.guoleMIS.vo.BillLogVO;

public class RechargeLogDaoImpl extends BaseDaoImpl implements RechargeLogDao {

	@Override
	public int insertLog(BillLogVO logVO) {
		return sqlSessionTemplate.insert("insertLog");
	}

	@Override
	public List<BillLogVO> queryLog(String conditions) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int queryLogCount(String conditions) {
		// TODO Auto-generated method stub
		return 0;
	}
}
