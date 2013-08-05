package com.ttsMIS.action.line;

import java.util.List;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;

import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.TagVO;
import com.opensymphony.xwork2.ActionSupport;
import com.ttsMIS.service.line.TagService;

/**
 * 标签管理Action
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-05
 * @history  版本	修改者	   时间	修改内容
 */
public class TagAction extends ActionSupport{
	
	private static final long serialVersionUID = 1415146777060554880L;

	private final static Logger logger = Logger.getLogger(TagAction.class);
	
	public TagService tagService;
	
	public TagVO tagVO;
	
	public int page;
	
	public int id;
	
	private String result;
	
	private final static Config config = Config.getInstance();
	
	/**
	 *获取标签列表
	 */
	public void loadTags(){
		result = "";
		try{
			List<TagVO> tags = tagService.loadTags(tagVO,page);
			int totalCount = tagService.getTagInfosCount(tagVO);
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(tags != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			result = "{\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(tags);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取标签出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 加载所有有效标签
	 */
	public void loadAllTags(){
		String rs = JSONArray.fromObject(tagService.loadAllTags()).toString();
		ResponseUtil.sendResult(rs);
	}
	
	/**
	 *添加标签信息
	 */
	public void addTag(){
		try{
			if(tagService.isExsits(tagVO.getName(),tagVO.getId())){
				result = "EXISTS";
			}else{
			    result = (tagService.addTag(tagVO) ? "SUCCESS" :"ERROR");
			}
		} catch (Exception e) {
			logger.error("添加标签信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *获取标签详细信息
	 */
	public String editTag(){
		try{
			tagVO = tagService.getTagInfoById(id);
			return SUCCESS;
		} catch (Exception e) {
			logger.error("获取标签详细信息出错!", e);
			return ERROR;
		}
	}
	
	/**
	 *更新标签信息
	 */
	public void modifyTag(){
		try{
			if(tagService.isExsits(tagVO.getName(),tagVO.getId())){
				result = "EXISTS";
			}else{
			    result = (tagService.modifyTag(tagVO) ? "SUCCESS" :"ERROR");
			}
		} catch (Exception e) {
			logger.error("更新标签信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *删除标签信息
	 */
	public void removeTag(){
		try{
			result = (tagService.removeTag(id) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("删除标签信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *恢复已删除的标签信息
	 */
	public void rebackTag(){
		try{
			result = (tagService.rebackTag(id) ? "SUCCESS" :"ERROR");
		} catch (Exception e) {
			logger.error("删除标签信息出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}

	public TagService getTagService() {
		return tagService;
	}

	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

	public TagVO getTagVO() {
		return tagVO;
	}

	public void setTagVO(TagVO tagVO) {
		this.tagVO = tagVO;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
