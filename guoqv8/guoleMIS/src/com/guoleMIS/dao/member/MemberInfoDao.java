package com.guoleMIS.dao.member;

import java.util.List;
import java.util.Map;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.guoleMIS.dao.member.MemberInfoDao;
import com.guoleMIS.vo.MemberInfoVO;

/**
 * 会员信息持久层接口
 * @author zhenhua.kou
 * @version V1.0
 * @createTime   2013-06-03
 * @history  版本	修改者	   时间	修改内容
 */
public interface MemberInfoDao {
	
	/**
     * 获取会员信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadMembers(String conditions);
    
    /**
     * 获取会员信息记录数
     * @param filter 查询条件
     * @return 
     */
    public int getMemberInfosCount(String conditions);
    
    /**
     * 获取供应商榜单最大排序号
     * @return 
     */
    public int getMaxSortNo();
    
    /**
     * 获取供应商榜单
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadSupplyRanking(String conditions);
    
    /**
	 * 榜单中该供应商是否已存在
	 * @param userId   供应商编号
	 */
	public int isExists(int userId);
	
	/**
	 * 添加榜单供应商
	 * @param userId   供应商编号
	 */
	public boolean addRankingSupply(int userId);
    
	/**
	 * 更新供应商榜单中的排序号,减
	 * @param id
	 */
	public boolean updateRankingSortNo(int id);
	
	/**
	 * 更新榜单中的排序号,减
	 * @param params
	 */
	public boolean updateSupplyRankingSort(Map params);
	
	/**
	 * 更新当前记录在榜单中的排序号,减
	 * @param counterPartId
	 * @param pid
	 */
	public boolean updateSupplySelfSortNo(Map params);
	
	/**
	 * 更新榜单中的排序号,加
	 * @param id
	 * @param sortNo
	 */
	public boolean updateSupplySortNo(Map params);
	
	/**
	 * 删除供应商榜单中的供应商
	 * @param id
	 */
	public boolean removeRankingSupply(int id);
    
    /**
     * 获取供应商榜单记录数
     * @param filter 查询条件
     * @return 
     */
    public int getSupplyRankingCount();
    
    /**
     * 根据会员编号获取经营目的地
     * @param place ，目的地编号
     * @return
     */
    public List<String> getPlaceNames(String place);
	
	/**
     * 根据会员编号获取会员信息
     * @param userId 用户编号
     * @return 
     */
    public MemberInfoVO getMemberInfoByUserId(int userId);
    
    /**
     * 根据会员编号获取会员信息(含升级申请信息)
     * @return 
     */
    public MemberInfoVO getMemberApplyInfoByUserId(Map params);
    
    /**
     * 审核会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    public boolean aduitMember(MemberInfoVO memberInfoVO);
    
    /**
     * 审核会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    public boolean aduitAndModCutoffTime(MemberInfoVO memberInfoVO);
    
    /**
     * 审核签约会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
    public boolean aduitMemberApply(MemberInfoVO memberInfoVO);
    
    /**
     * 审核会员信息
     * @param memberInfoVO 会员信息
     * @return 
     */
    @Transactional(rollbackFor={Exception.class},propagation = Propagation.MANDATORY)
    public boolean refuseMemberApply(MemberInfoVO memberInfoVO);
    
    /**
     * 批量审核通过会员信息
     * @param userIds 会员编号
     * @return 
     */
    public boolean batchTransit(String userIds);
    
    /**
     * 批量审核通过会员信息
     * @param userIds 会员编号
     * @return 
     */
    public boolean batchRefuse(String userIds);
    
    /**
     * 冻结过期的账户
     * @return 
     */
	public void cutoffAccount();
    
}
