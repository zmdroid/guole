<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>线路管理</title>
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
		<jsp:param value="product" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>产品管理 → <span>线路管理</span></h1>
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
							<label>发布日期:</label>
							<input type="text" name="lineStateQueryVO.publishTime" onkeydown="return false;" id="publishTime" class="width120" readonly="readonly" onClick="WdatePicker()"/>
							<label>商品名称:</label>
							<input type="text" name="lineStateQueryVO.keyword" id="keyword" class="width120"/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>业务类型:</label>
							<select id="state" class="width130" name="lineStateQueryVO.busiType">
								<option value="-1">全部</option>
								<option value="1">国内游</option>
								<option value="2">出境游</option>
								<option value="3">周边游</option>
							</select>
							<input type="hidden" name="lineStateQueryVO.state" id="lineStateInput" value="0">
							<a href="javascript:void(0);" onclick="reloadLines()" id="searchBtn" class="btn  btn-blue">筛选</a>
						</p>
					</form>
					<div class="Retrieval" id="lineState">
						<span>线路状态:</span>
						<a href="javascript:;" class="State current" data="0">全部</a>
						<a href="javascript:;" class="State" data="1">过期下架</a>
						<a href="javascript:;" class="State" data="2">手动下架</a>
						<a href="javascript:;" class="State" data="3">违规下架</a>
						<a href="javascript:;" class="State" data="5">代售</a>
					</div>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<a  class="btn  btn-blue" href="${pageContext.request.contextPath}/page/product/linePost.jsp">
							发布线路
						</a>
					<h3 style="margin-bottom:15px;">
						线路列表
						<span class="FR">
							<a href="#" class="btn"><span class="icon icon_export"></span>导出列表</a>
							<a href="#" class="btn"><span class="icon icon_print"></span>打印列表</a>
						</span>
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th width="35">商品编号</th>
								<th>商品名称</th>
								<th width="55">业务类型</th>
								<th width="55">线路类型</th>
								<th width="70">发布日期</th>
								<th width="55">发布人</th>
								<th width="35">状态</th>
								<th width="120">操作</th>
							</tr>
						</thead>
						<tbody id="withDrawingList">
						</tbody>
					</table>
				</div>
				<!--列表 end-->
				<div class="leading" id="pageTool">
					<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
					<div>共 <b id="lineCount">0</b> 条，每页显示 <b><%=Config.getInstance().get("page.size") %></b> 条</div>
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
	<script id="lineTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var line = data[i];
		#>
		<tr>
			<td><#=line.id#></td>
			<td style="word-break: break-all; word-wrap:break-word;"><#=line.name.replace(/>/g,'&gt;').replace(/</g,'&lt;')#></td>
			<td><#=line.busiType==1?'国内游':line.busiType==2?'出境游':'周边游'#></td>
			<td><#=line.lineType==1?'跟团游':line.lineType==2?'自由行':'当地地接'#></td>
			<td><#=convertDate(line.publishTime).replace(' ','<br/>')#></td>
			<td><a href="${pageContext.request.contextPath}/memberDetail.do?userId=<#=line.supplierId#>" target="_new"><#=line.userName#></a></td>
			<td><#=showState(line.state>>0)#></td>
			<td>
				<div class="DView">
					<a target="_blank" href="${pageContext.request.contextPath}/forwardManageLineViewPage.do?fromPage=manage&lineId=<#=line.id#>&lineInfo.supplierId=<#=line.supplierId#>">查看</a>
					<#if(line.state!=4){#>
					| <a target="_blank" href="${pageContext.request.contextPath}/forwardManageLineModifyPage.do?lineId=<#=line.id#>&lineInfo.supplierId=<#=line.supplierId#>">编辑</a>
					| <a href="javascript:;" onclick="lineSelling(<#=line.id#>,<#=line.supplierId#>)">上架</a>
					<#}#>
					| <a href="javascript:;" onclick="copyLine(<#=line.id#>,<#=line.supplierId#>)">复制</a>
				</div>
			</td>
		</tr>
		<#}#>

	</script>
	<script type="text/javascript">
	function showState(s){
		switch(s){
		case 1:return '过期下架';
		case 2:return '手动下架';
		case 3:return '违规下架';
		case 5:return '待售';
		}
	}
	
	$('#lineState a').click(function(){
		$('#lineState a').attr('class','State');
		$(this).addClass('current');
		var state = $(this).attr('data');
		$('#lineStateInput').val(state);
		loadLines(state);
	});
	
	var _CURRENT_PAGE = 1;
	var _limit = "<%=Config.getInstance().get("page.size") %>";
	var _pageDis = false;
	
	//初始化模版引擎
	var tmplOpts = {varName:'data', compiler:'rapid'};
	fn.template.setting(tmplOpts);

	// 加载下架线路列表
	function loadLines(state) {
		var start =  (_CURRENT_PAGE - 1) * _limit;
		$.ajax( {
			  type: "get",
			  url: "${pageContext.request.contextPath}/getOffLineList.do?start="+start+"&t=" + new Date().getTime(),
			  data: $("#paramForm").serialize(),
			  success:function(data){
				if ("error" == data){
					alert("出错了");
					return;
				}
				data = $.parseJSON(data);
				var html = "";
				if (data.totalCount == 0){
					_pageDis = false;
					$("#Pagination").hide();
					html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有该类型的线路信息</td></li>";
				}else{
					$("#Pagination").show();
					html = fn.template($('#lineTmpl').html())(data.list);
				}

				$("#withDrawingList").html(html);
				$("#lineCount").html(data.totalCount);

				if (!_pageDis){
					var totalPage = Math.ceil(data.totalCount/_limit);
					if (totalPage == 1) {
						$("#Pagination").hide();
					}
					
			    	$("#Pagination").pagination(totalPage, {callback: pageselectCallback});
			  	  	_pageDis = true;
			  	}
			  },
			  error:function(){
				  alert("服务器断访问出错");
			  }
		});
	}
	
	// 分页控件回调
	function pageselectCallback(page_index){
		if (_CURRENT_PAGE == (page_index + 1)){
			return false;
		}

		_CURRENT_PAGE = page_index + 1;
		loadLines();
		return false;
	}
	
	loadLines();
		
		
		
		// 绑定点击行程天数事件
		$("a.AreaType").each(function(){
			$(this).on("click", function(){
				$("a.AreaType").removeClass("Active");
				$(this).addClass("Active");
				reloadLines();
			});
		});
		
		
		/**
		 * 从加载线路列表
		 */
		function reloadLines() {
			_CURRENT_PAGE = 1;
			_pageDis = false;
			loadLines();
		}

		/**
		 * 上架
		 */
		function lineSelling(lineIds,supId) {
			if (lineIds == ""){
				alert("请选择上架商品");
				return;
			}
			
			if (!window.confirm("您确定要这么做吗？")){
				return;
			}
			
			if (isNaN(lineIds)){
				lineIds = lineIds.substring(0, lineIds.length - 1);
			}

			$.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/lineSelling.do?lineInfo.supplierId="+supId+"&t=" + new Date().getTime(),
				  data: {lineIds: lineIds},
				  success:function(data){
					if ("error" == data){
						alert("出错了");
						return;
					}else if("login" == data){
						window.location.href = "/tpm/login";
					}else{
						alert("上架成功！");
						reloadLines();
					}
				  },
				  error:function(){
					  alert("服务器断访问出错");
				  }
			});
		}

		
		/**
		 * 复制线路
		 * @return {TypeName} 
		 */
		function copyLine(lineId,supId) {
			$.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/copyLine.do?lineInfo.supplierId="+supId+"&t=" + new Date().getTime(),
				  data: {lineId: lineId},
				  success:function(data){
					if ("error" == data){
						alert("出错了");
						return;
					}else if("login" == data){
						window.location.href = "${pageContext.request.contextPath}/login";
					}else{
						alert("复制成功！");
						reloadLines();
					}
				  },
				  error:function(){
					  alert("服务器断访问出错");
				  }
			});
		}
		
		
		
		
	</script>
</body>
</html>