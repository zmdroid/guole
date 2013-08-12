package com.guole.service.gift;

import java.util.List;
import java.util.Map;

import com.guole.vo.GiftCardTypeVO;
import com.guole.vo.GiftCardVO;

public interface GiftCardService {

	/**
	 * 获取全部的礼品卡类型
	 */
	public Object[] getGiftCardType(int page);

	/**
	 * 获取全部的礼品卡类型
	 */
	public GiftCardTypeVO getGiftCardTypeByTypeId(int cardId);

	/**
	 * 根据礼品卡编号和礼品卷密码 及其状态获取礼品卡信息
	 */
	public GiftCardVO getGiftCardInfo(GiftCardVO giftCardVO);
	/**
	 * 修改礼品卡状态
	 */
	public boolean modifyGiftCardState(GiftCardVO giftCardVO);
}
