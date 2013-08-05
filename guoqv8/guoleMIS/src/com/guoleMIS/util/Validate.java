package com.guoleMIS.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validate {

	private final static String EMPTY = "";

	/**
	 * 验证字符串为空
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		if (null == str) {
			return true;
		}
		
		return str.equals(EMPTY);
	}
	
	/**
	 * 验证输入的邮箱格式是否符合
	 * @param email
	 * @return 是否合法
	 */
   public static boolean checkEmail(String email) {
       final String pattern1 = "^\\w+((-w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
       final Pattern pattern = Pattern.compile(pattern1);
       final Matcher mat = pattern.matcher(email);
       return mat.find();
   }
   
   /**
    * 判断字符串是否为数字
    * @param numStr
    * @return
    */
   public static boolean isNumber(String numStr) {
	   if (null == numStr) return false;
	   Pattern pattern = Pattern.compile("[0-9]*"); 
	   return pattern.matcher(numStr).matches();   
   }
   
   /**
    * 是否含有中文（也包含日文和韩文）
    */
   public static boolean isChineseChar(String str){     
       return str.replaceAll("\\w", "").matches("^[\u4E00-\u9FA5\uF900-\uFA2D]+$");
   }
}