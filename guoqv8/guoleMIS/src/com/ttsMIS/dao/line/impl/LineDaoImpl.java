package com.ttsMIS.dao.line.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.LineVO;
import com.ttsMIS.dao.line.LineDao;

public class LineDaoImpl extends BaseDaoImpl implements LineDao {
	/**
	 * 查询旅游线路列表
	 */
	@Override
	public List<LineVO> queryLineList(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.selectList("queryLineList");
	}

	/**
	 * 查询旅游线路列表大小
	 */
	@Override
	public int queryLineListSize(String sqlChip) throws Exception {
		return sqlSessionTemplate.selectOne("queryLineListSize");
	}
	
	/**
	 * 根据线路编号查询线路信息
	 * @param lineId 线路编号
	 * @return
	 * @throws Exception
	 */
	@Override
	public LineVO queryLineInfoById(int lineId) throws Exception {
		return sqlSessionTemplate.selectOne("queryLineInfoById");
	}
	
	/**
	 * 根据线路ID和供应商ID的查询线路信息列表
	 * @param lineId
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@Override
	public LineVO queryLineInfoByUidAndId(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.selectOne("queryLineInfoByUidAndId");
	}
	
	
	/**
	 * 查询个人线路列表
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<LineVO> queryLineListByStatus(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.selectList("queryLineListByStatus");
	}

	/**
	 * 查询个人线路列表大小
	 * @return
	 * @throws Exception
	 */
	@Override
	public int queryLineListCountByStatus(String sqlChip) throws Exception {
		return sqlSessionTemplate.selectOne("queryLineListCountByStatus");
	}

	/**
	 * 更新线路状态
	 * @throws Exception
	 */
	@Override
	public int updateLineState(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.update("updateLineState");
	}
	
	/**
	 * 复制线路
	 * @throws Exception
	 */
	@Override
	public int inserLineForCopy(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.update("inserLineForCopy");
	}
	
	@Override
	public void copyPlan(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
	}
	
	/**
	 * 插入线路基本信息
	 * @return
	 * @throws Exception
	 */
	@Override
	public void insertLineBaseInfo(LineVO lineVO) throws Exception {
		sqlSessionTemplate.insert("insertLineBaseInfo");
	}
	
	/**
	 * 更新线路图片
	 * @throws Exception
	 */
	@Override
	public void updateLinePics(HashMap<String, Object> map) throws Exception {
		sqlSessionTemplate.update("updateLinePics");
	}
	
	
	@Override
	public void updateLinePlanState(HashMap<String, Object> map)
			throws Exception {
		
	}
	
	
	/**
	 * 更新线路扩展信息
	 * @param lineInfo
	 * @throws Exception
	 */
	@Override
	public void updateLineMoreInfo(LineVO lineInfo) throws Exception {
		sqlSessionTemplate.update("updateLineMoreInfo");
	}
	
	/**
	 * 删除线路
	 * @throws Exception
	 */
	@Override
	public void deleteLines(HashMap<String, Object> map) throws Exception {
		sqlSessionTemplate.delete("deleteLines");
	}
	
	/**
	 * 更新线路所有信息
	 * @param lineInfo
	 * @throws Exception
	 */
	@Override
	public void updateLineInfo(LineVO lineInfo) throws Exception {
		sqlSessionTemplate.update("updateLineInfo");
	}
	
	/**
	 * 查询下架商品列表
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<LineVO> queryOffShelfLineList(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.selectList("queryOffShelfLineList");
	}
	
	/**
	 * 查询下架商品列表大小
	 * @return
	 * @throws Exception
	 */
	@Override
	public int queryOffShelfLineListCount(String sqlChip) throws Exception {
		return sqlSessionTemplate.selectOne("queryOffShelfLineListCount");
	}
	
	/**
	 * 更换主图
	 * @throws Exception
	 */
	@Override
	public void updateLineFirstPic(HashMap<String, Object> map) throws Exception {
		sqlSessionTemplate.update("updateLineFirstPic");
	}
	
	/**
	 * 在线商品复制线路
	 * @throws Exception
	 */
	@Override
	public int inserLineForCopyFromPublish(LineVO lineInfo) throws Exception {
		return sqlSessionTemplate.insert("inserLineForCopyFromPublish");
	}
	
	/**
	 * 根据IDS查询线路信息
	 * @throws Exception
	 */
	@Override
	public List<LineVO> queryLineByIds(String lineIds) throws Exception {
		return sqlSessionTemplate.selectList("queryLineByIds");
	}
	
	/**
	 * 手工下架
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@Override
	public int offShelfLine(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.update("offShelfLine");
	}
	

	
	@Override
	public List<LineVO> getLineByState(int state) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateLinePlanStateById(int planId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateLineStateByLineId(int lineId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * 根据团期ID删除团期
	 * @return
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int deletePlanByIds(HashMap<String, Object> map) throws Exception {
		return sqlSessionTemplate.delete("deletePlanByIds");
	}
}
