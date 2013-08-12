package com.guoleMIS.dao.system;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.RoleVO;

/**
 * 角色DAO
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface RoleDao {
	/**
	 * 插入角色
	 * @param role
	 */
	void insertRole(RoleVO role);
	/**
	 * 批量插入关联表
	 * @param param
	 */
	void insertRolePermission(List<Map<String,Object>> param);
	
	/**
	 * 删除角色对应的功能
	 * @param roleId
	 */
	void deleteRolePermission(int roleId);
	/**
	 * 更新角色
	 * @param role
	 */
	void updateRole(RoleVO role);
	/**
	 * 删除角色
	 * @param role
	 */
	void deleteRole(RoleVO role);
	
	/**
	 * 查询所有角色
	 * @return
	 */
	List<RoleVO> queryAllRole();
	
	/**
	 * 查询指定角色
	 * @param id
	 * @return
	 */
	RoleVO queryRole(int id);
	
	/**
	 * 通过
	 * @param managerId
	 * @return
	 */
	List<RoleVO> queryRoleByManager(int managerId);
}
