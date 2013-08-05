package com.guoleMIS.dao.system;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.ManagerVO;


/**
 * 后台管理人员操作DAO
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface ManagerDao {
	/**
	 * 新增一个管理员
	 * @param manager
	 */
	void insertManager(ManagerVO manager);
	
	/**
	 * 插入关联表
	 * @param param
	 */
	void insertManagerRole(List<Map<String,Object>> param);
	
	/**
	 * 删除帐号拥有所有角色
	 * @param managerId
	 */
	void deleteManagerRole(int managerId);
	
	/**
	 * 更新一个管理员
	 * @param manager
	 */
	void updateManager(ManagerVO manager);
	
	/**
	 * 查询所有管理人
	 * 不需要查询权限信息,需要查询角色信息
	 * @return
	 */
	List<ManagerVO> queryAllManager();
	
	/**
	 * 通过用户名、密码查询账户
	 * 这个账户，需要查询权限信息
	 * @param manager.userAccount
	 * @param manager.pwd
	 * @return
	 */
	ManagerVO queryManager(ManagerVO manager);
	
	/**
	 * 通过id查询帐号
	 * @param managerId
	 * @return
	 */
	ManagerVO queryManagerById(int managerId);
}
