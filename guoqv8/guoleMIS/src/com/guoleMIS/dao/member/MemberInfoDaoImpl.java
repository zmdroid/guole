package com.guoleMIS.dao.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guoleMIS.dao.base.BaseDaoImpl;
import com.guoleMIS.vo.MemberAccountVO;
import com.guoleMIS.vo.MemberInfoVO;

public class MemberInfoDaoImpl extends BaseDaoImpl implements MemberInfoDao {

	@Override
	public List<MemberInfoVO> loadMembers(String conditions) {
		return sqlSessionTemplate.selectList("loadMembers",conditions);
	}
	
	@Override
	public int getMemberInfosCount(String conditions) {
		return sqlSessionTemplate.selectOne("getMemberInfosCount",conditions);
	}
	
	@Override
	public List<MemberInfoVO> loadSupplyRanking(String conditions) {
		return sqlSessionTemplate.selectList("loadSupplyRanking",conditions);
	}
	
	@Override
	public int getSupplyRankingCount() {
		return sqlSessionTemplate.selectOne("getSupplyRankingCount",null);
	}
	
	@Override
	public List<String> getPlaceNames(String place){
		return sqlSessionTemplate.selectList("getPlaceNames",place);
	}


	@Override
	public MemberInfoVO getMemberInfoByUserId(int userId) {
		return sqlSessionTemplate.selectOne("getMemberInfoByUserId",userId);
	}
	
	@Override
	public MemberInfoVO getMemberApplyInfoByUserId(Map params) {
		return sqlSessionTemplate.selectOne("getMemberApplyInfoByUserId",params);
	}

	@Override
	public boolean aduitMember(MemberInfoVO memberInfoVO) {
		return sqlSessionTemplate.update("aduitMember",memberInfoVO) > 0;
	}
	
	@Override
	public boolean aduitAndModCutoffTime(MemberInfoVO memberInfoVO) {
		return sqlSessionTemplate.update("aduitAndModCutoffTime",memberInfoVO) > 0;
	}
	
	@Override
    public boolean batchTransit(String userIds){
		return sqlSessionTemplate.update("batchTransit",userIds) > 0;
    }
    
	@Override
    public boolean batchRefuse(String userIds){
		return sqlSessionTemplate.update("batchRefuse",userIds) > 0;
	}
	
	@Override
	public boolean aduitMemberApply(MemberInfoVO memberInfoVO) {
		return sqlSessionTemplate.update("aduitMemberApply",memberInfoVO) > 0;
	}
	
	@Override
	public boolean refuseMemberApply(MemberInfoVO memberInfoVO) {
		return sqlSessionTemplate.update("refuseMemberApply",memberInfoVO) > 0;
	}

	@Override
	public boolean updateRankingSortNo(int id) {
		return sqlSessionTemplate.update("updateRankingSortNo",id) > 0;
	}

	@Override
	public boolean removeRankingSupply(int id) {
		return sqlSessionTemplate.delete("removeRankingSupply",id) > 0;
	}

	@Override
	public boolean updateSupplyRankingSort(Map params) {
		return sqlSessionTemplate.update("updateSupplyRankingSort",params) > 0;
	}

	@Override
	public boolean updateSupplySelfSortNo(Map params) {
		return sqlSessionTemplate.update("updateSupplySelfSortNo",params) > 0;
	}

	@Override
	public boolean updateSupplySortNo(Map params) {
		return sqlSessionTemplate.update("updateSupplySortNo",params) > 0;
	}

	@Override
	public int getMaxSortNo() {
		return (Integer)sqlSessionTemplate.selectOne("getMaxSortNo",null);
	}

	@Override
	public int isExists(int userId) {
		return (Integer)sqlSessionTemplate.selectOne("isExists",userId);
	}

	@Override
	public boolean addRankingSupply(int userId) {
		return sqlSessionTemplate.insert("addRankingSupply",userId) > 0;
	}

	@Override
	public void cutoffAccount() {
	    sqlSessionTemplate.update("cutoffAccount",null);
	}

	@Override
	public List<MemberInfoVO> loadCompanyApplys(String conditions) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getCompanyApplysCount(String conditions) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MemberAccountVO getMemberAccountByUserId(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public double getUserAccountBalanceTotal() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modifyUserBalance(HashMap<String, Object> param)
			throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public double queUserBalance(int userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

}
