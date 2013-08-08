package com.guoleMIS.dao.finance;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.dao.finance.RechargeDao;
import com.guoleMIS.vo.RechargeVO;

public class RechargeDaoImpl extends BaseDaoImpl implements RechargeDao{

	/**
	 * 根据查询条件查询充值单列表
	 */
	@Override
	public List<RechargeVO> queryRechargeList(HashMap<String, Object> map) throws Exception{
		return sqlSessionTemplate.selectList("queryRechargeList");
	}

	/**
	 * 根据查询条件查询充值单列表大小
	 */
	@Override
	public int queryRechargeListCount(String sqlChip) throws Exception {
		return sqlSessionTemplate.selectOne("queryRechargeListCount");
	}
	
	/**
	 * 根据id查询充值单
	 * @param orderNo
	 * @return
	 */
	@Override
	public RechargeVO queryRechargeById(int orderNo) throws Exception {
		return sqlSessionTemplate.selectOne("queryRechargeById");
	}
	
	/**
	 * 更新充值单
	 * @param orderNo
	 * @param state
	 * @param keepaccount
	 */
	@Override
	public boolean updateRecharge(RechargeVO recharge) throws Exception {
		return sqlSessionTemplate.update("updateRecharge") > 0;
	}
	
	/**
	 * 记账
	 * @return
	 * @throws Exception
	 */
	@Override
	public boolean updateRechargeKeepaccount(int orderNo) throws Exception {
		return sqlSessionTemplate.update("updateRechargeKeepaccount") > 0;
	}
}
