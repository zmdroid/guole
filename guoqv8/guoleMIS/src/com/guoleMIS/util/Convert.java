package com.guoleMIS.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.guoleMIS.util.Convert;
import com.guoleMIS.util.DateType;

public class Convert {
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
	
	public static Date stringToDate(String str ,DateType dateType){
		if(null == str){
			return null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat(dateType.getValue());
		try {
			return sdf.parse(str);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
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
	
	/**
	 * 日期转换为字符串
	 * @param date
	 * @return
	 */
	public static String dateToString(java.sql.Date date, DateType dateType) {
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
	public static String dateToString(java.sql.Date date) {
		if (null == date) {
			return null;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(DateType.YMDHMS.getValue());
		return sdf.format(date);
	}
	
	public static void main(String[] args) {
		java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
		String str = Convert.dateToString(date);
		System.out.println(str);
	}
}
