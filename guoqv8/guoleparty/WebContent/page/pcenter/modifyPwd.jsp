<%@ page language="java" import="java.util.*,com.guole.util.Config"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
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

<title>个人中心-密码修改</title>
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

	<form id="updatePwdForm" name="updatePwdForm" action="updatepassword.do" method="POST">
		<input type="hidden" name="userInfoVO.userId" value="${sessionScope.current_user_info.userId}">
		<div class="TipsBox">
			修改登录密码
		</div>
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">原密码:</td>
				<td>
					<span class="IBoxTip"> 
						<input class="IEnter WMax" type="password" name="oldpassword" id="oldpassword" maxlength="6">
						<font color="red"><span id="oldpasswordError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">新密码:</td>
				<td>
					<span class="IBoxTip"> 
						<input class="IEnter WMax" type="password" name="newpassword" id="newpassword" maxlength="6">
						<font color="red"><span id="newpasswordError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">确认新密码:</td>
				<td>
					<span class="IBoxTip"> 
						<input class="IEnter WMax" type="password" name="newpassword2" id="newpassword2" maxlength="6"> 
						<font color="red"><span id="newpassword2Error"></span></font>
				</span></td>
			</tr>
		</table>
		<div class="PostBut">
			<a href="javascript:void(0);" class="But" id="modifyPwdBtn">保存</a>
		</div>
	</form>
	<hr>
	<form id="updatePaypasswordForm" name="updatePaypasswordForm" action="updatePaypassword.do" method="POST">
		<input type="hidden" name="userInfoVO.userId" value="${sessionScope.current_user_info.userId}">
		<div class="TipsBox">
			支付支付密码才能成功付款，建议支付密码不要和登录密码重复。
		</div>
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">支付旧密码:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="password" name="oldPaypassword" id="oldPaypassword" maxlength="6"> 
						<label class="IExplain">输入支付旧密码</label>&nbsp;&nbsp;
						<font color="orange">初始：111111</font> &nbsp;&nbsp;
						<font color="red"><span id="oldPaypasswordError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">支付新密码:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="password" name="newPaypassword" id="newPaypassword" maxlength="6"> 
						<font color="red"><span id="newPaypasswordError"></span></font>
					</span>
				</td>
			</tr>
			<tr>
				<td class="CA">确认支付密码:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="password" name="newPaypassword2" id="newPaypassword2" maxlength="6"> 
					<font color="red"><span id="newPaypassword2Error"></span></font>
				</span></td>
			</tr>
		</table>
		<div class="PostBut">
			<a href="javascript:void(0);" class="But" id="modifyPaypasswordBtn">保存</a>
		</div>
	</form>

</body>
<%@include file="/js.jsp"%>
<script type="text/javascript" charset="utf-8">

//修改登陆密码
function updatepassword(){
	  var oldpassword = $('#oldpassword');
	  if($.trim(oldpassword.val()).length == 0){
		  $('#oldpasswordError').show();
		  $('#oldpasswordError').html("旧密码不能为空!");
		  setFocus(oldpassword);
		  canClick = true;
		  return;
	  }else{
		  $('#oldpasswordError').html('');
		  $('#oldpasswordError').hide();
	  }
	  var newpassword = $('#newpassword');
	  if($.trim(newpassword.val()).length == 0){
		  $('#newpasswordError').show();
		  $('#newpasswordError').html("新密码不能为空!");
		  setFocus(newpassword);
		  canClick = true;
		  return;
	  }else{
		  $('#newpasswordError').html('');
		  $('#newpasswordError').hide();
	  }
	  var newpassword2 = $('#newpassword2');
	  if($.trim(newpassword2.val()).length == 0){
		  $('#newpassword2Error').show();
		  $('#newpassword2Error').html("重复新密码不能为空!");
		  setFocus(newpassword2);
		  canClick = true;
		  return;
	  }else{
		  if($.trim(newpassword2.val()) != $.trim(newpassword.val())){
			  $('#newpassword2Error').html('两次输入的密码不一致!');
			  $('#newpassword2Error').show();
			  setFocus(newpassword2);
			  canClick = true;
			  return;
		  }else{
			  $('#newpassword2Error').html('');
			  $('#newpassword2Error').hide();
		  }
	  }
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/updatepassword.do?time=" + new Date().getTime(),
		  data: $("#updatePwdForm").serialize(),
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "FAILURE"){    
		    	  alert("登陆密码修改失败,请稍后再试!");
		      }else if(data == "PASSWORDERROR"){
		    	  $('#oldpasswordError').show();
				  $('#oldpasswordError').html("旧密码错误,请重新输入!");
		    	  setFocus(cashpassword);
		      }else if(data == "ERROR"){
		    	  alert("系统繁忙,请稍后再试!");
		      }else{
		    	  alert("登陆密码成功!");
		    	  window.location.href="${pageContext.request.contextPath}/login";
		      }
		      canClick = true;
		  }
   	 });
	  return true;
}	
$("#modifyPwdBtn").click(function(){   
	  updatepassword();
});


//修改支付密码
function updatePaypassword(){
	  var oldPaypassword = $('#oldPaypassword');
	  if($.trim(oldPaypassword.val()).length == 0){
		  $('#oldPaypasswordError').show();
		  $('#oldPaypasswordError').html("支付旧密码不能为空!");
		  setFocus(oldPaypassword);
		  canClick = true;
		  return;
	  }else{
		  $('#oldPaypasswordError').html('');
		  $('#oldPaypasswordError').hide();
	  }
	  var newPaypassword = $('#newPaypassword');
	  if($.trim(newPaypassword.val()).length == 0){
		  $('#newPaypasswordError').show();
		  $('#newPaypasswordError').html("支付新密码不能为空!");
		  setFocus(newPaypassword);
		  canClick = true;
		  return;
	  }else{
		  $('#newPaypasswordError').html('');
		  $('#newPaypasswordError').hide();
	  }
	  var newPaypassword2 = $('#newPaypassword2');
	  if($.trim(newPaypassword2.val()).length == 0){
		  $('#newPaypassword2Error').show();
		  $('#newPaypassword2Error').html("确认支付新密码不能为空!");
		  setFocus(newPaypassword2);
		  canClick = true;
		  return;
	  }else{
		  if($.trim(newPaypassword2.val()) != $.trim(newPaypassword.val())){
			  $('#newPaypassword2Error').html('两次输入的密码不一致!');
			  $('#newPaypassword2Error').show();
			  setFocus(newPaypassword2);
			  canClick = true;
			  return;
		  }else{
			  $('#newPaypassword2Error').html('');
			  $('#newPaypassword2Error').hide();
		  }
	  }
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/updatePaypassword.do?time=" + new Date().getTime(),
		  data: $("#updatePaypasswordForm").serialize(),
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "FAILURE"){    
		    	  alert("修改失败,请稍后再试!");
		      }else if(data == "PASSWORDERROR"){
		    	  $('#oldPaypasswordError').show();
				  $('#oldPaypasswordError').html("支付旧密码错误,请重新输入!");
		    	  setFocus(cashpassword);
		      }else if(data == "ERROR"){
		    	  alert("系统繁忙,,请稍后再试!");
		      }else{
		    	  alert("支付密码成功!");
		      }
		      canClick = true;
		  }
   	 });
	  return true;
}
$("#modifyPaypasswordBtn").click(function(){   
	  updatePaypassword();
});
</script>
</html>
