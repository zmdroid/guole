package com.guole.dao.bill;

import java.util.List;

import com.guole.dao.base.BaseDaoImpl;
import com.guole.vo.BillVO;


/**
 * 账单DAO实现
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class BillDaoImpl extends BaseDaoImpl implements BillDao{

	@Override
	public boolean insertBill(BillVO bill) {
		int rs = this.sqlSessionTemplate.insert("insertBill", bill);
		return rs>0?true:false;
	}

	@Override
	public List<BillVO> queryBill(String conditions) {
		return this.sqlSessionTemplate.selectList("queryBill", conditions);
	}

	@Override
	public int queryBillPageCount(String conditions) {
		return this.sqlSessionTemplate.selectOne("queryBillPageCount", conditions);
	}
	
}