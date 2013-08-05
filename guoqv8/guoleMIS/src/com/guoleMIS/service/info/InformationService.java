package com.guoleMIS.service.info;

import com.guoleMIS.vo.InformationVO;

public interface InformationService {

	Object[] getInformationList(int page,int type);
	
	boolean crateInformation(InformationVO information);
	
	InformationVO getInformationById(int id);
	
	boolean deleteInformationById(int id);
	
	boolean updateInformation(InformationVO information);
	
	boolean saveUpdateInfo(InformationVO information);
	
	boolean modifyInformationStateById(int id,int state);
}
