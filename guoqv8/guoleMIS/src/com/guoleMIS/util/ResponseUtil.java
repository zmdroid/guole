package com.guoleMIS.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.guoleMIS.util.ResponseUtil;

/**
 * 请求响应对象工具类
 * @author xubo.wang
 * @version V1.0
 * @createTime   2012-06-07
 * @history  版本	修改者	   时间	修改内容
 */
public class ResponseUtil {

	private final static Logger logger = Logger.getLogger(ResponseUtil.class);
	/**
	 * 向前台发送返回结果
	 * @param result 返回结果
	 */
	public static void sendResult(String result){
		// 请求和响应对象
		HttpServletResponse response = (HttpServletResponse) ActionContext
		                               .getContext().get(ServletActionContext.HTTP_RESPONSE);

		PrintWriter pw = null;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html");
			pw = response.getWriter();
			pw.write(result);
		}catch (IOException e){
			logger.error("向前台发送返回结果出错", e);
		}finally{
			if (null != pw){
				pw.close();
			}
		}
	}
}
