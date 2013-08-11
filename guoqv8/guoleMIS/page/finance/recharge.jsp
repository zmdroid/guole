<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>充值管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<script type="text/javascript">
/**
	<c:if test="${current_user_permission['recharge.jsp'] != true}">
		alert("无权访问");
		window.location.href = "${pageContext.request.contextPath}/index.jsp";
	</c:if>
*/
	</script>
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width120{
		width:120px !important;
	}
	
	.width130{
		width:130px !important;
	}
	
	.pointer{
		cursor: pointer;
	}
	
	.icon_export {
		background-image: url("${pageContext.request.contextPath}/img/export.png");
	}
	
	.icon_print {
		background-image: url("${pageContext.request.contextPath}/img/print.png");
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
			<h1>财务管理 → <span>充值管理</span></h1>
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
					<form id="paramForm">
						<p>
							<label>时间范围:</label>
							<input type="text" name="rechargeQuery.startDate" onkeydown="return false;" id="startDate" readonly="readonly" onClick="WdatePicker()" class="width120"/>
							<label>~</label>
							<input type="text" name="rechargeQuery.endDate" onkeydown="return false;" id="endDate" readonly="readonly" onClick="WdatePicker()" class="width120"/>
							<label>流 水 号:</label>
							<input type="text" name="rechargeQuery.sn" id="sn" class="width120"/>
							<label>公司名称:</label>
							<input type="text" name="rechargeQuery.corName" id="corName" class="width120"/>
							<label>充值方式:</label>
							<select id="type" class="width130" name="rechargeQuery.type">
								<option value="-1">所有方式</option>
								<option value="1">支 付 宝</option>
								<option value="2">线　   下</option>
								<option value="3">银行转账</option>
							</select>
						</p>
						<br/>
						<p>
							<label>状　　态:</label>
							<select id="state" class="width130" name="rechargeQuery.state">
								<option value="A">所有状态</option>
								<option value="0">申　　请</option>
								<option value="D">取　　消</option>
								<option value="1">通过</option>
								<option value="2">拒绝</option>
							</select>
							<a href="javascript:;" id="queryBtn" class="btn  btn-blue">查询充值单</a>
						</p>
					</form>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						充值单列表
						<span class="FR">
							<a href="#" class="btn"><span class="icon icon_export"></span>导出列表</a>
							<a href="#" class="btn"><span class="icon icon_print"></span>打印列表</a>
						</span>
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>充值单号</th>
								<th>运营商</th>
								<th>充值方式</th>
								<th>机构名称</th>
								<th>帐号名称</th>
								<th>充值金额</th>
								<th>充值时间	</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="rechargeList">
						</tbody>
					</table>
				</div>
				<!--列表 end-->
				<div class="leading" id="pageTool">
					<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
					<div>共 <b id="totalCount">0</b> 条，每页显示 <b>${rechargePageSize}</b> 条</div>
				</div>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
	<link href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
	<script id="rechargeTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var recharge = data[i];
		#>
		<tr>
			<td><#=recharge.rechargeId#></td>
			<td>平台</td>
			<td><#=convertTradeChannel(parseInt(recharge.type))#></td>
			<td><#=recharge.corName#></td>
			<td><#=recharge.userName#></td>
			<td><#=recharge.moneynum#></td>
			<td><#=convertDate(recharge.optime)#></td>
			<td><#=convertWithdrawingState(recharge.state)#></td>
			<td>
				<#
					if (recharge.state == 1) {
				#>
					<a target="_blank" href="${pageContext.request.contextPath}/lookRechargeBill.do?tradeId=<#=recharge.rechargeId#>">查看流水</a>
				<#}else{
					var dos = _rechargeStateDo[recharge.state];
					if (dos) {
						for (var j = 0; j < dos.length; j++) {
							var op = dos[j];
				#> 
					<a href="javascript:change(<#=op.value#>,<#=recharge.rechargeId#>);"><#=op.label#></a>
				<#}}}#>
			</td>
		</tr>
		<#}#>
	</script>
	<script type="text/javascript">
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);
		
		var _rechargeStateDo = ${rechargeStateDo};
		var _actionMap = {1: "cnApproveRecharge.do", 2: "cnRefuseRecharge.do"};
		var _limit = "${rechargePageSize}";
		var _CURRENT_PAGE = 1;
		var _pageDis = false;
		var _trLoading = '<tr><td colspan="10"><img src="${pageContext.request.contextPath}/img/loading1.gif"/></td></tr>';
		// 加载充值单列表
		function loadRecharge() {
			var rechargeList = $("#rechargeList");
			rechargeList.empty();
			rechargeList.html(_trLoading);
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getRechargeList.do?t=" + new Date().getTime(),
				  data: $("#paramForm").serialize() + "&start=" + (_CURRENT_PAGE - 1) * _limit,
				  success:function(data){
					var pg = $("#Pagination");
					if ("error" == data) {
						alert("出错了!");
						return;
					}

					data = $.parseJSON(data);
					var html = "";
					if (data.totalCount == 0){
						_pageDis = false;
						html = "<tr><td colspan='10' style='color:red;'>没有检索到任何提现单</td></tr>";
						pg.hide();
					}else{
						html = fn.template($('#rechargeTmpl').html())(data.rechargeList);
						pg.show();
					}
					
					rechargeList.html(html);
					$("#totalCount").html(data.totalCount);

					var totalPage = Math.ceil(data.totalCount/_limit);
					if (totalPage == 1) {
						pg.hide();
					}
					if (!_pageDis){
				    	pg.pagination(totalPage, {callback: pageselectCallback});
				  	  	_pageDis = true;
				  	}
				  },
				  error: function(){
					  alert("服务端出错");
				  }
			});
		}
		
		// 分页控件回调
		function pageselectCallback(page_index){
			if (_CURRENT_PAGE == (page_index + 1)){
				return false;
			}

			_CURRENT_PAGE = page_index + 1;
			loadRecharge();
			return false;
		}

		loadRecharge();
		
		// 重新加载列表
		function reloadRechargeList() {
			_CURRENT_PAGE = 1;
			_pageDis = false;
			loadRecharge();
		}

		// 更新状态成功刷新列表
		function refreshRechargeList() {
			var tr = $("#rechargeList tr");
			var state = $("#state").val();
			if (state == "-1" || _CURRENT_PAGE == 1) {
				loadRecharge();
			}else{
				if (tr.length == 1) {
					_CURRENT_PAGE -= 1;
				}
				loadRecharge();
			}
		}
		
		// 记账成功刷新列表
		function refreshRechargeListForKeepaccount() {
			var tr = $("#rechargeList tr");
			var state = $("#keepaccount").val();
			if (state == "A" || _CURRENT_PAGE == 1) {
				loadRecharge();
			}else{
				if (tr.length == 1) {
					_CURRENT_PAGE -= 1;
				}
				loadRecharge();
			}
		}
		
		// 更新充值单状态
		function change(state, rechargeId) {
			
			if (!window.confirm("您确定要这么做吗？")) {
				return;
			}

			var action = _actionMap[state];
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/"+ action +"?t=" + new Date().getTime(),
				  data: {rechargeId: rechargeId},
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
					}else{
						alert("成功");
						refreshRechargeList();
					}
				  },
				  error: function(){
					  alert("服务端出错");
				  }
			});
		}

		<c:if test="${current_user_permission['keepaccountRecharge.do'] == true}">
			// 记账
			function keepaccount(orderNo) {
				if (!window.confirm("您确定要执行记账吗？")) {
					return;
				}
	
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/keepaccountRecharge.do?t=" + new Date().getTime(),
					  data: {orderNo: orderNo},
					  success:function(data){
						if ("error" == data) {
							alert("出错了!");
						}else{
							alert("成功");
							refreshRechargeListForKeepaccount();
						}
					  },
					  error: function(){
						  alert("服务端出错");
					  }
				});
			}
		</c:if>

		$("#queryBtn").bind("click", function(){
			if (!/^[0-9]*$/.test($("#sn").val())){
				alert("流水号必须为数字");
				return;
			}

			reloadRechargeList();
		});
	</script>
</body>
</html>