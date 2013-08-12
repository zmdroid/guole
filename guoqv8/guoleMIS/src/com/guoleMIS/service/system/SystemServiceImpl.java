package com.guoleMIS.service.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.dao.system.ManagerDao;
import com.guoleMIS.dao.system.PermissionDao;
import com.guoleMIS.dao.system.RoleDao;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.PermissionVO;
import com.guoleMIS.vo.RoleVO;

public class SystemServiceImpl implements SystemService {
	private ManagerDao managerDao;
	private RoleDao roleDao;
	private PermissionDao permissionDao;
	Logger log = Logger.getLogger(SystemServiceImpl.class);

	
	@Override
	public ManagerVO getManager(ManagerVO manager) {
		return managerDao.queryManager(manager);
	}
	
	@Override
	public ManagerVO getManagerById(int managerId) {
		return managerDao.queryManagerById(managerId);
	}
	
	@Override
	public List<ManagerVO> getAllManagers() {
		return managerDao.queryAllManager();
	}

	@Override
	public void updateManagerInfo(ManagerVO manager) {
		//更新基本信息
		managerDao.updateManager(manager);
		//更新拥有角色
		List<RoleVO> roles = manager.getRole();
		if(roles!=null && roles.size()>0){
			List<Map<String,Object>> param = new ArrayList<Map<String,Object>>(roles.size());
			for(int i=0,l=roles.size();i<l;i++){
				Map<String,Object> tmp = new HashMap<String, Object>();
				tmp.put("roleId", roles.get(i).getId());
				tmp.put("userId", manager.getId());
				param.add(tmp);
			}
			
			managerDao.deleteManagerRole(manager.getId());
			managerDao.insertManagerRole(param);
		}
	}

	@Override
	public void addManager(ManagerVO manager) {
		managerDao.insertManager(manager);
		List<RoleVO> roles = manager.getRole();
		if(roles!=null && roles.size()>0){
			List<Map<String,Object>> param = new ArrayList<Map<String,Object>>(roles.size());
			for(int i=0,l=roles.size();i<l;i++){
				Map<String,Object> tmp = new HashMap<String, Object>();
				tmp.put("roleId", roles.get(i).getId());
				tmp.put("userId", manager.getId());
				param.add(tmp);
			}
			managerDao.insertManagerRole(param);
		}
	}

	@Override
	public void setManagerRole(ManagerVO manager) {
		// TODO Auto-generated method stub

	}
	
	@Override
	public RoleVO getRole(int roleId) {
		return roleDao.queryRole(roleId);
	}

	@Override
	public void addRole(RoleVO role) {
		roleDao.insertRole(role);
		List<PermissionVO> permissions = role.getPermission();
		if(permissions!=null && permissions.size()>0){
			List<Map<String,Object>> param = new ArrayList<Map<String,Object>>(permissions.size());
			for(int i=0,l=permissions.size();i<l;i++){
				Map<String,Object> tmp = new HashMap<String, Object>();
				tmp.put("roleId", role.getId());
				tmp.put("pid", permissions.get(i).getId());
				param.add(tmp);
			}
			roleDao.insertRolePermission(param);
		}
	}

	@Override
	public void updateRole(RoleVO role) {
		//更新信息
		roleDao.updateRole(role);
		//更新权限
		List<PermissionVO> permissions = role.getPermission();
		if(permissions!=null && permissions.size()>0){
			List<Map<String,Object>> param = new ArrayList<Map<String,Object>>(permissions.size());
			for(int i=0,l=permissions.size();i<l;i++){
				Map<String,Object> tmp = new HashMap<String, Object>();
				tmp.put("roleId", role.getId());
				tmp.put("pid", permissions.get(i).getId());
				param.add(tmp);
			}
			roleDao.deleteRolePermission( role.getId());
			roleDao.insertRolePermission(param);
		}

	}

	@Override
	public void removeRole(RoleVO role) {
		roleDao.deleteRole(role);
		roleDao.deleteRolePermission(role.getId());
	}
	
	@Override
	public List<RoleVO> getAllRoles() {
		return roleDao.queryAllRole();
	}

	@Override
	public void setRolePermission(RoleVO role) {
		// TODO Auto-generated method stub

	}

	@Override
	public void addPermission(PermissionVO permission) {
		permissionDao.insertPermission(permission);
	}

	@Override
	public void updatePermission(PermissionVO permission) {
		permissionDao.updatePermission(permission);
	}

	@Override
	public void removePermission(PermissionVO permission) {
		//删除功能
		permissionDao.deletePermission(permission);
		//删除功能角色关联
		permissionDao.deleteRolePermission(permission.getId());
	}

	public ManagerDao getManagerDao() {
		return managerDao;
	}

	public void setManagerDao(ManagerDao managerDao) {
		this.managerDao = managerDao;
	}

	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public PermissionDao getPermissionDao() {
		return permissionDao;
	}

	public void setPermissionDao(PermissionDao permissionDao) {
		this.permissionDao = permissionDao;
	}

	@Override
	public List<Map<String,Object>> getAllPermissions() {
		return permissionDao.queryAllPermission();
	}
	
	@Override
	public List<PermissionVO> getResources(){
		return permissionDao.getResources();
	}
	
	@Override
	public List<PermissionVO> getAllTopPermissions(){
		return permissionDao.getAllTopPermissions();
	}
	
	@Override
	public PermissionVO getPermission(int pid) {
		return permissionDao.queryPermission(pid);
	}
}
