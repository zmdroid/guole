<%@ page language="java" import="com.guole.util.Config" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	long sysTime = System.currentTimeMillis();
    Config configInstance = Config.getInstance();
%>
<div class="FL Left ManBuyers">
	<div class="LBody">
		<!--用户头像-->
		<div class="UserPhoto">
			<img id="userHead" src="${imgUrl}<%=configInstance.getString("headDir")%>${sessionScope.current_user_info.avatar}" width="150" height="150"/>
			<div class="Name">
			   <script type="text/javascript">
				       var nick = "${sessionScope.current_user_info.name}";
				       nick.length>10?document.write((nick.substring(0,20))+".."):document.write(nick);
			   </script>
		    </div>
		</div>
		<!--用户头像 end-->
		<!--功能菜单-->
		<div class="ManSidebar ">
			<dl>
				<dt>账户管理</dt>
				<dd><a href="${pageContext.request.contextPath}/pcenter/home">信息中心</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/baseInfo">基本信息</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/modifypwd">密码管理</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/accountManage">账户余额</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/recharge">账户充值</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/message">消息中心</a></dd>
			</dl>
			<dl>
				<dt>订单管理</dt>
				<dd><a href="${pageContext.request.contextPath}/pcenter/home">我的订单</a></dd>
				<dd><a href="${pageContext.request.contextPath}/pcenter/home">收货地址</a></dd>
			</dl>
		</div>
		<!--功能菜单 end-->
	</div>
</div>