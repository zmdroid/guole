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
					<c:if test="${sessionScope.current_user_info.avatar != null && sessionScope.current_user_info.avatar != ''}">
					<img id="headImg" src="${imgUrl}<%=conf.getString("headDir")%>${sessionScope.current_user_info.avatar}" width="90" height="90">
							&nbsp;&nbsp;
					</c:if>
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

	<form id="headForm" action="${pageContext.request.contextPath}/uploadPicture.do" method="post">
		<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA"></td>
				<td><input type="file" name="imageFile" id="imageFile"/>
				</td>
			</tr>
			<tr>
				<td class="CA"></td>
				<td>
					<div class="PostPic" id="picList">												
					</div>
				</td>
			</tr>		
			<tr>
				<a href="javascript:void(0);" id="modHead">上传头像</a>
			</tr>					
		</table>
	</form>

</body>
<%@include file="/js.jsp" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/jquery.form.js"></script>
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



var _picHtml = '<img id="tempPic" src="${imgUrl}<%=Config.getInstance().get("resTmp")%>/#pic" width="120" height="90"/>';
// 上传图片
function uploadHeadtPic() {
	var picList = $("#picList");
	$("#headForm").ajaxSubmit({
		success:function(rs){
			if ("error" == rs) {
				alert("上传服务器出错");
			}else{
				picList.html(_picHtml.replace("#pic", rs));
			}
		},
		error: function(){
			alert("服务器断访问出错");
		}
	});
}
$("#imageFile").change(function(){
	uploadHeadtPic();
});






$("#modHead").click(function(){
	uploadHead();
});

function uploadHead () {
	var tempPic = $("#tempPic").attr("src");
	if (!tempPic || tempPic.length == 0) {
		alert("请上传图片");
		return;
	}
	var pic = tempPic.split("/");
	pic = pic[pic.length-1]
	$.post('updateHead.do',{"img":pic},function(rs){
		if(rs=="ERROR"){
				alert("操作失败，请稍后在试...");
		}else{
				location.href='${pageContext.request.contextPath}/pcenter/baseInfo';
				alert("保存成功");
		}
	});
}
</script>
</html>
