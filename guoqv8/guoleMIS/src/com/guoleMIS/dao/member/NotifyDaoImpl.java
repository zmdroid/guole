package com.guoleMIS.dao.member;

import java.util.List;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.NotifyVO;

public class NotifyDaoImpl extends BaseDaoImpl implements NotifyDao {

	@Override
	public List<NotifyVO> loadNotifys(String conditions) {
		return sqlSessionTemplate.selectList("loadNotifys",conditions);
	}

	@Override
	public int getNotifyInfosCount(String conditions) {
		return sqlSessionTemplate.selectOne("getNotifyInfosCount",conditions);
	}

	@Override
	public boolean publishNotify(NotifyVO notifyVO) {
		return sqlSessionTemplate.insert("publishNotify",notifyVO) > 0;
	}

}
