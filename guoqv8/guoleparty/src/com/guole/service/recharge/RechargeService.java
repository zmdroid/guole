package com.guole.service.recharge;


import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guole.vo.GiftCardVO;
import com.guole.vo.RechargeVO;

/**
 * 充值服务
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
 *		版本		修改者	时间		修改内容
 *
 */
public interface RechargeService{
	/**
	 * 创建一个充值单
	 * @return
	 */
	boolean recharge(RechargeVO vo);
	
	/**
	 * 查询指定条件的充值单列表
	 * @param conditions
	 * @return
	 */
	Object[] getRechargeList(int userId,int pageIndex, String timeRange, String types,char state);
	
	/**
	 * 返回充值单
	 * @param userId
	 * @param orderNo
	 * @return
	 */
	RechargeVO getRecharge(int userId,int orderNo);
	
	/**
	 * 礼品卡充值
	 * @param userId
	 * @param orderNo
	 * @return
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	boolean giftCardRecharge(int userId,GiftCardVO giftCardVO) throws Exception;
}
