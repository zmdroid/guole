package com.guole.dao.gift;

import java.util.List;
import java.util.Map;

import com.guole.vo.GiftCardTypeVO;

public interface GiftCardDao {

	/**
	 * 
	 * 获取礼品卡种类
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-02
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public List<GiftCardTypeVO> getGiftCardType(Map map);
	/**
	 * 
	 * 获取礼品卡种类总数
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-02
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public int getGiftCardTypeCount();
}
