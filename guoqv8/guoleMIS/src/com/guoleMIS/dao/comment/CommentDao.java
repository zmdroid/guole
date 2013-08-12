package com.guoleMIS.dao.comment;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.CommentVO;

public interface CommentDao {
	
	/**
	 * 删除指定留言
	 * @param id
	 */
	public int delComment(int  commentId);

	/**
	 * 查询留言数量
	 * @param conditions
	 * @return
	 */
	public int queryCommentCount(Map map);
	/**
	 * 获取指定页信息
	 * @param pageIndex
	 * @return
	 */
	public List<CommentVO> queryAllComment(Map<String,Object> params);
	
	/**
	 * 回复留言信息
	 * 
	 */
	public int updateReplyComment(CommentVO commentVO);
	
	
}
