package com.guole.service.recharge;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guole.consts.Consts;
import com.guole.dao.bill.BillDao;
import com.guole.dao.recharge.RechargeDao;
import com.guole.dao.user.UserInfoDao;
import com.guole.service.gift.GiftCardService;
import com.guole.util.MD5Encrypt;
import com.guole.vo.BillVO;
import com.guole.vo.GiftCardTypeVO;
import com.guole.vo.GiftCardVO;
import com.guole.vo.RechargeVO;


public class RechargeServiceImpl implements RechargeService {
	Logger logger = Logger.getLogger(RechargeServiceImpl.class);
	
	private GiftCardService giftCardService;//礼品卡服务
	
	private RechargeDao rechargeDao;
	private UserInfoDao userInfoDao;//用户信息持久层接口
	
	
	private BillDao billDao;//流水信息持久接口
	
	@Override
	public boolean recharge(RechargeVO vo) {
		rechargeDao.insertRecharge(vo);
		return true;
	}
	
	@Override
	public RechargeVO getRecharge(int userId, int orderNo) {
		return rechargeDao.queryRechargeById(orderNo);
	}
	

	@Override
	public Object[] getRechargeList(int userId,int pageIndex, String timeRange, String types,char state) {
		//拼装条件
		String where = "userId = "+userId+" and ";
		if(types!=null && types.length()>0){
			where += "type in ("+types+") and ";
		}
		if(timeRange!=null){
			String[] times = timeRange.split(",");
			where += "(optime >= '"+times[0]+"' and optime <= '"+times[1]+"') and ";
		}
		if(state!=0){
			where += "state="+state+" and ";
		}
		//查询分页
		int records = rechargeDao.queryRechargeCount(where);
		
		int pageSize = 20;
		int pageCount = records/pageSize;
		if(records%pageSize!=0)pageCount++;
		//查询当前页数据
		where += "1=1 order by optime desc limit "+(pageIndex-1)*pageSize+","+pageSize;
		List<RechargeVO> recharge = rechargeDao.queryRecharge(where);
		return new Object[]{pageCount,recharge};
	}
	

	// 获取账户余额
	private double getUserBalance(int userId) throws Exception {
			return userInfoDao.queUserBalance(userId);
	}
	
	// 更改账户余额
	private boolean modifyUserBalance(int userId,double balan) throws Exception{
		boolean rs = false;
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			map.put("balance", balan);
			rs = userInfoDao.modifyUserBalance(map);
		return rs;
	}
	
	// 插入流水
	private boolean insertBill(BillVO billVO) {
		boolean rs = false;
		rs = billDao.insertBill(billVO);
		return rs;
	}
	
	/**
	 * 礼品卡充值
	 */
	@Override
	public boolean giftCardRecharge(int userId,GiftCardVO giftCardVO) throws Exception {
		// TODO Auto-generated method stub
		//验证礼品卡真伪
		giftCardVO.setPwd(MD5Encrypt.getInstance().encrypt(giftCardVO.getPwd()));
		giftCardVO.setState(1);
		giftCardVO = giftCardService.getGiftCardInfo(giftCardVO);
		if(null==giftCardVO){
			throw new Exception();
		}
		
		//获取礼品卡类型
		GiftCardTypeVO cardType = giftCardService.getGiftCardTypeByTypeId(giftCardVO.getId());
		if(null==cardType||cardType.getState()==2){
			throw new Exception();
		}
		
		//修改礼品卡状态和使用时间
		giftCardVO.setState(2);
		giftCardVO.setUseTime(new Date());
		boolean rs = giftCardService.modifyGiftCardState(giftCardVO);
		if(!rs){
			throw new Exception();
		}
		//修改用户虚拟账户余额
		double balance = getUserBalance(userId);
		double blan = balance + cardType.getMoney();
		rs = modifyUserBalance(userId,blan);
		if(!rs){
			throw new Exception();
		}
		BillVO billVO = new BillVO();
		billVO.setCurrtime(new Date());
		billVO.setTradetype(Consts.BILL_TRADETYPE_RECHARGE);//交易类型 为充值
		billVO.setTradechannel(Consts.RECHARGE_TYPE_GIFTCARD);//交易方式 为礼品卡
		billVO.setTradeId(cardType.getId());//业务id 为充值卡类型ID
		billVO.setMoney(cardType.getMoney());
		billVO.setType(Consts.BILL_TYPE_INCOME);//流水类型 为收入
		billVO.setUserId(userId);
		billVO.setBalance(blan);
		rs = insertBill(billVO);
		if(!rs){
			throw new Exception();
		}
		return rs;
	}

	public RechargeDao getRechargeDao() {
		return rechargeDao;
	}

	public void setRechargeDao(RechargeDao rechargeDao) {
		this.rechargeDao = rechargeDao;
	}

	public GiftCardService getGiftCardService() {
		return giftCardService;
	}

	public void setGiftCardService(GiftCardService giftCardService) {
		this.giftCardService = giftCardService;
	}

	public UserInfoDao getUserInfoDao() {
		return userInfoDao;
	}

	public void setUserInfoDao(UserInfoDao userInfoDao) {
		this.userInfoDao = userInfoDao;
	}

	public BillDao getBillDao() {
		return billDao;
	}

	public void setBillDao(BillDao billDao) {
		this.billDao = billDao;
	}
	
}
