package com.ttsMIS.service.line.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.util.Config;
import com.guoleMIS.vo.TagVO;
import com.ttsMIS.dao.line.TagDao;
import com.ttsMIS.service.line.TagService;

public class TagServiceImpl implements TagService {
	
	private final static Config config = Config.getInstance();
	
	public TagDao tagDao;

	@Override
	public List<TagVO> loadTags(TagVO tagVO,int page) {
		return tagDao.loadTags(getConditions(tagVO,page));
	}
	
	@Override
	public List<TagVO> loadAllTags() {
		return tagDao.loadTags("status='1'");
	}

	@Override
	public int getTagInfosCount(TagVO tagVO) {
		return tagDao.getTagInfosCount(getConditions(tagVO,-1));
	}

	private String getConditions(TagVO tagVO,int page){
		StringBuffer conditions = new StringBuffer(" 1 = 1 ");
		//标签状态
		if(tagVO != null && !tagVO.getStatus().equals("-1")){
			conditions.append(" AND status='").append(tagVO.getStatus()).append("'");
		}
		//标签名称
		if(tagVO != null && tagVO.getName() != null && !tagVO.getName().equals("")){
			conditions.append(" AND name LIKE '%").append(tagVO.getName()).append("%'");
		}
		conditions.append(" ORDER BY id DESC ");
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions.append(" LIMIT ").append(start).append(",").append(limit);
		return conditions.toString();
	}
	
	@Override
	public TagVO getTagInfoById(int id) {
		return tagDao.getTagInfoById(id);
	}

	@Override
	public boolean isExsits(String name,int id) {
		Map params = new HashMap();
		params.put("name", name);
		params.put("id", id);
		return tagDao.getTagInfoByName(params) > 0;
	}

	@Override
	public boolean addTag(TagVO tagVO) {
		return tagDao.addTag(tagVO);
	}

	@Override
	public boolean modifyTag(TagVO tagVO) {
		return tagDao.modifyTag(tagVO);
	}

	@Override
	public boolean removeTag(int id) {
		return tagDao.removeTag(id);
	}
	
	@Override
    public boolean rebackTag(int id){
		return tagDao.rebackTag(id);
    }
	
	public TagDao getTagDao() {
		return tagDao;
	}

	public void setTagDao(TagDao tagDao) {
		this.tagDao = tagDao;
	}

}
