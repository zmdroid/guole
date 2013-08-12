package com.guoleMIS.dao.finance;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.RechargeVO;

public interface RechargeDao {
	/**
	 * 根据查询条件查询充值单列表
	 * @param map
	 * @return
	 */
	public List<RechargeVO> queryRechargeList(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 根据查询条件查询充值单列表大小
	 * @param sqlChip
	 * @return
	 */
	public int queryRechargeListCount(String sqlChip) throws Exception;
	
	/**
	 * 根据id查询充值单
	 * @param orderNo
	 * @return
	 */
	RechargeVO queryRechargeById(int orderNo) throws Exception;
	
	/**
	 * 更新充值单
	 * @param orderNo
	 * @param state
	 * @param keepaccount
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int updateRecharge(RechargeVO recharge) throws Exception;
	
	/**
	 * 记账
	 * @return
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public boolean updateRechargeKeepaccount(int orderNo) throws Exception;
}
