package com.ttsMIS.service.line.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.Validate;
import com.guoleMIS.vo.LineVO;
import com.ttsMIS.dao.line.LineDao;
import com.ttsMIS.service.line.LineService;

public class LineServiceImpl implements LineService{
	private LineDao lineDao;

	private static final Config config = Config.getInstance();
	private static Logger log = Logger.getLogger("linePlanFile");
	/**
	 * 获取旅游线路列表
	 * @return
	 * @throws Exception 
	 */
	@Override
	public List<LineVO> getLineList(String sqlChip, int start, int limit) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sqlChip", sqlChip);
		map.put("start", start);
		map.put("limit", limit);

		return lineDao.queryLineList(map);
	}
	
	/**
	 * 获取旅游线路列表大小
	 * @return
	 * @throws Exception 
	 */
	@Override
	public int getLineListSize(String sqlChip) throws Exception {
		return lineDao.queryLineListSize(sqlChip);
	}
	
	/**
	 * 根据ID查询线路信息列表
	 * @param lineId
	 * @return
	 * @throws Exception
	 */
	@Override
	public LineVO getLineInfoById(int lineId) throws Exception {
		return lineDao.queryLineInfoById(lineId);
	}
	
	/**
	 * 根据线路ID和供应商ID的查询线路信息列表
	 * @param lineId
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@Override
	public LineVO getLineInfoByUidAndId(int lineId, int userId) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("lineId", lineId);
		map.put("userId", userId);

		return lineDao.queryLineInfoByUidAndId(map);
	}
    
	/**
	 * 根据状态获取个人线路列表
	 * @param sqlChip
	 * @param start
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<LineVO> getLineListByStatus(String sqlChip, int start, int limit) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sqlChip", sqlChip);
		map.put("start", start);
		map.put("limit", limit);

		return lineDao.queryLineListByStatus(map);
	}
	
	/**
	 * 根据状态获取个人线路列表大小
	 * @param sqlChip
	 * @return
	 * @throws Exception
	 */
	@Override
	public int getLineListCountByStatus(String sqlChip) throws Exception {
		return lineDao.queryLineListCountByStatus(sqlChip);
	}
	
	/**
	 * 线路下架
	 * @throws Exception
	 */
	@Override
	public boolean lineOffShelf(int userId, String lineIds) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int lineCount = getIdsCount(lineIds);
		if (0 != lineCount) {
			map.put("userId", userId);
			map.put("lineIds", lineIds);
			map.put("state", Consts.LINE_STATE_ARTIFICIAL);

			int rows = lineDao.updateLineState(map);
			if (rows != lineCount) {
				throw new Exception();
			}

			return true;
		}
		
		return false;
	}

	/**
	 * 线路上架
	 * @throws Exception
	 */
	public boolean lineSelling(int userId, String lineIds) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int lineCount = getIdsCount(lineIds);
		if (0 != lineCount) {
			map.put("userId", userId);
			map.put("lineIds", lineIds);
			map.put("state", Consts.LINE_STATE_SELLING);

			int rows = lineDao.updateLineState(map);
			if (rows != lineCount) {
				throw new Exception();
			}

			return true;
		}
		
		return false;
	}
	
	/**
	 * 根据线路ID字符串获取包含的线路数量
	 * @param lineIds
	 * @return
	 */
	private int getIdsCount(String lineIds){
		if (Validate.isEmpty(lineIds)) {
			return 0;
		}

		int count = 0;
		for (String str : lineIds.split(",")) {
			if (Validate.isNumber(str)) {
				count += 1;
			}
		}
		
		return count;
	}
	
	/**
	 * 复制线路
	 * @throws Exception
	 */
	@Override
	public int copyLine(int lineId, int userId) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("lineId", lineId);

		if  (lineDao.inserLineForCopy(map) > 0) {
			map.put("newId", map.get("id"));
			lineDao.copyPlan(map);
			return Integer.parseInt(map.get("id") + "");
		}
		
		return 0;
	}
	
	/**
	 * 保存线路基本信息
	 * @throws Exception
	 */
	@Override
	public int saveLineBaseInfo(LineVO lineVO) throws Exception {
		// 如果是地接线路，设置大交通为空
		if (lineVO.getBusiType() == Consts.LINE_TYPE_NATIVE) {
			lineVO.setToTransport(null);
			lineVO.setFromTransport(null);
		}
		
		// 拷贝临时照片
		renameLinePics(lineVO.getPropics());

		lineDao.insertLineBaseInfo(lineVO);
		
		return lineVO.getId();
	}
	
	/**
	 * 保存线路图片
	 * @param userId
	 * @param lineId
	 * @param pics
	 * @return
	 * @throws Exception
	 */
	@Override
	public void saveLiePics(int userId, int lineId, String pics) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("lineId", lineId);
		map.put("propics", pics);

		lineDao.updateLinePics(map);

		// 拷贝临时照片
		renameLinePics(pics);
	}
	
	
	@Override
	public void terminateLinePlans(int lineId, String planIds) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("lineId", lineId);
		map.put("planIds", planIds);
		map.put("state", 0);
		lineDao.updateLinePlanState(map);
	}
	
	@Override
	public void openLinePlans(int lineId, String planIds, int supplierId)
			throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("lineId", lineId);
		map.put("planIds", planIds);
		map.put("state", 1);
		map.put("supplierId", supplierId);
		lineDao.updateLinePlanState(map);
	}

	/**
	 * 保存线路扩展信息
	 * @throws Exception
	 */
	@Override
	public void saveLineMoreInfo(LineVO lineInfo) throws Exception {
		String fileRoot = config.getString("resRootUrl")+config.getString("fileDir");
		//转移文件
		String lineResPath = config.getString("lineUrl");
		String tmpPath = config.getString("resTmp");
		File sFile = new File(fileRoot+tmpPath + "/" + lineInfo.getTravelDocPath());
		File dFile = new File(fileRoot+lineResPath + "/" + lineInfo.getTravelDocPath());
		if (sFile.exists()) {
			sFile.renameTo(dFile);
		}
		
		lineDao.updateLineMoreInfo(lineInfo);
	}
	
	/**
	 * 删除线路
	 * @param userId
	 * @param lineIds
	 * @throws Exception
	 */
	@Override
	public void deleteLines(int userId, String lineIds) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("lineIds", lineIds);

		lineDao.deleteLines(map);
	}

	/**
	 * 编辑线路基本信息
	 * @param lineInfo
	 * @throws Exception
	 */
	public void modifyLineInfo(LineVO lineInfo) throws Exception {
		// 如果是地接线路，设置大交通为空
		if (lineInfo.getBusiType() == Consts.LINE_TYPE_NATIVE) {
			lineInfo.setToTransport(null);
			lineInfo.setFromTransport(null);
		}
		
		LineVO line = lineDao.queryLineInfoById(lineInfo.getId());
		if(!line.getPropics().equals(lineInfo.getPropics())){
			// 拷贝临时照片
			renameLinePics(lineInfo.getPropics());
		}
		if(line.getTravelDocPath()!=null && !line.getTravelDocPath().equals(lineInfo.getTravelDocPath())){
			//转移文件
			String fileRoot = config.getString("resRootUrl")+config.getString("fileDir");
			//转移文件
			String lineResPath = config.getString("lineUrl");
			String tmpPath = config.getString("resTmp");
			File sFile = new File(fileRoot+tmpPath + "/" + lineInfo.getTravelDocPath());
			File dFile = new File(fileRoot+lineResPath + "/" + lineInfo.getTravelDocPath());
			if (sFile.exists()) {
				sFile.renameTo(dFile);
			}
		}

		lineDao.updateLineInfo(lineInfo);
		
	}
	
	/**
	 * 将线路临时照片copy到资源目录中
	 * @param pics
	 */
	private void renameLinePics(String pics) {
		String imgRoot = config.getString("resRootUrl")+config.getString("imageDir");
		String lineResPath = config.getString("lineUrl");
		String tmpPath = config.getString("resTmp");
		String[] imgs = pics.split(",");
		File sFile;
		File dFile;
		for (String pic : imgs){
			sFile = new File(imgRoot+tmpPath + "/" + pic);
			dFile = new File(imgRoot+lineResPath + "/" + pic);
			if (sFile.exists()) {
				sFile.renameTo(dFile);
			}
		}
	}
	
	/**
	 * 查询下架商品列表
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<LineVO> getOffShelfLineList(String sqlChip, int start, int limit) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sqlChip", sqlChip);
		map.put("start", start);
		map.put("limit", limit);
		
		return lineDao.queryOffShelfLineList(map);
	}
	
	/**
	 * 查询下架商品列表大小
	 * @return
	 * @throws Exception
	 */
	@Override
	public int getOffShelfLineListCount(String sqlChip) throws Exception {
		return lineDao.queryOffShelfLineListCount(sqlChip);
	}

	/**
	 * 更换主图
	 * @throws Exception
	 */
	public void changeFirstPic(int userId, int lineId, String pic) throws Exception {
		if (!pic.contains(",")) {
			pic = pic + ",";
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("lineId", lineId);
		map.put("pic", pic);

		lineDao.updateLineFirstPic(map);
	}
	

	/**
	 * 在线商品复制发布线路
	 * @throws Exception
	 */
	@Override
	public boolean copyLineToPublish(LineVO lineInfo) throws Exception {
		lineInfo.setState(Consts.LINE_STATE_SELLING);
		return lineDao.inserLineForCopyFromPublish(lineInfo) > 0;
	}
	
	/**
	 * 在线商品复制预售线路
	 * @throws Exception
	 */
	@Override
	public boolean copyLineToPreselling(LineVO lineInfo) throws Exception {
		lineInfo.setState(Consts.LINE_STATE_PRESELL);
		lineDao.inserLineForCopyFromPublish(lineInfo);
		System.out.println(lineInfo.getId());
		return true;
	}
	
	/**
	 * 根据DS查询线路信息
	 * @throws Exception
	 */
	@Override
	public List<LineVO> getLineByIds(String lineIds) throws Exception {
		return lineDao.queryLineByIds(lineIds);
	}
	
	
	/**
	 * 根据团期ID删除团期
	 * @return
	 * @throws Exception
	 */
	@Override
	public void deletePlanByIds(int lineId, String pIds) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("lineId",  lineId);
		map.put("pIds", pIds);

		int count = pIds.split(",").length;
		int row = lineDao.deletePlanByIds(map);
		if (count != row) {
			throw new Exception();
		}
	}
	
	public LineDao getLineDao() {
		return lineDao;
	}

	public void setLineDao(LineDao lineDao) {
		this.lineDao = lineDao;
	}

	@Override
	public void linePlanOffShelf() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
