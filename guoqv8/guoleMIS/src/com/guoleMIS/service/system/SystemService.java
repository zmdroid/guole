package com.guoleMIS.service.system;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.PermissionVO;
import com.guoleMIS.vo.RoleVO;

/**
 * 系统管理服务
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface SystemService {
	/**
	 * 通过用户名密码获取管理员
	 * @param manager
	 * @return
	 */
	ManagerVO getManager(ManagerVO manager);
	
	/**
	 * 通过id查询帐号
	 * @param managerId
	 * @return
	 */
	ManagerVO getManagerById(int managerId);
	/**
	 * 查询所有管理员
	 * @return
	 */
	List<ManagerVO> getAllManagers();
	
	/**
	 * 更新用户信息
	 * @param manager
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	void updateManagerInfo(ManagerVO manager);
	
	/**
	 * 增加管理员
	 * @param manager
	 */
	void addManager(ManagerVO manager);
	
	/**
	 * 设置管理员角色
	 */
	void setManagerRole(ManagerVO manager);
	
	/**
	 * 查询指定角色信息
	 * @param roleId
	 * @return
	 */
	RoleVO getRole(int roleId);
	
	/**
	 * 增加角色
	 * @param role
	 */
	void addRole(RoleVO role);
	
	/**
	 * 修改角色
	 * @param role
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	void updateRole(RoleVO role);
	/**
	 * 删除角色
	 * @param role
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	void removeRole(RoleVO role);
	
	/**
	 * 获取角色列表
	 * @return
	 */
	List<RoleVO> getAllRoles();
	
	/**
	 * 设置角色权限
	 * @param role
	 */
	void setRolePermission(RoleVO role);
	
	/**
	 * 增加一个权限
	 * @param permission
	 */
	void addPermission(PermissionVO permission);
	/**
	 * 修改权限
	 */
	void updatePermission(PermissionVO permission);
	/**
	 * 删除权限
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	void removePermission(PermissionVO permission);
	
	List<Map<String, Object>> getAllPermissions();
	
	List<PermissionVO> getResources();
	
	List<PermissionVO> getAllTopPermissions();
	
	PermissionVO getPermission(int pid);
}
