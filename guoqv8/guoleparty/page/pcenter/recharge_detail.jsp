<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户中心</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>

<body>
<!--Header-->
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>
<!--Header end--> 
<!--PageBody-->
<div id="PageBody">
	<div class="WAll">
		<div class="ManBox MainBG">
			<div class="FR Right">
				<div class="RBody">
					<!--面包屑-->
					<div class="Breadcrumbs">
						<a href="">首页</a> >
						<a href="">旅财金账户</a> >
						账户充值
					</div>
					<!--面包屑 end-->
					<!--充值-->
					<div class="ODetailList CTable">
						<div class="FB CC">充值信息</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="CA">充值时间:</td>
								<td id="time"></td>
							</tr>
							<tr>
								<td class="CA">充值方式:</td>
								<td id="type"></td>
							</tr>
							<tr>
								<td class="CA">充值金额:</td>
								<td id="money"></td>
							</tr>
							<tr>
								<td class="CA">充值状态:</td>
								<td id="state"></td>
							</tr>
						</table>
						<div><a href="javascript:window.close()" class="But">关闭</a></div>
					</div>
					<!--充值 end-->
				</div>
			</div>
			
			
		</div>
	</div>
</div>
<!--PageBody end--> 
<!--Footer-->
<!--Footer end-->
<%@include file="/js.jsp" %>
</body>
<script type="text/javascript">
	$.get("${pageContext.request.contextPath}/getRecharge.do",{'rechargeVO.rechargeId':'${param.no}',r:Math.random()},function(rs){
		$("#time").html(convertDate(rs.optime));
		$("#type").html(convertTradeChannel(rs.type>>0));
		$("#money").html((rs.moneynum)+'元');
		$("#state").html(convertWithdrawingState(rs.state>>0));
	},'json');
</script>
</html>