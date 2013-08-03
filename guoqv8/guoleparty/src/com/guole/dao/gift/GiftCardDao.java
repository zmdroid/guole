package com.guole.dao.gift;

import java.util.List;
import java.util.Map;

import com.guole.vo.GiftCardTypeVO;
import com.guole.vo.GiftCardVO;

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
	
	/**
	 * 
	 * 根据CardId获取礼品卡类型实体
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-02
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public GiftCardTypeVO getGiftCardTypeById(int id);
	
	/**
	 * 
	 * 根据 cardNum pwd state 获取礼品卡
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-02
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public GiftCardVO getGiftCardInfo(GiftCardVO giftCardVO);
	/**
	 * 
	 * 使用礼品卡
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-02
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public int updateGiftCardInfo(GiftCardVO giftCardVO);
}
