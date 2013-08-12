package com.guoleMIS.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.guoleMIS.util.DateType;

/**
 * 自定义el函数
 * @author ken
 * @version 1.0
 * @createtime 2013-6-9
 *		版本		修改者	时间		修改内容
 *
 */
public class Fn {
	/**
	 * 把对象 转换成字符串
	 * @param str
	 * @return
	 */
	public static String convert(Object str){
		return str+"";
	}
	
	/**
	 * 日期转换为字符串
	 * @param date
	 * @return
	 */
	public static String dateToString(Date date, DateType dateType) {
		if (null == date) {
			return null;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(dateType.getValue());
		return sdf.format(date);
	}
	
	/**
	 * 日期转换为字符串
	 * @param date
	 * @return
	 */
	public static String dateToString(Date date) {
		if (null == date) {
			return null;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(DateType.YMDHMS.getValue());
		return sdf.format(date);
	}
	
}
