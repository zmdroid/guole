package com.guoleMIS.action.comment;

import java.util.Date;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;

import com.guoleMIS.consts.Consts;
import com.guoleMIS.service.comment.CommentService;
import com.guoleMIS.util.ResponseUtil;
import com.guoleMIS.vo.CommentVO;
import com.guoleMIS.vo.ManagerVO;
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
	private Integer commentId;
	private Integer state;//回复状态
	
	/**
	 * 
	 * 根据回复状态获取留言信息
	 * @author Ming Zhou
	 * @version 1.0
	 * @createtime 2013-8-3
	 *		版本		修改者	时间		修改内容
	 *
	 */
	public void getAllComments(){
		Object[] obj = commentService.getCommentList(pageIndex, commentVO.getReplyState());
		if(null==obj){
			result = Consts.NULL_LIST;
		}else{
			result = JSONArray.fromObject(obj).toString();
		}
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 根据commentId删除用户的评论
	 * 
	 */
	public void delCommentById(){
		result="error";
		boolean rs = commentService.delComment(commentId);
		if(rs)result="success";
		ResponseUtil.sendResult(result);
	}
	
	/**
	 * 回复客户留言
	 * 
	 */
	public void replyComment(){
		result = "error";
		ManagerVO user = (ManagerVO)session.get(Consts.CURRENT_USER_INFO);
		if(null==user){
			ResponseUtil.sendResult(result);
			return;
		}
		if(commentVO.getCommentId()<1){
			ResponseUtil.sendResult(result);
			return;
		}
		commentVO.setReplyTime(new Date());
		commentVO.setReplyUser(user.getUserName());
		commentVO.setReplyState(CommentVO.REPLY_STATE_1);
		boolean rs = commentService.replyComment(commentVO);
		if(rs)result="success";
		ResponseUtil.sendResult(result);
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

	public Integer getCommentId() {
		return commentId;
	}

	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}


}
