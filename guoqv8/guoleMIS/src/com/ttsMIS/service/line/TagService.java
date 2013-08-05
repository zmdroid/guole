package com.ttsMIS.service.line;

import java.util.List;

import com.guoleMIS.vo.TagVO;

/**
 * 标签信息业务层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-05
 * @history  版本	修改者	   时间	修改内容
 */
public interface TagService {
	
	/**
     * 获取标签信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<TagVO> loadTags(TagVO tagVO,int page);
    
    /**
     * 加载所有有效标签
     * @return
     */
    public List<TagVO> loadAllTags();
    
    /**
     * 获取标签信息记录数
     * @param filter 查询条件
     * @return 
     */
    public int getTagInfosCount(TagVO tagVO);
    
    /**
     * 根据标签编号获取标签信息
     * @param id 标签编号
     * @return 
     */
    public TagVO getTagInfoById(int id);
    
    /**
     * 根据标签名称获取标签信息
     * @param name 标签名称
     * @return 
     */
    public boolean isExsits(String name,int id);
    
    /**
     * 添加标签信息
     * @param tagVO 标签信息
     * @return 
     */
    public boolean addTag(TagVO tagVO);
    
    /**
     * 更新标签信息
     * @param tagVO 标签信息
     * @return 
     */
    public boolean modifyTag(TagVO tagVO);
    
    /**
     * 删除标签信息
     * @param id 标签编号
     * @return 
     */
    public boolean removeTag(int id);
    
    /**
     * 恢复已删除的标签信息
     * @param id 标签编号
     * @return 
     */
    public boolean rebackTag(int id);

}
