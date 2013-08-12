package com.guoleMIS.dao.info;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.InformationVO;

public interface InformationDao {

	int insertInformation(InformationVO infor);
	
	int updateInformation(InformationVO infor);
	
	int deleteInformationByinfoId(int id);
	
	int updateInformationStateById(Map map);
	
	InformationVO getInformationByinfoId(int id);
	
	List<InformationVO> getInformations(Map map);
	int getInformationsCount(int type);
}
