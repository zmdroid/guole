<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<div id="Header">
	<div class="wrapper">
		<!-- Logo-->
		<div id="title"><span>后台管理系统</span></div>
		<!-- Top navigation -->
		<div id="topnav">
			欢迎！ <b>${current_user_info.userName}</b> 
			<span>|</span> <a href="${pageContext.request.contextPath}/logout.do">退出系统</a><br />
		</div>
		<!-- End of Top navigation -->
		<!-- Main navigation -->
		<div id="menu">
			<ul class="sf-menu">
				<li ${param.type == "home" ? "class='current'" : ""}><a href="${pageContext.request.contextPath}/index.jsp">首页</a></li>
				<li ${(param.type == "product" || param.type == "tagManager" || param.type == "lineRankingManager") ? "class='current'" : ""}>
					<c:if test="${not empty current_user_permission['/CP'] }">
					</c:if>
						<a href="javascript:;">商品管理</a>
					<ul>
						<c:if test="${not empty current_user_permission['lineFB.jsp'] }">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/lineFB.jsp">线路副本管理</a></li>
						<c:if test="${not empty current_user_permission['lineOnline.jsp'] }">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/lineOnline.jsp">线路库</a></li>
						<c:if test="${not empty current_user_permission['lineManager.jsp'] }">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/lineManager.jsp">线路管理</a></li>
						<c:if test="${not empty current_user_permission['lineRankingManager.jsp'] }">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/lineRankingManager.jsp">线路推广</a></li>
						<c:if test="${not empty current_user_permission['tag.jsp'] }">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/tag.jsp">标签管理</a></li>
						<li><a href="${pageContext.request.contextPath}/page/product/words.jsp">线路搜索关键字库</a></li>
						<li><a href="${pageContext.request.contextPath}/page/product/dic.jsp">分词器字典</a></li>
						<c:if test="${not empty current_user_permission['place.jsp']}">
						</c:if>
							<li><a href="${pageContext.request.contextPath}/page/product/place.jsp">目的地管理</a></li>
					</ul>
				</li>
				<li ${(param.type == "memberManager" || param.type == "supplyRankingManager" || param.type == "notifyManager") ? "class='current'" : ""}>
						<c:if test="${not empty current_user_permission['/HY'] }">
						</c:if>
							<a href="javascript:;">会员管理</a>
					<ul>
							<c:if test="${not empty current_user_permission['memberManager.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/member/memberManager.jsp">会员信息管理</a></li>
							<c:if test="${not empty current_user_permission['supplyRankingManager.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/member/supplyRankingManager.jsp">供应商榜单</a></li>
							<c:if test="${not empty current_user_permission['notifyManager.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/member/notifyManager.jsp">消息管理</a></li>
								<li><a href="${pageContext.request.contextPath}/page/member/typeManager.jsp">产品类型</a></li>
					</ul>
				</li>	
				<li>
					<a href="${pageContext.request.contextPath}/page/zhaopin/zhaopinlist.jsp">秒杀管理</a>
				</li>	
				<li>
					<a href="${pageContext.request.contextPath}/page/information/informationlist.jsp">团购管理</a>
				</li>	
				<li>
					<a href="${pageContext.request.contextPath}/page/annou/announcement.jsp">公告管理</a>
				</li>	
				<li>
					<a href="${pageContext.request.contextPath}/page/advert/advertlist.jsp">广告管理</a>
				</li>	
				<li>
						<c:if test="${not empty current_user_permission['/XT'] }">
						</c:if>
							<a href="javascript:;">系统管理</a>
					<ul>
							<c:if test="${not empty current_user_permission['permission.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/system/permission.jsp">资源管理</a></li>
							<c:if test="${not empty current_user_permission['role.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/system/role.jsp">角色管理</a></li>
							<c:if test="${not empty current_user_permission['manager.jsp'] }">
							</c:if>
								<li><a href="${pageContext.request.contextPath}/page/system/manager.jsp">用户管理</a></li>
					</ul>
				</li>	
			</ul>
		</div>
		<!-- End of Main navigation -->
		<div class="cle"></div>
	</div>
</div>
