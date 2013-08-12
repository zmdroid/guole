package com.guoleMIS.service.advert;

import com.guoleMIS.vo.AdvertVO;


public interface AdvertService {

	Object[] getAdvertList(int page,int state);
	
	boolean crateAdvert(AdvertVO advertVO);
	
	AdvertVO getAdvertById(int id);
	
	boolean deleteAdvertById(int id);
	
	boolean modifyAdvertById(int id,int state);
	
	boolean updateAdvert(AdvertVO advertVO);
	
	boolean saveUpdateAdvert(AdvertVO advertVO);
}
