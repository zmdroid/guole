<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
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
		<!--充值-->
			<a href="${pageContext.request.contextPath}/pcenter/rechargeHistory">充值记录</a>
		<div class="RechBox">
			<span class="FL RechTabsTi">请选择充值方式:</span>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="CA">充值方式:</td>
					<td>支付宝<input type="hidden" id="type" value="1" /></td>
				</tr>
				<tr>
					<td class="CA">充值金额:</td>
					<td><input class="WMid" type="text" id="moneynum1"> 元</td>
				</tr>
				<tr>
					<td class="CA">备注:</td>
					<td><input class="WMid" type="text" id="remark1"></td>
				</tr>
				<tr>
					<td class="CA"></td>
					<td>
						<a href="javascript:void(0)" onclick="recharge(1)" class="But">确认充值</a>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="CA">充值方式:</td>
					<td>线下汇款<input type="hidden" id="type" value="2" /></td>
				</tr>
				<tr>
					<td class="CA">充值金额:</td>
					<td><input class="WMid" type="text" id="moneynum2"> 元</td>
				</tr>
				<tr>
					<td class="CA">备注:</td>
					<td><input class="WMid" type="text" id="remark2"></td>
				</tr>
				<tr>
					<td class="CA"></td>
					<td>
						<a href="javascript:void(0)" onclick="recharge(2)" class="But">确认充值</a>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="CA">充值方式:</td>
					<td>银行转账<input type="hidden" id="type" value="3" /></td>
				</tr>
				<tr>
					<td class="CA">充值金额:</td>
					<td><input class="WMid" type="text" id="moneynum3"> 元</td>
				</tr>
				<tr>
					<td class="CA">备注:</td>
					<td><input class="WMid" type="text" id="remark3"></td>
				</tr>
				<tr>
					<td class="CA"></td>
					<td>
						<a href="javascript:void(0)" onclick="recharge(3)" class="But">确认充值</a>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="CA">充值方式:</td>
					<td>礼品卷兑换</td>
				</tr>
				<tr>
					<td class="CA">礼品卷编号:</td>
					<td><input class="WMid" type="text" id="cardId"> 元</td>
				</tr>
				<tr>
					<td class="CA">礼品卷密码:</td>
					<td><input class="WMid" type="text" id="cardPwd"></td>
				</tr>
				<tr>
					<td class="CA"></td>
					<td>
						<a href="javascript:void(0)" onclick="rechargeCard()" class="But">确认充值</a>
					</td>
				</tr>
			</table>
		</div>
		<!--充值 end-->

	</div>
	<!--PageBody end-->
	<!--Footer-->
	<!--Footer end-->
	<%@include file="/js.jsp"%>
</body>
<script type="text/javascript">
	function recharge(type) {
		var money,remark;
		type = parseInt(type)
		switch(type){
		case 1:
				money = $('#moneynum1').val();
				 remark = $('#remark1').val();
				 break;
		case 2: money = $('#moneynum2').val();
				 remark = $('#remark2').val();
				 break;
		case 3: money = $('#moneynum3').val();
				 remark = $('#remark3').val();
				 break;
		}
		if (!money) {
			alert('填写充值金额');
			return;
		}
		if (!remark) {
			alert('填写备注');
			return;
		}
		$.post(
				"${pageContext.request.contextPath}/recharge.do?r="+new Date(),
				{
					"rechargeVO.type" : type,
					"rechargeVO.moneynum" : money,
					"rechargeVO.remark":remark
				},
				function(rs) {
					if (rs === 'true') {
					alert('申请成功');
					top.location.href = '${pageContext.request.contextPath}/pcenter/rechargeHistory';
					}
			});
	}
	
	/**
	* 礼品卷充值
	*/
	function rechargeCard() {
		var cardId,cardPwd;
		cardId = $('#cardId').val();
		cardPwd = $('#cardPwd').val();
		if (!cardId) {
			alert('填写礼品卷编号');
			return;
		}
		if (!cardPwd) {
			alert('填写礼品卷密码');
			return;
		}
		$.post(
				"${pageContext.request.contextPath}/rechargeCard.do?r="+new Date(),
				{
					"giftCardVO.cardNum" : cardId,
					"giftCardVO.pwd":cardPwd
				},
				function(rs) {
					alert(rs);
					
					if (rs === 'true') {
					alert('申请成功');
					top.location.href = '${pageContext.request.contextPath}/pcenter/rechargeHistory';
					}
			});
	}
</script>
</html>