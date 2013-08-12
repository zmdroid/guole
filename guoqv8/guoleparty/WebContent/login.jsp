<%@ page language="java" pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String act = request.getParameter("act");
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>登录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
</head>
<body>
<!--Header-->
<!--Header end--> 

<!--PageBody-->
<div id="PageBody">
			<!--登录-->
			<form id="loginForm" name="loginForm" action="login.do" method="POST">
			 <input class="IEnter WMax" type="hidden" name="readCookies" id="readCookies" value="0">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="TTi FF F18">帐号</td>
								<td>
									<span class="IBoxTip">
										<input class="IEnter IA FF" type="text" name="userInfoVO.userAccount" id="userAccount"  maxLength="60" onKeyDown="$('#readCookies').val('0');"/>
									</span>
								</td>
							</tr>
							<tr>
						    	<td class="TTi FF F18"></td>
								<td><font color="red"><span id="userAccountError"></span></font></td>
							</tr>	
							<tr>
								<td class="TTi FF F18">密码</td>
								<td>
									<span class="IBoxTip">
										<input class="IEnter IA FF" type="password"  name="userInfoVO.pwd" id="pwd" maxLength="32" onKeyDown="$('#readCookies').val('0');"/>
									</span>
								</td>
							</tr>
							<tr>
						    	<td class="TTi FF F18"></td>
								<td><font color="red"><span id="pwdError"></span></font></td>
							</tr>		
							<tr>
								<td class="CA"></td>
								<td>
								  <label><input class="VMid BNo" type="checkbox" name="remindMe" id="remindMe"> 下次自动登录</label>
								  &nbsp;&nbsp;<a href="${pageContext.request.contextPath}/resetPassword.jsp">忘记密码?</a>
								</td>
							</tr>
							<tr>
								<td class="CA"></td>
								<td>
									<a href="javascript:void(0);" class="RegBut RegLogin" id="loginButton">登录</a>
									<a href="${pageContext.request.contextPath}/humanRegister">注册个人</a>
									<a href="${pageContext.request.contextPath}/companyRegister">注册企业</a>
								</td>
							</tr>
						</table>
			</form>
			<!--登录 end-->
</div>
<!--PageBody end-->
<!--Footer-->
<!--Footer end-->
</body>
</html>
<%@include file="/js.jsp" %>
<script type="text/javascript" charset="utf-8">
	function setFocus(obj){
		   if(obj != null){
			   obj.focus();
			   obj.select();
		   }
	}
	//邮箱校验
    function checkEmail(userAccount){
       //对电子邮件的验证
       var myreg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
       return myreg.test($.trim(userAccount.val()));
	}
	//登录
	function clickButton(){
		  var userAccount = $('#userAccount');
		  if($.trim(userAccount.val()).length == 0){
			  $('#userAccountError').html("登录帐号不能为空!");
			  setFocus(userAccount);
			  return;
		  }else{
			  $('#userAccountError').html("");
		  }
		  var pwd = $('#pwd');
		  if($.trim(pwd.val()).length == 0){
			  $('#pwdError').html("登录密码不能为空!");
			  setFocus(pwd);
			  return;
		  }else{
			  $('#pwdError').html('');
		  }
		  $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/login.do?time=" + new Date().getTime(),
			  data: "readCookies="+$('#readCookies').val()+"&userInfoVO.userAccount="+$.trim(userAccount.val())+"&userInfoVO.pwd="+$.trim(pwd.val()),
			  async : true,
			  success:function callback(data){
			      if (data == "FAILURE"){    
			    	  $(this).Point('PointC','用户名或密码错误,请重新输入!');
			      }else if(data == "ERROR"){
			    	  $(this).Point('PointC','系统繁忙,请稍后再试!');
			    	  setFocus(userAccount);
			      }else if(data == "DISABLED"){
			    	  $(this).Point('PointC','帐号已冻结,请联系客服!');
			    	  setFocus(userAccount);
			      }else{
			    	  if($('#remindMe').is(":checked")){
		    		     setCookie("tpm_userName",$.trim(userAccount.val()),24,"/");
	                     setCookie("tpm_passWord",data,24,"/");
			    	  }else{
			    		 deleteCookie("tpm_userName","/");
				    	 deleteCookie("tpm_passWord","/");
			    	  }
			          window.location.href = "${pageContext.request.contextPath}/pcenter/home";  
			      }
			  }
	   	 });
	  }
	 $(document).keydown(function(event){
		if(event.keyCode==13){
			clickButton(); 
		}
     });
	  $("#loginButton").click(function(){   
	        clickButton(); 
	  }); 
	  if(getCookieValue("tpm_userName") != "undefined"){
		  $("#userAccount").val(getCookieValue("tpm_userName"));
	      if($("#userAccount").val() != ""){
	    	  $('#userAccountLabel').hide();
	    	  if(getCookieValue("tpm_passWord") != "undefined")$("#pwd").val(getCookieValue("tpm_passWord"));    
	          if($("#pwd").val() != "") $('#passWordLabel').hide();
	          $("#readCookies").val("1");
	          $('#remindMe').attr("checked",true);
	      }
	  }
</script>
