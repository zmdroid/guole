package com.guole.util;

public enum DateType {
	YMDHMS("yyyy-MM-dd HH:mm:ss"),
	YMD("yyyy-MM-dd"), 
	YMDHMS_CN("yyyy年MM月dd日 HH点mm分ss秒"),
	YMD_CN("yyyy年-MM月-dd日");

	 private final String value;
     public String getValue() {
         return value;
     }

     DateType(String value) {
         this.value = value;
     }
}
