package com.guole.dao.recharge;

import java.util.List;

import com.guole.dao.base.BaseDaoImpl;
import com.guole.vo.RechargeVO;


public class RechargeDaoImpl extends BaseDaoImpl implements RechargeDao {

	@Override
	public int insertRecharge(RechargeVO recharge) {
		return this.sqlSessionTemplate.insert("insertRecharge", recharge);
	}

	@Override
	public List<RechargeVO> queryRecharge(String conditions) {
		return this.sqlSessionTemplate.selectList("queryRecharge",conditions);
	}
	
	@Override
	public int queryRechargeCount(String conditions) {
		return this.sqlSessionTemplate.selectOne("queryRechargeCount",conditions);
	}
	
	@Override
	public RechargeVO queryRechargeById(int orderNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void updateRecharge(RechargeVO recharge) {
		// TODO Auto-generated method stub
		
	}

}
