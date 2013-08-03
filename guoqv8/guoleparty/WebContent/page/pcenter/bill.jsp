<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

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
	<!--Header end-->
	<!--PageBody-->
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>
	<br>
		账户余额:
		<span class="CB F18">
			<i class="F12" id="balance">￥</i>&nbsp;&nbsp;
		</span>
		<a href="${pageContext.request.contextPath}/pcenter/recharge" class="But">充值</a>
	<br>
	<div id="PageBody">
		<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">交易单号:</td>
				<td>
					<span class="IBoxTip"> 
						<input class="IEnter WMax" type="text" id="tradeId"> 
						<label class="IExplain">交易单号</label>
					</span>
				</td>
				<td class="CA">起止日期:</td>
				<td>
					<input class="" type="text" id="timeRange1">-
					<input class="" type="text" id="timeRange2">
				</td>
				<td>
					<a href="javascript:void(0);" onclick="loadData()" class="But">筛选</a>
				</td>
			</tr>
			<tr>
				<td class="CA">明细类型:</td>
				<td colspan="3" class="InChoose">
					<label class="lab-wrap type-lab-wrap"> 
						<input type="checkbox" checked="checked" name="tradeType" value="1">充值
					</label> 
					<label class="lab-wrap type-lab-wrap"> 
						<input type="checkbox" checked="checked" name="tradeType" value="2">商品交易
					</label> 
					<label class="lab-wrap type-lab-wrap"> 
						<input type="checkbox" checked="checked" name="tradeType" value="3">返款
					</label> 
				</td>
				<td class="CA">金额范围:</td>
				<td colspan="3" class="InChoose">
					<input class="" type="text" id="moneyRange1">-
					<input class="" type="text" id="moneyRange2">
				</td>
			</tr>
		</table>
	</div>
	<!--查询 end-->
	<!--列表-->
	<div class="ManList">
		<div class="List">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<thead>
				<th scope="col">流水号</th>
				<th scope="col">交易类型</th>
				<th scope="col">交易详情</th>
				<th scope="col">时间</th>
				<th scope="col">金额</th>
				<th scope="col">收/支</th>
				<th scope="col">余额</th>
			</thead>
			<tbody id="container">
			</tbody>
		</table>
		</div>
	</div>



	<!--PageBody end-->
	<!--Footer-->
	<!--Footer end-->
	<%@include file="/js.jsp"%>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/Script/fn.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/Script/util.js"></script>
<script id="billTmpl" type="text/x-fn-tmpl">

		<#
			for(var i = 0,l = data.length; i < l; i++){
				var bill = data[i];
		#>
		<tr>
			<td><#=bill.sn#></td>
			<td><#=convertTradeType(bill.tradetype>>0)#></td>
			<td>单号：
				<#if(bill.tradetype==1){#>
					<a target="_new" href="${pageContext.request.contextPath}/Page/pcenter/recharge_detail.jsp?no=<#=bill.tradeId#>">
				<#}#>
				<#if(bill.tradetype==2){#>
					<a target="_new" href="${pageContext.request.contextPath}/Page/pcenter/withdrawing_detail.jsp?no=<#=bill.tradeId#>">
				<#}#>
				<#if(bill.tradetype==3){#>
					<a target="_new" href="${pageContext.request.contextPath}/Page/pcenter/${sessionScope.current_user_info.usertype == 1?'myorderdetail':'sellerorderdetail'}/<#=bill.tradeId#>">
				<#}#>
<#=bill.tradeId#>
				</a>
			</td>
			<td class="CA"><#=convertDate(bill.currtime)#></td>
			<td><span class="CD"><#=bill.type==1?'+':'-'#>&nbsp;<#=bill.money#></span></td>
			<td><#=convertBillType(bill.type>>0)#></td>
			<td><#=bill.balance#></td>
		</tr>
		<#}#>
	<!--列表 end-->
	<#if(pageCount > 1){#>
		<div class="Pages">
			<#if(currPageIndex<2){#>
				<a class="Disabled" href="javascript:void(0)">上页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex-1#>)">上页</a>&nbsp;
			<#}#>
			<%-- 出现首页导航 --%>
			<#if(currPageIndex>(pageLength+1)){#>
				<a href="javascript:loadData(1)">1...</a>&nbsp;
				<#for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){#>
					<#var tmp = j+1;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}else{#>
				<#for(var j=1;j<currPageIndex;j++){#>
					<a href="javascript:loadData(<#=j#>)"><#=j#></a>&nbsp;
				<#}#>
			<#}#>
			<a class="Active" href="javascript:void(0)"><#=currPageIndex#></a>&nbsp;
			<%-- 出现末页导航 --%>
			<#if(pageCount-pageLength>currPageIndex){#>
				<#for(var j=1;j<=pageLength;j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
				<a href="javascript:loadData(<#=pageCount#>)">...<#=pageCount#></a>&nbsp;
			<#}else{#>
				<#for(var j=1;j<=(pageCount-currPageIndex);j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}#>
			
			<#if(currPageIndex==pageCount){#>
				<a class="Disabled" href="javascript:void(0)">下页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex+1#>)">下页</a>
			<#}#>
			</div>
		<#}#>
</script>
<script type="text/javascript">

	var pageCount, pageLength = 4, currPageIndex = 1, tradetypes = "", timeRange, moneyRange, tradeId, types;
	/**
	*	加载账户流水
	*/
	function loadData(pageIndex) {
		tradetypes = "";
		$('#container').html("");
		currPageIndex = pageIndex = pageIndex || 1;
		$("input[name=tradeType]").each(function() {
			if ($(this).attr("checked")) {
				tradetypes += "," + $(this).val();
			}
		});
		if (tradetypes.length > 1)
			tradetypes = tradetypes.substring(1, tradetypes.length);
		if ($('#timeRange1').val()) {
			timeRange = $('#timeRange1').val() + ',' + $('#timeRange2').val();
		}
		if ($('#moneyRange1').val()) {
			moneyRange = $('#moneyRange1').val() + ','
					+ $('#moneyRange2').val();
		}
		tradeId = $('#tradeId').val();
		$.get("${pageContext.request.contextPath}/getBills.do?t="
				+ Math.random(), {
			'pageIndex' : pageIndex,
			'tradetypes' : tradetypes,
			'timeRange' : timeRange,
			'moneyRange' : moneyRange,
			'tradeId' : tradeId,
			'types' : types
		}, function(rs) {
			if (!rs || !rs.length)
				return;
			pageCount = rs.shift();
			if (!pageCount)
				return;
			rs = rs[0];
			if (rs) {
				//初始化模版引擎
				var tmplOpts = {
					varName : 'data',
					compiler : 'rapid'
				};
				fn.template.setting(tmplOpts);
				var html = fn.template($('#billTmpl').html())(rs);
				$('#container').html(html);
			}
		}, 'json');
	}
	//加载账户流水
	loadData();
	
	//查询账户余额
	$.get('${pageContext.request.contextPath}/getAccountInfo.do?t='+ new Date().getTime(),{},function(rs){
		$('#balance').text('￥'+rs.balance);
	},'json');
</script>
</html>