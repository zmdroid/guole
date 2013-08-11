<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>账户明细</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
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
			<h1>财务管理 → <span>账户明细</span></h1>
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
					<form id="qurForm">
						<p>
							<label>起止日期:</label>
							<input type="text" name="startDate" id="startDate" readonly="readonly" onClick="WdatePicker()" class="width120"/>
							<label>~</label>
							<input type="text" name="endDate" id="endDate" readonly="readonly" onClick="WdatePicker()" class="width120"/>
							<label>交易单号:</label>
							<input type="text" name="tradeId" id="tradeId" class="width120"/>
							<label>会员名称:</label>
							<input type="hidden" name="userId" id="userId" value="-1"/>
							<input type="text" name="userName" id="userName" readonly="readonly" onClick="selMember();" class="width120"/>
							<label>明细类型:</label>
							<select id="type" class="width130" name="tradeType">
								<option value="-1">--请选择--</option>
								<option value="1">充值</option>
								<option value="2">提现</option>
								<option value="3">线路购买</option>
								<option value="4">返款</option>
								<option value="5">佣金</option>
							</select>
						    <a href="javascript:qurDetails();void(0);" id="queryBtn" class="btn  btn-blue">查询</a>
						</p>
					</form>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<h3>账户明细列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th scope="col">流水号</th>
								<th scope="col">交易类型</th>
								<th scope="col">交易单号</th>
								<th scope="col">时间</th>
								<th scope="col">金额</th>
								<th scope="col">收/支</th>
								<th scope="col">查看详情</th>
							</tr>
						</thead>
						<tbody id="container">
							
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
    <script type="text/javascript">
	var _CURRENT_PAGE = 1;
	var _pageDis = false;
	var pageLength;
	function qurDetails(){
		_CURRENT_PAGE = 1;
		_pageDis = false;
		loadItems();
	}
	//分页控件回调
	function pageselectCallback(page_index){
		if (_CURRENT_PAGE == (page_index+1)){
			return false;
		}
		_CURRENT_PAGE = page_index+1;
		loadItems();
		return false;
	}
	function loadItems(){
	  var postData = $('#qurForm').serialize();
	  var pages = $("#Pagination"); 
	  $.ajax({
			url: "${pageContext.request.contextPath}/getBills.do",
			dataType: 'json',
			data: postData+"&pageIndex="+_CURRENT_PAGE,
			success: function onLoadData(data){
				    pageLength = data.pageLength;
				    $('#totalCount').html(data.totalCount);
				    var html = '';
					var i=0, length=data.items.length, bill;
					if(length > 0){
						  for(; i<length; i++) {
							  bill = data.items[i];
							   html += '<tr>\
							        <td>'+bill.sn+'</td>\
							        <td>'+convertTradeType(bill.tradetype>>0)+'</td>\
							        <td>'+bill.tradeId+'</td>';
							        html += '<td>'+convertDate(bill.currtime)+'</td>';
							        if(bill.type == 1){
							        	html += '<td>+'+bill.money+'</a></td>';
							        }else{
							        	html += '<td>-'+bill.money+'</a></td>';
							        }
							        html += '<td>'+convertBillType(bill.type>>0)+'</td>';
							        if(bill.tradetype == 1){//充值
							        	html += '<td><a target="_new" href="${pageContext.request.contextPath}/lookRechargeBill.do?tradeId='+bill.tradeId+'">查看详情</a></td>';
							        }else if(bill.tradetype == 2){//提现
							        	html += '<td><a target="_new" href="${pageContext.request.contextPath}/lookWithDrawingBill.do?tradeId='+bill.tradeId+'">查看详情</a></td>';
							        }else if(bill.tradetype == 3){//交易
							        	html += '<td><a target="_new" href="${pageContext.request.contextPath}/getOrderDetail.do?orderNo='+bill.tradeId+'">查看详情</a></td>';
							        }else if(bill.tradetype == 4){//返款
							            html += '<td><a target="_new" href="${pageContext.request.contextPath}/getRefundDetail.do?refundId='+bill.tradeId+'">查看详情</a></td>';
							        }else if(bill.tradetype == 5){//佣金
							        	html += '<td><a target="_new" href="${pageContext.request.contextPath}/getCommissionDetail.do?tradeId='+bill.tradeId+'">查看详情</a></td>';
							        }
								    html += '</tr>';
						  }
						  pages.show();
					}else{
						_pageDis = false;
						pages.hide();
						html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有相关明细信息</td></li>";
					}
				    $('#container').html(html);
				    if (!_pageDis){
					    if (pageLength == 1) {
				    		pages.hide();
						}
					    pages.show();
					    pages.pagination(pageLength, {callback: pageselectCallback});
					    _pageDis = true;
				    }
			     }
		  });
     }
	function selMember(){
		window.open('${pageContext.request.contextPath}/page/member/selSingleMember.jsp');
	}
	qurDetails();	
 </script>
</body>
</html>