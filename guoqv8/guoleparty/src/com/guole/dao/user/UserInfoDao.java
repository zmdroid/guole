package com.guole.dao.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guole.vo.ApplyCompanyInfoVO;
import com.guole.vo.UserAccountVO;
import com.guole.vo.UserInfoVO;

/**
 * 用户信息持久层接口
 * @author mingzhou
 * @version V1.0
 * @createTime    2013-08-02
 * @history  版本	修改者	   时间	修改内容
 */
public interface UserInfoDao {
	
	/**
     * 根据用户编号获取用户虚拟账户
     * @param userId 用户编号
     * @return
     */
    public UserAccountVO qurUserAccountByUserId(int userId);
    
    /**
     * 根据用户编号及取现密码获取用户虚拟账户,用于校验取现密码
     * @param userAccount 用户账户
     * @return
     */
    public int qurUserAccount(UserAccountVO userAccount);
    
    /**
     * 添加用户虚拟账户信息
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
    public boolean addUserAccount(UserAccountVO userAccount);
    
    /**
     * 添加企业用户申请信息
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
    public boolean addApplyCompanyInfo(ApplyCompanyInfoVO applyCompanyVO);
    
    /**
     * 更新用户虚拟账户信息
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    public boolean modifyUserAccount(UserAccountVO userAccount);
    
    /**
     * 更新用户虚拟账户支付密码
     * @param userAccount 用户虚拟账户信息
     * @return 
     */
    public boolean modifyPaypassword(UserAccountVO userAccount);
    
    
    /**
     * 根据登陆账号和登陆密码获取用户信息,用于系统登陆
     * @param userAccount 登陆账号
     * @param pwd         登录密码
     * @return 
     */
    public UserInfoVO getUserInfo(UserInfoVO user);
    
    /**
     * 根据登陆账号和登陆密码获取用户信息,用于系统登陆
     * @param userAccount 登陆账号
     * @param pwd         登录密码
     * @return 
     */
    public UserInfoVO getUserInfoByUserId(int userId);
    
    /**
     * 用户注册
     * @param userInfo 用户信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
    public boolean addUserInfo(UserInfoVO userInfo);
    
    /**
     * 更新用户基本信息
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserInfo(UserInfoVO userInfo);
    
    /**
     * 更新用户公司信息
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserCorInfo(UserInfoVO userInfo);
    
    /**
     * 修改用户登陆密码
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifypassword(UserInfoVO userInfo);
    
    /**
     * 修改用户头像
     * @param userInfo 用户信息
     * @return 
     */
    public boolean modifyUserHead(UserInfoVO userInfo);
    
    /**
     * 校验用户账号是否已存在
     * @param userAccount 登陆账号
     * @return 
     */
    public int getUserCountByUserAccount(String userAccount);
    
    /**
     * 校验公司名称及品牌名称是否已存在
     * @param params 参数组合
     * @return 
     */
    public UserInfoVO getCorInfo(Map params);
    
	/**
	 * 更新用户的账户余额
	 * @param userId,balance
	 * @return boolean
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public boolean modifyUserBalance(HashMap<String, Object> param) throws Exception;
	
	/**
	 * 获取用户的账户余额
	 * @param userId,balance
	 * @return boolean
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public double queUserBalance(int userId) throws Exception;

}
