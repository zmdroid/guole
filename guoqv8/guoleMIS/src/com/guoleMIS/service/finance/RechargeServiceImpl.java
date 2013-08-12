package com.guoleMIS.service.finance;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import com.guoleMIS.consts.Consts;
import com.guoleMIS.dao.finance.BillDao;
import com.guoleMIS.dao.finance.RechargeDao;
import com.guoleMIS.dao.finance.RechargeLogDao;
import com.guoleMIS.dao.member.MemberInfoDao;
//import com.guoleMIS.dao.order.OrderDao;
import com.guoleMIS.service.finance.RechargeService;
import com.guoleMIS.vo.BillLogVO;
import com.guoleMIS.vo.BillVO;
import com.guoleMIS.vo.RechargeVO;

public class RechargeServiceImpl implements RechargeService{
	//日志接口
	private final static Logger logger = Logger.getLogger(RechargeServiceImpl.class);

	private RechargeDao rechargeDao;
	
	private MemberInfoDao memberInfoDao;
	
	private BillDao billDao;
	
	private RechargeLogDao rechargeLogDao;

	/**
	 * 获取充值单列表
	 * @param map
	 * @return
	 */
	@Override
	public List<RechargeVO> getRechargeList(String sqlChip, int start, int limit) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sqlChip", sqlChip);
		map.put("start", start);
		map.put("limit", limit);
		
		return rechargeDao.queryRechargeList(map);
	}
	
	/**
	 * 获取充值单列表大小
	 * @param sqlChip
	 * @return
	 */
	@Override
	public int getRechargeListCount(String sqlChip) throws Exception {
		return rechargeDao.queryRechargeListCount(sqlChip);
	}
	
	/**
	 * 更新充值单状态
	 * @param orderNo
	 * @param state
	 */
	@Override
	public boolean changeRechargeState(int rechargeId,int state) throws Exception {
		//查询RechargeVO
		RechargeVO vo = rechargeDao.queryRechargeById(rechargeId);

		if (vo == null) {
			return false;
		}
		
		//更新recharge
		vo.setState(state);
		boolean rs = rechargeDao.updateRecharge(vo)>0;
		if(!rs)throw new Exception();
		
		if(state == Consts.RECHARGEVO_STATE_SUCCESS){
				double balance = memberInfoDao.queUserBalance(vo.getUserId());
				//插入流水
				BillVO bill = new BillVO();
				bill.setCurrtime(new Date()); 
				bill.setTradetype(Consts.BILL_TRADETYPE_RECHARGE);
				bill.setTradechannel(vo.getType());
				bill.setMoney(vo.getMoneynum());
				bill.setUserId(vo.getUserId());
				bill.setType(Consts.BILL_TYPE_INCOME);
				bill.setTradeId(rechargeId);
				bill.setBalance(vo.getMoneynum() + balance);
				rs = billDao.insertBill(bill)>0;
				if(!rs)throw new Exception();
				
				//更新账户余额
				HashMap<String,Object> param = new HashMap<String, Object>();
				param.put("userId", vo.getUserId());
				param.put("balance", balance + vo.getMoneynum());
				rs = memberInfoDao.modifyUserBalance(param)>0;
				if(!rs)throw new Exception();
		}
		
		//插入日志
		BillLogVO log = new BillLogVO();
		log.setMoneynum(vo.getMoneynum());
		log.setOp(state + "");
		log.setOperId(vo.getUserId());
		log.setOptime(new Date());
		log.setOptype(Consts.PLATFORM_OPERATOR);
		log.setOrderNo(rechargeId);
		rs = rechargeLogDao.insertLog(log)>0;
		if(!rs)throw new Exception();
		return true;
	}
	
	/**
	 * 查询充值单信息
	 * @param orderNo
	 * @return
	 * @throws Exception
	 */
	@Override
	public RechargeVO getRechargeInfoByNo(int orderNo) throws Exception {
		return rechargeDao.queryRechargeById(orderNo);
	}
	
	
	public RechargeDao getRechargeDao() {
		return rechargeDao;
	}

	public void setRechargeDao(RechargeDao rechargeDao) {
		this.rechargeDao = rechargeDao;
	}
	
	public BillDao getBillDao() {
		return billDao;
	}

	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}
	
	public RechargeLogDao getRechargeLogDao() {
		return rechargeLogDao;
	}

	public void setRechargeLogDao(RechargeLogDao rechargeLogDao) {
		this.rechargeLogDao = rechargeLogDao;
	}

	public MemberInfoDao getMemberInfoDao() {
		return memberInfoDao;
	}

	public void setMemberInfoDao(MemberInfoDao memberInfoDao) {
		this.memberInfoDao = memberInfoDao;
	}
	
}
