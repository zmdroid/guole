package com.guole.dao.groupbuy;

import java.util.List;
import java.util.Map;

import com.guole.vo.GroupbuyInfoVO;

public interface GroupbuyDao {
	/**
	 * 获取团购商品
	 * @param type 商品类型
	 * @param pageIndex 页码
	 * @return
	 */
	public List<GroupbuyInfoVO> getGroupbuyInfo(Map map);
	
	/**
	 * 获取团购商品数量
	 * @param type 商品类型
	 * @return
	 */
	public int getGoopbuyInfocCount(Map map);
	
	/**
	 * 根据编号获取团购产品信息
	 * @param recordNo
	 * @return
	 */
	public GroupbuyInfoVO getGroupbuyInfoById(int recordNo);
	
}
