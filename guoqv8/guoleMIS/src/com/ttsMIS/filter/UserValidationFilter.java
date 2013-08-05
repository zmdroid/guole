package com.ttsMIS.filter;


import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.vo.ManagerVO;
import com.guoleMIS.vo.PermissionVO;
/**
 * 用户访问权限过滤
 * 配置项进行过滤
 * @author ken
 * @version 1.0
 * @createtime 2012-6-15
 *		版本		修改者	时间		修改内容
 *
 */
public class UserValidationFilter implements Filter {
	Logger logger = Logger.getLogger(UserValidationFilter.class);
	@Override
	public void destroy() {
		
	}

	@SuppressWarnings({ })
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		String url = request.getServletPath();
		HttpSession session = request.getSession(false);
		String path = request.getContextPath();
		if (!url.contains("/login.") && (null == session || session.getAttribute(Consts.CURRENT_USER_INFO) == null) 
			) {
			forwardPage(resp, path + "/login.jsp");
			return;
		}
		
		//权限过滤
//		if(session != null && !url.contains("/login.")){
//			ManagerVO manager = (ManagerVO) session.getAttribute(Consts.CURRENT_USER_INFO);
//			if(manager==null ){
//				session = null;
//				forwardPage(resp, path + "/login.jsp");
//				return;
//			}
//			List<PermissionVO> permissions = manager.getPermission();
//			boolean passable = false;
//			for(PermissionVO p : permissions ){
//				if(url.endsWith(p.getAddr())){
//					passable = true;
//					break;
//				}
//			}
//			//*
//			if (!passable && !url.endsWith("/login.jsp")) {
//				forwardPage(resp, path + "/login.jsp");
//				return;
//			}
//			//*/
//			
//		}
		
		chain.doFilter(req, resp);
	}

	private void forwardPage(ServletResponse resp, String pageUrl){
		HttpServletResponse response = (HttpServletResponse)resp;
		try {
			response.sendRedirect(pageUrl);
		} catch (IOException e) {
			logger.error("拦截器中跳转页面出错", e);
		}
	}
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		
	}
	
	public static void main(String[] args) {
		System.out.println(!"/login.do".contains("/login."));
	}
}
