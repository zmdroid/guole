<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>退款管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
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
			<h1>退款管理</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
	
		<!-- Wrapper -->
		<div class="wrapper">
				<!--添加标签-->
				<fieldset class="SearchBox">
					<legend>检索条件</legend>
					<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">退款单号:</td>
							<td>
								<input type="text" id="refundId">
							</td>
						</tr>
						<tr>
							<td class="CA">订&nbsp;&nbsp;单&nbsp;&nbsp;号:</td>
							<td>
								<input type="text" id="tradeId">
							</td>
						</tr>
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
							<td class="CA">退款原因:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="Reason current" data="-1">全部</a>
								<a href="#" class="Reason" data="1">卖家过期未确定</a>
								<a href="#" class="Reason" data="2">卖家取消</a>
								<a href="#" class="Reason" data="3">卖家下架</a>
							</td>
						</tr>
					</table>
				</fieldset>
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						佣金列表
						<span class="FR">
							<a href="#" class="btn"><span class="icon icon_export"></span>导出列表</a>
							<a href="#" class="btn"><span class="icon icon_print"></span>打印列表</a>
						</span>
					</h3>
					<table class="display stylized">
							<thead>
								<tr>
									<th scope="col">返款编号</th>
									<th scope="col">返款单号</th>
									<th scope="col">接受用户</th>
									<th scope="col">时间</th>
									<th scope="col">金额</th>
									<th scope="col">返款原因</th>
									<th scope="col">操作</th>
								</tr>
							</thead>
							<tbody id="refundList">
							</tbody>
						</table>
				</div>
			<div class="leading" id="pageTool">
				<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
			</div>
		</div>
		<!--列表-->
	</div>
	
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
<script id="commissionTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var refund = data[i];
		#>
		<tr>
			<td><#=refund.id#></td>
			<td>单号：
				<a target="_new" href="${pageContext.request.contextPath}/getRefundDetail.do?refundId=<#=refund.id#>"><#=refund.orderNo#></a>
			</td>
			<td>
				<#=refund.userName#>
			</td>
			<td class="CA"><#=convertTime(refund.backtime)#></td>
			<td><span class="CD"><#=refund.moneynum#></span></td>
			<td><span class="CD">
				<#if(refund.reason==1){#>
					卖家过期未确定
				<#}else if(refund.reason==2){#>
					卖家取消
				<#}else if(refund.reason==3){#>
					卖家下架
				<#}#>
				</span></td>
			<td><a target="_new" href="${pageContext.request.contextPath}/getRefundDetail.do?refundId=<#=refund.id#>">查看</a></td>
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
		$('#refundList').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		var timeRange;
		if($('#timeRange1').val()){
			timeRange = $('#timeRange1').val()+','+$('#timeRange2').val();
		}

		tradeId = $('#tradeId').val();
		refundId = $('#refundId').val();
		reason = $("a.Reason[class*='current']").attr("data");
		$.get("${pageContext.request.contextPath}/getRefund.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'timeRange':timeRange,
				'tradeId':tradeId,'refundId':refundId,'reason':reason},function(rs){
			if(!rs || !rs.length)return;
	       	pageCount = rs.shift();
	       	if(!pageCount)return;
	       	rs = rs[0];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#commissionTmpl').html())(rs);
	    		$('#refundList').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();
	
	// 绑定点击退款原因事件
	$("a.Reason").each(function(){
		$(this).bind("click", function(){
			$("a.Reason").removeClass("current");
			$(this).addClass("current");
			loadData(1);
		});
	});
</script>
</html>