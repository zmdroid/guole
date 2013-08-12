package com.qingning.tag;

import com.guoleMIS.util.Config;


public class Function {
	/**
	 * 解码文本
	 * @param str
	 * @return
	 */
	public static String decodeText(String str) {
		return str.replaceAll(">", "&gt;").replaceAll("<", "&lt;");
	}
	
	/**
	 * 根据key获取配置项
	 * @param key
	 * @return
	 */
	public static String getConfig(String key) {
		return Config.getInstance().getString(key);
	}
}
