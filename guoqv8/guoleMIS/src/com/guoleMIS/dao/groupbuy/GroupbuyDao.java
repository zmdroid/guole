package com.guoleMIS.dao.groupbuy;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.GroupbuyInfoVO;

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
	
	int insertGroupbuyInfo(GroupbuyInfoVO groupbuyInfo);
	
	int updateGroupbuyInfo(GroupbuyInfoVO groupbuyInfo);
	
	/**
	 * 根据recordNo删除团购产品
	 */
	int delGroupbuyInfoByRecordNo(int recordNo);
	
	/**
	 * 更改团购产品的状态
	 */
	int updateGroupbuyInfoOnLine(Map map);
}
