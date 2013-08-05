<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
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
    This is my JSP page. <br>
    <a href="${pageContext.request.contextPath}/login">登录</a> <br>
    <a href="${pageContext.request.contextPath}/humanRegister">个人注册</a> <br>
    <a href="${pageContext.request.contextPath}/companyRegister">企业注册</a> <br>
    <a href="${pageContext.request.contextPath}/tuangou">水果团购</a> <br>
    <a href="${pageContext.request.contextPath}/giftCards">礼品卡礼品卷</a> <br>
    <a href="${pageContext.request.contextPath}/vipCards">会员卡-更多折扣</a> <br>
    <a href="${pageContext.request.contextPath}/comments">客户留言页</a> <br>
  </body>
</html>
