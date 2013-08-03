<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/_lib/jQuery/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/_lib/jQuery/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/zh_cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/Calls.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/cookies.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/util.js"></script>
<script type="text/javascript">
	//登录
	function logon(){
		  var userAccount = $('#account');
		  if($.trim(userAccount.val()).length == 0){
			  $('#accountError').html("登录帐号不能为空!");
			  setFocus(userAccount);
			  return;
		  }else{
			  $('#accountError').html("");
		  }
		  var pwd = $('#password');
		  if($.trim(pwd.val()).length == 0){
			  $('#passwordError').html("登录密码不能为空!");
			  setFocus(pwd);
			  return;
		  }else{
			  $('#passwordError').html('');
		  }
		  $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/login.do?time=" + new Date().getTime(),
			  data: "readCookies="+$('#readCookie').val()+"&userInfoVO.userAccount="+$.trim(userAccount.val())+"&userInfoVO.pwd="+$.trim(pwd.val()),
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
			    	  if($('#remandMe').is(":checked")){
		    		     setCookie("tpm_userName",$.trim(userAccount.val()),24,"/");
	                     setCookie("tpm_passWord",data,24,"/");
			    	  }else{
			    		 deleteCookie("tpm_userName","/");
				    	 deleteCookie("tpm_passWord","/");
			    	  }
			          window.location.reload();  
			      }
			  }
	   	 });
	  }

	  if(getCookieValue("tpm_userName") != "undefined"){
		  $("#account").val(getCookieValue("tpm_userName"));
	      if($("#account").val() != ""){
	    	  $('#accountLabel').hide();
	    	  if(getCookieValue("tpm_passWord") != "undefined")$("#password").val(getCookieValue("tpm_passWord"));    
	          if($("#password").val() != "") $('#pwdLabel').hide();
	          $("#readCookie").val("1");
	          $('#remandMe').attr("checked",true);
	      }
	  }
	  var checkLoginTimer;
	  function checkLogin(){
			  $.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/checkLogin.do?time=" + new Date().getTime(),
				  async : true,
				  success:function callback(data){
				      if(data == "NOTCURENTUSER"){
				    	  clearInterval(checkLoginTimer);
				          window.location.href = "${pageContext.request.contextPath}/login?act=-1";  
				      }
				  }
		   	 }); 
	  }
</script>
