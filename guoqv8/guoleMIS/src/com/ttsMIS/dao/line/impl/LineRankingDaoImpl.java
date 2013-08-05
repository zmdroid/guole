package com.ttsMIS.dao.line.impl;

import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.LineVO;
import com.ttsMIS.dao.line.LineRankingDao;

public class LineRankingDaoImpl extends BaseDaoImpl implements LineRankingDao {

	@Override
	public int getLineRankingMaxSortNo() {
		return (Integer)sqlSessionTemplate.selectOne("getLineRankingMaxSortNo",null);
	}

	@Override
	public List<LineVO> loadLineRanking(String conditions) {
		return sqlSessionTemplate.selectList("loadLineRanking",conditions);
	}

	@Override
	public List<LineVO> loadLineList(String condition) {
		return sqlSessionTemplate.selectList("loadLineList",condition);
	}

	@Override
	public int getLineCount(String condition) {
		return sqlSessionTemplate.selectOne("getLineCount",condition);
	}
	
	@Override
	public int isLineExists(int lineId) {
		return (Integer)sqlSessionTemplate.selectOne("isLineExists",lineId);
	}

	@Override
	public boolean addRankingLine(int lineId) {
		return sqlSessionTemplate.insert("addRankingLine",lineId) > 0;
	}

	@Override
	public boolean updateLineRankingSortNo(int id) {
		return sqlSessionTemplate.update("updateLineRankingSortNo",id) > 0;
	}

	@Override
	public boolean updateLineRankingSort(Map params) {
		return sqlSessionTemplate.update("updateLineRankingSort",params) > 0;
	}

	@Override
	public boolean updateRankingSelfSortNo(Map params) {
		return sqlSessionTemplate.update("updateRankingSelfSortNo",params) > 0;
	}

	@Override
	public boolean updateLineSortNo(Map params) {
		return sqlSessionTemplate.update("updateLineSortNo",params) > 0;
	}

	@Override
	public boolean removeRankingLine(int id) {
		return sqlSessionTemplate.delete("removeRankingLine",id) > 0;
	}

	@Override
	public int getRankingCount() {
		return sqlSessionTemplate.selectOne("getRankingCount",null);
	}

	@Override
	public List<String> loadFoundationList(int lineId) {
		return sqlSessionTemplate.selectList("loadFoundationList",lineId);
	}

}
