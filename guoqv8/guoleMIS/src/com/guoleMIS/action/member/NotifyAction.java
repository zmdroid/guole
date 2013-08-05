package com.guoleMIS.action.member;

import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.member.NotifyService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.NotifyVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 消息管理Action
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-06
 * @history  版本	修改者	   时间	修改内容
 */
public class NotifyAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1415146777060554880L;

	private final static Logger logger = Logger.getLogger(NotifyAction.class);
	
	public NotifyService notifyService;
	
	public NotifyVO notifyVO;
	
	public int page;

	public String content;
	
	public String receivers;
	
	private String result;
	
	private Map<String, Object> session;
	
	private final static Config config = Config.getInstance();
	
	/**
	 *获取消息列表
	 */
	public void loadNotifys(){
		result = "";
		try{
			List<NotifyVO> notifys = notifyService.loadNotifys(notifyVO, page);
			int totalCount = notifyService.getNotifyInfosCount(notifyVO);
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(notifys != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			result = "{\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(notifys);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取消息列表出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *发送消息信息
	 */
	public void publishNotify(){
		try{
			 ManagerVO user = (ManagerVO) session.get(Consts.CURRENT_USER_INFO);
			 result = (notifyService.publishNotify(receivers, NotifyVO.NOTIFY_TYPE_1, user.getId(), content) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("发送消息信出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	
	public void setSession(Map session) {
		this.session = session;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReceivers() {
		return receivers;
	}

	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}
    
	public NotifyService getNotifyService() {
		return notifyService;
	}

	public void setNotifyService(NotifyService notifyService) {
		this.notifyService = notifyService;
	}
	
	public NotifyVO getNotifyVO() {
		return notifyVO;
	}

	public void setNotifyVO(NotifyVO notifyVO) {
		this.notifyVO = notifyVO;
	}
}
