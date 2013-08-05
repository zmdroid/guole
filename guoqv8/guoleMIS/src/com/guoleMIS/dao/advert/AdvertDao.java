package com.guoleMIS.dao.advert;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.AdvertVO;

public interface AdvertDao {

	int insertAdvert(AdvertVO infor);
	
	int updateAdvert(AdvertVO infor);
	
	int deleteAdvertById(int id);
	
	int updateAdvertStateById(Map map);
	
	AdvertVO getAdvertById(int id);
	
	List<AdvertVO> getAdverts(String paramter);
	int getAdvertsCount(String paramter);
}
