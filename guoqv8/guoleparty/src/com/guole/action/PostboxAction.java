package com.guole.action;

import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.struts2.interceptor.SessionAware;

import com.guole.consts.Consts;
import com.guole.service.postbox.PostboxService;
import com.guole.util.ResponseUtil;
import com.guole.vo.UserInfoVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 消息管理
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class PostboxAction extends ActionSupport implements SessionAware{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3259090528804103039L;
	private PostboxService postboxService;//消息服务
	
	private Map<String,Object> session;
	
	
	private int pageIndex=1;
	private int messageNo;
	
	/**
	 * 查询个人消息
	 */
	public void getMessage(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		Object[] rs = postboxService.getMessageList(user.getUserId(),pageIndex);
		ResponseUtil.sendResult(JSONArray.fromObject(rs).toString());
	}
	
	/**
	 * 删除指定信息
	 */
	public void deleteMessage(){
		Object o = session.get(Consts.CURRENT_USER_INFO);
		if(o==null){
			ResponseUtil.sendResult("error");
			return;
		}
		UserInfoVO user = (UserInfoVO) o;
		postboxService.delMessage(user.getUserId(), messageNo);
		ResponseUtil.sendResult("ok");
	}

	
	
	
	
	
	
	public PostboxService getPostboxService() {
		return postboxService;
	}

	public void setPostboxService(PostboxService postboxService) {
		this.postboxService = postboxService;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	public int getMessageNo() {
		return messageNo;
	}

	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}
	
}
