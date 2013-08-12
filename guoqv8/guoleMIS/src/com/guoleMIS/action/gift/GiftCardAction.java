package com.guoleMIS.action.gift;

import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.gift.GiftCardService;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.GiftCardTypeVO;
import com.guoleMIS.vo.GiftCardVO;
import com.opensymphony.xwork2.ActionSupport;

public class GiftCardAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = -2436423584203199716L;
	private static final Logger logger = Logger.getLogger(GiftCardAction.class);
	
	
	private Map<String,Object> session;
	private GiftCardService giftCardService;
	
	private GiftCardTypeVO giftCardTypeVO;
	private GiftCardVO giftCardVO;
	
	private int pageIndex;
	private String result;
	
	private Integer giftTypeId;
	private Integer giftId;
	private Integer state;
	
	public void addUpdateGiftCardType(){
		result="error";
		try {
			boolean rs = giftCardService.addUpdateGiftCardType(giftCardTypeVO);
			if(rs)result="success";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("添加礼品卡分类出错", e);
			result="error";
		}
		ResponseUtil.sendResult(result);
	}
	
	public void getGiftCardTypes(){
		result=Consts.NULL_LIST;
		try {
			Object[] obj = giftCardService.getGiftCardTypes(pageIndex);
			result = JSONArray.fromObject(obj).toString();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("获取礼品卡类型列表出错", e);
		}
		ResponseUtil.sendResult(result);
	}
	
	public void  delGiftCardTypeById(){
		boolean rs = giftCardService.delGiftCardTypeById(giftTypeId);
		if(rs)ResponseUtil.sendResult("success");
		ResponseUtil.sendResult("error");
	}
	
	public void modifyGifyCardTypeById(){
		boolean rs = giftCardService.modifyGiftCardTypeStateById(state, giftTypeId);
	
		if(rs)ResponseUtil.sendResult("success");
		ResponseUtil.sendResult("error");
	}
	
	public void getGiftCardTypeById(){
		System.out.println(giftTypeId);
		giftCardTypeVO = giftCardService.getGiftCardTypeById(giftTypeId);
		result = JSONArray.fromObject(new Object[]{giftCardTypeVO}).toString();
		ResponseUtil.sendResult(result);
	}
	
	
	public void addUpdateGiftCard(){
		result="error";
		try {
			giftCardVO.setCreateTime(new Date());
			boolean rs = giftCardService.addUpdateGiftCard(giftCardVO);
			if(rs)result="success";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("添加礼品卡出错", e);
			result="error";
		}
		ResponseUtil.sendResult(result);
	}
	
	public void getGiftCards(){
		result=Consts.NULL_LIST;
		try {
			Object[] obj = giftCardService.getGiftCards(pageIndex);
			result = JSONArray.fromObject(obj).toString();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("获取礼品卡列表出错", e);
		}
		ResponseUtil.sendResult(result);
	}
	
	public void  delGiftCardById(){
		boolean rs = giftCardService.delGiftCardById(giftId);
		if(rs)ResponseUtil.sendResult("success");
		ResponseUtil.sendResult("error");
	}
	
	public void modifyGifyCardById(){
		boolean rs = giftCardService.modifyGiftCardStateById(state, giftId);
		
		if(rs)ResponseUtil.sendResult("success");
		ResponseUtil.sendResult("error");
	}
	
	public void getGiftCardById(){
		System.out.println(giftTypeId);
		giftCardVO = giftCardService.getGiftCardById(giftId);
		result = JSONArray.fromObject(new Object[]{giftCardVO}).toString();
		ResponseUtil.sendResult(result);
	}
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session= session;
	}

	public GiftCardService getGiftCardService() {
		return giftCardService;
	}

	public void setGiftCardService(GiftCardService giftCardService) {
		this.giftCardService = giftCardService;
	}


	public GiftCardTypeVO getGiftCardTypeVO() {
		return giftCardTypeVO;
	}
	public void setGiftCardTypeVO(GiftCardTypeVO giftCardTypeVO) {
		this.giftCardTypeVO = giftCardTypeVO;
	}

	public Integer getGiftTypeId() {
		return giftTypeId;
	}

	public void setGiftTypeId(Integer giftTypeId) {
		this.giftTypeId = giftTypeId;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public GiftCardVO getGiftCardVO() {
		return giftCardVO;
	}

	public void setGiftCardVO(GiftCardVO giftCardVO) {
		this.giftCardVO = giftCardVO;
	}

	public Integer getGiftId() {
		return giftId;
	}

	public void setGiftId(Integer giftId) {
		this.giftId = giftId;
	}
}
