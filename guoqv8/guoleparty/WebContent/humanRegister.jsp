<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>个人注册</title>
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
	<!--注册-->
	<form id="registerForm" name="registerForm" action="register.do" method="POST">
	    <input type="hidden" name="userInfoVO.usertype" id="usertype" value="1"/>
				<table class="BTable" width="60%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 用户名</td>
					<td>
							<input class="IEnter WMids IN" type="text" name="userInfoVO.userAccount" id="userAccount" maxLength="60"/>
						&nbsp;&nbsp;<font color="red"><span id="userAccountError"></span></font>
					</td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 密码</td>
					<td>
							<input class="IEnter WMids IN" type="password" id="pwd" name="userInfoVO.pwd" maxLength="32"/>
					    &nbsp;&nbsp;<font color="red"><span id="pwdError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 确认密码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="password" id="pwd2" maxLength="32"/>
							<label class="IExplain">重复登录密码</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="pwd2Error"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 注册人姓名</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="name" name="userInfoVO.name" maxLength="20"/>
							<label class="IExplain">输入注册人姓名</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="nameError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"></td>
					<td><input type="checkbox" name="protocol" id="protocol" class="VMid" onclick="agreeProtocol(this);"/> <a href="javascript:void(0);">阅读并同意《网络服务使用协议》</a></td>
				  </tr>
				  <tr>
					<td class="CA TTi"></td>
					<td><a href="javascript:register();void(0);" id="regBtn" class="RegBut RegAgree RegAgreeN">同意并注册</a> <a href="javascript:resetForm();" class="RegBut RegReFill">重填</a></td>
				  </tr>
				</table>
	</form>
	<!--注册 end-->
</div>
<!--PageBody end-->
<!--Footer-->
<!--Footer end-->
</body>
</html>
<%@include file="/js.jsp" %>
<script type="text/javascript" charset="utf-8">
    function resetForm(){
    	window.location.reload();
    }
    function agreeProtocol(chk){
  	  if(chk.checked) {
  		  $('#regBtn').removeClass("RegAgreeN");
	  }else{
		  $('#regBtn').addClass("RegAgreeN");
	  }
    }
    $('#staffnum').bind("keypress", function(event) {
    	//控制只能输入的值
    	if (event.which && (event.which < 48 || event.which > 57) && event.which != 8 ) {
	    	event.preventDefault();
	    	return;
    	}
    });
    function checkNumber(value){    
    	//定义正则表达式部分    
    	var reg = /^\d+$/;    
    	if( value.constructor === String ){        
    		var re = value.match( reg );        
    		return re;    
    	}    
    	return false;
    }
    $(document).keydown(function(event){
		if(event.keyCode==13){
			register(); 
		}
    });
	var canClick = true;
    //注册
    function register(){
    	  if(!canClick)return;
    	  if(!$('#protocol').is(":checked")){
    		  $(this).Point('PointC','请选择阅读并同意《网络服务使用协议》!');
    		  return;
    	  }
		  canClick = false;
    	  //用户名
		  var userAccount = $('#userAccount');
		  if($.trim(userAccount.val()).length == 0){
			  $('#userAccountError').html("用户名不能为空!");
			  setFocus(userAccount);
			  canClick = true;
			  return;
		  }else{
			  $('#userAccountError').html('');
		  }
		  //密码
		  var pwd = $('#pwd');
		  if($.trim(pwd.val()).length == 0){
			  $('#pwdError').html("密码不能为空!");
			  setFocus(pwd);
			  canClick = true;
			  return;
		  }else{
			  $('#pwdError').hide();
		  }
		  //确认密码
		  var pwd2 = $('#pwd2');
		  if($.trim(pwd2.val()).length == 0){
			  $('#pwd2Error').html("确认密码不能为空!");
			  setFocus(pwd2);
			  canClick = true;
			  return;
		  }else{
			  $('#pwd2Error').html('');
		  }
		  if($.trim(pwd.val()) != $.trim(pwd2.val())){
			  $('#pwd2Error').html("两次输入的密码不一致!");
			  setFocus(pwd2);
			  canClick = true;
			  return;
		  }else{
			  $('#pwd2Error').html('');
		  }
		  //姓名
		  var name = $('#name');
		  if($.trim(name.val()).length == 0){
			  $('#nameError').html("注册人姓名不能为空!");
			  setFocus(name);
			  canClick = true;
			  return;
		  }else{
			  $('#nicknameError').html('');
		  }
		  var postData = $("#registerForm").serialize();
    	  $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/register.do?time=" + new Date().getTime(),
			  data: postData,
			  async : true,
			  success:function callbackFunc(data){
			      if (data == "FAILURE"){    
			    	  $(this).Point('PointC','注册失败,请稍后再试!');
			      }else if(data == "EXISTS"){
			    	  $(this).Point('PointC','用户帐号已存在,请重新输入!');
			    	  setFocus(userAccount);
			      }else if(data == "ERROR"){
			    	  $(this).Point('PointC','系统繁忙,请稍后再试!');
			    	  setFocus(userAccount);
			      }else{
			          window.location.href = "${pageContext.request.contextPath}/pCenter/home";  
			      }
			      canClick = true;
			  }
	   	 });
		  return false;
    }
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
</script>