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
					<dd><a href="${pageContext.request.contextPath}/page/product/lineOnline.jsp">线路库</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/lineManager.jsp">线路管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/lineRankingManager.jsp">线路推广</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/tag.jsp">标签管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/words.jsp">线路搜索关键字库</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/dic.jsp">分词器字典</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/product/place.jsp">目的地管理</a></dd>
				</dl>				
				<dl class="System">
					<dt>系统管理</dt>
					<dd><a href="${pageContext.request.contextPath}/page/system/permission.jsp">资源管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/system/role.jsp">角色管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/system/manager.jsp">用户管理</a></dd>
				</dl>				
				<dl class="Member">
					<dt>会员管理</dt>
					<dd><a href="${pageContext.request.contextPath}/page/member/memberManager.jsp">会员信息管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/member/supplyRankingManager.jsp">供应商榜单</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/member/notifyManager.jsp">消息管理</a></dd>
					<dd><a href="${pageContext.request.contextPath}/page/member/typeManager.jsp">产品类型</a></dd>
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