package com.guoleMIS.action.finance;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;
import com.opensymphony.xwork2.ActionSupport;
import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.finance.BillService;
import com.guoleMIS.service.finance.PlatFormAccountService;
import com.guoleMIS.service.finance.RechargeService;
import com.guoleMIS.service.finance.RefundService;
import com.guoleMIS.service.member.MemberInfoService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.BillVO;
import com.guoleMIS.vo.MemberAccountVO;
import com.guoleMIS.vo.MemberInfoVO;
import com.guoleMIS.vo.RechargeQueryVO;
import com.guoleMIS.vo.RechargeVO;
import com.guoleMIS.vo.RefundVO;

public class FinanceAction extends ActionSupport implements SessionAware {

	private Map<String,Object> session;
	private RefundService refundService;
	private PlatFormAccountService platFormAccountService;
	
	
	private static final long serialVersionUID = 1415146777060554880L;

	//日志接口
	private final static Logger logger = Logger.getLogger(FinanceAction.class);
	
	private final static Config config = Config.getInstance();
	
	String result = "";
	
	private RechargeService rechargeService;

	private RechargeQueryVO rechargeQuery;
	
	private int start;

	private int limit;

	public FinanceAction() {
		rechargeQuery = new RechargeQueryVO();
	}
	
	private int pageIndex=1;//页码
	private String timeRange;//时间段（2012-12-12,2012-12-21）
	private Integer type;//流水类型
	private Integer tradeId;//订单Id
	
	private BillVO billVO;//流水VO
	private RefundVO refundVO;//返款VO
	
	private MemberInfoService memberInfoService;
	
	/**
	 * 个人用户信息VO
	 */
	//private MemberInfoVO humanInfoVO;
	/**
	 * 企业用户信息VO
	 */
	//private MemberInfoVO companyInfoVO;
	
	/**
	 * 充值单号
	 */
	private Integer rechargeId;

	private BillService billService;
	
	private String startDate;
	
	private String endDate;
	
	private int userId;
	
	private int tradeType;
	
	/**
	 * 查询账单明细
	 */
	public void getBills(){
		if(tradeId == null)tradeId=0;
		List<BillVO> rs = billService.getDetailList(startDate,endDate,pageIndex,tradeType,userId,tradeId);
		int totalCount = billService.queryBillPageCount(startDate,endDate,tradeType,userId,tradeId);
		int pageLength = 1;
		int limit = Integer.parseInt(config.getString("page.size"));
		if(rs != null){
			if(totalCount % limit == 0){
				pageLength = totalCount / limit;
			}else{
				pageLength = totalCount / limit + 1;
			}
		}
		result = "{\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
		JSONArray jArray = new JSONArray();
		jArray.addAll(rs);
		result += ",\"items\":"+jArray.toString()+"}";
		ResponseUtil.sendResult(result);
	}

	
	private Integer refundId;//退款单号
	private Integer reason;//退款原因
	/**
	 * 查询返款记录
	 */
	public void getRefund(){
//		Object o = session.get(Consts.CURRENT_USER_INFO);
//		if(o==null){
//			ResponseUtil.sendResult("error");
//			return;
//		}
//		UserInfoVO user = (UserInfoVO) o;
		Object[] rs = refundService.getRefundList(pageIndex, (refundId==null)?0:refundId, timeRange, (tradeId==null)?0:tradeId, (reason==null)?0:reason);
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}
	
	/**
	 * 根据id查询该返款对应的详细信息>>>>返款单，订单信息，用户信息，流水信息等等
	 */
	public String getRefundDetail(){
		
		refundVO = refundService.getRefundDetail(refundId);
//		orderVO = orderService.getOrderByOrderId(refundVO.getOrderNo());
		billVO = billService.getBillDetail(refundVO.getOrderNo(),Consts.BILL_TRADETYPE_REFUND,Consts.BILL_TYPE_PAY);
		//buyerInfoVO = memberInfoService.getMemberInfoByUserId(orderVO.getBuyer());
		//sellerInfoVO = memberInfoService.getMemberInfoByUserId(orderVO.getSeller());
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//logger.error("根据线路Id获取线路出错"+orderVO.getLineId(), e);
		}
		if(null!=refundVO){
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	/**
	 * 查询充值单列表
	 */
	public void getRechargeList() {
		String sqlChip = rechargeQuery.getQuery();
		if (null == sqlChip) {
			ResponseUtil.sendResult(ERROR);
			return;
		}

		JSONObject json = new JSONObject();
		try {
			limit = Integer.parseInt(config.getString("recharge.list.page.size"));

			json.put("totalCount", rechargeService.getRechargeListCount(sqlChip));
			json.put("rechargeList", rechargeService.getRechargeList(sqlChip, start, limit));
			result = json.toString();
		} catch (Exception e) {
			logger.error("查询充值单列表出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 出纳通过充值单
	 */
	public void cnApproveRecharge() {
		boolean bl = false;
		try {
			bl = rechargeService.changeRechargeState(rechargeId, Consts.RECHARGEVO_STATE_SUCCESS);
			result =  bl ? SUCCESS : ERROR;
		} catch (Exception e) {
			logger.error("通过充值单出错，单号：" + rechargeId, e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 出纳拒绝充值单
	 */
	public void cnRefuseRecharge() {
		boolean bl = false;
		try {
			bl = rechargeService.changeRechargeState(rechargeId, Consts.RECHARGEVO_STATE_FAILS);
			result =  bl ? SUCCESS : ERROR;
		} catch (Exception e) {
			logger.error("拒绝充值单出错，单号：" + rechargeId, e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	
	
	/**
	 * 查看充值单流水
	 */
	public String lookRechargeBill() {
		try {
			billVO = billService.getBillInfo(tradeId, Consts.BILL_TRADETYPE_RECHARGE);
		} catch (Exception e) {
			logger.error("查看充值单流水出错，单号：" + tradeId, e);
			return ERROR;
		}

		return SUCCESS;
	}
	
	
	/**
	 * 
	 * 平台账务
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-6
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void platformAccount(){
		String total = platFormAccountService.getPlatFormTotal();
		String platformmoney = platFormAccountService.getPlatFormMoney();
		String usermoney = platFormAccountService.getUserAccountMoney();
		List<BillVO> bills = platFormAccountService.getPlantFormBill(pageIndex,timeRange,type);
		int pageCount = platFormAccountService.getPlantFormBillCountPage(timeRange,type);
		Object[] object = new Object[]{total,platformmoney,usermoney,bills,pageCount};
		ResponseUtil.sendResult(JSONArray.fromObject(object).toString());
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public RefundService getRefundService() {
		return refundService;
	}

	public void setRefundService(RefundService refundService) {
		this.refundService = refundService;
	}
	
	public BillVO getBillVO() {
		return billVO;
	}
	public void setBillVO(BillVO billVO) {
		this.billVO = billVO;
	}
	public RefundVO getRefundVO() {
		return refundVO;
	}
	public void setRefundVO(RefundVO refundVO) {
		this.refundVO = refundVO;
	}
	public MemberInfoService getMemberInfoService() {
		return memberInfoService;
	}
	public void setMemberInfoService(MemberInfoService memberInfoService) {
		this.memberInfoService = memberInfoService;
	}

	public PlatFormAccountService getPlatFormAccountService() {
		return platFormAccountService;
	}
	public void setPlatFormAccountService(
			PlatFormAccountService platFormAccountService) {
		this.platFormAccountService = platFormAccountService;
	}
	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}


	public String getTimeRange() {
		return timeRange;
	}


	public void setTimeRange(String timeRange) {
		this.timeRange = timeRange;
	}


	public Integer getTradeId() {
		return tradeId;
	}

	public void setTradeId(Integer tradeId) {
		this.tradeId = tradeId;
	}

	public Integer getRefundId() {
		return refundId;
	}


	public void setRefundId(Integer refundId) {
		this.refundId = refundId;
	}


	public Integer getReason() {
		return reason;
	}


	public void setReason(Integer reason) {
		this.reason = reason;
	}
	
	public RechargeService getRechargeService() {
		return rechargeService;
	}

	public void setRechargeService(RechargeService rechargeService) {
		this.rechargeService = rechargeService;
	}

	public RechargeQueryVO getRechargeQuery() {
		return rechargeQuery;
	}

	public void setRechargeQuery(RechargeQueryVO rechargeQuery) {
		this.rechargeQuery = rechargeQuery;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}
	
	
	
	public Integer getRechargeId() {
		return rechargeId;
	}

	public void setRechargeId(Integer rechargeId) {
		this.rechargeId = rechargeId;
	}

	public BillService getBillService() {
		return billService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}

	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getTradeType() {
		return tradeType;
	}

	public void setTradeType(int tradeType) {
		this.tradeType = tradeType;
	}
}
