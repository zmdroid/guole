package com.guoleMIS.dao.base;

import org.mybatis.spring.SqlSessionTemplate;

/**
 * DAO实现基类
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
 *		版本		修改者	时间		修改内容
 *
 */
public class BaseDaoImpl {
	/** 
     * 注入sqlSessionTemplate 
     */  
    protected SqlSessionTemplate sqlSessionTemplate;  
  
    protected void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {  
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
}
