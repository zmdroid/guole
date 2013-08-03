package com.guole.service.user;

import com.guole.dao.user.UserInfoDao;
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
    
    public UserInfoDao userInfoDao;//用户信息持久层接口
    
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
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    public boolean addUserAccount(UserInfoVO userInfo,UserAccountVO userAccount){
    	if(userInfoDao.addUserInfo(userInfo)){
    		UserInfoVO v = userInfoDao.getUserInfo(userInfo);
    		userAccount.setUserId(v.getUserId());
    		userAccount.setState(UserAccountVO.USERACCOUNT_STATE_1);
    		userAccount.setBalance(0);
    	    return userInfoDao.addUserAccount(userAccount);
    	}else{
    		return false;
    	}
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
    
    public UserInfoDao getUserInfoDao() {
		return userInfoDao;
	}

	public void setUserInfoDao(UserInfoDao userInfoDao) {
		this.userInfoDao = userInfoDao;
	}
}
