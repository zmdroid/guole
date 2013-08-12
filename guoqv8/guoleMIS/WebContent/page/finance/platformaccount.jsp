<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>平台账务</title>
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
		<jsp:param value="financeManage" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>平台账务</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">	
			
			<div>
				<div class="con">
					<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>平台总账</th>
							<th>平台金额</th>
							<th>虚拟账户总金额</th>
						</tr>
						<tr>
							<td class="textLeft" id="plattotal"></td>
							<td class="textLeft" id="platmoney"></td>
							<td class="textLeft" id="usermoney"></td>
						</tr>
					</table>
				</div>
			</div>
			<fieldset class="SearchBox">
					<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">起止日期:</td>
							<td>
								<input id="timeRange1" name="rechargeQuery.startDate" onkeydown="return false;"readonly="readonly" onClick="WdatePicker()" class="width120">
								-
								<input id="timeRange2" name="rechargeQuery.startDate" onkeydown="return false;"readonly="readonly" onClick="WdatePicker()" class="width120">
							</td>
							<td><a href="javascript:void(0);" onclick="loadData()" class="btn  btn-blue">筛选</a></td>
						</tr>
						<tr>
							<td class="CA">流水类型:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="State current" data="-1">全部</a>
								<a href="javascript:;" class="State" data="1">充值</a>
								<a href="javascript:;" class="State" data="2">交易</a>
								<a href="javascript:;" class="State" data="3">返款</a>
							</td>
						</tr>
					</table>
				</fieldset>
			<div class="Summary">
				平台流水：
			</div>
			<div>
				<div class="con">
					<table class="display stylized" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th scope="col">流水号</th>
							<th scope="col">交易类型</th>
							<th scope="col">用户名称</th>
							<th scope="col">交易方式</th>
							<th scope="col">交易详情</th>
							<th scope="col">时间</th>
							<th scope="col">金额</th>
							<th scope="col">账号余额</th>
						</tr>
						<tbody id="billList">
						</tbody>
					</table>
				</div>
			</div>
			<div class="leading" id="pageTool">
				<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
			</div>
		<!--列表-->
		</div>
	</div>
	
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
<script id="billTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var bill = data[i];
		#>
		<#if(bill.virtual==1){#>
			<tr style=background:#E7E7E7>
		<#}else{#>
			<tr>
		<#}#>
			<td class="textLeft"><#=bill.sn#></td>
			<td class="textLeft"><#=convertTradeType(bill.tradetype>>0)#></td>
			<td class="textLeft">
				<#=bill.userName#>
			</td>
			<td class="textLeft"><#=convertTradeChannel(bill.tradechannel>>0)#></td>
			<td class="textLeft">单号：
				<#if(convertTradeType(bill.tradetype>>0)=='充值'){#>
					<a target="_new" href="${pageContext.request.contextPath}/lookRechargeBill.do?tradeId=<#=bill.tradeId#>"><#=bill.tradeId#></a>
				<#}#>
				<#if(convertTradeType(bill.tradetype>>0)=='提现'){#>
					<a target="_new" href="${pageContext.request.contextPath}/lookWithDrawingBill.do?tradeId=<#=bill.tradeId#>"><#=bill.tradeId#></a>
				<#}#>
				<#if(convertTradeType(bill.tradetype>>0)=='线路购买'){#>
					<a target="_new" href="${pageContext.request.contextPath}/getOrderDetail.do?orderNo=<#=bill.tradeId#>"><#=bill.tradeId#></a>
				<#}#>
				<#if(convertTradeType(bill.tradetype>>0)=='返款'){#>
					<a target="_new" href="${pageContext.request.contextPath}/getRefundDetail.do?refundId=<#=bill.tradeId#>"><#=bill.tradeId#></a>
				<#}#>
				<#if(convertTradeType(bill.tradetype>>0)=='佣金'){#>
					<a target="_new" href="${pageContext.request.contextPath}/getCommissionDetail.do?tradeId=<#=bill.tradeId#>"><#=bill.tradeId#></a>
				<#}#>
			</td>
			<td class="textLeft"><#=convertDate(bill.currtime)#></td>
			<td class="textLeft"><span class="CD"><#=bill.type==1?'+':'-'#>&nbsp;<#=bill.money#></span></td>
			<td class="textLeft"><#=bill.balance#></td>
		</tr>
		<#}#>
	<!--列表 end-->
</script>
<script id="pageTmpl" type="text/x-fn-tmpl">
	<#if(pageCount > 1){#>
		<div class="Pages">
			<#if(currPageIndex<2){#>
				<a class="number" class="Disabled" href="javascript:void(0)">&lt;&lt</a>&nbsp;
			<#}else{#>
				<a class="number" href="javascript:loadData(<#=currPageIndex-1#>)">&lt;&lt</a>&nbsp;
			<#}#>
			<%-- 出现首页导航 --%>
			<#if(currPageIndex>(pageLength+1)){#>
				<a href="javascript:loadData(1)">1...</a>&nbsp;
				<#for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){#>
					<#var tmp = j+1;#>
					<a class="number" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}else{#>
				<#for(var j=1;j<currPageIndex;j++){#>
					<a class="number" href="javascript:loadData(<#=j#>)"><#=j#></a>&nbsp;
				<#}#>
			<#}#>
			<a class="number pagination-active" href="javascript:void(0)"><#=currPageIndex#></a>&nbsp;
			<%-- 出现末页导航 --%>
			<#if(pageCount-pageLength>currPageIndex){#>
				<#for(var j=1;j<=pageLength;j++){#>
					<#var tmp = currPageIndex+j;#>
					<a class="number" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
				<a class="number" href="javascript:loadData(<#=pageCount#>)">...<#=pageCount#></a>&nbsp;
			<#}else{#>
				<#for(var j=1;j<=(pageCount-currPageIndex);j++){#>
					<#var tmp = currPageIndex+j;#>
					<a class="number" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}#>
			
			<#if(currPageIndex==pageCount){#>
				<a class="Disabled" href="javascript:void(0)">&gt;&gt</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex+1#>)">&gt;&gt</a>
			<#}#>
			</div>
		<#}#>
</script>
<script type="text/javascript">
	var pageCount,pageLength=4,currPageIndex=1, tradeId,refundId,reason;
	function loadData(pageIndex){
		$('#billList').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		var timeRange;
		if($('#timeRange1').val()){
			timeRange = $('#timeRange1').val()+','+$('#timeRange2').val();
		}
		tradeId = $('#tradeId').val();
		refundId = $('#refundId').val();
		type = $("a.State[class*='current']").attr("data");
		$.get("${pageContext.request.contextPath}/platformAccount.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'timeRange':timeRange,'type':type},function(rs){
			if(!rs || !rs.length)return;
	       	var plattotal = rs[0];
	       	var platmoney = rs[1];
	       	var usermoney = rs[2];
	       	$("#plattotal").html(plattotal);
	       	$("#platmoney").html(platmoney);
	       	$("#usermoney").html(usermoney);
	       	pageCount = rs[4];
	       	if(!pageCount)return;
	       	rs = rs[3];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#billTmpl').html())(rs);
	    		$('#billList').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();
	
	// 绑定点击线路类型原因事件
	$("a.State").each(function(){
		$(this).bind("click", function(){
			$("a.State").removeClass("current");
			$(this).addClass("current");
			loadData(1);
		});
	});
</script>
</html>