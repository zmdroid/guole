package com.ttsMIS.dao.line;

import java.util.List;
import java.util.Map;

import com.guoleMIS.vo.LineVO;
import com.guoleMIS.vo.MemberInfoVO;

/**
 * 线路推广持久层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-26
 * @history  版本	修改者	   时间	修改内容
 */
public interface LineRankingDao {
	
    /**
     * 获取线路
     * @param condition 查询条件
     * @return 
     */
    public List<LineVO> loadLineList(String condition);
    
    /**
     * 获取线路団期列表
     * @param lineId 线路编号
     * @return 
     */
    public List<String> loadFoundationList(int lineId);
    
    /**
     * 获取线路数
     * @return 
     */
    public int getLineCount(String condition);
	
    /**
     * 获取线路推广榜单最大排序号
     * @return 
     */
    public int getLineRankingMaxSortNo();
    
    /**
     * 获取线路推广榜单
     * @param filter 查询条件
     * @return 
     */
    public List<LineVO> loadLineRanking(String conditions);
    
    /**
	 * 榜单中该线路推广是否已存在
	 * @param lineId   线路编号
	 */
	public int isLineExists(int lineId);
	
	/**
	 * 添加榜单线路推广
	 * @param lineId   线路编号
	 */
	public boolean addRankingLine(int lineId);
    
	/**
	 * 更新线路推广榜单中的排序号,减
	 * @param id
	 */
	public boolean updateLineRankingSortNo(int id);
	
	/**
	 * 更新榜单中的排序号,减
	 * @param params
	 */
	public boolean updateLineRankingSort(Map params);
	
	/**
	 * 更新当前记录在榜单中的排序号,减
	 * @param params
	 * @param pid
	 */
	public boolean updateRankingSelfSortNo(Map params);
	
	/**
	 * 更新榜单中的排序号,加
	 * @param params
	 */
	public boolean updateLineSortNo(Map params);
	
	/**
	 * 删除线路推广榜单中的供应商
	 * @param id
	 */
	public boolean removeRankingLine(int id);
    
    /**
     * 获取线路推广榜单记录数
     * @param filter 查询条件
     * @return 
     */
    public int getRankingCount();

}
