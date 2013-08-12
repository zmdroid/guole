package com.guole.action.linkaddr;

import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.struts2.interceptor.SessionAware;

import com.guole.consts.Consts;
import com.guole.service.linkaddr.LinkAddrService;
import com.guole.util.ResponseUtil;
import com.guole.vo.LinkAddrVO;
import com.guole.vo.UserInfoVO;
import com.opensymphony.xwork2.ActionSupport;

public class LinkAddrAction extends ActionSupport implements SessionAware  {

	private static final long serialVersionUID = -3951281717173301895L;

	private Map<String,Object> session;
	private LinkAddrService linkAddrService;
	
	
	private LinkAddrVO linkAddrVO;
	private Integer pageIndex;
	private String result;
	
	
	/**
	 * 
	 * 跳转到个人中心-送货地址页
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public String forwordLinkAddrPage(){
		UserInfoVO userInfo = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		if(null==userInfo)return "login";
		return SUCCESS;
	}

	/**
	 * 
	 * 根据用户获取该用户的所有关联送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void getAllLinkAddrByUserId(){
		UserInfoVO userInfo = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		if(null==userInfo){
			result ="login";
			ResponseUtil.sendResult(result);
			return;
		}
		Object[] obj = linkAddrService.getLinkAddrByUserId(userInfo.getUserId(), pageIndex);
		result = JSONArray.fromObject(obj).toString();
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 
	 * 添加或者修改送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-5-22
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void addUpdateLinkAddr(){
		UserInfoVO userInfo = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		if(null==userInfo){
			result ="login";
			ResponseUtil.sendResult(result);
			return;
		}
		linkAddrVO.setUserId(userInfo.getUserId());
		boolean rs = linkAddrService.addUpdateLinkAddr(linkAddrVO);
		if(rs){
			ResponseUtil.sendResult("success");
		}else{
			ResponseUtil.sendResult("error");
		}
	}
	
	/**
	 * 
	 * 删除用户的关联送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void delLinkAddr(){
		UserInfoVO userInfo = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		if(null==userInfo){
			result ="login";
			ResponseUtil.sendResult(result);
			return;
		}
		linkAddrVO.setUserId(userInfo.getUserId());
		linkAddrService.deleteLinkAddr(linkAddrVO);
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

	public LinkAddrService getLinkAddrService() {
		return linkAddrService;
	}

	public void setLinkAddrService(LinkAddrService linkAddrService) {
		this.linkAddrService = linkAddrService;
	}

	public LinkAddrVO getLinkAddrVO() {
		return linkAddrVO;
	}

	public void setLinkAddrVO(LinkAddrVO linkAddrVO) {
		this.linkAddrVO = linkAddrVO;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

}
