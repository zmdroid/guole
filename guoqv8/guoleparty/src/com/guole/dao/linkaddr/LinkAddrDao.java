package com.guole.dao.linkaddr;

import java.util.List;
import java.util.Map;

import com.guole.vo.LinkAddrVO;

public interface LinkAddrDao {

	/**
	 * 
	 * 新增送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	int insertLinkAddr(LinkAddrVO linkAddrVO);
	/**
	 * 
	 * 修改送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	int updateLinkAddr(LinkAddrVO linkAddrVO);
	/**
	 * 
	 * 删除送货地址根据编号和所有者
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	int deleteLinkAddr(LinkAddrVO linkAddrVO);

	/**
	 * 
	 * 根据用户编号获取用户的所有送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	List<LinkAddrVO> getLinkAddrsByUserId(Map map);
	
	/**
	 * 
	 * 查询用户关联送货地址总数
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	int getLinkAddrCountByUserId(int userId);
}
