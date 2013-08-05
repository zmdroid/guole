package com.ttsMIS.dao.line.impl;

import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.TagVO;
import com.ttsMIS.dao.line.TagDao;

public class TagDaoImpl extends BaseDaoImpl implements TagDao {

	@Override
	public List<TagVO> loadTags(String conditions) {
		return sqlSessionTemplate.selectList("loadTags",conditions);
	}

	@Override
	public int getTagInfosCount(String conditions) {
		return sqlSessionTemplate.selectOne("getTagInfosCount",conditions);
	}

	@Override
	public TagVO getTagInfoById(int id) {
		return sqlSessionTemplate.selectOne("getTagInfoById",id);
	}

	@Override
	public int getTagInfoByName(Map params) {
		return sqlSessionTemplate.selectOne("getTagInfoByName",params);
	}

	@Override
	public boolean addTag(TagVO tagVO) {
		return sqlSessionTemplate.insert("addTag",tagVO) > 0;
	}

	@Override
	public boolean modifyTag(TagVO tagVO) {
		return sqlSessionTemplate.update("modifyTag",tagVO) > 0;
	}

	@Override
	public boolean removeTag(int id) {
		return sqlSessionTemplate.update("removeTag",id) > 0;
	}
	
	@Override
	public boolean rebackTag(int id) {
		return sqlSessionTemplate.update("rebackTag",id) > 0;
	}

}
