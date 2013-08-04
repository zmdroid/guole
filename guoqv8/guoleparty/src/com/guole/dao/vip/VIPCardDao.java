package com.guole.dao.vip;

import java.util.List;
import java.util.Map;

import com.guole.vo.VIPCardVO;

public interface VIPCardDao {

	/**
	 * 
	 * 获取VIP会员卡种类
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-05
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public List<VIPCardVO> getVIPCards(Map map);
	/**
	 * 
	 * 获取VIP会员卡种类总数
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-08-05
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public int getVIPCardsCount();
	
}
