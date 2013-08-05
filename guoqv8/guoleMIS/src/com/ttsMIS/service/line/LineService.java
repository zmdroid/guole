package com.ttsMIS.service.line;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.LineVO;

public interface LineService {
	/**
	 * 获取旅游线路列表
	 * @return
	 * @throws Exception 
	 */
	public List<LineVO> getLineList(String sqlChip, int start, int limit) throws Exception;
	
	/**
	 * 获取旅游线路列表大小
	 * @return
	 * @throws Exception 
	 */
	public int getLineListSize(String sqlChip) throws Exception;
	
	/**
	 * 根据ID查询线路信息列表
	 * @param lineId
	 * @return
	 * @throws Exception
	 */
	public LineVO getLineInfoById(int lineId) throws Exception;
	
	/**
	 * 根据线路ID和供应商ID的查询线路信息列表
	 * @param lineId
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public LineVO getLineInfoByUidAndId(int lineId, int userId) throws Exception;
    
	
	/**
	 * 根据状态获取个人线路列表
	 * @param sqlChip
	 * @param start
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	public List<LineVO> getLineListByStatus(String sqlChip, int start, int limit) throws Exception;
	
	/**
	 * 根据状态获取个人线路列表大小
	 * @param sqlChip
	 * @return
	 * @throws Exception
	 */
	public int getLineListCountByStatus(String sqlChip) throws Exception;
	
	/**
	 * 线路下架
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean lineOffShelf(int userId, String lineIds) throws Exception;
	
	/**
	 * 线路上架
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean lineSelling(int userId, String lineIds) throws Exception;
	
	/**
	 * 复制线路
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public int copyLine(int lineId, int userId) throws Exception;
	
	/**
	 * 保存线路基本信息
	 * @throws Exception
	 */
	public int saveLineBaseInfo(LineVO lineVO) throws Exception;
	
	/**
	 * 保存线路图片
	 * @param userId
	 * @param lineId
	 * @param pics
	 * @return
	 * @throws Exception
	 */
	public void saveLiePics(int userId, int lineId, String pics) throws Exception;
	
	
	/**
	 * 终止出团计划
	 * @param lineId
	 * @param planIds
	 * @throws Exception
	 */
	public void terminateLinePlans(int lineId,String planIds)throws Exception;
	public void openLinePlans(int lineId,String planIds,int supplierId)throws Exception;
	
	/**
	 * 保存线路扩展信息
	 * @throws Exception
	 */
	public void saveLineMoreInfo(LineVO lineInfo) throws Exception;
	
	/**
	 * 删除线路
	 * @param userId
	 * @param lineIds
	 * @throws Exception
	 */
	public void deleteLines(int userId, String lineIds) throws Exception;
	
	/**
	 * 编辑线路基本信息
	 * @param lineInfo
	 * @throws Exception
	 */
	public void modifyLineInfo(LineVO lineInfo) throws Exception;
	
	/**
	 * 查询下架商品列表
	 * @return
	 * @throws Exception
	 */
	public List<LineVO> getOffShelfLineList(String sqlChip, int start, int limit) throws Exception;
	
	/**
	 * 查询下架商品列表大小
	 * @return
	 * @throws Exception
	 */
	public int getOffShelfLineListCount(String sqlChip) throws Exception;
	
	/**
	 * 更换主图
	 * @throws Exception
	 */
	public void changeFirstPic(int userId, int lineId, String pic) throws Exception;
	
	
	/**
	 * 在线商品复制发布线路
	 * @throws Exception
	 */
	public boolean copyLineToPublish(LineVO lineInfo) throws Exception;
	
	/**
	 * 在线商品复制预售线路
	 * @throws Exception
	 */
	public boolean copyLineToPreselling(LineVO lineInfo) throws Exception;
	
	/**
	 * 根据DS查询线路信息
	 * @throws Exception
	 */
	public List<LineVO> getLineByIds(String lineIds) throws Exception;
	
	/**
	 * 
	 * 下架超过当前时间的出团计划
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-7-9
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void linePlanOffShelf() throws Exception;

	/**
	 * 根据团期ID删除团期
	 * @return
	 * @throws Exception
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public void deletePlanByIds(int lineId, String pIds) throws Exception;
}
