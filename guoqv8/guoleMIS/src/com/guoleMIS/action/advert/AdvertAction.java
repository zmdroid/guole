package com.guoleMIS.action.advert;

import java.io.File;
import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.advert.AdvertService;
import com.guoleMIS.service.info.InformationService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.AdvertVO;
import com.guoleMIS.vo.InformationVO;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.MemberInfoVO;
import com.opensymphony.xwork2.ActionSupport;

public class AdvertAction  extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 7332666825441809737L;
	private static final Logger logger = Logger.getLogger(AdvertAction.class);
	
	private Map<String,Object> session;
	
	private AdvertService advertService;
	
	private AdvertVO advertVO;
	private Integer pageIndex;
	private String result;
	private Integer advertId;
	private Integer state;
	
	public void saveUpdateAdvert(){
		try {
			boolean rs = advertService.saveUpdateAdvert(advertVO);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("保存或更新广告信息出错", e);
			ResponseUtil.sendResult("error");
		}
	}
	
	public void getAdverts(){
		try {
			Object[] rs = advertService.getAdvertList(pageIndex,state);
			result = JSONArray.fromObject(rs).toString();
			ResponseUtil.sendResult(result);
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("获取广告列表信息出错", e);
		}
	}

	public void deleteAdvert(){
		try {
			boolean rs = advertService.deleteAdvertById(advertId);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("删除广告信息出错", e);
			ResponseUtil.sendResult("error");
		}
	}
	
	public void getAdvertById(){
		advertVO = advertService.getAdvertById(advertId);
		result = JSONArray.fromObject(new Object[]{advertVO}).toString();
		ResponseUtil.sendResult(result);
	}
	
	public void modifyAdvertState(){
		boolean rs = advertService.modifyAdvertById(advertId, state);
		if(rs){
			ResponseUtil.sendResult("success");
		}else{
			ResponseUtil.sendResult("error");
		}
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session=session;
	}



	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public AdvertService getAdvertService() {
		return advertService;
	}

	public void setAdvertService(AdvertService advertService) {
		this.advertService = advertService;
	}

	public AdvertVO getAdvertVO() {
		return advertVO;
	}

	public void setAdvertVO(AdvertVO advertVO) {
		this.advertVO = advertVO;
	}

	public Integer getAdvertId() {
		return advertId;
	}

	public void setAdvertId(Integer advertId) {
		this.advertId = advertId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}
