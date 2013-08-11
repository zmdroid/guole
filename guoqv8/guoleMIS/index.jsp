<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>后台管理首页</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
	<jsp:include page="menu.jsp">
		<jsp:param value="home" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>首页</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
			<div class="IndexBox">
				<dl class="Line">
					<dt>产品管理</dt>
					<dd><a href="#">线路库</a></dd>
					<dd><a href="#">线路管理</a></dd>
					<dd><a href="#">线路推广</a></dd>
					<dd><a href="#">标签管理</a></dd>
				</dl>				
				<dl class="System">
					<dt>系统管理</dt>
					<dd><a href="#">资源管理</a></dd>
					<dd><a href="#">角色管理</a></dd>
					<dd><a href="#">用户管理</a></dd>
				</dl>				
				<dl class="Member">
					<dt>会员管理</dt>
					<dd><a href="#">会员信息管理</a></dd>
					<dd><a href="#">供应商榜单</a></dd>
					<dd><a href="#">消息管理</a></dd>
					<dd><a href="#">产品类型</a></dd>
				</dl>				
			</div>
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
</html>