﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>登录</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<!-- Favicons --> 
<link rel="shortcut icon" type="image/png" HREF="img/favicons/favicon.png"/>
<link rel="icon" type="image/png" HREF="img/favicons/favicon.png"/>
<link rel="apple-touch-icon" HREF="img/favicons/apple.png" />
<!-- Main Stylesheet --> 
<link rel="stylesheet" href="css/style.css" type="text/css" />
<!-- jQuery with plugins -->
<script type="text/javascript" SRC="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" SRC="js/jquery.ui.core.min.js"></script>
<script type="text/javascript" SRC="js/jquery.ui.widget.min.js"></script>
<script type="text/javascript" SRC="js/jquery.ui.tabs.min.js"></script>
<!-- jQuery tooltips -->
<script type="text/javascript" SRC="js/jquery.tipTip.min.js"></script>
<!-- Superfish navigation -->
<script type="text/javascript" SRC="js/jquery.superfish.min.js"></script>
<script type="text/javascript" SRC="js/jquery.supersubs.min.js"></script>
<!-- jQuery form validation -->
<script type="text/javascript" SRC="js/jquery.validate_pack.js"></script>
<!-- jQuery popup box -->
<script type="text/javascript" SRC="js/jquery.nyroModal.pack.js"></script>
<!-- Internet Explorer Fixes --> 
<script type="text/javascript">

$(document).ready(function(){
	
	/* setup navigation, content boxes, etc... */
	Administry.setup();
	
	// validate signup form on keyup and submit
	var validator = $("#loginform").validate({
		rules: {
			username: "required",
			password: "required"
		},
		messages: {
			username: "输入您的用户名",
			password: "输入您的密码"
		},
		// the errorPlacement has to take the layout into account
		errorPlacement: function(error, element) {
			error.insertAfter(element.parent().find('label:first'));
		},
		// set new class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("ok");
		}
	});

});
</script>
</head>
<body>
	<!-- Header -->
	<div id="Header">
		<div class="wrapper-login">
			<div id="title"><span>后台管理系统</span></div>
		</div>
	</div>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper-login"></div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper-login">
				<!-- Login form -->
				<div class="full LoginBox">					
					
					<h3>登录</h3>

					<form id="loginform" method="post" action="${pageContext.request.contextPath}/login.do">

						<p>
							<label class="required" for="username">用户名:</label><br/>
							<input type="text" id="username" class="full" value="" name="managerVO.userAccount"/>
						</p>
						
						<p>
							<label class="required" for="password">密码:</label><br/>
							<input type="password" id="password" class="full" value="" name="managerVO.pwd"/>
						</p>
						
						<!--  p>
							<input type="checkbox" id="remember" class="" value="1" name="remember"/>
							<label class="choice" for="remember">记住密码?</label>
						</p>-->
						
						<p>
							<input type="submit" class="btn btn-green big" value="登录"/>
							<!-- 
								 &nbsp; <a href="javascript: //;" onClick="$('#emailform').slideDown(); return false;">忘记密码?</a> / <a href="#">帮助?</a>
							 -->
						</p>
						<div class="clear">&nbsp;</div>

					</form>
					
					<form id="emailform" style="display:none" method="post" action="#">
						<div class="box">
							<p id="emailinput">
								<label for="email">邮箱:</label><br/>
								<input type="text" id="email" class="full" value="" name="email"/>
							</p>
							<p>
								<input type="submit" class="btn" value="发送"/>
							</p>
						</div>
					</form>
					
				</div>
				<!-- End of login form -->
				
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	
	<!-- Page footer -->
	<footer id="bottom">
		<div class="wrapper-login">
			<p>Copyright &copy; 2013 <b><a HREF="http://" title=""></a></b> </p>
		</div>
	</footer>
	<!-- End of Page footer -->

<!-- User interface javascript load -->
<script type="text/javascript" SRC="js/administry.js"></script>
</body>
<script type="text/javascript">
if('${param.error}'==1)alert('密码或者用户名错误');
if('${param.error}'==2)alert('帐号被冻结');
</script>
</html>