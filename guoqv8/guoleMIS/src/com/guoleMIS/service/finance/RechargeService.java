package com.guoleMIS.service.finance;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.RechargeVO;

public interface RechargeService {
	/**
	 * 获取充值单列表
	 * @param map
	 * @return
	 */
	public List<RechargeVO> getRechargeList(String sqlChip, int start, int limit) throws Exception;
	
	/**
	 * 获取充值单列表大小
	 * @param sqlChip
	 * @return
	 */
	public int getRechargeListCount(String sqlChip) throws Exception;
	
	/**
	 * 更新充值单状态
	 * @param orderNo
	 * @param state
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean changeRechargeState(int rechargeId,int state) throws Exception;
	
	/**
	 * 查询充值单信息
	 * @param orderNo
	 * @return
	 * @throws Exception
	 */
	public RechargeVO getRechargeInfoByNo(int orderNo) throws Exception;
	
}
