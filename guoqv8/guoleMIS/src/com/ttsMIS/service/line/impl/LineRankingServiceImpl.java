package com.ttsMIS.service.line.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.util.Config;
import com.guoleMIS.vo.LineVO;
import com.guoleMIS.vo.MemberInfoVO;
import com.ttsMIS.dao.line.LineRankingDao;
import com.ttsMIS.service.line.LineRankingService;

public class LineRankingServiceImpl implements LineRankingService {
	
    private final static Config config = Config.getInstance();
	
	public LineRankingDao lineRankingDao;
	
	public LineRankingDao getLineRankingDao() {
		return lineRankingDao;
	}

	public void setLineRankingDao(LineRankingDao lineRankingDao) {
		this.lineRankingDao = lineRankingDao;
	}

	@Override
	public int getLineRankingMaxSortNo() {
		return lineRankingDao.getLineRankingMaxSortNo();
	}

	@Override
	public List<LineVO> loadLineRanking(int page) {
		String conditions = "";
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions = " LIMIT "+start+","+limit;
		return lineRankingDao.loadLineRanking(conditions);
	}

	@Override
	public List<LineVO> loadAllRankingLine() {
		return lineRankingDao.loadLineRanking(" AND 1 = 1 ");
	}

	@Override
	public int getRankingCount() {
		return lineRankingDao.getRankingCount();
	}

	@Override
	public boolean isLineExists(int lineId) {
		return lineRankingDao.isLineExists(lineId) > 0;
	}

	@Override
	public boolean addRankingLine(String lineIds) {
		boolean isSuccess = true;
		String[] itemPid = lineIds.split(",");
		int len = itemPid.length;
		for(int i = 0; i < len; i++){
			 if(lineRankingDao.isLineExists(Integer.parseInt(itemPid[i])) == 0){
			   if(!lineRankingDao.addRankingLine(Integer.parseInt(itemPid[i]))){
				   return false;
			   }
			 }
		}
		return isSuccess;
	}

	@Override
	public boolean resetLineRankingSort(int id, int sortNo, int oldSortNo) {
		boolean isSuccess = true;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("sortNo", sortNo);
		params.put("oldSortNo", oldSortNo);
		if(sortNo > oldSortNo){
			lineRankingDao.updateLineRankingSort(params);
			if(!lineRankingDao.updateRankingSelfSortNo(params)){
			   return false;
			}
		}else if(sortNo < oldSortNo){
			lineRankingDao.updateLineSortNo(params);
			if(!lineRankingDao.updateRankingSelfSortNo(params)){
			   return false;
		    }
		}
		return isSuccess;
	}

	@Override
	public boolean removeRankingLine(int id) {
		boolean isSuccess = true;
		lineRankingDao.updateLineRankingSortNo(id);
		if(!lineRankingDao.removeRankingLine(id)){
			 return false;
		}
		return isSuccess;
	}

	@Override
	public List<LineVO> loadLineList(LineVO lineVO, int page) {
		return lineRankingDao.loadLineList(getConditions(lineVO,page));
	}

	@Override
	public int getLineCount(LineVO lineVO) {
		return lineRankingDao.getLineCount(getConditions(lineVO,-1));
	}
	
	private String getConditions(LineVO lineVO,int page){
		StringBuffer conditions = new StringBuffer();
		//线路类型
		if(!lineVO.getLineType().equals("-1")){
			conditions.append(" AND line.lineType='").append(lineVO.getLineType()).append("'");
		}
		//业务类型
		if(!lineVO.getBusiType().equals("-1")){
			conditions.append(" AND line.busiType='").append(lineVO.getBusiType()).append("'");
		}
		//线路名称
		if(lineVO.getName() != null && !lineVO.getName().equals("")){
			conditions.append(" AND line.name LIKE '%").append(lineVO.getName()).append("%'");
		}
		//供应商名称
		if(lineVO.getSupplierName() != null && !lineVO.getSupplierName().equals("")){
			conditions.append(" AND u.name LIKE '%").append(lineVO.getSupplierName()).append("%'");
		}
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions.append(" LIMIT ").append(start).append(",").append(limit);
		return conditions.toString();
	}

	@Override
	public List<String> loadFoundationList(int lineId) {
		return lineRankingDao.loadFoundationList(lineId);
	}

}
