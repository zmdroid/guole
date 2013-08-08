package com.guoleMIS.dao.finance;

import java.util.HashMap;
import java.util.List;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.dao.finance.BillDao;
import com.guoleMIS.vo.BillVO;


/**
 * 账单DAO实现
 * @author ken
 * @version 1.0
 * @createtime 2013-5-24
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
	
	/**
	 * 查询流水
	 * @return
	 * @throws Exception
	 */
	@Override
	public BillVO queryBillInfo(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.selectOne("queryBillInfo");
	}

	@Override
	public BillVO queryBillDetail(String _parameter) {
		// TODO Auto-generated method stub
		return this.sqlSessionTemplate.selectOne("queryBillDetail", _parameter);
	}
}