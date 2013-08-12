package com.guole.service.vip;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guole.dao.vip.VIPCardDao;
import com.guole.util.Config;
import com.guole.vo.VIPCardVO;

public class VIPCardServiceImpl implements VIPCardService {

	private static final Logger logger = Logger.getLogger(VIPCardServiceImpl.class);
	
	private VIPCardDao vipCardDao;
	
	private Config config = Config.getInstance();
	
	@Override
	public Object[] getVIPCards(int page) {
		// TODO Auto-generated method stub
		try {
			if(page<=0)page=1;
			int count = vipCardDao.getVIPCardsCount();
			int pageSize = Integer.parseInt(config.getString("pagesize"));
			int pageCount = count/pageSize;
			if(count%pageSize>0)pageCount++;
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("pageIndex", (page-1)*pageSize);
			map.put("pageSize", pageSize);
			List<VIPCardVO> list = vipCardDao.getVIPCards(map);
			return new Object[]{pageCount,list};
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("获取全部的VIP会员卡类型出错", e);
			return null;
		}
	}

	public VIPCardDao getVipCardDao() {
		return vipCardDao;
	}

	public void setVipCardDao(VIPCardDao vipCardDao) {
		this.vipCardDao = vipCardDao;
	}

}
