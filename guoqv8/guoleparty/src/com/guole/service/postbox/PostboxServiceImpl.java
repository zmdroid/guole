package com.guole.service.postbox;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.guole.consts.Consts;
import com.guole.dao.notify.PostboxDao;
import com.guole.service.base.BaseServiceImpl;
import com.guole.util.Config;
import com.guole.vo.MessageVO;

public class PostboxServiceImpl extends BaseServiceImpl<Serializable> implements PostboxService{
	Logger logger = Logger.getLogger(PostboxServiceImpl.class);
	private PostboxDao postboxDao;
	
	private Config conf = Config.getInstance();
	
	@Override
	public void addMessage(MessageVO message) {
		Jedis jedis = null;
		try {
			int rs = postboxDao.insertMessage(message);
			if(rs>0){
				//添加家庭消息
				jedis = this.getJedis();
				//更新未读消息计数
				jedis.incr(String.format(Consts.POSTBOX_UNREAD_FORMAT,message.getReceiver()));
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			if(jedis != null)this.returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)this.closeJedis(jedis);
		}
		
	}

	@Override
	public void delMessage(int userId, int id) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("userId", userId);
		postboxDao.delMessage(params);
	}

	@Override
	public Object[] getMessageList(int userId, int pageIndex) {
		int count = postboxDao.queryMessageCount(userId);
		int pageSize = Integer.parseInt(conf.getString("pagesize"));
		int pageCount = count/pageSize;
		if(count%pageSize!=0)pageCount++;
		//计算页数有效性
		if(pageIndex>pageCount)pageIndex=pageCount;
		if(pageIndex<=0)pageIndex=1;
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("start", (pageIndex-1)*pageSize);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<MessageVO> rs = postboxDao.queryMessage(params);
		return new Object[]{pageCount,rs};
	}

	@SuppressWarnings("finally")
	@Override
	public int getUnReaderNum(int userId) {
		Jedis jedis = null;
		String unReader = "0";
		try{
			jedis = getJedis();
		    unReader = jedis.get(String.format(Consts.POSTBOX_UNREAD_FORMAT,userId));
			if(unReader == null){
				unReader = "0";
			}
		}catch(Exception e){
			if(jedis != null)returnBrokenJedis(jedis);
		}finally{
			if(jedis != null)closeJedis(jedis);
		    return Integer.parseInt(unReader);
		}
	}

	@Override
	public void resetUnReaderNum(int userId) {
		Jedis jedis = null;
		try{
			jedis = getJedis();
			jedis.set(String.format(Consts.POSTBOX_UNREAD_FORMAT,userId), "0");
		}catch(Exception e){
			if(jedis != null)returnBrokenJedis(jedis);
		}finally{
			if(jedis != null)closeJedis(jedis);
		}
	}

	@Override
	public void addUnReaderNum(int userId) {
		Jedis jedis = null;
		try{
			jedis = getJedis();
		    jedis.incr(String.format(Consts.POSTBOX_UNREAD_FORMAT,userId));
		}catch(Exception e){
			if(jedis != null)returnBrokenJedis(jedis);
		}finally{
			if(jedis != null)closeJedis(jedis);
		}
	}

	public PostboxDao getPostboxDao() {
		return postboxDao;
	}

	public void setPostboxDao(PostboxDao postboxDao) {
		this.postboxDao = postboxDao;
	}

	
	
}
