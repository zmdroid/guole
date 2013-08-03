<%@ page language="java" import="java.util.*,com.guole.util.Config" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
   Config conf = Config.getInstance();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>个人中心-基本资料</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body>
	个人中心
	<br>
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>

	<form id="modifyUserInfoForm" name="modifyUserInfoForm" action="modifyUserInfo.do" method="POST">
		<input type="hidden" name="userInfoVO.userId" value="${sessionScope.current_user_info.userId}">
		<div class="TipsBox">用户基本信息</div>
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">真实姓名:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="userInfoVO.name" id="name" maxlength="30" value="${sessionScope.current_user_info.name}"> 
					<font color="red"> <span id="nameError"></span></font>
				</span></td>
			</tr>
			<tr>
				<td class="CA">头像:</td>
				<td>
					<span class="IBoxTip" id="head"> 
					<c:choose>
						<c:when test="${sessionScope.current_user_info.avatar != null && sessionScope.current_user_info.avatar != ''}">
							<img src="${imgUrl}<%=conf.getString("headDir")%>${sessionScope.current_user_info.avatar}" width="90" height="90">
							&nbsp;&nbsp;
							<a href="javascript:uploadImg(1);">上传头像</a>
						</c:when>
						<c:otherwise>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:uploadImg(1);">上传头像</a>
						</c:otherwise>
					</c:choose>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">QQ:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="userInfoVO.qq" id="qq" maxlength="30" value="${sessionScope.current_user_info.qq}"> 
					<font color="red"><span id="qqError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">邮箱:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="userInfoVO.email" id="email" maxlength="30" value="${sessionScope.current_user_info.email}"> 
					<font color="red"><span id="emailError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">手机:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="userInfoVO.mobile" id="mobile" maxlength="30" value="${sessionScope.current_user_info.mobile}"> 
					<font color="red"><span id="mobileError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">账户状态:</td>
				<td id="accountState">
					<span class="IBoxTip"> 
					<c:choose>
						<c:when test="${sessionScope.current_user_info.state == 1}">
													 待审核
						</c:when>
						<c:when test="${sessionScope.current_user_info.state == 2}">
													 审核通过
						</c:when>
						<c:when test="${sessionScope.current_user_info.state == 3}">
													 审核拒绝
						</c:when>
						<c:otherwise>
					                                                    冻结
						</c:otherwise>
					</c:choose>
					</span>
				</td>
			</tr>
		</table>
		<div class="PostBut">
			<a href="javascript:void(0);" class="But" id="updateBtn">保存</a>
		</div>
	</form>

</body>
<%@include file="/js.jsp" %>
<script type="text/javascript" charset="utf-8">

var canClick = true;
//基本信息维护
function clickButton(){
	  if(!canClick)return;
	  canClick = false;
	  var name = $('#name');
	  if($.trim(name.val()).length == 0){
		  $('#nameError').show();
		  $('#nameError').html("姓名不能为空!");
		  setFocus(name);
		  canClick = true;
		  return;
	  }else{
		  $('#nameError').html('');
		  $('#nameError').hide();
	  }
	  var email = $('#email');
	  if($.trim(email.val()).length == 0){
		  $('#emailError').show();
		  $('#emailError').html("邮箱不能为空!");
		  setFocus(email);
		  canClick = true;
		  return;
	  }else{
		  if(!checkEmail(email.val())){
			  $('#emailError').show();
			  $('#emailError').html("邮箱格式不正确!");
			  setFocus(email);
			  canClick = true;
			  return;
		  }else{
			  $('#emailError').html('');
			  $('#emailError').hide();
		  }
	  }
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/modifyUserInfo.do?time=" + new Date().getTime(),
		  data: $("#modifyUserInfoForm").serialize(),
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "FAILURE"){    
		    	  alert("用户信息修改失败,请稍后再试!");
		      }else if(data == "ERROR"){
		    	  alert("系统繁忙,,请稍后再试!");
		      }else{
		    	  alert("用户信息修改成功!");
		    	  window.location.reload();
		      }
		      canClick = true;
		  }
   	 });
	 return true;
}


$("#updateBtn").click(function(){   
    clickButton(); 
}); 

</script>
</html>
