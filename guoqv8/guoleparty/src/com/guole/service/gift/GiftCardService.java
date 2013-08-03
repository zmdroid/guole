package com.guole.service.gift;

import java.util.List;

import com.guole.vo.GiftCardTypeVO;

public interface GiftCardService {

	/**
	 * 获取全部的礼品卡类型
	 */
	public Object[] getGiftCardType(int page);

}
