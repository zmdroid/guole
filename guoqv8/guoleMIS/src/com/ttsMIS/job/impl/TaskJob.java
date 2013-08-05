package com.ttsMIS.job.impl;

import org.apache.log4j.Logger;

import com.ttsMIS.service.line.LineService;

public class TaskJob {
	
	
    private static Logger log = Logger.getLogger("linePlanFile");
    private LineService lineService;
    
    /**
     * 
     * 关闭过期的线路出团计划
     * @author Ming Zhou
     * @version 1.0
     * @createtime 2013-7-9
     *		版本		修改者	时间		修改内容
     *
     */
    public void CloseLinePlan(){
    	 try {
             // 业务逻辑代码调用
    		 log.info("关闭过期的线路出团计划开始");
             lineService.linePlanOffShelf();
             log.info("关闭过期的线路出团计划结束");
      } catch (Exception e) {
             log.error("关闭过期的线路出团计划出错", e);
      }
    }

	public LineService getLineService() {
		return lineService;
	}

	public void setLineService(LineService lineService) {
		this.lineService = lineService;
	}

}
