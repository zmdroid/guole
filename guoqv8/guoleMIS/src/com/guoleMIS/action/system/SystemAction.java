package com.guoleMIS.action.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.system.SystemService;
import com.guoleMIS.util.MD5Encrypt;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.PermissionVO;
import com.guoleMIS.vo.RoleVO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class SystemAction extends ActionSupport implements SessionAware{
	private static final long serialVersionUID = 3274092670558877729L;
	private Map<String, Object> session;
	private SystemService systemService;
	
	private ManagerVO managerVO;
	private RoleVO roleVO;
	private PermissionVO permissionVO;
	
	
	/**
	 * 登录
	 * @return
	 */
	public String login(){
		managerVO.setPwd(MD5Encrypt.getInstance().encrypt(managerVO.getPwd()));
		ManagerVO rs = systemService.getManager(managerVO);
		if(rs==null){
			return Action.INPUT;
		}
		if(rs.getAccountStatus() == Consts.MANAGER_TYPE_FROZEN){
			return "frozen";
		}
		//设置权限列表
		List<PermissionVO> ps = new ArrayList<PermissionVO>();
		for(RoleVO role:rs.getRole()){
			for(PermissionVO permission:role.getPermission()){
				ps.add(permission);
			}
		}
		rs.setPermission(ps);
		
		// 权限存入map并放入session中
		HashMap<String, Boolean> perMap = new HashMap<String, Boolean>();
		for (PermissionVO pVO : ps) {
			perMap.put(pVO.getAddr(), true);
		}
		session.put(Consts.CURRENT_USER_PERMISSION, perMap);
		
		session.put(Consts.CURRENT_USER_INFO, rs);
		return Action.SUCCESS;
	}
	
	/**
     * 退出系统
     * @return
     * @throws Exception
     */
	public String logout(){
		//销毁SESSION
		session.clear();
		session = null;
		return Action.SUCCESS;
    }
	
	/**
	 * 获取所有用户
	 */
	public void getManagers(){
		String rs = JSONArray.fromObject(systemService.getAllManagers()).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	/**
	 * 获得指定帐号信息
	 */
	public void getManager(){
		JSONObject rs = JSONObject.fromObject(systemService.getManagerById(managerVO.getId()));
		//屏蔽字段
		rs.element("pwd", " ");
		ResponseUtil.sendResult(rs.toString()) ;
	}
	
	private String pwdOld;//旧密码
	/**
	 * 更新帐号信息
	 */
	public void updateManagerInfo(){
		ManagerVO m = systemService.getManagerById(managerVO.getId());
		if(m==null)return;
		String pwd = managerVO.getPwd();
		
		if(pwd!=null && pwd.trim().length()>0){
			pwdOld = MD5Encrypt.getInstance().encrypt(pwdOld);
			if(!m.getPwd().equals(pwdOld)){//密码不对应
				ResponseUtil.sendResult("pwd_error");
				return;
			}
			managerVO.setPwd(MD5Encrypt.getInstance().encrypt(managerVO.getPwd()));
		}
		
		systemService.updateManagerInfo(managerVO);
	}
	
	/**
	 * 添加后台帐号
	 */
	public void addManager(){
		//默认新建是正常状态
		managerVO.setAccountStatus(Consts.MANAGER_TYPE_NORMAL);
		managerVO.setPwd(MD5Encrypt.getInstance().encrypt(managerVO.getPwd()));
		systemService.addManager(managerVO);
	}
	
	
	
	/**
	 * 冻结账户
	 */
	public void freeze(){
		ManagerVO m = systemService.getManagerById(managerVO.getId());
		if(m==null)return;
		managerVO.setAccountStatus(Consts.MANAGER_TYPE_FROZEN);
		systemService.updateManagerInfo(managerVO);
	}
	
	/**
	 * 解冻账户
	 */
	public void unfreeze(){
		ManagerVO m = systemService.getManagerById(managerVO.getId());
		if(m==null)return;
		managerVO.setAccountStatus(Consts.MANAGER_TYPE_NORMAL);
		systemService.updateManagerInfo(managerVO);
	}
	
	/**
	 * 获取所有角色
	 */
	public void getRoles(){
		String rs = JSONArray.fromObject(systemService.getAllRoles()).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	/**
	 * 添加角色
	 */
	public void addRole(){
		systemService.addRole(roleVO);
	}
	
	/**
	 * 修改角色
	 */
	public void updateRole(){
		systemService.updateRole(roleVO);
	}
	
	public void getRole(){
		String rs = JSONObject.fromObject(systemService.getRole(roleVO.getId())).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	/**
	 * 删除一个角色
	 */
	public void removeRole(){
		systemService.removeRole(roleVO);
	}
	
	
	public void getPermissions(){
		String rs = JSONArray.fromObject(systemService.getAllPermissions()).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	public void getResources(){
		String rs = JSONArray.fromObject(systemService.getResources()).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	public void getTopPermissions(){
		String rs = JSONArray.fromObject(systemService.getAllTopPermissions()).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	public void getPermission(){
		String rs = JSONObject.fromObject(systemService.getPermission(permissionVO.getId())).toString();
		ResponseUtil.sendResult(rs) ;
	}
	
	/**
	 * 添加功能
	 */
	public void addPermission(){
		systemService.addPermission(permissionVO);
	}
	
	public void updatePermission(){
		systemService.updatePermission(permissionVO);
	}
	
	public void removePermission(){
		systemService.removePermission(permissionVO);
	}
	
	
	
	
	

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

	public SystemService getSystemService() {
		return systemService;
	}

	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	public ManagerVO getManagerVO() {
		return managerVO;
	}

	public void setManagerVO(ManagerVO managerVO) {
		this.managerVO = managerVO;
	}

	public RoleVO getRoleVO() {
		return roleVO;
	}

	public void setRoleVO(RoleVO roleVO) {
		this.roleVO = roleVO;
	}

	public PermissionVO getPermissionVO() {
		return permissionVO;
	}

	public void setPermissionVO(PermissionVO permissionVO) {
		this.permissionVO = permissionVO;
	}

	public String getPwdOld() {
		return pwdOld;
	}

	public void setPwdOld(String pwdOld) {
		this.pwdOld = pwdOld;
	}
	
	
}
