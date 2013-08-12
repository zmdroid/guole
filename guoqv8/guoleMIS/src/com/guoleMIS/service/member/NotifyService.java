package com.guoleMIS.service.member;

import java.util.List;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.NotifyVO;

/**
 * 消息信息业务层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-06
 * @history  版本	修改者	   时间	修改内容
 */
public interface NotifyService {
	
	/**
     * 获取消息信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<NotifyVO> loadNotifys(NotifyVO notifyVO,int page);
    
    /**
     * 获取消息信息记录数
     * @param filter 查询条件
     * @return 
     */
    public int getNotifyInfosCount(NotifyVO notifyVO);
    
    /**
     * 发送消息信息
     * @param notifyVO 消息信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
    public boolean publishNotify(String receivers,String type, int fromBy,String content);

}
