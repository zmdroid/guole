package com.guole.action.user;

import java.io.File;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guole.consts.Consts;
import com.guole.service.user.UserInfoService;
import com.guole.util.Config;
import com.guole.util.ImageUtil;
import com.guole.util.MD5Encrypt;
import com.guole.util.ResponseUtil;
import com.guole.vo.UserAccountVO;
import com.guole.vo.UserInfoVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 用户信息Action
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-05-24
 * @history  版本	修改者	   时间	修改内容
 */
public class UserInfoAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1415146777060554880L;

	private final static Logger logger = Logger.getLogger(UserInfoAction.class);
	
	public UserInfoService userInfoService;
	
	public UserAccountVO userAccountVO;
	
    public UserInfoVO userInfoVO;
	
	private String result;
	
	public String readCookies;
	
	public String picType;
	
	public String img;
	
	public String oldpassword;

	public String newpassword;
	
    public String oldPaypassword;
	
	public String newPaypassword;

	private Map<String, Object> session;
	
	/**
	 * 用户登陆
	 */
	public void login() {
		result = "FAILURE";
		try {
			if(readCookies == null || !readCookies.equals(Consts.READ_COOKIES)){
	        	//密码加密
			    userInfoVO.setPwd(MD5Encrypt.getInstance().encrypt(userInfoVO.getPwd()));
			}
			UserInfoVO v = userInfoService.getUserInfo(userInfoVO);
			if (null != v){
				//当前家庭成员
				session.put(Consts.CURRENT_USER_INFO, v);
				result = userInfoVO.getPwd();
			}
		} catch (Exception e) {
			logger.error("获取用户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}

	/**
	 *用户注册
	 */
	public void register(){
		try{
			if(userInfoService.getUserCountByUserAccount(userInfoVO.getUserAccount())){
				result = "EXISTS";
			}else{
				//登陆密码加密
				userInfoVO.setPwd(MD5Encrypt.getInstance().encrypt(userInfoVO.getPwd().toLowerCase()));
				//设置默认头像
				userInfoVO.setAvatar(Config.getInstance().get("defaultHead")+"");
				userInfoVO.setState(2);
				//取现密码初始：111111
				UserAccountVO userAccountVO =new UserAccountVO();
				userAccountVO.setPaypassword(MD5Encrypt.getInstance().encrypt("111111".toLowerCase()));
				result = (userInfoService.addUserAccount(userInfoVO,userAccountVO) ? "SUCCESS" :"FAILURE");
				if (result.equals("SUCCESS")){
					//获取用户信息填充SESSION
					UserInfoVO v = userInfoService.getUserInfo(userInfoVO);
					session.put(Consts.CURRENT_USER_INFO, v);
					
				}
			}
		} catch (Exception e) {
			logger.error("用户注册出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}

	/**
     * 退出系统
     * @return
     * @throws Exception
     */
	public String loginOut(){
		//销毁SESSION
		session.clear();
		return SUCCESS;
    }
	
	/**
	 *更新用户基本信息
	 */
	public void modifyUserInfo(){
		try{
			result = (userInfoService.modifyUserInfo(userInfoVO) ? "SUCCESS" :"ERROR");
			if (result.equals("SUCCESS")){
				//刷新用户SESSION
				UserInfoVO v = userInfoService.getUserInfoByUserId(userInfoVO.getUserId());
				session.put(Consts.CURRENT_USER_INFO, v);
			}
		} catch (Exception e) {
			logger.error("更新用户基本信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *更新用户公司信息
	 */
	public void modifyUserCorInfo(){
		try{
			result = (userInfoService.modifyUserCorInfo(userInfoVO) ? "SUCCESS" :"ERROR");
			if (result.equals("SUCCESS")){
				//刷新用户SESSION
				UserInfoVO v = userInfoService.getUserInfoByUserId(userInfoVO.getUserId());
				session.put(Consts.CURRENT_USER_INFO, v);
			}
		} catch (Exception e) {
			logger.error("更新用户基本信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *更新用户登陆密码
	 */
	public void updatepassword(){
		result = "FAILURE";
		try{
			UserInfoVO v = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
			if(userInfoVO == null)userInfoVO = new UserInfoVO();
			userInfoVO.setUserAccount(v.getUserAccount());
			userInfoVO.setPwd(MD5Encrypt.getInstance().encrypt(oldpassword.toLowerCase()));
			UserInfoVO user = userInfoService.getUserInfo(userInfoVO);
			if(user != null){
				userInfoVO.setPwd(MD5Encrypt.getInstance().encrypt(newpassword.toLowerCase()));
				userInfoVO.setUserId(v.getUserId());
			    result = (userInfoService.modifypassword(userInfoVO) ? "SUCCESS" :"ERROR");
			    if (result.equals("SUCCESS")){
					//刷新用户SESSION
					v = userInfoService.getUserInfoByUserId(v.getUserId());
					session.put(Consts.CURRENT_USER_INFO, v);
				}
			}else{
				result = "PASSWORDERROR";
			}
		} catch (Exception e) {
			logger.error("更新用户虚拟账户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *更新用户头像
	 */
	public void updateHead(){
		result = "FAILURE";
		try{
			userInfoVO = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
			if(userInfoVO != null){
				File src = new File(Config.getInstance().get("tmpDir")+"/"+img);
				File dir = new File(Config.getInstance().get("resRootUrl")+"/head/");
				if(!dir.exists())dir.mkdirs();
				File dest = new File(Config.getInstance().get("resRootUrl")+"/head/"+img);
				ImageUtil.copy(src, dest);
				userInfoVO.setAvatar("/head/"+img);
				result = (userInfoService.modifyUserHead(userInfoVO) ? "SUCCESS" :"ERROR");
				if (result.equals("SUCCESS")){
					//刷新用户SESSION
					userInfoVO = userInfoService.getUserInfoByUserId(userInfoVO.getUserId());
					session.put(Consts.CURRENT_USER_INFO, userInfoVO);
					src.delete();
				}
			
			}
		} catch (Exception e) {
			logger.error("更新用户头像出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	
	
	/**
	 *更新用户虚拟账户信息
	 */
	public void modifyUserAccount(){
		result = "FAILURE";
		try{
			result = (userInfoService.modifyUserAccount(userAccountVO) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("更新用户虚拟账户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *更新用户虚拟账户取现密码
	 */
	public void updatePaypassword(){
		result = "FAILURE";
		try{
			UserInfoVO v = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
			if(userAccountVO == null)userAccountVO = new UserAccountVO();
			userAccountVO.setUserId(v.getUserId());
			userAccountVO.setPaypassword(MD5Encrypt.getInstance().encrypt(oldPaypassword.toLowerCase()));
			if(userInfoService.qurUserAccount(userAccountVO)){
				userAccountVO.setPaypassword(MD5Encrypt.getInstance().encrypt(newPaypassword.toLowerCase()));
			    result = (userInfoService.modifyPaypassword(userAccountVO) ? "SUCCESS" :"ERROR");
			}else{
				result = "PASSWORDERROR";
			}
		} catch (Exception e) {
			logger.error("更新用户虚拟账户信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	
	/**
	 * 初始化用户信息界面
	 */
	public String baseInfo() {
		try {
			userInfoVO = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
			if(userInfoVO != null){
				userAccountVO = userInfoService.qurUserAccountByUserId(userInfoVO.getUserId());
				//刷新用户SESSION
				UserInfoVO v = userInfoService.getUserInfoByUserId(userInfoVO.getUserId());
				session.put(Consts.CURRENT_USER_INFO, v);
				return SUCCESS;
			}else{
				return ERROR;
			}
		} catch (Exception e) {
			logger.error("获取用户虚拟账户出错!", e);
			result = "ERROR";
			return ERROR;
		}
	}
	
	/**
	 * 跳转到个人管理中心页面
	 * @return
	 */
	public String forwardManageCenter() {
		UserInfoVO user = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		
		// 跳转到登录页面
		if (null == user){
			return Consts.STRUTS_FORWARD_LOGIN;
		}
		
		//获取用户账户信息
		userAccountVO = userInfoService.qurUserAccountByUserId(user.getUserId());
		
		// 跳转到买家个人中心
		if (user.getUsertype()==Consts.USER_TYPE_HUMAN) {
			return Consts.STRUTS_FORWARD_HUMAN;
		}

		// 跳转到企业个人中心
		if (user.getUsertype()==Consts.USER_TYPE_COMPANY) {
			return Consts.STRUTS_FORWARD_COMPANY;
		}

		// 跳转到错误页面
		return ERROR;
	}

	public UserAccountVO getUserAccountVO() {
		return userAccountVO;
	}

	public void setUserAccountVO(UserAccountVO userAccountVO) {
		this.userAccountVO = userAccountVO;
	}

	public UserInfoVO getUserInfoVO() {
		return userInfoVO;
	}

	public void setUserInfoVO(UserInfoVO userInfoVO) {
		this.userInfoVO = userInfoVO;
	}

	public void setSession(Map session) {
		this.session = session;
	}
	
	public String getReadCookies() {
		return readCookies;
	}

	public void setReadCookies(String readCookies) {
		this.readCookies = readCookies;
	}
	
	public UserInfoService getUserInfoService() {
		return userInfoService;
	}

	public void setUserInfoService(UserInfoService userInfoService) {
		this.userInfoService = userInfoService;
	}
	
	public String getPicType() {
		return picType;
	}

	public void setPicType(String picType) {
		this.picType = picType;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getOldpassword() {
		return oldpassword;
	}

	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}

	public String getNewpassword() {
		return newpassword;
	}

	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}
	
	public String getOldPaypassword() {
		return oldPaypassword;
	}

	public void setOldPaypassword(String oldPaypassword) {
		this.oldPaypassword = oldPaypassword;
	}

	public String getNewPaypassword() {
		return newPaypassword;
	}

	public void setNewPaypassword(String newPaypassword) {
		this.newPaypassword = newPaypassword;
	}
}
