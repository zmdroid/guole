package com.guoleMIS.vo;

import org.apache.log4j.Logger;
import com.guoleMIS.util.Validate;

/**
 * 充值单查询条件VO
 * @author xubo.wang
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public class RechargeQueryVO {
	//日志接口
	private final static Logger logger = Logger.getLogger(RechargeQueryVO.class);

	/**
	 * 开始日期
	 */
	private String startDate;
	
	
	/**
	 * 结束日期
	 */
	private String endDate;
	
	/**
	 * 流水号
	 */
	private Long sn;
	
	/**
	 * 公司名称
	 */
	private String corName;
	
	/**
	 * 充值类型
	 */
	private int type;
	
	/**
	 * 充值状态
	 */
	private char state;
	
	
	/**
	 * 表示所有记账状态及充值方式
	 */
	private static final int ALL = -1;
	
	/**
	 * 表示所有状态
	 */
	private static final char STATE_ALL = 'A';
	
	/**
	 * 组装查询条件
	 * @return
	 */
	public String getQuery() {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" 1 = 1 ");
		
		try{
			// 如果输入流水号，则只根据流水号查询充值单
			if (null!=sn && 0 != sn) {
				sql.append(" and rechargeId = (select tradeId from t_bill b where b.sn = "+ sn +")");
				return sql.toString();
			}
			
			if (!Validate.isEmpty(startDate) && !Validate.isEmpty(endDate)) {
				if (Integer.parseInt(startDate.replaceAll("-", "")) 
						> Integer.parseInt(endDate.replaceAll("-", ""))) {
					String tmpDate = "";
					tmpDate = startDate;
					startDate = endDate;
					endDate = tmpDate;
				}
			}

			// 开始日期
			if (!Validate.isEmpty(startDate)) {
				sql.append(" and datediff(optime,'"+ startDate +"') >= 0");
			}
			
			// 结束日期
			if (!Validate.isEmpty(endDate)) {
				sql.append(" and datediff(optime,'"+ endDate +"') <= 0");
			}
			
			// 公司名称
			if (!Validate.isEmpty(corName)) {
				sql.append(" and corName like '%"+ corName +"%'");
			}
			
			// 非所有充值方式
			if (ALL != type) {
				sql.append(" and type = " + type);
			}
			
			// 非所有状态
			if (STATE_ALL != state) {
				sql.append(" and state = '" + state + "'");
			}
			
		}catch(Exception ex){
			logger.error("拼装查询充值单SQL异常", ex);
			return null;
		}

		return sql.toString();
	}
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public Long getSn() {
		return sn;
	}

	public void setSn(Long sn) {
		this.sn = sn;
	}

	public String getCorName() {
		return corName;
	}

	public void setCorName(String corName) {
		this.corName = corName;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public char getState() {
		return state;
	}

	public void setState(char state) {
		this.state = state;
	}

}
