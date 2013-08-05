package com.guoleMIS.vo;

import org.apache.log4j.Logger;

import com.guoleMIS.util.Validate;



public class LineQueryVO {
	//日志接口
	private final static Logger logger = Logger.getLogger(LineQueryVO.class);

	/**
	 * 出发地
	 */
	private String fromPlace;
	
	/**
	 * 目的地
	 */
	private String keyword;

	/**
	 * 线路类型
	 */
	private int lineType;

	/**
	 * 出发日期
	 */
	private String startDate;
	
	/**
	 * 行程天数
	 */
	private String days;
	
	/**
	 * 去程交通
	 */
	private String toTransport;
	
	/**
	 * 返程交通
	 */
	private String fromTransport;
	
	/**
	 * 排序字段
	 */
	private String sortField;

	/**
	 * 排序类型
	 */
	private String sortType;

	/**
	 * 价格
	 */
	private String price;

	/**
	 * 线路类型
	 */
	private int busiType;

	/**
	 * sql查询条件片段
	 */
	private StringBuffer sqlChip = new StringBuffer();
	
	/**
	 * 排序字段ID（默认）
	 */
	private static final String SORT_FIELD_ID  = "id";
	
	/**
	 * 升序
	 */
	private static final String SORT_TYPE_ASC = "asc";
	
	/**
	 * 降序（默认）
	 */
	private static final String SORT_TYPE_DESC = "desc";

	/**
	 * 获取查询条件
	 * @return
	 */
	public String getQuery() {
		sqlChip.append(" 1 = 1 ");
		
		try {
			if (!Validate.isEmpty(keyword)) { // 关键字不为空
				if (Validate.isNumber(keyword.trim())){ // 如果关键字全为数字，则认为是线路编号
					sqlChip.append(" and id = " + keyword.trim());
					return sqlChip.toString();
				}else{ // 非编号
					String ids = null;//PlaceUtil.getCityIds(keyword);
					if (null != ids) {
						String toPlace = "";
						for (String id : ids.split(",")) {
							toPlace += " instr(concat(',',toplace,','),concat(',','"+ id +"',',')) != 0 or ";
						}
						sqlChip.append(" and (name like '%"+ keyword +"%' or "+ toPlace +" topic like '%"+ keyword +"%' or views like '%"+ keyword +"%')");
					}else{
						sqlChip.append(" and (name like '%"+ keyword +"%' or topic like '%"+ keyword +"%' or views like '%"+ keyword +"%')");
					}
				}
			}

			sqlChip.append(busiType == -1 ? "" : (" and busiType = " + busiType));
			sqlChip.append(fromPlace.equals("") ? "" : (" and fromplace = '"+ fromPlace +"'"));

			if (-1 != lineType) {
				sqlChip.append(" and lineType = " + lineType);
			}
			if (!Validate.isEmpty(days)) {
				String[] ds = days.split("-");
				int max = Integer.parseInt(ds[1]);
				sqlChip.append(" and days >= "+ ds[0] + "" + (max == 0 ? "" : " and days < "+ (max + 1) +""));
			}
			if (!Validate.isEmpty(fromTransport)) {
				sqlChip.append(" and fromTransport = '"+ fromTransport +"'");
			}
			if (!Validate.isEmpty(toTransport)) {
				sqlChip.append(" and toTransport = '"+ toTransport +"'");
			}
		} catch(Exception e) {
			logger.error("组装线路列表查询SQL出错！", e);
			return null;
		}

			sqlChip.append(" order by "+ SORT_FIELD_ID);
		
		if (!Validate.isEmpty(sortType) && (sortType.equalsIgnoreCase(SORT_TYPE_ASC) || sortType.equalsIgnoreCase(SORT_TYPE_DESC))) {
			sqlChip.append(" " + sortType);
		}else{
			sqlChip.append(" " + SORT_TYPE_DESC);
		}
		
		return sqlChip.toString();
	}

	public int getLineType() {
		return lineType;
	}

	public void setLineType(int lineType) {
		this.lineType = lineType;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getToTransport() {
		return toTransport;
	}

	public void setToTransport(String toTransport) {
		this.toTransport = toTransport;
	}

	public String getFromTransport() {
		return fromTransport;
	}

	public void setFromTransport(String fromTransport) {
		this.fromTransport = fromTransport;
	}
	
	public String getFromPlace() {
		return fromPlace;
	}

	public void setFromPlace(String fromPlace) {
		this.fromPlace = fromPlace;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}
	
	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	public int getBusiType() {
		return busiType;
	}

	public void setBusiType(int busiType) {
		this.busiType = busiType;
	}
}
