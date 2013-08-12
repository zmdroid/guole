package com.guoleMIS.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;

import com.guoleMIS.util.Config;

/**
 * 全局配置文件类
 * @author ken
 *
 */
public final class Config {
	
	private Config(){}
	
	private static Config instance = new Config();
	
	/**
	 * 获取一个配置实例
	 * @return
	 */
	public static Config getInstance(){
		return instance;
	}
	/**
	 * 系统属性对象
	 */
	Map<String,Object> properties = null;
	
	public void setProperties(Map<String, Object> properties) {
		this.properties = properties;
	}
	
	/**
	 * 获取一个配置项的值
	 * @param key 配置名称
	 * @return Object 值
	 */
	public Object get(String key){
		return properties.get(key);
	}
	
	/**
	 * 获取一个配置项的值
	 * @param key 配置名称
	 * @return String 值
	 */
	public String getString(String key){
		return properties.get(key) == null ? null : (properties.get(key) + "");
	}
	
	//test
	public static void main(String[] args) {
		//1.加载静态配置文件
		 InputStream in = ClassLoader.getSystemResourceAsStream("tpm.properties");
		 Properties p = new Properties();
		 try {
			p.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(in!=null){
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		 System.out.println(p.getProperty("tmpDir"));
	}

}
