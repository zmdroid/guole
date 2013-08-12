package com.guoleMIS.service.member;

import java.io.Serializable;
import java.util.List;
import redis.clients.jedis.Jedis;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.dao.member.NotifyDao;
import com.guoleMIS.service.base.BaseServiceImpl;
import com.guoleMIS.util.Config;
import com.guoleMIS.vo.NotifyVO;

public class NotifyServiceImpl extends BaseServiceImpl<Serializable> implements NotifyService {
	
	private final static Config config = Config.getInstance();
   
	public NotifyDao notifyDao;

	@Override
	public List<NotifyVO> loadNotifys(NotifyVO notifyVO,int page) {
		return notifyDao.loadNotifys(getConditions(notifyVO,page));
	}

	@Override
	public int getNotifyInfosCount(NotifyVO notifyVO) {
		return notifyDao.getNotifyInfosCount(getConditions(notifyVO,-1));
	}
    
	private String getConditions(NotifyVO notifyVO,int page){
		StringBuffer conditions = new StringBuffer(" 1 = 1 ");
		//消息类型
		if(notifyVO != null && !notifyVO.getType().equals("-1")){
			conditions.append(" AND notify.type='").append(notifyVO.getType()).append("'");
		}
		//发送起始时间
		if(notifyVO != null && notifyVO.getStartDate() != null && !notifyVO.getStartDate().equals("")){
			conditions.append(" AND DATE_FORMAT(notify.publishTime,'%Y-%m-%d') >= '").append(notifyVO.getStartDate()).append("'");
		}
		//发送截止时间
		if(notifyVO != null && notifyVO.getEndDate() != null && !notifyVO.getEndDate().equals("")){
			conditions.append(" AND DATE_FORMAT(notify.publishTime,'%Y-%m-%d') <= '").append(notifyVO.getEndDate()).append("'");
		}
		conditions.append(" ORDER BY publishTime DESC ");
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions.append(" LIMIT ").append(start).append(",").append(limit);
		return conditions.toString();
	}
		
	@Override
	public boolean publishNotify(String receivers, String type, int fromBy,String content) {
		boolean success = true;
		NotifyVO notifyVO;
		String[] receiverArray = receivers.split(",");
		int size = receiverArray.length;
//		Jedis jedis = this.getJedis();
		for(int index = 0; index < size; index++ ){
			notifyVO = new NotifyVO();
			notifyVO.setContent(content);
			notifyVO.setType(type);
			notifyVO.setFromBy(fromBy);
			notifyVO.setReceiver(Integer.parseInt(receiverArray[index]));
			if(!notifyDao.publishNotify(notifyVO)){
				success = false;
				break;
			}else{
				//更新未读消息计数
				//jedis.incr(String.format(Consts.POSTBOX_UNREAD_FORMAT,notifyVO.getReceiver()));
			}
		}
		return success;
	}
    
	public NotifyDao getNotifyDao() {
		return notifyDao;
	}

	public void setNotifyDao(NotifyDao notifyDao) {
		this.notifyDao = notifyDao;
	}
}
