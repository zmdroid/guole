package com.guole.service.postbox;

import com.guole.vo.MessageVO;

/**
 * 消息处理服务
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public interface PostboxService {

	/**
	 * 添加消息
	 * @param familyNo 家庭编号
	 * @param message   消息实体
	 */
	void addMessage(MessageVO message);
	
	/**
	 * 删除消息
	 * @param userId
	 * @param messageNo
	 */
	void delMessage(int userId,int messageNo);
	
	/**
	 * 分页获取消息ID列表
	 * @param familyNo
	 * @param pageIndex
	 * @return [idList,pageCount]
	 */
	Object[] getMessageList(int userId,int pageIndex);
	
	/**
	 * 通过家庭编号获取未读消息数量
	 * @param familyNo 家庭编号
	 * @return 家庭未读信息数量
	 */
	int getUnReaderNum(int userId);
	
	/**
	 * 将指定家庭的未读消息数量清零
	 * @param familyNo 家庭编号
	 */
	void resetUnReaderNum(int userId);
	
	/**
	 * 将指定家庭的未读消息数量+1
	 * @param familyNo 家庭编号
	 */
	void addUnReaderNum(int userId);
}
