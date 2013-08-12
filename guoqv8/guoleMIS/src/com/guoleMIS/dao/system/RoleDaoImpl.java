package com.guoleMIS.dao.system;

import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.RoleVO;

public class RoleDaoImpl extends BaseDaoImpl implements RoleDao {

	@Override
	public void insertRole(RoleVO role) {
		// TODO Auto-generated method stub

	}
	
	@Override
	public void insertRolePermission(List<Map<String, Object>> param) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void deleteRolePermission(int roleId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRole(RoleVO role) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteRole(RoleVO role) {
		// TODO Auto-generated method stub

	}

	
	@Override
	public List<RoleVO> queryAllRole() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public RoleVO queryRole(int id) {
		return null;
	}
	
	@Override
	public List<RoleVO> queryRoleByManager(int managerId) {
		// TODO Auto-generated method stub
		return null;
	}
}
