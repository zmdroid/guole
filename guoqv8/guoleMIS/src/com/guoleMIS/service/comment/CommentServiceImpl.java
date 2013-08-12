package com.guoleMIS.service.comment;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.dao.comment.CommentDao;
import com.guoleMIS.util.Config;
import com.guoleMIS.vo.CommentVO;

public class CommentServiceImpl  implements CommentService{
	Logger logger = Logger.getLogger(CommentServiceImpl.class);
	
	private CommentDao commentDao;
	
	private Config conf = Config.getInstance();

	@Override
	public boolean delComment(int commentId) {
		// TODO Auto-generated method stub
		return commentDao.delComment(commentId)>0;
	}

	@Override
	public Object[] getCommentList(int pageIndex, int replyState) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("replyState", replyState);
		int record = commentDao.queryCommentCount(map);
		int pageSize = Integer.parseInt(conf.getString("page.size"));
		int pageCount = record/pageSize;
		if(record%pageSize>0)pageCount++;
		if(pageIndex>pageCount)pageIndex=1;
		if(pageIndex<=0)pageIndex=1;
		map.put("pageIndex", (pageIndex-1)*pageSize);
		map.put("pageSize", pageSize);
		List<CommentVO> list = commentDao.queryAllComment(map);
		return new Object[]{record,pageCount,list};
	}

	
	@Override
	public boolean replyComment(CommentVO commentVO) {
		// TODO Auto-generated method stub
		try {
			return commentDao.updateReplyComment(commentVO)>0;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			logger.error("回复客户留言出错", e);
			return false;
		}
	}

	public CommentDao getCommentDao() {
		return commentDao;
	}

	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}

}
