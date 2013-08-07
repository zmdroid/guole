package com.guoleMIS.service.groupbuy;

import com.guoleMIS.vo.GroupbuyInfoVO;


public interface GroupbuyService {

	/**
	 * 获取团购商品
	 * @param type 商品类型
	 * @param maxPrice 页码
	 * @return
	 */
	public Object[] getGroupbuyInfos(int onLine,int typeId,int pageIndex);
	
	/**
	 * 根据编号获取团购产品信息
	 * @param recordNo
	 * @return
	 */
	public GroupbuyInfoVO getGroupbuyInfo(int recordNo);
	
	/**
	 * 保存或更新团购信息
	 * 
	 */
	public boolean saveUpdateGroupbuyInfo(GroupbuyInfoVO groupbuyInfo);
	
	/**
	 * 根据Id删除团购商品
	 * 
	 */
	public boolean delGroupbuyInfoByRecordNo(int recordNo);
	
	/**
	 * 更改团购商品的状态
	 */
	public boolean modifyGroupbuyInfoOnLine(int recordNo,int onLine);
}
