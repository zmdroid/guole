<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.guoqv8.com/fnx" prefix="fnx" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>订单详细页</title>
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
		<jsp:param value="orderManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>订单详细页</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
			<!-- Wrapper -->
		<div class="wrapper">		
			<!-- 订单信息 -->
			<div class="Summary">
				订单单号：${orderVO.id }
			</div>
			<div class="rightmenu">
				<h3 class="title">买家信息</h3>				
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="CA">联系人:</td>
						<td width="250px">${UserInfoVO.name }</td>
						<td class="CA">联系QQ:</td>
						<td width="250px">${UserInfoVO.qq }</td>
						<td class="CA">联系电话:</td>
						<td width="250px">${UserInfoVO.mobile }</td>
					</tr>
				</table>
			</div>
			<div class="rightmenu">
				<h3 class="title">送货信息</h3>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">					
					<tr>
						<td class="CA">联系人:</td>
						<td width="250px">${orderVO.linkMan }</td>
						<td class="CA">联系电话:</td>
						<td width="250px">${orderVO.linkPhone }</td>
						<td class="CA">送货地址:</td>
						<td width="250px">${orderVO.address }</td>
					</tr>
				</table>
			</div>
			<div class="rightmenu">
				<h3 class="title">订单信息</h3>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">订单编号:</td>
							<td>${orderVO.id }</td>
						</tr>
						<tr>
							<td class="CA">创建时间:</td>
							<td>${fnx:dateToString(orderVO.createTime)}</td>
						</tr>
						<tr>
							<td class="CA">合计:</td>
							<td><span class="CB F24">¥${orderVO.money }</span> 元</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="CA">特殊要求:</td>
							<td colspan="3">无</td>
						</tr>
						<tr>
							<td class="CA">订单状态:</td>
							<td>
								<c:choose>  
							       <c:when test="${orderVO.state==0}">  
							                   待付款
							       </c:when>  
							       <c:when test="${orderVO.state==1}">  
							          	 已付款
							       </c:when>  
							       <c:when test="${orderVO.state==2}">  
							           	 交易成功  
							       </c:when>  
							       <c:when test="${orderVO.state==3}">  
							           	  交易关闭
							       </c:when>  
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
				<div class="rightmenu">
				<h3 class="title">订单详情</h3>
				<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
							<tr>
								<th>商品名称</th>
								<th>商品单价</th>
								<th>购买数量</th>
								<th>商品规格</th>
								<th>备注</th>
							</tr>
						</thead>
						<c:forEach var="orderDetail" items="${orderVO.orderDetailList}">
							<tr>
								<td>${orderDetail.productName }</td>
								<td>${orderDetail.price }</td>
								<td>${orderDetail.num }</td>
								<td>${orderDetail.spec }</td>
								<td>${orderDetail.remark }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			<!-- 订单信息end -->
			<!-- 订单日志信息 -->
			<!-- 订单日志信息end -->
			<!-- 订单流水信息 -->
			<div class="rightmenu">
				<h3 class="title">订单流水：</h3>	
					<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>流水编号：</th>
							<th>用户名称：</th>
							<th>订单编号：</th>
							<th>交易类型：</th>
							<th>交易方式：</th>
							<th>创建时间：</th>
							<th>流水金额：</th>
							<th>流水类型：</th>
						</tr>
						<c:forEach var="billVO" items="${billVOs}">
							<tr>
								<td class="textLeft">${billVO.sn }</td>
								<td class="textLeft">
										${billVO.userName }
								</td>
								<td class="textLeft">${billVO.tradeId }</td>
								<td class="textLeft">
									<c:choose>
										<c:when test="${fnx:convert(billVO.tradetype)==1 }">
											充值
										</c:when>
										<c:when test="${fnx:convert(billVO.tradetype)==2 }">
											交易
										</c:when>
										<c:when test="${fnx:convert(billVO.tradetype)==3 }">
											返款
										</c:when>
									</c:choose>
								</td>
								<td class="textLeft">
									<c:choose>
										<c:when test="${fnx:convert(billVO.tradechannel)==1 }">
											平台内
										</c:when>
										<c:when test="${fnx:convert(billVO.tradechannel)==2 }">
											线下
										</c:when>
										<c:when test="${fnx:convert(billVO.tradechannel)==3 }">
											支付宝
										</c:when>
										<c:when test="${fnx:convert(billVO.tradechannel)==4 }">
											礼品卡
										</c:when>
									</c:choose>
									
								</td>
								<td class="textLeft">
									${fnx:dateToString(billVO.currtime)}
								</td>
								<td class="textLeft">
									<c:choose>
										<c:when test="${fnx:convert(billVO.type)==1 }">
											+
										</c:when>
										<c:when test="${fnx:convert(billVO.type)==2 }">
											-
										</c:when>
									</c:choose>
									${billVO.money }
								</td>
								<td class="textLeft">
									<c:choose>
										<c:when test="${fnx:convert(billVO.type)==1 }">
											收入
										</c:when>
										<c:when test="${fnx:convert(billVO.type)==2 }">
											支出
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- 订单流水信息end -->
			<center>
				<a href="javascript:closeWin();" id="searchBtn" class="btn  btn-blue">关闭页面</a>
				<br/><br/>
			</center>
		</div>
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
</html>