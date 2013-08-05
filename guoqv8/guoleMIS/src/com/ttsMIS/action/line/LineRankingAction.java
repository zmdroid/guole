package com.ttsMIS.action.line;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.util.Config;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.LineVO;
import com.opensymphony.xwork2.ActionSupport;
import com.ttsMIS.service.line.LineRankingService;

/**
 * 线路推广管理Action
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-26
 * @history  版本	修改者	   时间	修改内容
 */
public class LineRankingAction extends ActionSupport implements SessionAware{
	
	private static final long serialVersionUID = 1415146777060554880L;

	private final static Logger logger = Logger.getLogger(LineRankingAction.class);
	
	public LineRankingService lineRankingService;
	
    public LineVO lineVO;

	public int page;
	
	public int id;

	public int sortNo;
	
	public int oldSortNo;
	
	public String lineIds;

	private String result;

	private Map<String, Object> session;
	
	private final static Config config = Config.getInstance();
	
	/**
	 *获取线路列表
	 */
	public void loadLineList(){
		result = "";
		try{
			List<LineVO> lines = lineRankingService.loadLineList(lineVO,page);
			int totalCount = lineRankingService.getLineCount(lineVO);
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(lines != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			result = "{\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(lines);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取线路推广榜单出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 *获取推广线路列表
	 */
	public void loadLineRanking(){
		result = "";
		try{
			List<LineVO> lines = lineRankingService.loadLineRanking(page);
			int totalCount = lineRankingService.getRankingCount();
			int pageLength = 1;
			int limit = Integer.parseInt(config.getString("page.size"));
			if(lines != null){
				if(totalCount % limit == 0){
					pageLength = totalCount / limit;
				}else{
					pageLength = totalCount / limit + 1;
				}
			}
			int maxSortNo = lineRankingService.getLineRankingMaxSortNo();
			result = "{\"maxSortNo\":"+maxSortNo+",";
			result += "\"pageLength\":"+pageLength+",\"totalCount\":"+totalCount;
			JSONArray jArray = new JSONArray();
			jArray.addAll(lines);
			result += ",\"items\":"+jArray.toString()+"}";
		} catch (Exception e) {
			logger.error("获取线路推广榜单出错!", e);
			result = "ERROR";
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
     * 移除推广线路中的线路
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void removeRankingLine(){
		try {   
			if(lineRankingService.removeRankingLine(id)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	/**
     * 设置推广线路排序
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void resetLineRankingSort(){
		try {   
			if(lineRankingService.resetLineRankingSort(id,sortNo,oldSortNo)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	/**
     * 添加推广线路
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public void addRankingLine(){
		try {   
			if(lineRankingService.addRankingLine(lineIds)){
				result = "success";
			}else{
				result = "failing";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
		}
    }
	
	/**
     * 生成推广线路榜单JSON
     * @return
     * @throws Exception
     */
	@SuppressWarnings("finally")
	public String generateLineRanking(){
		result = "failing";
		try {   
			if(createLineRanking()){
				result = "success";
			}
		} catch (Exception e) {
			logger.error("出错了：",e);
			result = "error";
		} finally{
			ResponseUtil.sendResult(result);
 	        return null;
		}
    }
	
	@SuppressWarnings("finally")
	private boolean createLineRanking(){
		boolean isSuccess = false;
		String rankingDir = (String) Config.getInstance().get("resRootUrl")+(String) Config.getInstance().get("fileDir")+(String) Config.getInstance().get("rankingDir");
		File f = new File(rankingDir);
		if(!f.exists())f.mkdirs();
		List lineInfoList = lineRankingService.loadAllRankingLine();
		int size = 0;
		List lineList = new ArrayList();
		if(lineInfoList != null){
			size = lineInfoList.size();
			Iterator it = lineInfoList.iterator();
			LineVO vo;
			List<String> fundations;
			StringBuffer sb;
			String[] myDate;
			int month;
			int day;
			int i = 0;
			try {
				while(it.hasNext()){
					vo = (LineVO)it.next();
					if(vo.getName() != null && !vo.getName().equals(""))vo.setName(URLEncoder.encode(vo.getName(), "UTF-8"));
				    if(vo.getUserName() != null && !vo.getUserName().equals(""))vo.setUserName(URLEncoder.encode(vo.getUserName(), "UTF-8"));
				    if(vo.getToTransport() != null && !vo.getToTransport().equals(""))vo.setToTransport(URLEncoder.encode(vo.getToTransport(), "UTF-8"));
				    if(vo.getFromTransport() != null && !vo.getFromTransport().equals(""))vo.setFromTransport(URLEncoder.encode(vo.getFromTransport(), "UTF-8"));
				    if(vo.getTopic() != null && !vo.getTopic().equals(""))vo.setTopic(URLEncoder.encode(vo.getTopic(), "UTF-8"));
				    if(vo.getSupplierName() != null && !vo.getSupplierName().equals(""))vo.setSupplierName(URLEncoder.encode(vo.getSupplierName(), "UTF-8"));
				    if(vo.getFromplace() != null && !vo.getFromplace().equals(""))vo.setFromplace(URLEncoder.encode(vo.getFromplace(), "UTF-8"));
				    if(vo.getCorname() != null && !vo.getCorname().equals(""))vo.setCorname(URLEncoder.encode(vo.getCorname(), "UTF-8"));
				    fundations = lineRankingService.loadFoundationList(vo.getId());
				    if(fundations != null && !fundations.isEmpty()){
					    sb = new StringBuffer();
					    i = 0;
					    for(String fundation : fundations){
					    	if(i > 2){
					    		sb.append("...");
					    		break;
					    	}
					    	myDate = fundation.split("-");
					    	month = Integer.parseInt(myDate[1]);
					    	day = Integer.parseInt(myDate[2]);
					    	sb.append(month+"月").append(day+"日").append(",");
					        i++;
					    }
					    vo.setFundations(URLEncoder.encode(sb.toString().substring(0,sb.toString().length()-1), "UTF-8"));
				    }
				    lineList.add(vo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("出错了：",e);
			}
		}
		String json = "{\"totalCount\":"+size+"";
		JSONArray jArray = new JSONArray();
		jArray.addAll(lineList);
		json += ",\"lines\":"+jArray.toString()+"}";
		json = "jsonfeed("+json+")";
		String path = rankingDir+"/lineRanking.json";
		FileOutputStream out = null;
		try {
			File toFile = new File(path);
			if(toFile.exists())toFile.delete();
			out = new FileOutputStream(toFile);
			out.write(json.getBytes());
			isSuccess = true;
		}catch(IOException e){
			logger.error("出错了：",e);
		}finally{
			try {
				if(out != null)out.close();
			} catch (IOException e) {
				logger.error("出错了：",e);
			}
			return isSuccess;
		}
	}

	public void setSession(Map session) {
		this.session = session;
	}
	
    public LineRankingService getLineRankingService() {
		return lineRankingService;
	}

	public void setLineRankingService(LineRankingService lineRankingService) {
		this.lineRankingService = lineRankingService;
	}

	public LineVO getLineVO() {
		return lineVO;
	}

	public void setLineVO(LineVO lineVO) {
		this.lineVO = lineVO;
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

	public int getSortNo() {
		return sortNo;
	}

	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}

	public int getOldSortNo() {
		return oldSortNo;
	}

	public void setOldSortNo(int oldSortNo) {
		this.oldSortNo = oldSortNo;
	}

	public String getLineIds() {
		return lineIds;
	}

	public void setLineIds(String lineIds) {
		this.lineIds = lineIds;
	}
}
