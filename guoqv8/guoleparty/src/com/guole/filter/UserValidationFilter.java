package com.guole.filter;


import java.io.IOException;

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

import com.guole.consts.Consts;
import com.guole.util.Config;


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
		String referer = request.getHeader("referer");
		HttpSession session = request.getSession(false);
		
		if(referer==null)referer="";
		//检测url是否包含过滤目录，如果包含验证session
		String[] dirs = (Config.getInstance().get("validation.dirs")+"").split(",");
		boolean needValidate = false;
		for(String dir:dirs){
			if(url.indexOf(dir)>-1 || referer.indexOf(dir)>-1){
				needValidate = true;
				break;
			}
		}
		//是否属于白名单
		String[] excepts = (Config.getInstance().get("validation.except")+"").split(",");
		for(String except:excepts){
			if(url.indexOf(except)>-1 || referer.indexOf(except)>-1){
				needValidate = false;
				break;
			}
		}
		if(needValidate){
				
			if(session != null){
				Object obj = session.getAttribute(Consts.CURRENT_USER_INFO);
				if(obj != null) {
					chain.doFilter(req, resp);
					return;
				}
			}

			//跳转到主页
			String cp = request.getContextPath();
			String indexPage = Config.getInstance().get("validation.redirectPage")+"";
			HttpServletResponse response = (HttpServletResponse)resp;
			response.sendRedirect(cp+indexPage);
			return;
		}
		chain.doFilter(req, resp);
		return;
	}
	
	// 判断链接是否超时
	private boolean isInvalidUrl(long time){
		return System.currentTimeMillis() - time > 0;
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

}
