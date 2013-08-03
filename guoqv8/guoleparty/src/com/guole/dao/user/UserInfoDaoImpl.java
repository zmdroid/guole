package com.guole.dao.user;

import org.mybatis.spring.SqlSessionTemplate;

import com.guole.dao.base.BaseDaoImpl;
import com.guole.vo.UserAccountVO;
import com.guole.vo.UserInfoVO;

public class UserInfoDaoImpl extends BaseDaoImpl implements UserInfoDao {

	@Override
	public UserAccountVO qurUserAccountByUserId(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int qurUserAccount(UserAccountVO userAccount) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean addUserAccount(UserAccountVO userAccount) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyUserAccount(UserAccountVO userAccount) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyPaypassword(UserAccountVO userAccount) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public UserInfoVO getUserInfo(UserInfoVO user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserInfoVO getUserInfoByUserId(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addUserInfo(UserInfoVO userInfo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyUserInfo(UserInfoVO userInfo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyUserCorInfo(UserInfoVO userInfo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifypassword(UserInfoVO userInfo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean modifyUserHead(UserInfoVO userInfo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int getUserCountByUserAccount(String userAccount) {
		// TODO Auto-generated method stub
		return 0;
	}

}
