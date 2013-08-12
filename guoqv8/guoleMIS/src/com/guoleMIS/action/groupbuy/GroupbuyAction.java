package com.guoleMIS.action.groupbuy;

import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.service.groupbuy.GroupbuyService;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.GroupbuyInfoVO;
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
	private Integer typeId;//类型编号
	private Integer onLine;//是否上线
	private String result;
	private Integer pageIndex;
	
	
	/**
	 * 新增或更新团购信息
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-07
	 *		版本		修改者	时间		修改内容
	 */
	public void saveUpdateGroupbuyInfo(){
		result="error";
		boolean rs = groupbuyService.saveUpdateGroupbuyInfo(groupbuyInfoVO);
		if(rs)result="success";
		ResponseUtil.sendResult(result);
	}
	
	
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
		Object obj = groupbuyService.getGroupbuyInfos(onLine,typeId,pageIndex);
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
	public void getGroupbuyById(){
		groupbuyInfoVO = groupbuyService.getGroupbuyInfo(recordNo);
		result = JSONObject.fromObject(groupbuyInfoVO).toString();
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 根据Id删除团购商品
	 */
	public void deleteGroupbuyInfo(){
		result = "error";
		boolean rs = groupbuyService.delGroupbuyInfoByRecordNo(recordNo);
		if(rs)result="success";
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 更改团购商品的状态
	 */
	public void modifyGroupbuyOnLine(){
		result="error";
		boolean rs = groupbuyService.modifyGroupbuyInfoOnLine(recordNo, onLine);
		if(rs)result="success";
		ResponseUtil.sendResult(result);
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

	public Integer getOnLine() {
		return onLine;
	}

	public void setOnLine(Integer onLine) {
		this.onLine = onLine;
	}

}
