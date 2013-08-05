<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date date = new Date();
	int year = date.getYear() + 1900;
	int month = date.getMonth() + 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>线路库</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<script type="text/javascript">
	<c:if test="${current_user_permission['lineOnline.jsp'] != true}">
		alert("无权访问");
		window.location.href = "${pageContext.request.contextPath}/index.jsp";
	</c:if>
</script>
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width120{
		width:120px !important;
	}
	
	.width40{
		width:40px !important;
	}
	
	.width270{
		width:270px !important;
	}
	
	.width130{
		width:130px !important;
	}
	
	.width200{
		width:200px !important;
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
	
	.DisNo {
		display: none;
	}
	
	.searchBg {
		background-image: url("${pageContext.request.contextPath}/img/search.gif");
		background-repeat: no-repeat;
		background-position: center right;
		padding-right: 23px!important;
		padding-top: 5px!important;
	}
	
	.textLeft {
		text-align: left!important;
	}
	
	.bgWhiteColor{
		background-color: #ffffff!important;
	}
	
	.FT12 {
		font-size:12px!important;
	}
	
	.areaOp {
		position: absolute;
		left: 10px;
		top:10px;
	}
	
	.fontRed {
		color:red;
	}
	
	.fontBlack {
		color:black;
	}
	
	.money{
		color:rgb(255, 127, 0);
		font-weight:bold;
	}
</style>
<style type="text/css">
	#resultDiv {
		height:165px;
		border:1px #cccccc solid;
		background-color: white;
		position: absolute;
	}

	#placeDiv {
		height:165px;
		overflow-y: auto;
		overflow-x: hidden;
	}
	
	#placeDiv a {
		line-height: 25px;
		display: block;
		height: 25px;
		width: 100%;
		padding-left:5px;
		border-bottom: 1px #ffffff solid;
		border-top: 1px #ffffff solid;
		color:blue;
		cursor:pointer;
		text-decoration: none;
	}
	
	#placeDiv a:HOVER {
		background-color: rgb(200, 227, 252);
		border-bottom: 1px rgb(104, 167, 246) solid;
		border-top: 1px rgb(104, 167, 246) solid;
	}
	
	#modForm a:HOVER {
		
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
			<h1>产品管理 → <span>线路库</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<fieldset class="SearchBox">
					<legend>检索条件</legend>					
					<form id="paramForm">
						<p>
							<label>业务类型:</label>
							<select id="busiType" class="width130" name="lineQueryVO.busiType">
								<option value="-1">全部</option>
								<option value="1">国内游</option>
								<option value="2">出境游</option>
								<option value="3">周边游</option>
							</select>
							<label>线路类型:</label>
							<select id="lineType" class="width130" name="lineQueryVO.lineType">
								<option value="-1">全部</option>
								<option value="1">跟团游</option>
								<option value="2">自由行</option>
								<option value="3">当地地接</option>
							</select>
							<label>出发地:</label>
							<input type="text" id="fromPlace" class="width130 cityAutoComplete"/>
						</p>
						<br/>
						<p>
							<label>编号 / 目的地 / 主题 / 景点 / 关键字:</label>
							<input type="text" name="lineQueryVO.keyword" id="keyword" class="width270"/>
						</p>
						<br/>
						<p>
							<label>行程天数:</label>
							<select id="days" class="width130" name="lineQueryVO.days">
								<option value="">全部</option>
								<option value="1-2">1-2天</option>
								<option value="3-5">3-5天</option>
								<option value="6-9">6-9天</option>
								<option value="10-15">10-15天</option>
								<option value="15-0">15天以上</option>
							</select>
							<label class="trans">去程交通:</label>
							<select id="toTransport" class="width130 trans" name="lineQueryVO.toTransport">
								<option value="">全部</option>
								<option value="飞机">飞机</option>
								<option value="高铁">高铁</option>
								<option value="火车">火车</option>
								<option value="轮船">轮船</option>
								<option value="汽车">汽车</option>
								<option value="包车">包车</option>
							</select>
							<label class="trans">返程交通:</label>
							<select id="fromTransport" class="width130 trans" name="lineQueryVO.fromTransport">
								<option value="">全部</option>
								<option value="飞机">飞机</option>
								<option value="高铁">高铁</option>
								<option value="火车">火车</option>
								<option value="轮船">轮船</option>
								<option value="汽车">汽车</option>
								<option value="包车">包车</option>
							</select>
							<a href="javascript:;" id="searchBtn" class="btn  btn-blue">查询线路</a>
						</p>
					</form>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<h3>
						线路列表 
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th width="35">编号</th>
								<th>名称</th>
								<th width="80">出发地</th>
								<th width="55">行程天数</th>
								<th width="55">业务类型</th>
								<th width="55">线路类型</th>
								<th width="55">联系人</th>
								<th width="155">联系电话</th>
								<th width="80">操作</th>
							</tr>
						</thead>
						<tbody id="lineList">
						
						</tbody>
					</table>
				</div>
				<!--列表 end-->
				<div class="leading">
					<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
					<div>共 <b id="totalCount">0</b> 条，每页显示 <b><%=Config.getInstance().get("page.size") %></b> 条</div>
				</div>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<!-- 区域提醒层 -->
	<div id="resultDiv" class="DisNo">
		<div id="placeDiv"></div>
	</div>
	<!-- 提示窗口 -->
	<a href="#foobar" class="nyroModal DisNo" id="openA">openA</a>
	<div id='foobar' style='display: none;'>
		<h3>提示</h3>
		<div class="box box-info">线路复制成功！</div>
		<center>
			<a id="doModify" href="#" target="_blank" onclick="closePopWin();" class="btn">去编辑</a>
			<input type="button" onclick="closePopWin();" class="btn btn-blue" value="留在本页面"/>
		</center>
	</div>
	<!-- 编辑区域窗口结束 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
	<script id="lineTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var line = data[i];
		#>
		<tr id="line_<#=line.id#>">
			<td class="textLeft"><#=line.id#></td>
<td class="textLeft" style="word-break: break-all; word-wrap:break-word;"><#=line.name.replace(/>/g,'&gt;').replace(/</g,'&lt;')#></td>
			<td class="textLeft"><#=line.fromplace#></td>
			<td class="textLeft"><#=line.days#></td>
			<td><#=line.busiType==1?'国内游':line.busiType==2?'出境游':'周边游'#></td>
			<td><#=line.lineType==1?'跟团游':line.lineType==2?'自由行':'当地地接'#></td>
			<td class="textLeft"><#=line.linker.replace(/>/g,'&gt;').replace(/</g,'&lt;')#></td>
			<td class="textLeft"><#=line.linkphone.replace(/>/g,'&gt;').replace(/</g,'&lt;')#></td>
			<td class="textLeft">
				<c:if test="${current_user_permission['forwardDetailPage.do']}">
					<a target="_blank" href="${pageContext.request.contextPath}/forwardDetailPage.do?fromPage=store&lineId=<#=line.id#>">查看</a> 
				</c:if>
				<c:if test="${current_user_permission['lineOffShelf.do']}">
					<a href="javascript:;" onclick="lineOffShelf(<#=line.id#>,<#=line.supplierId#>)">下架</a> 
				</c:if>
				<c:if test="${current_user_permission['forwardCopyLinePage.do']}">
					<a href="javascript:copyLine(<#=line.id#>, <#=line.supplierId#>);">复制</a>
				</c:if>
			</td>
		</tr>
		<#}#>
	</script>
	<script type="text/javascript">
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);

		var _pageDis = false;
		var _limit  = "<%=Config.getInstance().get("page.size") %>";
		var _CURRENT_PAGE = 1;
		var _trLoading = '<tr><td colspan="11"><img src="${pageContext.request.contextPath}/img/loading1.gif"/></td></tr>';
		var _params = {
				"lineQueryVO.busiType": 1, // 线路类型 1：线路 2：地接
				"lineQueryVO.fromPlace": "北京", // 默认北京
				"lineQueryVO.keyword": "",
				"lineQueryVO.lineType": -1,
				"lineQueryVO.days": "",
				"start": (_CURRENT_PAGE - 1) * _limit
			};
		var _areas;
		
		/**
		 * 加载出发地
		 * @return {TypeName} 
		 */
		function loadFromPlace() {
			var placeList = $("#placeDiv");
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getPlaces.do?t=" + new Date().getTime(),
				  async: false,
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}

					data = $.parseJSON(data);
					if (data.length == 0){
						return;	
					}
					
					_areas = data;
					
					var city,html = "";
					for (var i = 0; i < data.length; i++) {
						city = data[i];
						html += "<a href='javascript:chooseCity(\""+ city.id +"\",\""+ city.city +"\");' id='city_"+ city.id +"' class='DisNo' data='"+ city.id +"'>"+ city.city +"</a>";
					}
					
					placeList.html(html);
					
					// 绑定联想功能
					$(".cityAutoComplete").focus(function(){
						var _this = $(this);
						var resultDiv = $("#resultDiv");
						resultDiv.css({
							left: _this.offset().left,
							top: _this.offset().top + _this.outerHeight(),
							width: _this.outerWidth()
						});
			
						this.onkeydown = function(){
							var obj = this;
							window.setTimeout(function(){
								if (obj.value.trim() == "") {
									resultDiv.hide();
								}else{
									resultDiv.show();
									findCity(obj.value.trim());
								}
							}, 20);
						}
						
						this.onblur = function(){
							var city;
							var bl = false;
							for (var i = 0; i < _areas.length; i++) {
								city = _areas[i];
								if (city.city == this.value) {
									bl = true;
									return;
								}
							}

							this.value = "";
						}	
					});
				  },
				  error: function(){
					  alert("服务端出错");
				  }
			});
		}
		
		// 设置城市与ID
		function chooseCity(obj) {
			if (obj.id) {
				var id = obj.id.split("_")[1];
				var name = obj.innerHTML;
				$("#fromPlace").val(name);
				$("#resultDiv").hide();
			}
		}
		 
		// 查找城市
		function findCity(keyword) {
			var city;
			if (isChineseChar(keyword)) { // 中文
				for (var i = 0; i < _areas.length; i++) {
					city = _areas[i];
					if (city.city.indexOf(keyword) == 0) {
						$("#city_" + city.id).show();
					}else{
						$("#city_" + city.id).hide();
					}
				}
			}else{
				keyword = keyword.toLowerCase();
				for (var i = 0; i < _areas.length; i++) {
					city = _areas[i];
					if (city.short_py.indexOf(keyword) == 0 || city.py.indexOf(keyword) == 0) {
						$("#city_" + city.id).show();
					}else{
						$("#city_" + city.id).hide();
					}
				}
			}
		}
		
		loadFromPlace();
		
		$(document).ready(function(){
			searchLine();
		});
		
		// 分页控件回调
		function pageselectCallback(page_index){
			if (_CURRENT_PAGE == (page_index + 1)){
				return false;
			}

			_CURRENT_PAGE = page_index + 1;
			loadLines();
			return false;
		}
		
		// 加载线路列表
		function loadLines() {
			_params.start = (_CURRENT_PAGE - 1) * _limit;
			var lineList = $("#lineList").empty();
			lineList.empty();
			lineList.html(_trLoading);
			var page = $("#Pagination");
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getLineList.do?t=" + new Date().getTime(),
				  data: _params,
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}
					data = $.parseJSON(data);
					var html = "";
					if (data.totalCount == 0){
						_pageDis = false;
						html = "<tr><td colspan='11' class='fontRed'>没有检索到线路</td></tr>";
						page.hide();
					}else{
						html = fn.template($('#lineTmpl').html())(data.list);
						page.show();
					}
					lineList.html(html);
					$("#totalCount").html(data.totalCount);
					
					var totalPage = Math.ceil(data.totalCount/_limit);
					if (totalPage == 1) {
						page.hide();
					}
					if (!_pageDis){
				    	$("#Pagination").pagination(totalPage, {callback: pageselectCallback});
				  	  	_pageDis = true;
				  	}
					
					refreshLines();
				  },
				  error:function(){
					  alert("服务出错，查询线路列表出错");
				  }
			});
		}
		
		// 刷新列表，当在非第一页下架时，且下架后当前页记录为0时刷新
		function refreshLines() {
			var lines = $("#lineList tr");
			// 下驾时如果当前页无记录
			if (lines.length == 0 && _CURRENT_PAGE != 1) {
				_CURRENT_PAGE = 1;
				_pageDis = false;
				loadLines();
				return;
			}
		}
		
		/**
		 * 处理行程天数显示
		 */
		function formatDays(days){
			var newDays = days.split(".");
			if (newDays[1] == 0){
				return newDays[0];
			}else{
				return days;
			}
		}

		/**
		 * 搜索线路
		 */
		function searchLine() {
			var busiType = $("#busiType").val();
			_params["lineQueryVO.fromPlace"] = $("#fromPlace").val(); 
			_params["lineQueryVO.keyword"] = $("#keyword").val();
			_params["lineQueryVO.lineType"] = $("#lineType").val();
			_params["lineQueryVO.days"] = $("#days").val();
			_params["lineQueryVO.busiType"] = busiType;
			
			if (busiType == 1) {
				_params["lineQueryVO.fromTransport"] = $("#fromTransport").val();
				_params["lineQueryVO.toTransport"] = $("#toTransport").val();
			}

			_CURRENT_PAGE = 1;
			_pageDis = false;
			_params["start"] = (_CURRENT_PAGE - 1) * _limit;

			loadLines();
		}

		<c:if test="${current_user_permission['lineOffShelf.do']}">
			// 下架
			function lineOffShelf(lineId, userId) {
				if (window.confirm("确定要下架该线路吗？")) {
					closeLine(lineId, userId);
				}
			}
			
			function closeLine(lineId, userId) {
			// 下架
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/lineOffShelf.do?t=" + new Date().getTime(),
					  data: {lineIds: lineId, "lineInfo.supplierId": userId},
					  success:function(data){
						if ("error" == data) {
							alert("出错了!");
							return;
						}else{
							alert("下架成功");
							loadLines();
						}
					  },
					  error:function(){
						  alert("服务出错");
					  }
				});
			}
		</c:if>

		<c:if test="${current_user_permission['forwardCopyLinePage.do']}">
			// 复制线路
			function copyLine(lId, uId) {
				$.ajax( {
					  type: "get",
					  url: "${pageContext.request.contextPath}/forwardCopyLinePage.do?t=" + new Date().getTime(),
					  data: {lineId: lId, "lineInfo.supplierId": uId},
					  success:function(data){
						if ("error" == data) {
							alert("出错了!");
							return;
						}else{
							data = $.parseJSON(data);
							$("#openA").trigger("click");
							$("#doModify").attr("href", "${pageContext.request.contextPath}/forwardManageLineModifyPage.do?lineId="+ data.lineId +"&lineInfo.supplierId=" + data.supplierId);
						}
					  },
					  error:function(){
						  alert("服务出错，查询线路列表出错");
					  }
				});
			}
			
			// 留在本页面
			function closePopWin() {
				$("#closeBut").trigger("click");
			}
		</c:if>


		
		$("#searchBtn").click(function(){
			searchLine();
		});
		
		$("#busiType").change(function(){
			if (this.value == "1") {
				$(".trans").show();
			}else{
				$(".trans").hide();
			}
		});
		
		$("body").keydown(function(){
			if ($("#resultDiv").is(":visible")) {
				if (event.keyCode == 38) { // 上
					// alert("上");
				}
				
				if (event.keyCode == 40) { // 下
					// alert("下");
				}
			}
		})
		
		$("body").click(function(){
			var ev = event || window.event; // 事件     
			var target = ev.target || ev.srcElement; // 获得事件源 
			var resultDiv = $("#resultDiv");
			if (target.id) {
				if (target.id.indexOf("city_") != -1) {
					chooseCity(target);
				}else if (target.id != "fromPlace"){
					resultDiv.hide();
				}else{
					// do nothing
				}
			}else{
				resultDiv.hide();
			}
		});
	</script>
</body>
</html>