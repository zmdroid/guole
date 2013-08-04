package com.guole.service.user;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.guole.dao.user.UserInfoDao;
import com.guole.util.MD5Encrypt;
import com.guole.vo.ApplyCompanyInfoVO;
import com.guole.vo.UserAccountVO;
import com.guole.vo.UserInfoVO;

/**
 * 用户信息领域模型
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-05-24
 * @history  版本	修改者	   时间	修改内容
 */
public class UserInfoServiceImpl implements UserInfoService{
    
    private UserInfoDao userInfoDao;//用户信息持久层接口
    
    /**
     * 根据用户编号获取用户虚拟账户列表
     * @param userId 用户编号
     * @return
     */
    public UserAccountVO qurUserAccountByUserId(int userId){
		return userInfoDao.qurUserAccountByUserId(userId);
	}
    
    /**
     * 根据用户编号获取用户虚拟账户列表
     * @param userAccount 用户账户
     * @return
     */
    public boolean qurUserAccount(UserAccountVO userAccount){
    	return userInfoDao.qurUserAccount(userAccount) > 0;
    }
    
    /**
     * 添加用户账户信息
     * @param userAccount 用户信息
     * @return 
     */
    public boolean addUserAccount(UserInfoVO userInfo) throws Exception{
    	boolean rs = userInfoDao.addUserInfo(userInfo);
    	if(rs){
    		UserInfoVO v = userInfoDao.getUserInfo(userInfo);
    		if(v.getUsertype()==UserInfoVO.USER_TYPE_2){//是否为企业用户，填写申请表
    			ApplyCompanyInfoVO appCompanyVO = new ApplyCompanyInfoVO();
    			appCompanyVO.setApplyTime(new Date());
    			appCompanyVO.setUserId(v.getUserId());
    			appCompanyVO.setState(ApplyCompanyInfoVO.APPLY_COMPANY_STATE_ING);
    			rs = userInfoDao.addApplyCompanyInfo(appCompanyVO);
    			if(!rs){
    				throw new Exception();
    			}
    		}
    		
    		//初始化用户虚拟账户信息
    		UserAccountVO userAccountVO =new UserAccountVO();
			userAccountVO.setPaypassword(MD5Encrypt.getInstance().encrypt("111111".toLowerCase()));
			userAccountVO.setUserId(v.getUserId());
			userAccountVO.setState(UserAccountVO.USERACCOUNT_STATE_1);
			userAccountVO.setBalance(0);
			rs = userInfoDao.addUserAccount(userAccountVO);
    	    if(!rs){
    	    	throw new Exception();
    	    }
    	}else{
    		throw new  Exception();
    	}
    	return rs;
    }
    
    /**
     * 更新用户虚拟账户信息
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    public boolean modifyUserAccount(UserAccountVO userAccount){
    	return userInfoDao.modifyUserAccount(userAccount);
    }
    
    /**
     * 修改用户登陆密码
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifypassword(UserInfoVO userInfo){
    	return userInfoDao.modifypassword(userInfo);
    }
    
    /**
     * 修改用户头像
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserHead(UserInfoVO userInfo){
    	return userInfoDao.modifyUserHead(userInfo);
    }
    
    /**
     * 更新用户虚拟账户支付密码
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    public boolean modifyPaypassword(UserAccountVO userAccount){
    	return userInfoDao.modifyPaypassword(userAccount);
    }
    
    /**
     * 根据登陆账号和登陆密码获取用户信息,用于系统登陆
     * @param userAccount 登陆账号
     * @param pwd         登录密码
     * @return 
     */
    public UserInfoVO getUserInfo(UserInfoVO user){
    	return userInfoDao.getUserInfo(user);
    }
    
    /**
     * 根据登陆账号和登陆密码获取用户信息,用于系统登陆
     * @param userAccount 登陆账号
     * @param pwd         登录密码
     * @return 
     */
    public UserInfoVO getUserInfoByUserId(int userId){
    	return userInfoDao.getUserInfoByUserId(userId);
    }
    
    /**
     * 更新用户基本信息
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserInfo(UserInfoVO userInfo){
    	return userInfoDao.modifyUserInfo(userInfo);
    }
    
    /**
     * 更新用户公司信息
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserCorInfo(UserInfoVO userInfo){
    	return userInfoDao.modifyUserCorInfo(userInfo);
    }
    
    
    /**
     * 校验用户账号是否已存在
     * @param userAccount 登陆账号
     * @return 
     */
    public boolean getUserCountByUserAccount(String userAccount){
    	return userInfoDao.getUserCountByUserAccount(userAccount) > 0;
    }
    
    /**
     * 校验公司名称是否已存在
     * @param corname 公司名称
     * @return 
     */
	@Override
	public UserInfoVO getCorInfo(String corname) {
		Map params = new HashMap();
    	params.put("corname", corname);
    	return userInfoDao.getCorInfo(params);
	}
    
    
    public UserInfoDao getUserInfoDao() {
		return userInfoDao;
	}

	public void setUserInfoDao(UserInfoDao userInfoDao) {
		this.userInfoDao = userInfoDao;
	}
}
