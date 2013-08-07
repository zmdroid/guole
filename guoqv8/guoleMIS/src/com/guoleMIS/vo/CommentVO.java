package com.guoleMIS.vo;

import java.util.Date;
/**
 * 留言信息
 * @author mingzhou
 * @version 1.0
 * @createtime 2013-8-3
 *		版本		修改者	时间		修改内容
 *
 */
public class CommentVO {
	
	public int commentId;// 消息编号
	public int userId;// 会员编号
	public String userName;// 会员姓名(游客)
	public String linkPhone;//联系方式
	public String commentMsg;//留言内容
	public Date pubtime;//发布时间
	public int state;//留言状态(1:正常 2:关闭)
	public int replyState;//是否回复(1:回复 2:未回复)
	public String replyUser;//回复人姓名
	public String replyMsg;//回复内容
	public Date replyTime;//回复时间
	public String remark;//备注
	
	public static int COMMENT_STATE_1 = 1;//正常
	    
	public static int COMMENT_STATE_2 =2;//关闭
	
	public static int REPLY_STATE_1 = 1;//已回复
	
	public static int REPLY_STATE_2=2;//未回复

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCommentMsg() {
		return commentMsg;
	}

	public void setCommentMsg(String commentMsg) {
		this.commentMsg = commentMsg;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getReplyState() {
		return replyState;
	}

	public void setReplyState(int replyState) {
		this.replyState = replyState;
	}

	public String getReplyUser() {
		return replyUser;
	}

	public void setReplyUser(String replyUser) {
		this.replyUser = replyUser;
	}

	public String getReplyMsg() {
		return replyMsg;
	}

	public void setReplyMsg(String replyMsg) {
		this.replyMsg = replyMsg;
	}

	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getLinkPhone() {
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}

	
}
