package com.guole.service.groupbuy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guole.dao.groupbuy.GroupbuyDao;
import com.guole.util.Config;
import com.guole.vo.GroupbuyInfoVO;

/**
 * 团购商品业务处理服务
 * @author 005
 *
 */
public class GroupbuyServiceImpl implements GroupbuyService {

	private static final Config conf = Config.getInstance();
	private GroupbuyDao groupbuyDao;
	
	@Override
	public Object[] getGroupbuyInfos(int typeCode, int pageIndex) {
		// TODO Auto-generated method stub
		
		int pageSize = Integer.parseInt(conf.getString("pagesize"));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("typeCode", typeCode);
		int record = groupbuyDao.getGoopbuyInfocCount(map);
		int pageCount = record/pageSize;
		if(record%pageSize>0)pageCount++;
		if(pageIndex<1||pageIndex>pageCount)pageIndex=1;
		map.put("pageIndex", (pageIndex-1)*pageSize);
		map.put("pageSize", pageSize);
		List<GroupbuyInfoVO> list = groupbuyDao.getGroupbuyInfo(map);
		return new Object[]{record,pageCount,list};
	}

	@Override
	public GroupbuyInfoVO getGroupbuyInfo(int recordNo) {
		// TODO Auto-generated method stub
		return groupbuyDao.getGroupbuyInfoById(recordNo);
	}
	
	public GroupbuyDao getGroupbuyDao() {
		return groupbuyDao;
	}

	public void setGroupbuyDao(GroupbuyDao groupbuyDao) {
		this.groupbuyDao = groupbuyDao;
	}
}
