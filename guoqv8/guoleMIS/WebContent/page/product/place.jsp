<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>目的地管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<script type="text/javascript">
	<c:if test="${current_user_permission['place.jsp'] != true}">
		alert("无权访问");
		window.location.href = "${pageContext.request.contextPath}/index.jsp";
	</c:if>
</script>
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width80{
		width:80px !important;
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
		background-repeat: no-repeat;
		background-position: center right;
		padding-right: 23px!important;
		padding-top: 5px!important;
	}
	
	.textLeft {
		text-align: left!important;
	}
	
	.textCenter {
		text-align: center!important;
	}
	
	.bgWhiteColor{
		background-color: #ffffff!important;
	}
	
	.FT12 {
		font-size:12px!important;
		font-weight: normal;
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
	
	#listTab {
		table-layout:fixed;
	}
	
	#listTab th {
		text-align:left;
	}
	
	#listTab td {
		word-wrap : break-word;
		text-align:left;
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
			<h1>产品管理 → <span>目的地管理</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
			<c:if test="${current_user_permission['addPlace.do'] == true}">
				<!--添加标签-->
				<fieldset class="SearchBox">
					<legend>添加区域</legend>					
					<form id="paramForm">
						<p>
							<label class="required">大洲:</label>
								<select id="continent" name="placeInfo.continent">
									<option>亚洲</option>
									<option>美洲</option>
									<option>欧洲</option>
									<option>非洲</option>
									<option>大洋洲</option>
								</select>
							<label class="required">国家:</label>
							<input type="text" name="placeInfo.country" id="country" class="width80"/>
							<label class="required">省份:</label>
							<input type="text" name="placeInfo.province" id="province" class="width80"/>
							<label class="required">城市:</label>
							<input type="text" name="placeInfo.city" id="city" class="width80"/>
							<label class="required">拼音:</label>
							<input type="text" name="placeInfo.py" id="py" class="width80"/>
							<label class="required">简拼:</label>
							<input type="text" name="placeInfo.short_py" id="short_py" class="width80"/>
							<label>英文名:</label>
							<input type="text" name="placeInfo.en" id="en" class="width80"/>
							<a href="javascript:;" id="addBtn" class="btn  btn-blue">新增</a>
						</p>
					</form>
				</fieldset>
				<!--添加标签 end-->
			</c:if>
				<!--列表-->
				<div>
					<h3>
						区域列表 <span class="FT12"> 数据库总共存储了 <span  id="totalSize" class="fontRed">0</span> 条区域信息， 检索到 <span class="fontRed" id="placeSize">0</span> 条信息</span>
						<span class="FR">
								<p>
									<a href="javascript:;" onclick="searchPlace();" class="btn  btn-blue" style="margin-left:3px;margin-top:-2px;">搜索</a>
								</p>
						</span>
						<span class="FR">
								<p>
									<a title="输入国家 / 省份（直辖市） / 城市（全拼或首字母简拼）"><input type="text" onkeypress="if (event.keyCode == 13){searchPlace();}" id="keyword" class="width200 searchBg"/></a>
								</p>
						</span>
					</h3>
					<table id="listTab" class="display stylized">
						<thead>
							<tr>
								<th>编号</th>
								<th>大洲</th>
								<th>国家</th>
								<th>省</th>
								<th>城市</th>
								<th>城市拼音</th>
								<th>城市简拼</th>
								<th>英文名</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="placeList">
						
						</tbody>
					</table>
				</div>
				<!--列表 end-->
				<div class="leading">
				</div>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<a href="#foobar" class="nyroModal DisNo" id="openA">openA</a>
	<!-- 编辑区域窗口 -->
	<div id='foobar' style='display: none;'>
		<h3>编辑区域信息</h3>
		<div class="box box-info">除了英文名外，其他所有字段都必须填写</div>
		<form id="modForm" method="post" action="#">
			<fieldset>
				<p align="center">
					<input type="hidden" id="m_id" class="half" value="" name="placeInfo.id"/>
					<label class="required" for="m_continent">大洲:</label>&nbsp;
					<select id="m_continent" name="placeInfo.continent" style="width:210px;">
						<option>亚洲</option>
						<option>美洲</option>
						<option>欧洲</option>
						<option>非洲</option>
						<option>大洋洲</option>
					</select>
				</p>
				<br/>
				<p align="center">
					<label class="required" for="m_country">国家:</label>&nbsp;
					<input type="text" id="m_country" class="half" value="" name="placeInfo.country"/>
				</p>
				<br/>
				<p align="center">
					<label class="required" for="m_province">省份:</label>
					<input type="text" id="m_province" class="half" value="" name="placeInfo.province"/>
				</p>
				<br/>
				<p align="center">
					<label class="required" for="m_city">城市:</label>&nbsp;
					<input type="text" id="m_city" class="half" value="" name="placeInfo.city"/>	
				</p>
				<br/>
				<p align="center">
					<label class="required" for="m_py">拼音:</label>&nbsp;
					<input type="text" id="m_py" class="half" value="" name="placeInfo.py"/>	
				</p>
				<br/>
				<p align="center">
					<label class="required" for="m_short_py">简拼:</label>&nbsp;
					<input type="text" id="m_short_py" class="half" value="" name="placeInfo.short_py"/>	
				</p>
				<br/>
				<p align="center">
					<label for="m_en">英文:</label>&nbsp;
					<input type="text" id="m_en" class="half" value="" name="placeInfo.en"/>	
				</p>
				<br/>
				<p class="box" align="center">
					<input type="button" onclick="saveInfo();" class="btn btn-blue" value="提交修改"/>
				</p>
			</fieldset>
		</form>
	</div>
	<!-- 编辑区域窗口结束 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<script id="placeTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var place = data[i];
		#>
		<tr id="place_<#=place.id#>">
			<td><#=place.id#></td>
			<td><#=place.continent#></td>
			<td><#=place.country#></td>
			<td><#=place.province#></td>
			<td><#=place.city#></td>
			<td><#=place.py#></td>
			<td><#=place.short_py#></td>
			<td><#=place.en#></td>
			<td>
				<c:if test="${current_user_permission['modPlace.do'] == true}">
					<a href="javascript:;" onclick="fillInfo(<#=place.id#>)">编辑</a> <a class="DisNo" href="javascript:alert('未开通');">删除</a>
				</c:if>
			</td>
		</tr>
		<#}#>
	</script>
	<script type="text/javascript">
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);
		var _trLoading = '<tr><td colspan="9" style="text-align:center!important;"><img src="${pageContext.request.contextPath}/img/loading1.gif"/></td></tr>';
		
		/**
		 * 加载国家
		 * @return {TypeName} 
		 */
		function loadPlaceList() {
			var placeList = $("#placeList");
			placeList.empty();
			placeList.html(_trLoading);
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getPlaces.do?t=" + new Date().getTime(),
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}
					data = $.parseJSON(data);
					if (data.length == 0){
						html = "<tr><td class='textCenter' colspan='9' style='color:red;'>没有检索到任何区域信息</td></tr>";
					}else{
						html = fn.template($('#placeTmpl').html())(data);
					}
					$("#totalSize").html(data.length);
					
					html = "<tr><td colspan='9' class='textCenter' style='color:red;'>没有检索到任何区域信息</td></tr>";
					placeList.html(html);
				  },
				  error: function(){
					  alert("服务端出错");
				  }
			});
		}
		
		loadPlaceList();

		<c:if test="${current_user_permission['addPlace.do'] == true}">
			/**
			 * 新增城市
			 * @param {Object} country
			 * @return {TypeName} 
			 */
			function addPlace() {
				var country = $("#country").val();
				var province = $("#province").val();
				var city = $("#city").val();
				var py = $("#py").val();
				var short_py = $("#short_py").val();

				if (country.trim() == ""){
					alert("请输入国家名称");
					return;
				}
				
				if (province.trim() == ""){
					alert("请输入省份名称");
					return;
				}
				
				if (city.trim() == ""){
					alert("请输入城市名称");
					return;
				}
				
				if (py.trim() == ""){
					alert("请输入城市拼音");
					return;
				}
				
				if (short_py.trim() == ""){
					alert("请输入城市拼音简拼名称");
					return;
				}
	
				$.ajax( {
					  type: "get",
					  url: "${pageContext.request.contextPath}/addPlace.do?t=" + new Date().getTime(),
					  data: $("#paramForm").serialize(),
					  async: false,
					  success:function(data){
						if ("error" == data) {
							alert("出错了!");
							return;
						}else if("exists" == data) {
							alert("区域已存在");
							return;
						}else{
							alert("添加成功");
							window.location.reload();
						}
					  },
					  error: function(){
						  alert("服务端出错");
					  }
				});
			}
		</c:if>
			 
		// 搜索区域
		function searchPlace() {
			var keyword = $("#keyword").val().trim();
			if (keyword == "") {
				keyword = "##";
			}
			var placeList = $("#placeList");
			placeList.empty();
			placeList.html(_trLoading);
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/searchPlace.do?t=" + new Date().getTime(),
				  data: {keyword: keyword},
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}

					data = $.parseJSON(data);
					if (data.length == 0){
						html = "<tr><td colspan='9' class='textCenter' style='color:red;'>没有检索到任何区域信息</td></tr>";
					}else{
						html = fn.template($('#placeTmpl').html())(data);
					}
					$("#placeSize").html(data.length);
					
					placeList.html(html);
				  },
				  error: function(){
					  alert("服务端出错");
				  }
			});
		} 
		
		<c:if test="${current_user_permission['modPlace.do'] == true}">
			// 编辑时填充信息
			function fillInfo(id) {
				var tds = $("#place_" + id).find("td");
				$("#m_continent option").each(function(i){
					if ($(this).val() == $(tds[1]).text()) {
						this.selected = true;
					}
				});
				$("#m_country").val($(tds[2]).text());
				$("#m_province").val($(tds[3]).text());
				$("#m_city").val($(tds[4]).text());
				$("#m_id").val($(tds[0]).text());
				$("#m_py").val($(tds[5]).text());
				$("#m_short_py").val($(tds[6]).text());
				$("#m_en").val($(tds[7]).text());
				$("#openA").trigger("click");
			}
			
			// 保存信息
			function saveInfo() {
				var continent = $("#m_continent").val();
				var country = $("#m_country").val();
				var province = $("#m_province").val();
				var city = $("#m_city").val();
				var py = $("#m_py").val();
				var short_py = $("#m_short_py").val();
				var id = $("#m_id").val();
				var en = $("#m_en").val();
				if (country.trim() == ""){
					alert("请输入国家名称");
					return;
				}
				
				if (province.trim() == ""){
					alert("请输入省份名称");
					return;
				}
				
				if (city.trim() == ""){
					alert("请输入城市名称");
					return;
				}
				
				if (py.trim() == ""){
					alert("请输入城市拼音");
					return;
				}
				
				if (short_py.trim() == ""){
					alert("请输入城市简拼");
					return;
				}
				
				if (id == "") {
					alert("找不到区域编号，请刷新页面重试");
					rreturn;
				}
	
				$.ajax( {
					  type: "get",
					  url: "${pageContext.request.contextPath}/modPlace.do?t=" + new Date().getTime(),
					  data: $("#modForm").serialize(),
					  async: false,
					  success:function(data){
						if ("error" == data) {
							alert("出错了!");
							return;
						}else if("exists" == data) {
							alert("区域已存在");
							return;
						}else{
							alert("修改成功");
							refillContent(id, continent, country, province, city, py, short_py, en);
							$("#closeBut").trigger("click");
						}
					  },
					  error: function(){
						  alert("服务端出错");
					  }
				});
			}
			
			// 修改成功后回填信息
			function refillContent(id, continent, country, province, city, py, short_py, en) {
				var tds = $("#place_" + id).find("td");
				tds[1].innerHTML = continent;
				tds[2].innerHTML = country;
				tds[3].innerHTML = province;
				tds[4].innerHTML = city;
				tds[5].innerHTML = py;
				tds[6].innerHTML = short_py;
				tds[7].innerHTML = en;
			}
		</c:if>
		
		$("#addBtn").bind("click", function(){
			addPlace();
		});

		$("input[name='areaType']").bind("click", function(){
			$(".addP").hide();
			$("#" + this.value).show();
		});
	</script>
</body>
</html>