package com.guole.service.linkaddr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guole.dao.linkaddr.LinkAddrDao;
import com.guole.util.Config;
import com.guole.vo.LinkAddrVO;

public class LinkAddrServiceImpl implements LinkAddrService {

	private LinkAddrDao linkAddrDao;
	
	private static final Config config = Config.getInstance();
	
	@Override
	public boolean addUpdateLinkAddr(LinkAddrVO linkAddrVO) {
		// TODO Auto-generated method stub
		if(null!=linkAddrVO.getId()&&linkAddrVO.getId()>0){
			return linkAddrDao.updateLinkAddr(linkAddrVO)>0;
		}else{
			return linkAddrDao.insertLinkAddr(linkAddrVO)>0;
		}
	}

	@Override
	public boolean deleteLinkAddr(LinkAddrVO linkAddrVO) {
		// TODO Auto-generated method stub
		return linkAddrDao.deleteLinkAddr(linkAddrVO)>0;
	}

	@Override
	public Object[] getLinkAddrByUserId(int userId, int page) {
		// TODO Auto-generated method stub
		int pageSize = Integer.parseInt(config.getString("pagesize"));
		int record = linkAddrDao.getLinkAddrCountByUserId(userId);
		int pageCount = record/pageSize;
		if(record%pageSize>0)pageCount++;
		if(page>pageCount||page<=0)page=1;
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		map.put("pageIndex", (page-1)*pageSize);
		map.put("pageSize", pageSize);
		List<LinkAddrVO> lists = linkAddrDao.getLinkAddrsByUserId(map);
		return new Object[]{record,pageCount,lists};
	}

	public LinkAddrDao getLinkAddrDao() {
		return linkAddrDao;
	}

	public void setLinkAddrDao(LinkAddrDao linkAddrDao) {
		this.linkAddrDao = linkAddrDao;
	}
	

}
