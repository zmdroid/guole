package com.guole.service.comment;

import com.guole.vo.CommentVO;

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
	 * 添加消息
	 * @param familyNo 家庭编号
	 * @param message   消息实体
	 */
	boolean addComment(CommentVO comment);
	
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
	
}
