package com.guoleMIS.action.member;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.service.member.MemberInfoService;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.MemberInfoVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 会员管理Action
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-03
 * @history  版本	修改者	   时间	修改内容
 */
public class MemberInfoAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1415146777060554880L;

	private final static Logger logger = Logger.getLogger(MemberInfoAction.class);
	
	public MemberInfoService memberInfoService;
	
    public MemberInfoVO memberInfoVO;
    
    public int page;

	public int userId;
	
	public int id;

	public int sortNo;
	
	public int oldSortNo;
	
	public String userIds;
	
	public String ids;

	private String result;

	private Map<String, Object> session;
	
	private final static Config config = Config.getInstance();
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	/**
	 *获取会员列表
	 */
	public void loadMembers(){
		result = "";
		try{
			List<MemberInfoVO> members = memberInfoService.loadMembers(memberInfoVO,page);
			int totalCount = memberInfoService.getMemberInfosCount(memberInfoVO);
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(members != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			result = "{\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(members);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取会员信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *获取供应商榜单
	 */
	public void loadSupplyRanking(){
		result = "";
		try{
			List<MemberInfoVO> members = memberInfoService.loadSupplyRanking(page);
			int totalCount = memberInfoService.getSupplyRankingCount();
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(members != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			int maxSortNo = memberInfoService.getMaxSortNo();
			result = "{\"maxSortNo\":"+maxSortNo+",";
			result += "\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(members);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取供应商榜单出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
     * 移除榜单中的供应商
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void removeSupply(){
		try {   
			if(memberInfoService.removeSupply(id)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	/**
     * 设置店铺榜单排序
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void resetSupplyRanking(){
		try {   
			if(memberInfoService.resetSupplyRanking(id,sortNo,oldSortNo)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	/**
     * 添加店铺榜单店铺
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void addRankingSupply(){
		try {   
			if(memberInfoService.addRankingSupply(userIds)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			e.printStackTrace();
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	
	/**
	 *获取会员详细信息
	 */
	public String memberDetail(){
		try{
			memberInfoVO = memberInfoService.getMemberInfoByUserId(userId);
	    	//过滤HTML标签
			memberInfoVO.setUserAccount(filterHTMLTag(memberInfoVO.getUserAccount()));
			memberInfoVO.setName(filterHTMLTag(memberInfoVO.getName()));
			memberInfoVO.setCorname(filterHTMLTag(memberInfoVO.getCorname()));
			memberInfoVO.setCoraddr(filterHTMLTag(memberInfoVO.getCoraddr()));
			return SUCCESS;
		} catch (Exception e) {
			logger.error("获取用户详细信息出错!", e);
			e.printStackTrace();
			return ERROR;
		}
	}
	
	private String filterHTMLTag(String val){
		if(val == null)return "";
		return val.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&#39;", "'").replaceAll("&quot;", "\"");
	}
	
	/**
	 *冻结会员账户信息
	 */
	public void freezeAccount(){
		try{
			memberInfoVO.setState(MemberInfoVO.USER_STATE_4);
			result = (memberInfoService.aduitMember(memberInfoVO) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("冻结用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *解冻会员账户信息
	 */
	public void unFreezeAccount(){
		try{
			memberInfoVO.setState(MemberInfoVO.USER_STATE_2);
			result = (memberInfoService.aduitMember(memberInfoVO) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("冻结用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *审核拒绝会员账户信息
	 */
	public void refuse(){
		try{
			memberInfoVO.setState(MemberInfoVO.USER_STATE_3);
			result = (memberInfoService.aduitMember(memberInfoVO) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("审核拒绝用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *批量审核拒绝会员账户信息
	 */
	public void batchRefuse(){
		try{
			result = (memberInfoService.batchRefuse(userIds) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("批量审核通过用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *批量审核通过会员账户信息
	 */
	public void batchTransit(){
		try{
			result = (memberInfoService.batchTransit(userIds) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("批量审核通过用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *审核通过会员账户信息
	 */
	public void transit(){
		try{
			memberInfoVO.setState(MemberInfoVO.USER_STATE_2);
			result = (memberInfoService.aduitMember(memberInfoVO) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("审核通过用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}

	public void setSession(Map session) {
		this.session = session;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public MemberInfoService getMemberInfoService() {
		return memberInfoService;
	}

	public void setMemberInfoService(MemberInfoService memberInfoService) {
		this.memberInfoService = memberInfoService;
	}

	public MemberInfoVO getMemberInfoVO() {
		return memberInfoVO;
	}

	public void setMemberInfoVO(MemberInfoVO memberInfoVO) {
		this.memberInfoVO = memberInfoVO;
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
	    this.page = page;
	}
	
	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public int getSortNo() {
		return sortNo;
	}

	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}

	public int getOldSortNo() {
		return oldSortNo;
	}

	public void setOldSortNo(int oldSortNo) {
		this.oldSortNo = oldSortNo;
	}

}
