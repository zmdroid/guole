package com.guole.action;

import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guole.consts.Consts;
import com.guole.service.bill.BillService;
import com.guole.service.gift.GiftCardService;
import com.guole.service.recharge.RechargeService;
import com.guole.service.user.UserInfoService;
import com.guole.util.MD5Encrypt;
import com.guole.util.ResponseUtil;
import com.guole.vo.GiftCardVO;
import com.guole.vo.RechargeVO;
import com.guole.vo.UserAccountVO;
import com.guole.vo.UserInfoVO;
import com.opensymphony.xwork2.ActionSupport;


/**
 * 账户管理
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class AccountManageAction extends ActionSupport implements SessionAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3259090528804103039L;
	
	private static final Logger logger = Logger.getLogger(AccountManageAction.class);
	private BillService billService;//账单服务
	private RechargeService rechargeService;//充值服务
	private UserInfoService userInfoService;//用户信息服务
	
	private RechargeVO rechargeVO;//充值单
	private GiftCardVO giftCardVO;//礼品卡
	
	private Map<String,Object> session;
	private String result;
	
	/**
	 * 查询充值单
	 */
	public void getRecharge(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		RechargeVO rs = rechargeService.getRecharge(user.getUserId(), rechargeVO.getRechargeId());
		ResponseUtil.sendResult(JSONObject.fromObject(rs).toString());
	}
	
	/**
	 * 读取有关金额的用户账户信息
	 */
	public void getAccountInfo(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		//验证提现密码
		UserAccountVO userAccountVO = userInfoService.qurUserAccountByUserId(user.getUserId());
		JSONObject rs = JSONObject.fromObject(userAccountVO);
		rs.element("paypassword", "");
		ResponseUtil.sendResult(rs.toString());
	}
	
	/**
	 * 充值
	 */
	public void recharge(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		rechargeVO.setOptime(new Date());
		rechargeVO.setOper(1);
		rechargeVO.setUserId(user.getUserId());
		String corName = user.getCorname();
		if(user.getUsertype()==1)corName="个人";
		rechargeVO.setCorName(corName);
		rechargeVO.setUserName(user.getName());
		rechargeVO.setState(Consts.WITHDRAWING_STATE_APPLY);
		ResponseUtil.sendResult(rechargeService.recharge(rechargeVO)+"");
	}
	
	/**
	 * 使用礼品卡充值
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-04
	 *		版本		修改者	时间		修改内容
	 */
	public void rechargeCard(){
		UserInfoVO user = (UserInfoVO)session.get(Consts.CURRENT_USER_INFO);
		if(user==null){
			ResponseUtil.sendResult("error");
			return;
		}
		boolean rs;
		try {
			rs = rechargeService.giftCardRecharge(user.getUserId(), giftCardVO);
			if(rs){
				result = "success";
			}else{
				result = "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("礼品卡充值失败", e);
			result = "error";
		}
		ResponseUtil.sendResult(result);
	}
	
	
	/**
	 * 查询充值记录
	 */
	public void getRechargeList(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		Object[] rs = rechargeService.getRechargeList(user.getUserId(),pageIndex, timeRange,types,state);
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}
	
	private int pageIndex=1;
	private String tradetypes;
	private String timeRange;
	private String moneyRange;
	private int tradeId;
	private String types;
	private char state;
	
	/**
	 * 查询账单明细
	 */
	public void getBills(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		Object[] rs = billService.getBillList(user.getUserId(),pageIndex, tradetypes, timeRange, moneyRange, tradeId, types);
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}

	
	
	
	//////////////////////测试接口
	public void testOpRecharge(){
		//rechargeService.changeRechargeState(rechargeVO.getOrderNo(), state);
	}
	
	public BillService getBillService() {
		return billService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}
	
	public GiftCardVO getGiftCardVO() {
		return giftCardVO;
	}

	public void setGiftCardVO(GiftCardVO giftCardVO) {
		this.giftCardVO = giftCardVO;
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getTradetypes() {
		return tradetypes;
	}

	public void setTradetypes(String tradetypes) {
		this.tradetypes = tradetypes;
	}

	public String getTimeRange() {
		return timeRange;
	}

	public void setTimeRange(String timeRange) {
		this.timeRange = timeRange;
	}

	public String getMoneyRange() {
		return moneyRange;
	}

	public void setMoneyRange(String moneyRange) {
		this.moneyRange = moneyRange;
	}

	public int getTradeId() {
		return tradeId;
	}

	public void setTradeId(int tradeId) {
		this.tradeId = tradeId;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public UserInfoService getUserInfoService() {
		return userInfoService;
	}

	public void setUserInfoService(UserInfoService userInfoService) {
		this.userInfoService = userInfoService;
	}

	public char getState() {
		return state;
	}

	public void setState(char state) {
		this.state = state;
	}

	public RechargeService getRechargeService() {
		return rechargeService;
	}

	public void setRechargeService(RechargeService rechargeService) {
		this.rechargeService = rechargeService;
	}

	public RechargeVO getRechargeVO() {
		return rechargeVO;
	}

	public void setRechargeVO(RechargeVO rechargeVO) {
		this.rechargeVO = rechargeVO;
	}
	
	
}
