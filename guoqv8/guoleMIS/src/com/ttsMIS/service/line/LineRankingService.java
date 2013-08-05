package com.ttsMIS.service.line;

import java.util.List;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.LineVO;

/**
 * 线路推广业务层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-26
 * @history  版本	修改者	   时间	修改内容
 */
public interface LineRankingService {
	
	/**
     * 获取线路推广榜单最大排序号
     * @return 
     */
    public int getLineRankingMaxSortNo();
    
    /**
     * 获取线路
     * @param lineVO 查询条件
     * @param page 页码
     * @return 
     */
    public List<LineVO> loadLineList(LineVO lineVO,int page);
    
    /**
     * 获取线路数
     * @return 
     */
    public int getLineCount(LineVO lineVO);
    
    /**
     * 获取线路推广榜单
     * @param filter 查询条件
     * @return 
     */
    public List<LineVO> loadLineRanking(int page);
    
    /**
     * 获取线路推广列表
     * @param filter 查询条件
     * @return 
     */
    public List<LineVO> loadAllRankingLine();
    
    /**
     * 获取线路団期列表
     * @param lineId 线路编号
     * @return 
     */
    public List<String> loadFoundationList(int lineId);
    
    /**
     * 获取线路推广榜单记录数
     * @param filter 查询条件
     * @return 
     */
    public int getRankingCount();
    
    /**
	 * 榜单中该线路推广是否已存在
	 * @param lineId   线路编号
	 */
	public boolean isLineExists(int lineId);
	
	/**
	 * 添加榜单线路推广
	 * @param lineIds   线路编号,多个以逗号分隔
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean addRankingLine(String lineIds);
    
	/**
	 * 更新榜单中的顺序
	 * @param id   记录编号
	 * @param sortNo   记录编号
	 * @param oldSortNo   记录编号
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean resetLineRankingSort(int id,int sortNo,int oldSortNo);
	
	/**
	 * 删除线路推广榜单中的供应商
	 * @param id
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean removeRankingLine(int id);
}
