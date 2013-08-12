package com.guoleMIS.dao.system;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.PermissionVO;

/**
 * 功能DAO
 * @author ken
 * @version 1.0
 * @createtime 2013-6-4
 *		版本		修改者	时间		修改内容
 *
 */
public interface PermissionDao {
	/**
	 * 插入功能
	 * @param role
	 */
	void insertPermission(PermissionVO permission);
	/**
	 * 更新角色
	 * @param role
	 */
	void updatePermission(PermissionVO permission);
	/**
	 * 删除角色
	 * @param role
	 */
	void deletePermission(PermissionVO permission);
	
	/**
	 * 删除角色关联的权限
	 * @param pid
	 */
	void deleteRolePermission(int pid);
	/**
	 * 查询所有角色
	 * @return
	 */
	List<Map<String, Object>> queryAllPermission();
	
	public List<PermissionVO> getResources();
	
	public List<PermissionVO> getAllTopPermissions();
	
	/**
	 * 查询指定角色
	 * @param id
	 * @return
	 */
	PermissionVO queryPermission(int id);
	
	/**
	 * 通过
	 * @param roleId
	 * @return
	 */
	List<PermissionVO> queryPermissionByRole(int roleId);
}
