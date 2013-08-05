package com.guoleMIS.action.info;

import java.io.File;
import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.info.InformationService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.InformationVO;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.MemberInfoVO;
import com.opensymphony.xwork2.ActionSupport;

public class InformationAction  extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 7332666825441809737L;
	private static final Logger logger = Logger.getLogger(InformationAction.class);
	
	private Map<String,Object> session;
	
	private InformationService informationService;
	
	private InformationVO informationVO;
	private Integer pageIndex;
	private String result;
	private Integer infoNo;
	private Integer state;
	private Integer type;
	
	public void saveUpdateInfo(){
		ManagerVO user = (ManagerVO)session.get(Consts.CURRENT_USER_INFO);
		if(null==user){
			ResponseUtil.sendResult("error");
			return;
		}
		try {
			informationVO.setPublishTime(new Date());
			informationVO.setUserId(user.getId());
			informationVO.setState(0);
			boolean rs = informationService.saveUpdateInfo(informationVO);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("保存或更新资讯信息出错", e);
		}
	}
	
	public void getInformations(){
		try {
			Object[] rs = informationService.getInformationList(pageIndex,type);
			result = JSONArray.fromObject(rs).toString();
			ResponseUtil.sendResult(result);
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("获取资讯列表信息出错", e);
		}
	}
	/**
	 * 
	 * 根据Id删除资讯
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-6-26
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void deleteInformation(){
		try {
			boolean rs = informationService.deleteInformationById(infoNo);
			if(rs){
				ResponseUtil.sendResult("success");
			}else{
				ResponseUtil.sendResult("error");
			}
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("删除资讯信息出错", e);
		}
	}
	
	public void getInformationById(){
		informationVO = informationService.getInformationById(infoNo);
		result = JSONArray.fromObject(new Object[]{informationVO}).toString();
		ResponseUtil.sendResult(result);
	}
	
	public void modifyInformationState(){
		boolean rs = informationService.modifyInformationStateById(infoNo, state);
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

	public InformationService getInformationService() {
		return informationService;
	}

	public void setInformationService(InformationService informationService) {
		this.informationService = informationService;
	}


	public InformationVO getInformationVO() {
		return informationVO;
	}


	public void setInformationVO(InformationVO informationVO) {
		this.informationVO = informationVO;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getInfoNo() {
		return infoNo;
	}

	public void setInfoNo(Integer infoNo) {
		this.infoNo = infoNo;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

}
