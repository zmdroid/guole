package com.guole.service.gift;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guole.dao.gift.GiftCardDao;
import com.guole.util.Config;
import com.guole.vo.GiftCardTypeVO;

public class GiftCardServiceImpl implements GiftCardService {

	private static final Logger logger = Logger.getLogger(GiftCardServiceImpl.class);
	
	private GiftCardDao giftCardDao;
	
	private Config config = Config.getInstance();
	
	@Override
	public Object[] getGiftCardType(int page) {
		// TODO Auto-generated method stub
		try {
			if(page<=0)page=1;
			int count = giftCardDao.getGiftCardTypeCount();
			int pageSize = Integer.parseInt(config.getString("pagesize"));
			int pageCount = count/pageSize;
			if(count%pageSize>0)pageCount++;
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("pageIndex", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<GiftCardTypeVO> list = giftCardDao.getGiftCardType(map);
			return new Object[]{pageCount,list};
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("获取全部的礼品卡类型出错", e);
			return null;
		}
	}

	public GiftCardDao getGiftCardDao() {
		return giftCardDao;
	}

	public void setGiftCardDao(GiftCardDao giftCardDao) {
		this.giftCardDao = giftCardDao;
	}

}
