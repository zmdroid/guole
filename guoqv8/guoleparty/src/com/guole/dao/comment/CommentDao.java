package com.guole.dao.comment;

import java.util.List;
import java.util.Map;

import com.guole.vo.CommentVO;
import com.guole.vo.MessageVO;


public interface CommentDao {
	/**
	 * 添加留言
	 * @param message 信息实体
	 * @return boolean 成功标识
	 */
	public int insertComment(CommentVO comment);
	
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
	public int queryCommentCount(int state);
	/**
	 * 获取指定页信息
	 * @param pageIndex
	 * @return
	 */
	public List<CommentVO> queryComment(Map<String,Object> params);
}
