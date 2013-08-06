package com.guoleMIS.service.gift;

import com.guoleMIS.vo.GiftCardTypeVO;
import com.guoleMIS.vo.GiftCardVO;

public interface GiftCardService {

	/*****************礼品卡类型业务层*****************************/
	public boolean addUpdateGiftCardType(GiftCardTypeVO giftCardType);
	
	public GiftCardTypeVO getGiftCardTypeById(int id);

	public Object[] getGiftCardTypes(int page);
	
	public boolean delGiftCardTypeById(int id);
	
	public boolean modifyGiftCardTypeStateById(int state, int id);
	/*****************礼品卡类型业务层end*****************************/
	
	
	/*****************礼品卡业务层*****************************/
	public boolean addUpdateGiftCard(GiftCardVO giftCard);
	
	public GiftCardVO getGiftCardById(int id);
	
	public Object[] getGiftCards(int page);
	
	public boolean delGiftCardById(int id);
	
	public boolean modifyGiftCardStateById(int state, int id);
	/*****************礼品卡业务层end*****************************/
}
