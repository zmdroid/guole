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
<title>返款详细页</title>
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
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				返款详细
				 → <span>查看返款信息</span>
			</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- 流水信息 -->
		<!-- Wrapper -->
		<div class="wrapper">			
			<div class="Summary">
				返款单号：	${refundVO.id }
			</div>
			<div>
				<div class="con">
					<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>返款单号</th>
							<th>订单号</th>
							<th>接受人</th>
							<th>返款时间</th>
							<th>返款金额</th>
							<th >返款原因</th>
						</tr>
						<tr>
							<td class="textLeft">${refundVO.id }</td>
							<td class="textLeft">${refundVO.orderNo }</td>
							<td class="textLeft">${refundVO.userName }</td>
							<td class="textLeft">
								<script type="text/javascript">
									document.write(convertTime("${refundVO.backtime }"));
								</script>
							</td>
							<td class="textLeft">${refundVO.moneynum }</td>
							<td class="textLeft">
								<c:choose>
									<c:when test="${refundVO.reason=='1' }">
										卖家过期未确定
									</c:when>
									<c:when test="${refundVO.reason=='2' }">
										卖家取消
									</c:when>
									<c:when test="${refundVO.reason=='3' }">
										卖家下架
									</c:when>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 返款信息end -->
			<!-- 流水信息 -->
			<div class="Summary">
				流水单号：	${billVO.sn }
			</div>
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
							<td class="textLeft">${billVO.sn }</td>
							<td class="textLeft">${billVO.tradeId }</td>
							<td class="textLeft">
								<c:choose>
										<c:when test="${billVO.tradetype==1 }">
											充值
										</c:when>
										<c:when test="${billVO.tradetype==2 }">
											提现
										</c:when>
										<c:when test="${billVO.tradetype==3 }">
											交易
										</c:when>
										<c:when test="${billVO.tradetype==4 }">
											返款
										</c:when>
										<c:when test="${billVO.tradetype==5 }">
											佣金
										</c:when>
								</c:choose>
							</td>
							<td class="textLeft">
								<c:choose>
										<c:when test="${billVO.tradechannel==1 }">
											支付宝
										</c:when>
										<c:when test="${billVO.tradechannel==2 }">
											线下
										</c:when>
										<c:when test="${billVO.tradechannel==3 }">
											支票
										</c:when>
										<c:when test="${billVO.tradechannel==4 }">
											平台内
										</c:when>
								</c:choose>
							</td>
							<td class="textLeft">
								<c:choose>
										<c:when test="${billVO.type==1 }">
											收入
										</c:when>
										<c:when test="${billVO.type==2 }">
											支出
										</c:when>
								</c:choose>
							</td>
							<td class="F20 FB textLeft money">
								<c:choose>
										<c:when test="${billVO.type==1 }">
											+
										</c:when>
										<c:when test="${billVO.type)==2 }">
											-
										</c:when>
									</c:choose>
								${billVO.money }
							</td>
							<td class="F20 FB textLeft money">¥ ${billVO.balance }</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 流水信息end -->
			<!-- 订单信息 -->
			<div class="Summary">
				订单单号：${orderVO.orderNo }
			</div>
			<div class="rightmenu">
				<h3 class="title">买家信息</h3>				
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="CA">联系人:</td>
						<td width="250px">${buyerInfoVO.name }</td>
						<td class="CA">联系邮箱:</td>
						<td width="250px">${buyerInfoVO.email }</td>
						<td class="CA">联系电话:</td>
						<td width="250px">${buyerInfoVO.mobile }</td>
					</tr>
				</table>
			</div>
			<div class="rightmenu">
				<h3 class="title">卖家信息</h3>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">					
					<tr>
						<td class="CA">店铺名称:</td>
						<td width="250px">${sellerInfoVO.name }</td>
						<td class="CA">卖&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家:</td>
						<td width="250px">${sellerInfoVO.name }</td>
						<td class="CA">联系电话:</td>
						<td width="250px">${sellerInfoVO.mobile }</td>
					</tr>
				</table>
			</div>
			<div class="rightmenu">
				<h3 class="title">订单信息</h3>
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">订单编号:</td>
							<td>${orderVO.orderNo }</td>
							<td class="CA">创建时间:</td>
							<td>
								<script type="text/javascript">
									document.write(convertTime("${orderVO.createTime }"));
								</script>
							</td>
						</tr>
						<tr>
							<td class="CA">商品名称:</td>
							<td>${orderVO.lineName }</td>
							<td class="CA">出发城市:</td>
							<td>${lineVO.fromplace }</td>
						</tr>
						<tr>
							<td class="CA">到达城市:</td>
							<td>${lineVO.toplace }</td>
							<td class="CA">出发日期:</td>
							<td>${orderVO.startDate }</td>
						</tr>
						<tr>
							<td class="CA">返程日期:</td>
							<td>${orderVO.endDate }</td>
							<td class="CA">成人人数:</td>
							<td>${orderVO.adultnum }人 X ${orderVO.adultUnit }元 = <span class="CB">
								<script type="text/javascript">
									var adultmoney = ${orderVO.adultnum }*${orderVO.adultUnit };
									document.write(adultmoney);
								</script>
							</span> 元</td>
						</tr>
						<tr>
							<td class="CA">儿童人数:</td>
							<td>${orderVO.childnum }人 X ${orderVO.childUnit }元 = <span class="CB">
								<script type="text/javascript">
									var childmoney = ${orderVO.childnum }*${orderVO.childUnit };
									document.write(childmoney);
								</script>
							</span> 元</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="CA">合计:</td>
							<td><span class="CB F24">¥${orderVO.moneynum }</span> 元</td>
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
							          	 卖家待确认
							       </c:when>  
							       <c:when test="${orderVO.state==2}">  
							           	  交易关闭
							       </c:when>  
							       <c:when test="${orderVO.state==3}">  
							           	 交易成功  
							       </c:when>  
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
			<!-- 订单信息end -->
		</div>
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