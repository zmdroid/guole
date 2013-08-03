package com.guole.service.comment;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.guole.consts.Consts;
import com.guole.dao.comment.CommentDao;
import com.guole.dao.notify.PostboxDao;
import com.guole.util.Config;
import com.guole.vo.CommentVO;
import com.guole.vo.MessageVO;

public class CommentServiceImpl  implements CommentService{
	Logger logger = Logger.getLogger(CommentServiceImpl.class);
	
	private CommentDao commentDao;
	
	private Config conf = Config.getInstance();

	@Override
	public boolean addComment(CommentVO comment) {
		// TODO Auto-generated method stub
		return commentDao.insertComment(comment)>0;
	}

	@Override
	public boolean delComment(int commentId) {
		// TODO Auto-generated method stub
		return commentDao.delComment(commentId)>0;
	}

	@Override
	public Object[] getCommentList(int pageIndex, int state) {
		// TODO Auto-generated method stub
		int record = commentDao.queryCommentCount(state);
		int pageSize = Integer.parseInt(conf.getString("pagesize"));
		int pageCount = record/pageSize;
		if(record%pageSize>0)pageCount++;
		if(pageIndex>pageCount)pageIndex=1;
		if(pageIndex<=0)pageIndex=1;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageIndex", (pageIndex-1)*pageSize);
		map.put("pageSize", pageSize);
		map.put("state", state);
		List<CommentVO> list = commentDao.queryComment(map);
		return new Object[]{record,pageCount,list};
	}

	public CommentDao getCommentDao() {
		return commentDao;
	}

	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}

}
