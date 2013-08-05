package com.guole.service.groupbuy;

import java.util.List;

import com.guole.dao.groupbuy.GroupbuyDao;
import com.guole.vo.GroupbuyInfoVO;


public interface GroupbuyService {

	/**
	 * 获取团购商品
	 * @param type 商品类型
	 * @param maxPrice 页码
	 * @return
	 */
	public Object[] getGroupbuyInfos(int typeId,int pageIndex);
	
	/**
	 * 根据编号获取团购产品信息
	 * @param recordNo
	 * @return
	 */
	public GroupbuyInfoVO getGroupbuyInfo(int recordNo);
	
}
