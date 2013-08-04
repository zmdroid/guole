package com.guole.action.vip;

import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guole.action.user.UserInfoAction;
import com.guole.service.vip.VIPCardService;
import com.guole.util.MD5Encrypt;
import com.guole.util.ResponseUtil;
import com.guole.vo.VIPCardVO;
import com.opensymphony.xwork2.ActionSupport;

public class VIPCardAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 8750607313554878866L;
	private final static Logger logger = Logger.getLogger(UserInfoAction.class);
	
	private VIPCardService vipCardService;
	
	private Map<String ,Object> session ;
	
	private String result;
	private int pageIndex;
	
	
	/**
	 * 
	 * 获取全部的会员卡种类
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-05
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void getAllVIPCards(){
		Object obj = vipCardService.getVIPCards(pageIndex);
		result = JSONArray.fromObject(obj).toString();
		ResponseUtil.sendResult(result);
	}
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = this.session;
	}

	public VIPCardService getVipCardService() {
		return vipCardService;
	}


	public void setVipCardService(VIPCardService vipCardService) {
		this.vipCardService = vipCardService;
	}


	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
}
