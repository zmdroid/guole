package com.guole.action;

import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guole.consts.Consts;
import com.guole.service.comment.CommentService;
import com.guole.util.ResponseUtil;
import com.guole.vo.CommentVO;
import com.guole.vo.UserInfoVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 用户虚拟账户信息
 * @author mingzhou
 * @version V1.0
 * @createTime   2013-8-3
 * @history  版本	修改者	   时间	修改内容
 */
public class CommentAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = -3103914818445549065L;
	private Map<String,Object> session;
	
	private static final Logger  logger = Logger.getLogger(CommentAction.class);
	
	private CommentService commentService;
	private CommentVO commentVO;
	
	private Integer pageIndex;
	private String result;
	/**
	 * 
	 * 获取状态为正常的留言信息
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-8-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void getAllComments(){
		if(null==pageIndex)pageIndex=1;
		Object[] obj = commentService.getCommentList(pageIndex, 1);
		if(null==obj){
			result = Consts.NULL_LIST;
		}else{
			result = JSONArray.fromObject(obj).toString();
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 
	 * 新增一个留言
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-8-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void addComment(){
		UserInfoVO user = (UserInfoVO) session.get(Consts.CURRENT_USER_INFO);
		if(null == user){
			commentVO.setUserName("游客");
		}else{
			commentVO.setUserId(user.getUserId());
			commentVO.setUserName(user.getName());
		}
		commentVO.setPubtime(new Date());
		commentVO.setState(CommentVO.COMMENT_STATE_1);
		commentVO.setReplyState(CommentVO.REPLY_STATE_2);
		boolean rs = commentService.addComment(commentVO);
		if(rs){
			ResponseUtil.sendResult("SUCCESS");
		}else{
			ResponseUtil.sendResult("ERROR");
		}
		
	}
	
	@Override
	public void setSession(Map<String, Object> session) {
		// TODO Auto-generated method stub
		this.session = session;
	}

	public CommentService getCommentService() {
		return commentService;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public CommentVO getCommentVO() {
		return commentVO;
	}

	public void setCommentVO(CommentVO commentVO) {
		this.commentVO = commentVO;
	}

}
