package com.guole.service.base;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<V extends Serializable> {
	
	String getStr(String key);	
	void saveStr(String key, String value);	
	void updateStr(String key, String value);
	
	V get(String key);
	
	Long incr(String key);
	
	List<String> find(int pageNum, int pageSize);
	/**
	 * 一次加载多个KEY对应的结果
	 * @param keys
	 * @return
	 */
	List<byte[]> mget(String[] keys);
	
}