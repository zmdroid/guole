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
				<li ${(param.type == "product") ? "class='current'" : ""}>
					<c:if test="${not empty current_user_permission['/CP'] }">
					</c:if>
					<a href="javascript:;">商品管理</a>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/page/zhaopin/zhaopinlist.jsp">秒杀管理</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/page/tuan/tuanlist.jsp">团购管理</a>
						</li>
					</ul>
				</li>
				<li ${(param.type == "financeManage") ? "class='current'" : ""}>
						<c:if test="${not empty current_user_permission['/CW'] }">
						</c:if>
						<a href="javascript:;">财务管理</a>
					<ul>
								<li><a href="${pageContext.request.contextPath}/page/finance/recharge.jsp">充值管理</a></li>
								<li><a href="${pageContext.request.contextPath}/page/finance/refund.jsp">退款管理</a></li>
								<li><a href="${pageContext.request.contextPath}/page/finance/accountDetail.jsp">账户明细</a></li>
								<li><a href="${pageContext.request.contextPath}/page/finance/platformaccount.jsp">平台账务</a></li>
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
				<li ${(param.type == "orderManager") ? "class='current'" : ""} >
					<a href="${pageContext.request.contextPath}/page/order/orderManager.jsp">订单管理</a>
				</li>
				<li ${(param.type == "cardManager")? "class='current'" : ""}>
					<a href="javascript:;">礼品卡会员卡管理</a>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/page/card/giftcardtypelist.jsp">礼品卡类型</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/page/card/giftcardlist.jsp">礼品卡</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/page/card/vipcardlist.jsp">会员卡</a>
						</li>
					</ul>
				</li>	
				<li ${(param.type == "annouManager") ? "class='current'" : ""}>
					<a href="${pageContext.request.contextPath}/page/annou/announcement.jsp">公告管理</a>
				</li>	
				<li ${(param.type == "adManager") ? "class='current'" : ""}>
					<a href="${pageContext.request.contextPath}/page/advert/advertlist.jsp">广告管理</a>
				</li>	
				<li ${(param.type == "commentManager") ? "class='current'" : ""}>
					<a href="${pageContext.request.contextPath}/page/comment/commentManager.jsp">留言管理</a>
				</li>	
				<li ${(param.type == "sysManager" ) ? "class='current'" : ""}>
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
