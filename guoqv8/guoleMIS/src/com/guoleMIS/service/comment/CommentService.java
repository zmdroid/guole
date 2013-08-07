package com.guoleMIS.service.comment;

import com.guoleMIS.vo.CommentVO;

/**
 * 消息处理服务
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface CommentService {

	
	/**
	 * 删除消息
	 * @param userId
	 * @param messageNo
	 */
	boolean delComment(int CommentId);
	
	/**
	 * 分页获取消息ID列表
	 * @param familyNo
	 * @param pageIndex
	 * @return [idList,pageCount]
	 */
	Object[] getCommentList(int pageIndex,int state);
	
	/**
	 * 回复留言信息
	 * 
	 */
	boolean replyComment(CommentVO commentVO);
	
}
