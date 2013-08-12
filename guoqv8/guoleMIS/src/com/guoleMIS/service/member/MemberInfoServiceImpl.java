package com.guoleMIS.service.member;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.member.MemberInfoDao;
import com.guoleMIS.util.Config;
import com.guoleMIS.vo.MemberInfoVO;

public class MemberInfoServiceImpl implements MemberInfoService {
	
	private final static Config config = Config.getInstance();
	
	public MemberInfoDao memberInfoDao;
	
	public SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	
	public MemberInfoDao getMemberInfoDao() {
		return memberInfoDao;
	}

	public void setMemberInfoDao(MemberInfoDao memberInfoDao) {
		this.memberInfoDao = memberInfoDao;
	}

	@Override
	public List<MemberInfoVO> loadMembers(MemberInfoVO memberInfoVO,int page) {
		return memberInfoDao.loadMembers(getConditions(memberInfoVO,page));
	}
	
	@Override
	public int getMemberInfosCount(MemberInfoVO memberInfoVO) {
		return memberInfoDao.getMemberInfosCount(getConditions(memberInfoVO,-1));
	}
	
	@Override
	public List<MemberInfoVO> loadSupplyRanking(int page) {
		String conditions = "";
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions = " LIMIT "+start+","+limit;
		return memberInfoDao.loadSupplyRanking(conditions);
	}
	
	@Override
	public boolean removeSupply(int id) {
		boolean isSuccess = true;
		memberInfoDao.updateRankingSortNo(id);
		if(!memberInfoDao.removeRankingSupply(id)){
			 return false;
		}
		return isSuccess;
	}
	
	@Override
	public boolean resetSupplyRanking(int id,int sortNo,int oldSortNo){
		boolean isSuccess = true;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("sortNo", sortNo);
		params.put("oldSortNo", oldSortNo);
		if(sortNo > oldSortNo){
			memberInfoDao.updateSupplyRankingSort(params);
			if(!memberInfoDao.updateSupplySelfSortNo(params)){
			   return false;
			}
		}else if(sortNo < oldSortNo){
			memberInfoDao.updateSupplySortNo(params);
			if(!memberInfoDao.updateSupplySelfSortNo(params)){
			   return false;
		    }
		}
		return isSuccess;
	}
	
	@Override
	public boolean addRankingSupply(String userIds) {
		boolean isSuccess = true;
		String[] itemPid = userIds.split(",");
		int len = itemPid.length;
		for(int i = 0; i < len; i++){
			 if(memberInfoDao.isExists(Integer.parseInt(itemPid[i])) == 0){
			   if(!memberInfoDao.addRankingSupply(Integer.parseInt(itemPid[i]))){
				   return false;
			   }
			 }
		}
		return isSuccess;
	}
	
	/**
     * 获取会员信息列表
     * @param filter 查询条件
     * @return 
     */
    public List<MemberInfoVO> loadAllRankingSupply(){
    	return memberInfoDao.loadSupplyRanking(" AND 1 = 1 ");
    }
	
	@Override
	public int getSupplyRankingCount() {
		return memberInfoDao.getSupplyRankingCount();
	}
    
	@Override
    public List<String> getPlaceNames(String place){
    	return memberInfoDao.getPlaceNames(place);
    }
	
	private String getConditions(MemberInfoVO memberInfoVO,int page){
		StringBuffer conditions = new StringBuffer();
		//会员类型
		if(!(memberInfoVO.getUsertype()==-1)){
			conditions.append(" AND u.usertype='").append(memberInfoVO.getUsertype()).append("'");
		}
		//会员状态
		if((memberInfoVO.getState() != 0) && !(memberInfoVO.getState()==-1)){
			conditions.append(" AND u.state='").append(memberInfoVO.getState()).append("'");
		}
		//用户姓名
		if(memberInfoVO.getName() != null && !memberInfoVO.getName().equals("")){
			conditions.append(" AND u.name LIKE '%").append(memberInfoVO.getName()).append("%'");
		}
		//公司名称
		if(memberInfoVO.getCorname() != null && !memberInfoVO.getCorname().equals("")){
			conditions.append(" AND u.corname LIKE '%").append(memberInfoVO.getCorname()).append("%'");
		}
		//账户名称
		if(memberInfoVO.getUserAccount() != null && !memberInfoVO.getUserAccount().equals("")){
			conditions.append(" AND u.userAccount LIKE '%").append(memberInfoVO.getUserAccount()).append("%' ");
		}
		conditions.append(" ORDER BY userId DESC ");
		int limit = Integer.parseInt(config.getString("page.size"));
		int start = (page - 1)*limit;
		if(page != -1)conditions.append(" LIMIT ").append(start).append(",").append(limit);
		return conditions.toString();
	}
	
	@Override
	public MemberInfoVO getMemberInfoByUserId(int userId) {
		return memberInfoDao.getMemberInfoByUserId(userId);
	}

	@Override
	public boolean aduitMember(MemberInfoVO memberInfoVO) {
		return memberInfoDao.aduitMember(memberInfoVO);
	}
	
	@Override
	public boolean aduitAndModCutoffTime(MemberInfoVO memberInfoVO) {
		return memberInfoDao.aduitAndModCutoffTime(memberInfoVO);
	}
	
	@Override
	public boolean batchTransit(String userIds) {
		boolean success = true;
		String[] idArray = userIds.split(",");
		MemberInfoVO memberInfoVO;
		for(String id : idArray){
			memberInfoVO = new MemberInfoVO();
			memberInfoVO.setUserId(Integer.parseInt(id));
			memberInfoVO.setState(MemberInfoVO.USER_STATE_2);
			int days = Integer.parseInt(config.getString("valid.days"));
			Calendar cal = Calendar.getInstance(); 
			cal.add(Calendar.DATE, days); 
			aduitMember(memberInfoVO);
		}
		return success;
	}
	
	@Override
	public boolean batchRefuse(String userIds) {
		return memberInfoDao.batchRefuse("("+userIds+")");
	}

	@Override
	public int getMaxSortNo() {
		return memberInfoDao.getMaxSortNo();
	}

	@Override
	public void cutoffAccount() {
	    memberInfoDao.cutoffAccount();
	}

}
