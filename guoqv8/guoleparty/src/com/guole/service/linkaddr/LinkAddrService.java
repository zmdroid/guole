package com.guole.service.linkaddr;

import com.guole.vo.LinkAddrVO;

public interface LinkAddrService {

	/**
	 * 
	 * 新增或修改用户的送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	boolean addUpdateLinkAddr(LinkAddrVO linkAddrVO);
	
	/**
	 * 
	 * 删除送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	boolean deleteLinkAddr(LinkAddrVO linkAddrVO);
	
	/**
	 * 
	 * 获取用户关联的所有送货地址
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2012-8-12
	 *		版本		修改者	时间		修改内容
	 *
	 */
	Object[] getLinkAddrByUserId(int userId,int page);
}
