package com.guole.listener;

import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.guole.util.Config;

/**
 * 初始化系统全局配置，并放入内存
 * @author ken
 *
 */
public class InitSystemListener implements ServletContextListener{
	Logger logger = Logger.getLogger(InitSystemListener.class);
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		Map<String,Object> properties = new HashMap<String,Object>();
		/****************1.加载静态配置文件****************/
		//加载属性文件
		final ResourceBundle resource = ResourceBundle.getBundle("guole");
	
		for(Object key:resource.keySet()){
			properties.put(key+"", resource.getObject(key+""));
		}
		
		/****************2.加载动态配置文件****************/
		//put into the properties...
		
		/****************3.注入全局config****************/
		Config config  = Config.getInstance();
		config.setProperties(properties);
		
		event.getServletContext().setAttribute("fileDir", config.getString("resRootUrl")+config.getString("fileDir"));
		event.getServletContext().setAttribute("imgDir", config.getString("resRootUrl")+config.getString("imageDir"));
		event.getServletContext().setAttribute("headDir", config.getString("resRootUrl")+config.getString("imageDir")+config.getString("headDir"));
		event.getServletContext().setAttribute("fileUrl", config.getString("resWebRootUrl")+config.getString("fileDir"));
		event.getServletContext().setAttribute("imgUrl", config.getString("resWebRootUrl")+config.getString("imageDir"));
		
		logger.info("System config loaded...");
	}
}