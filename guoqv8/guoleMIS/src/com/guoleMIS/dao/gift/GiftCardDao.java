package com.guoleMIS.dao.gift;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.GiftCardTypeVO;
import com.guoleMIS.vo.GiftCardVO;

public interface GiftCardDao {

	/****************礼品卡类型Dao操作*****************************/
	int insertGiftCardType(GiftCardTypeVO giftCardTypeVO);
	
	int updateGiftCardType(GiftCardTypeVO giftCardTypeVO);
	
	GiftCardTypeVO qurGifyCardTypeById(int id);
	
	List<GiftCardTypeVO> getGiftCardTypes(Map map);
	int getGiftCardTypesCount();

	int delGiftCardTypeById(int id);
	int modifyGiftCardTypeStateById(Map map);
	/****************礼品卡类型Dao操作end*****************************/
	
	
	/****************礼品卡Dao操作*****************************/
	
	int insertGiftCard(GiftCardVO giftCardVO);
	
	int updateGiftCard(GiftCardVO giftCardVO);
	
	GiftCardVO qurGifyCardById(int id);
	
	List<GiftCardVO> getGiftCards(Map map);
	int getGiftCardsCount();
	
	int delGiftCardById(int id);
	int modifyGiftCardStateById(Map map);
	
	/****************礼品卡Dao操作end*****************************/
}
