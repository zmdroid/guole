package com.ttsMIS.dao.line;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.LineVO;


public interface LineDao {
	/**
	 * 查询旅游线路列表
	 */
	public List<LineVO> queryLineList(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 查询旅游线路列表大小
	 */
	public int queryLineListSize(String sqlChip) throws Exception;
	
	
	/**
	 * 根据线路编号查询线路信息
	 * @param lineId 线路编号
	 * @return
	 * @throws Exception
	 */
	public LineVO queryLineInfoById(int lineId) throws Exception;
	
	/**
	 * 根据线路ID和供应商ID的查询线路信息列表
	 * @param lineId
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public LineVO queryLineInfoByUidAndId(HashMap<String, Object> map) throws Exception;
	

	/**
	 * 查询个人线路列表
	 * @return
	 * @throws Exception
	 */
	public List<LineVO> queryLineListByStatus(HashMap<String, Object> map) throws Exception;

	/**
	 * 查询个人线路列表大小
	 * @return
	 * @throws Exception
	 */
	public int queryLineListCountByStatus(String sqlChip) throws Exception;
	
	/**
	 * 更新线路状态
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int updateLineState(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 复制线路
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int inserLineForCopy(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 复制线路出团计划
	 * @param map
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public void copyPlan(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 插入线路基本信息
	 * @throws Exception
	 */
	public void insertLineBaseInfo(LineVO lineVO) throws Exception;
	
	/**
	 * 更新线路图片
	 * @throws Exception
	 */
	public void updateLinePics(HashMap<String, Object> map) throws Exception;
	
	
	/**
	 * 更新指定出团计划的状态
	 * @param map
	 * @throws Exception
	 */
	public void updateLinePlanState(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 更新线路扩展信息
	 * @param lineInfo
	 * @throws Exception
	 */
	public void updateLineMoreInfo(LineVO lineInfo) throws Exception;
	
	/**
	 * 删除线路
	 * @throws Exception
	 */
	public void deleteLines(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 更新线路所有信息
	 * @param lineInfo
	 * @throws Exception
	 */
	public void updateLineInfo(LineVO lineInfo) throws Exception;
	
	/**
	 * 查询下架商品列表
	 * @return
	 * @throws Exception
	 */
	public List<LineVO> queryOffShelfLineList(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 查询下架商品列表大小
	 * @return
	 * @throws Exception
	 */
	public int queryOffShelfLineListCount(String sqlChip) throws Exception;
	
	/**
	 * 更换主图
	 * @throws Exception
	 */
	public void updateLineFirstPic(HashMap<String, Object> map) throws Exception;
	
	
	/**
	 * 在线商品复制线路
	 * @throws Exception
	 */
	public int inserLineForCopyFromPublish(LineVO lineInfo) throws Exception;
	
	/**
	 * 根据IDS查询线路信息
	 * @throws Exception
	 */
	public List<LineVO> queryLineByIds(String lineIds) throws Exception;
	
	/**
	 * 手工下架
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int offShelfLine(HashMap<String, Object> map) throws Exception;
	
	public List<LineVO> getLineByState(int state) throws Exception;
	
	
	/**
	 * 根据出团计划Id关闭该出团计划
	 * @param planId
	 * @throws Exception
	 */
	public int updateLinePlanStateById(int planId) throws Exception;
	
	/**
	 * 根据线路Id对线路进行下架
	 * @param lineId
	 * @throws Exception
	 */
	public int updateLineStateByLineId(int lineId) throws Exception;
	
	/**
	 * 根据团期ID删除团期
	 * @return
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
	public int deletePlanByIds(HashMap<String, Object> map) throws Exception;
}
