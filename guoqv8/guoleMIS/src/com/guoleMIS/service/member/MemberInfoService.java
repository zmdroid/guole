package com.guoleMIS.service.member;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.vo.MemberInfoVO;

/**
 * 会员信息业务层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-03
 * @history  版本	修改者	   时间	修改内容
 */
public interface MemberInfoService {
	
	/**
     * 获取会员信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadMembers(MemberInfoVO memberInfoVO,int page);
    
    /**
     * 获取会员信息记录数
     * @param filter 查询条件
     * @return 
     */
    public int getMemberInfosCount(MemberInfoVO memberInfoVO);
    
    /**
     * 获取供应商榜单最多排序号
     * @return 
     */
    public int getMaxSortNo();
    
    /**
     * 获取会员信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadSupplyRanking(int page);
    
    /**
	 * 移除榜单中的供应商
	 * @param id   记录编号
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean removeSupply(int id);
	
	/**
	 * 充值榜单中的供应商顺序
	 * @param id   记录编号
	 * @param sortNo   记录编号
	 * @param oldSortNo   记录编号
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean resetSupplyRanking(int id,int sortNo,int oldSortNo);
	
	/**
	 * 添加榜单中的供应商
	 * @param userIds   供应商编号
	 */
	@Transactional(rollbackFor={Exception.class},propagation = Propagation.REQUIRES_NEW)
	public boolean addRankingSupply(String userIds);
    
    /**
     * 获取会员信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadAllRankingSupply();
    
    /**
     * 获取会员信息记录数
     * @param filter 查询条件
     * @return 
     */
    public int getSupplyRankingCount();
	
	/**
     * 根据会员编号获取会员信息
     * @param userId 用户编号
     * @return 
     */
    public MemberInfoVO getMemberInfoByUserId(int userId);
    
    /**
     * 根据会员编号获取经营目的地
     * @param place ，目的地编号
     * @return
     */
    public List<String> getPlaceNames(String place);
    
    /**
     * 审核会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    public boolean aduitMember(MemberInfoVO memberInfoVO);
    
    
    /**
     * 审核签约会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    public boolean aduitAndModCutoffTime(MemberInfoVO memberInfoVO);
    
    /**
     * 冻结过期的会员账户
     * @return 
     */
    public void cutoffAccount();
    
    /**
     * 批量审核通过会员信息
     * @param userIds 会员编号
     * @return 
     */
    public boolean batchTransit(String userIds);
    
    /**
     * 批量审核拒绝会员信息
     * @param userIds 会员编号
     * @return 
     */
    public boolean batchRefuse(String userIds);
    
}