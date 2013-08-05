<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    
    <title>招聘详细页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
    <!-- Header -->
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				招聘管理
				 → <span>查看招聘信息</span>			
			</h1>
		</div>
	</div>
	<!-- End of Page title -->
		<!-- Page content -->
	<div id="page">
	
		<!-- Wrapper -->
		<div class="wrapper">	
			<div class="rightmenu">
				<h3 class="title">招聘信息 状态:
					<c:choose>
						<c:when test="${recruit.state==1 }">
							正常
						</c:when>
						<c:when test="${recruit.state==2 }">
							关闭
						</c:when>
						<c:otherwise>
							审核不通过
						</c:otherwise>
					</c:choose>
					
				</h3>				
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="CA">职位:</td>
						<td width="250px">${recruit.position }</td>
					</tr>
					<tr>
						<td class="CA">发布公司:</td>
						<td width="250px">${recruit.companyName }</td>
					</tr>
					<tr>
						<td class="CA">工作地点:</td>
						<td width="250px">${recruit.province }-${recruit.city }</td>
					</tr>
					<tr>
						<td class="CA">工作类型:</td>
						<td width="250px">
							<c:if test="${recruit.type==1 }">
								全职
							</c:if>
							<c:if test="${recruit.type==2 }">
								兼职
							</c:if>							
							</td>
					</tr>
					<tr>
						<td class="CA">工资待遇:</td>
						<td width="250px">${recruit.lowSalary }~${recruit.hightSalary }</td>
					</tr>
					<tr>
						<td class="CA">描述:</td>
						<td width="250px">${recruit.description }</td>
					</tr>
					<hr/>
					<tr>
						<td class="CA">联系人:</td>
						<td width="250px">${recruit.linkMan }</td>
					</tr>
					<tr>
						<td class="CA">联系电话:</td>
						<td width="250px">${recruit.linkPhone }</td>
					</tr>
					
				</table>
			</div>	
		</div>
		<center>
			<a href="javascript:closeWin();" id="searchBtn" class="btn  btn-blue">关闭页面</a>
			<br/><br/>
		</center>
	</div>
</html>
