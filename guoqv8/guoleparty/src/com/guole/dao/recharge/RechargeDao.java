package com.guole.dao.recharge;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guole.vo.RechargeVO;

/**
 * 充值单Dao
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
 *		版本		修改者	时间		修改内容
 *
 */
public interface RechargeDao {
	/**
	 * 新建充值单
	 * @param recharge
	 * @return
	 */
	int insertRecharge(RechargeVO recharge);
	
	/**
	 * 更新充值单
	 * @param orderNo
	 * @param state
	 * @param keepaccount
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	void updateRecharge(RechargeVO recharge);
	
	/**
	 * 查询充值单
	 * @param conditions
	 * @return
	 */
	List<RechargeVO> queryRecharge(String conditions);
	
	/**
	 * 根据id查询充值单
	 * @param orderNo
	 * @return
	 */
	RechargeVO queryRechargeById(int orderNo);
	
	/**
	 * 查询充值单数量
	 * @param conditions
	 * @return
	 */
	int queryRechargeCount(String conditions);
}
