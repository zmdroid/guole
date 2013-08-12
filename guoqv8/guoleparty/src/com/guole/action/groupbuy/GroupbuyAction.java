package com.guole.action.groupbuy;

import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guole.action.user.UserInfoAction;
import com.guole.service.groupbuy.GroupbuyService;
import com.guole.service.user.UserInfoService;
import com.guole.service.vip.VIPCardService;
import com.guole.util.MD5Encrypt;
import com.guole.util.ResponseUtil;
import com.guole.vo.GroupbuyInfoVO;
import com.guole.vo.VIPCardVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 团购商品
 * @author 005
 *
 */
public class GroupbuyAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 8750607313554878866L;
	private final static Logger logger = Logger.getLogger(GroupbuyAction.class);
	
	private GroupbuyService groupbuyService;
	private GroupbuyInfoVO groupbuyInfoVO;
	
	private Map<String ,Object> session ;
	
	private Integer recordNo;//团购商品编号
	private Integer typeId;
	private String result;
	private Integer pageIndex;
	
	
	/**
	 * 
	 * 获取全部的会员卡种类
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-05
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void getGroupbuys(){
		Object obj = groupbuyService.getGroupbuyInfos(typeId,pageIndex);
		result = JSONArray.fromObject(obj).toString();
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 更具团购商品的编号获取该团购的详细信息
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-05
	 *		版本		修改者	时间		修改内容
	 */
	public String getGroupbuyById(){
		groupbuyInfoVO = groupbuyService.getGroupbuyInfo(recordNo);
		if(null==groupbuyInfoVO)return ERROR;
		return SUCCESS;
	}
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = this.session;
	}

	public GroupbuyService getGroupbuyService() {
		return groupbuyService;
	}

	public void setGroupbuyService(GroupbuyService groupbuyService) {
		this.groupbuyService = groupbuyService;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public GroupbuyInfoVO getGroupbuyInfoVO() {
		return groupbuyInfoVO;
	}

	public void setGroupbuyInfoVO(GroupbuyInfoVO groupbuyInfoVO) {
		this.groupbuyInfoVO = groupbuyInfoVO;
	}

	public Integer getRecordNo() {
		return recordNo;
	}

	public void setRecordNo(Integer recordNo) {
		this.recordNo = recordNo;
	}

}
