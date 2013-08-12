package com.guole.dao.notify;

import java.util.List;
import java.util.Map;

import com.guole.dao.base.BaseDaoImpl;
import com.guole.vo.MessageVO;

public class PostboxDaoImpl extends BaseDaoImpl implements PostboxDao {
	
	@Override
	public int insertMessage(MessageVO message) {
		return 0;
	}

	@Override
	public void delMessage(Map<String,Object> params) {
	}

	@Override
	public int queryMessageCount(int userId) {
		return this.sqlSessionTemplate.selectOne("queryMessageCount",userId);
	}

	@Override
	public List<MessageVO> queryMessage(Map<String,Object> params) {
		return this.sqlSessionTemplate.selectList("queryMessage",params);
	}

	
	
}
