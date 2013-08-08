<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>流水信息</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.textLeft {
		text-align: left!important; 
	}

	.money{
		color:rgb(255, 127, 0)!important;
		font-weight:bold;
	}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="recharge" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				<c:if test="${billVO.tradetype == 1}">充值管理</c:if>
				 → <span>查看流水</span>
			</h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">			
			<div class="Summary">
				<c:if test="${billVO.tradetype == 1}">充值单号：</c:if>
				${tradeId} 
			</div>
			<br/>
			<div>
				<div class="con">
					<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>交易流水号</th>
							<th>业务单号</th>
							<th>交易类型</th>
							<th>交易方式</th>
							<th>流水类型</th>
							<th>交易金额</th>
							<th>账户余额</th>
						</tr>
						<tr>
							<td class="textLeft">${billVO.sn}</td>
							<td class="textLeft">${billVO.tradeId}</td>
							<td class="textLeft">
								<c:if test="${billVO.tradetype == 1}">充值</c:if>
							</td>
							<td class="textLeft">
								<c:if test="${billVO.tradechannel == 1}">平台内 </c:if>
								<c:if test="${billVO.tradechannel == 2}">线下</c:if>
								<c:if test="${billVO.tradechannel == 3}">支付宝</c:if>
								<c:if test="${billVO.tradechannel == 4}">支票</c:if>
							</td>
							<td class="textLeft">
								<c:if test="${billVO.type == 1}">收入 </c:if>
								<c:if test="${billVO.type == 2}">支出 </c:if>
							</td>
							<td class="F20 FB textLeft money">
								<c:if test="${billVO.type == 1}">+ </c:if>
								<c:if test="${billVO.type == 2}">- </c:if>
								${billVO.money}
							</td>
							<td class="F20 FB textLeft money">¥ ${billVO.balance}</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<center>
			<a href="javascript:closeWin();" id="searchBtn" class="btn  btn-blue">关闭页面</a>
			<br/><br/>
		</center>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
</html>