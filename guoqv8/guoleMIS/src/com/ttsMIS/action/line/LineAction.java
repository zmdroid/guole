package com.ttsMIS.action.line;

import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.LineQueryVO;
import com.guoleMIS.vo.LineStateQueryVO;
import com.guoleMIS.vo.LineVO;
import com.guoleMIS.vo.ManagerVO;
import com.opensymphony.xwork2.ActionSupport;
import com.ttsMIS.service.line.LineService;

public class LineAction extends ActionSupport implements SessionAware{

	private static final long serialVersionUID = 1415146777060554880L;

	//日志接口
	private final static Logger logger = Logger.getLogger(LineAction.class);
	
	private final static Config config = Config.getInstance();
	private String result;
	
	/**
	 * 注入旅游线路模型
	 */
	private LineService lineService;

	private LineQueryVO lineQueryVO;

	private List<LineVO> lines;
	
	/**
	 * 开始
	 */
	private int start;
	
	/**
	 * 线路列表总条数
	 */
	private int totalCount;
	
	/**
	 * 线路列表每页显示条数
	 */
	private int limit;
	
	/**
	 * 线路编号
	 */
	private int lineId;
	
	/**
	 * 线路信息
	 */
	private LineVO lineInfo;

	
	/**
	 * 个人线路列表查询VO
	 */
	private LineStateQueryVO lineStateQueryVO;
	
	private Map<String, Object> session;
	
	/**
	 * 管理中心查看线路详细时传入，表示来自那个页面的请求
	 */
	private String fromPage;

	/**
	 * 以","号隔开的线路ID集合
	 */
	private String lineIds;
	
	/**
	 * 新主图名称
	 */
	private String newFirstPicName;
	
	private static final String EXISTS = "exists";
	private String keyword;
	private int fbId; // 副本编号

	public LineAction() {
		lineQueryVO = new LineQueryVO();
		lineStateQueryVO = new LineStateQueryVO();
	}

	/**
	 * 获取旅游线路列表
	 * @return
	 */
	public void getLineList() {
		limit = Integer.parseInt(config.getString("page.size"));
		try {
			// 获取查询条件sql片段
			String sqlChip = lineQueryVO.getQuery();
			if (null == sqlChip) {
				ResponseUtil.sendResult("");
				return;
			}

			lines = lineService.getLineList(sqlChip, start, limit);
			totalCount = lineService.getLineListSize(sqlChip);
			for (LineVO line : lines) {
//				line.setFromplace(PlaceUtil.getCityNameCN(line.getFromplace()));
//				line.setToplace(PlaceUtil.getCityNameCN(line.getToplace()));
			}
			
			JSONObject json = new JSONObject();
			json.put("totalCount", totalCount);
			json.put("list", (null == lines) ? "" : lines);

			result = json.toString();
		} catch (Exception e) {
			logger.error("获取旅游线路列表出错！", e);
			result = ERROR;
			e.printStackTrace();
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 跳转到线路详细页面
	 * @return
	 */
	public String forwardDetailPage() {
		try {
			lineInfo = lineService.getLineInfoById(lineId);
			if (null == lineInfo || !lineInfo.getState().equals(Consts.LINE_STATE_SELLING)){
				return ERROR;
			}
			lineInfo.setPics(lineInfo.getPropics().split(","));
		} catch (Exception e) {
			logger.error("跳转到详细信息页面出错，出错线路编号:" + lineId, e);
			return ERROR;
		}
		return SUCCESS;
	}
	
	
	/**
	 * 跳转到个人管理中心线路查看页面
	 * @return
	 */
	public String forwardManageLineViewPage() {
		try {
			lineInfo = lineService.getLineInfoByUidAndId(lineId, lineInfo.getSupplierId());
			if (null == lineInfo){
				return ERROR;
			}
			lineInfo.setPics(lineInfo.getPropics().split(","));
		} catch (Exception e) {
			logger.error("跳转到个人管理中心线路查看页面出错，出错线路编号:" + lineId, e);
			return ERROR;
		}

		return SUCCESS;
	}
	/**
	 * 获取所有非上架线路商品列表
	 * @return
	 */
	public void getOffLineList() {
		limit = Integer.parseInt(config.getString("page.size"));
		try {
			// 获取查询条件sql片段
			String sqlChip = lineStateQueryVO.getQuery();
			if (null == sqlChip) {
				ResponseUtil.sendResult("");
				return;
			}

			lines = lineService.getOffShelfLineList(sqlChip, start, limit);
			totalCount = lineService.getOffShelfLineListCount(sqlChip);

			JSONObject json = new JSONObject();
			json.put("totalCount", totalCount);
			json.put("list", (null == lines) ?"": lines);

			result = json.toString();
		} catch (Exception e) {
			logger.error("获取所有非上架线路商品列表出错！", e);
			result = ERROR;
			e.printStackTrace();
		}

		ResponseUtil.sendResult(result);
	}

	/**
	 * 下架线路
	 * @return
	 */
	public void lineOffShelf() {
		try {
			result = lineService.lineOffShelf(lineInfo.getSupplierId(), lineIds) ? SUCCESS : ERROR;
		} catch (Exception e) {
			logger.error("线路下架时出错！操作者ID:" + lineInfo.getSupplierId() + ";下架线路ID:" + lineIds, e);
			result = ERROR;
			e.printStackTrace();
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 上架线路
	 * @return
	 */
	public void lineSelling() {
		try {
			result = lineService.lineSelling(lineInfo.getSupplierId(), lineIds) ? SUCCESS : ERROR;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("线路上架时出错！操作者ID:" + lineInfo.getSupplierId() + ";下架线路ID:" + lineIds, e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 复制线路
	 */
	public void copyLine() {
		
		try {
			lineService.copyLine(lineId, lineInfo.getSupplierId());
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("线路复制时出错！操作者ID:" + lineInfo.getSupplierId() + "复制线路ID:" + lineId, e);
			result = ERROR;
			e.printStackTrace();
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 跳转到个人管理中心线路编辑页面
	 * @return
	 */
	public String forwardManageLineModifyPage() {
		try {
			lineInfo = lineService.getLineInfoByUidAndId(lineId, lineInfo.getSupplierId());
			if (null == lineInfo){
				return ERROR;
			}
		} catch (Exception e) {
			logger.error("跳转到个人管理中心线路编辑页面出错，出错线路编号:" + lineId, e);
			return ERROR;
		}

		return SUCCESS;
	}
	
	/**
	 * 跳转到复制线路保存页面
	 * @return
	 */
	public void forwardCopyLinePage() {
		try {
			int newLineId = lineService.copyLine(lineId, lineInfo.getSupplierId());
			if (newLineId > 0) {
				JSONObject json = new JSONObject();
				json.put("lineId", newLineId);
				json.put("supplierId", lineInfo.getSupplierId());
				result = json.toString();
			}else{
				result = ERROR;
			}
		} catch (Exception e) {
			logger.error("跳转到个人管理中心线路编辑页面出错，出错线路编号:" + lineId, e);
			result = ERROR;
		}
		
		ResponseUtil.sendResult(result);
	}
	
	
	/**
	 * 保存线路基本信息
	 */
	public void saveLineBaseInfo() {

		try {
			lineId = lineService.saveLineBaseInfo(lineInfo);
			result = lineId + "";
		} catch (Exception e) {
			logger.error("保存线路基本信息出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 保存线路图片
	 */
	public void saveLiePics() {

		try {
			lineService.saveLiePics(lineInfo.getSupplierId(), lineId, lineInfo.getPropics());
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("保存线路图片出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	private String planIds;//计划id，逗号分割
	/**
	 * 终止出团计划
	 */
	public void terminateLinePlans(){
		try {
			lineService.terminateLinePlans(lineInfo.getId(),planIds);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("保存线路扩展信息出错，线路ID:，"+ lineInfo.getId(), e);
			result = ERROR;
		}
		
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 保存线路扩展信息
	 */
	public void saveLineMoreInfo() {

		try {
			lineService.saveLineMoreInfo(lineInfo);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("保存线路扩展信息出错，线路ID:，"+ lineInfo.getId() +"操作人ID：" + lineInfo.getSupplierId(), e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 编辑线路基本信息
	 */
	public void modifyLineInfo() {

		try {
			lineInfo.setUpdateTime(new Date());
			lineService.modifyLineInfo(lineInfo);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("编辑线路出错", e);
			result = ERROR;
		}
		
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *发布线路
	 */
	public void publishLine() {

		try {
			lineInfo.setPublishTime(new Date());
			lineInfo.setState(Consts.LINE_STATE_SELLING);
			lineService.modifyLineInfo(lineInfo);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("发布线路出错", e);
			result = ERROR;
		}
		
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 更换主图
	 */
	public void changeFirstPic() {

		try {
			lineService.changeFirstPic(lineInfo.getSupplierId(), lineId, newFirstPicName);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("更换主图出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	
	/**
	 * 拷贝发布线路
	 */
	public void copyLineToPublish() {
		try {
//			lineInfo.setToplace(PlaceUtil.getCityIds(lineInfo.getToplace()));
//			lineInfo.setFromplace(PlaceUtil.getCityIds(lineInfo.getFromplace()));
			boolean bl = lineService.copyLineToPublish(lineInfo);
			result = bl ? SUCCESS : ERROR;
		} catch (Exception e) {
			logger.error("拷贝并发布下路出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 拷贝预售线路
	 */
	public void copyLineToPreselling() {
		try {
			boolean bl = lineService.copyLineToPreselling(lineInfo);
			result = bl ? SUCCESS : ERROR;
		} catch (Exception e) {
			logger.error("拷贝并预售下路出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	
	/**
	 * 查询线路
	 */
	public void getLineByIds() {
		try {
			lines = lineService.getLineByIds(lineIds);
			for (LineVO lineInfo : lines) {
//				lineInfo.setToplace(PlaceUtil.getCityNameCN(lineInfo.getToplace()));
//				lineInfo.setFromplace(PlaceUtil.getCityNameCN(lineInfo.getFromplace()));
			}
			result = JSONArray.fromObject(lines).toString();
		} catch (Exception e) {
			logger.error("查看副本线路出错", e);
			result = ERROR;
		}

		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 保存计划团期所有修改
	 */
	public void delelePlans() {
		try {
			lineService.deletePlanByIds(lineId, planIds);
			result = SUCCESS;
		} catch (Exception e) {
			logger.error("删除线路计划出错，出错线路编号:" + lineId, e);
			e.printStackTrace();
			result = ERROR;
		}
		
		ResponseUtil.sendResult(result);
	}
	
	public String getNewFirstPicName() {
		return newFirstPicName;
	}

	public void setNewFirstPicName(String newFirstPicName) {
		this.newFirstPicName = newFirstPicName;
	}
	
	public LineService getLineService() {
		return lineService;
	}

	public void setLineService(LineService lineService) {
		this.lineService = lineService;
	}
	
	public List<LineVO> getLines() {
		return lines;
	}

	public void setLines(List<LineVO> lines) {
		this.lines = lines;
	}
	
	public LineQueryVO getLineQueryVO() {
		return lineQueryVO;
	}

	public void setLineQueryVO(LineQueryVO lineQueryVO) {
		this.lineQueryVO = lineQueryVO;
	}
	
	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}
	
	public int getLineId() {
		return lineId;
	}

	public void setLineId(int lineId) {
		this.lineId = lineId;
	}
	
	public LineVO getLineInfo() {
		return lineInfo;
	}

	public void setLineInfo(LineVO lineInfo) {
		this.lineInfo = lineInfo;
	}
	
	public LineStateQueryVO getLineStateQueryVO() {
		return lineStateQueryVO;
	}

	public void setLineStateQueryVO(LineStateQueryVO lineStateQueryVO) {
		this.lineStateQueryVO = lineStateQueryVO;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	public String getLineIds() {
		return lineIds;
	}

	public void setLineIds(String lineIds) {
		this.lineIds = lineIds;
	}
	
	public String getFromPage() {
		return fromPage;
	}

	public void setFromPage(String fromPage) {
		this.fromPage = fromPage;
	}
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public int getFbId() {
		return fbId;
	}

	public void setFbId(int fbId) {
		this.fbId = fbId;
	}

	public String getPlanIds() {
		return planIds;
	}

	public void setPlanIds(String planIds) {
		this.planIds = planIds;
	}
	
	
}
