<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>供应商注册</title>
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
	    <input type="hidden" name="userInfoVO.usertype" id="usertype" value="2"/>
				<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 用户名</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" name="userInfoVO.userAccount" id="userAccount" maxLength="60"/>
						</span>
						&nbsp;&nbsp;<font color="red"><span id="userAccountError"></span></font>
					</td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 密码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="password" id="pwd" name="userInfoVO.pwd"  maxLength="32"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="pwdError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 确认密码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="password" id="pwd2" maxLength="32"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="pwd2Error"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 注册人姓名</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="name" name="userInfoVO.name" maxLength="20"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="nameError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 公司全称</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMaxS IN" type="text" id="corname" name="userInfoVO.corname" maxLength="60"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="cornameError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 公司人数</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMaxS IN" type="text" id="cornum" name="userInfoVO.cornum" maxLength="6"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="cornumError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 公司地址</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMaxS IN" type="text" id="coraddr" name="userInfoVO.coraddr" maxLength="60"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="coraddrError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 联系人</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMaxS IN" type="text" id="corLinkMan" name="userInfoVO.corLinkMan" maxLength="20"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="corLinkManError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 联系电话</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="corLinkphone" name="userInfoVO.corLinkphone" maxLength="15"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="corLinkphoneError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span>联系邮箱</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="corEmail" name="userInfoVO.corEmail" maxLength="60"/>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="corEmailError"></span></font></td>
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
<div id="Fill-S" class="FillChoose DisNo">	
	<div class="FillCheck">
		<img class="FillCloseImg" src="${pageContext.request.contextPath}/Images/Icon/Close.gif"/>
		<div class="FillTitle">选择产品类型(最多选5个)</div>
		<div class="FillCon SpeCityM" id="lineProduct">
	
		</div>
	</div>
</div>
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
    $('#cornum').bind("keypress", function(event) {
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
		  //公司名称
		  var corname = $('#corname');
		  if($.trim(corname.val()).length == 0){
			  $('#cornameError').html("公司名称不能为空!");
			  setFocus(corname);
			  canClick = true;
			  return;
		  }else{
			  $('#cornameError').html('');
		  }
		  //员工数量
		  var cornum = $('#cornum');
		  if($.trim(cornum.val()).length > 0){
			  if(!checkNumber(cornum.val())){
				  $('#cornumError').html("员工数量只能输入数字!");
				  setFocus(cornum);
				  canClick = true;
				  return;
			  }else{
				  $('#cornumError').html('');
			  }
		  }
		  //公司地址
		  var coraddr = $('#coraddr');
		  if($.trim(coraddr.val()).length == 0){
			  $('#coraddrError').html("公司地址不能为空!");
			  setFocus(coraddr);
			  canClick = true;
			  return;
		  }else{
			  $('#coraddrError').html('');
		  }
		  //联系人类型
		  var corLinkMan = $('#corLinkMan');
		  if($.trim(corLinkMan.val()).length == 0){
			  $('#corLinkManError').html("联系人不能为空!");
			  setFocus(corLinkMan);
			  canClick = true;
			  return;
		  }else{
			  $('#corLinkManError').html('');
		  }
		  //电话
		  var corLinkphone = $('#corLinkphone');
		  if($.trim(corLinkphone.val()).length == 0){
			  $('#corLinkphoneError').html("电话不能为空!");
			  setFocus(corLinkphone);
			  canClick = true;
			  return;
		  }else{
			  var pattern=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
			  if(!pattern.exec($.trim(corLinkphone.val()))) { 
			    $('#corLinkphoneError').html('电话号码有误，请重新输入!');
			    setFocus(corLinkphone);
				canClick = true;
				return;
			  } else{
			    $('#corLinkphoneError').html('');
			  }
		  }
		  //邮箱
		  var corEmail = $('#corEmail');
		  if($.trim(corEmail.val()).length == 0){
			  $('#corEmailError').html("联系邮箱不能为空!");
			  setFocus(corEmail);
			  canClick = true;
			  return;
		  }else{
			  if(!checkEmail(corEmail)){
				  $('#corEmailError').html("联系邮箱格式不正确!");
				  setFocus(email);
				  canClick = true;
				  return;
			  }else{
				  $('#corEmailError').html('');
			  }
		  }
		  var postData = $("#registerForm").serialize();
    	  $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/register.do?t=" + new Date().getTime(),
			  data: postData,
			  async : true,
			  success:function callbackFunc(data){
				  if (data == "FAILURE"){    
			    	  $(this).Point('PointC','注册失败,请稍后再试!');
			      }else if(data == "EXISTS"){
			    	  $(this).Point('PointC','用户帐号已存在,请重新输入!');
			    	  setFocus(userAccount);
			      }else if(data == "COREXISTS"){
			    	  $(this).Point('PointC','公司名称已存在,请重新输入!');
			    	  setFocus($('#corname'));
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