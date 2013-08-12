package com.guoleMIS.action.order;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.finance.BillService;
import com.guoleMIS.service.finance.RechargeService;
import com.guoleMIS.service.finance.RefundService;
import com.guoleMIS.service.member.MemberInfoService;
import com.guoleMIS.service.order.OrderService;
//import com.guoleMIS.service.orderlog.OrderLogService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.BillVO;
import com.guoleMIS.vo.MemberAccountVO;
import com.guoleMIS.vo.MemberInfoVO;
//import com.guoleMIS.vo.OrderLogVO;
import com.guoleMIS.vo.OrderVO;
import com.guoleMIS.vo.RechargeQueryVO;
import com.guoleMIS.vo.RefundVO;

public class OrderAction extends ActionSupport implements SessionAware {

	
	private Map<String,Object> session;
	private OrderService orderService;
//	private OrderLogService orderLogService;
	private MemberInfoService memberInfoService;
//	private LineService lineService;
	private BillService billService;
	private MemberInfoVO UserInfoVO;
	
	

	//日志接口
	private final static Logger logger = Logger.getLogger(OrderAction.class);
	
	private final static Config config = Config.getInstance();
	
	String result = "";
	
	private int pageIndex=1;//页码
	private String timeRange;//时间段（2012-12-12,2012-12-21）

	private OrderVO orderVO;//订单VO
//	private List<OrderLogVO> orderLogVOs;//流水VO
	private List<BillVO> billVOs;//流水VO
	
	
	
	/**
	 * 订单编号
	 */
	private Integer orderNo;
	/**
	 * 买家编号
	 */
	private Integer userId;
	/**
	 * 订单状态
	 */
	private String state;
	
	/**
	 * 
	 * 根据条件获取订单列表
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-4
	 *		版本		修改者	时间		修改内容
	 *
	 */
	
	public void getOrderList(){
		Object[] rs = orderService.getOrderList(pageIndex, (orderNo==null)?0:orderNo, (userId==null)?0:userId, timeRange, state);
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}
	
	public String getOrderDetail(){
		
		orderVO = orderService.getOrderByOrderId(orderNo);
//		orderLogVOs = orderLogService.queryOrderLog(orderNo);
		UserInfoVO = memberInfoService.getMemberInfoByUserId(orderVO.getUserId());
		billVOs = billService.getBillListForTradeId(orderNo);
//		try {
//			lineVO = lineService.getLineInfoById(orderVO.getLineId());
//			lineVO.setFromplace(PlaceUtil.getCityNameCN(lineVO.getFromplace()));
//			lineVO.setToplace(PlaceUtil.getCityNameCN(lineVO.getToplace()));
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			logger.error("获取根据线路id获取线路信息出错"+orderVO.getLineId(), e);
//		}
		if(null!=orderVO){
			return SUCCESS;
		}else{
			return ERROR;
		}
	}
	
	
	public OrderService getOrderService() {
		return orderService;
	}
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
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
	public MemberInfoService getMemberInfoService() {
		return memberInfoService;
	}
	
	public void setMemberInfoService(MemberInfoService memberInfoService) {
		this.memberInfoService = memberInfoService;
	}
	
//	public OrderLogService getOrderLogService() {
//		return orderLogService;
//	}
//
//	public void setOrderLogService(OrderLogService orderLogService) {
//		this.orderLogService = orderLogService;
//	}

	public Integer getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

	public OrderVO getOrderVO() {
		return orderVO;
	}

	public void setOrderVO(OrderVO orderVO) {
		this.orderVO = orderVO;
	}


	public MemberInfoVO getUserInfoVO() {
		return UserInfoVO;
	}

	public void setUserInfoVO(MemberInfoVO userInfoVO) {
		UserInfoVO = userInfoVO;
	}

//	public List<OrderLogVO> getOrderLogVOs() {
//		return orderLogVOs;
//	}
//
//	public void setOrderLogVOs(List<OrderLogVO> orderLogVOs) {
//		this.orderLogVOs = orderLogVOs;
//	}

	public List<BillVO> getBillVOs() {
		return billVOs;
	}

	public void setBillVOs(List<BillVO> billVOs) {
		this.billVOs = billVOs;
	}

	public BillService getBillService() {
		return billService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}

}
