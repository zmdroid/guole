<%@ page language="java" import="com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>产品类型</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="notifyManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>会员管理 → <span>产品类型</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<fieldset class="SearchBox">
				<legend>产品类型</legend>
					<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">类型名称:</td>
							<td>
								<input type="text" id="seachkey"> 
							</td>
							<td><a href="javascript:void(0);" onclick="loadData()" class="btn  btn-blue">筛选</a></td>
						</tr>
						<tr>
							<td class="CA">父类名称:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="ptype current" data="全部">全部</a>
								<a href="javascript:;" class="ptype" data="国内长线">国内长线</a>
								<a href="javascript:;" class="ptype" data="国际线">国际线</a>
							</td>
						</tr>
						<tr>
							<td class="CA">状态:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="State current" data="-1">全部</a>
								<a href="javascript:;" class="State" data="0">下线</a>
								<a href="javascript:;" class="State" data="1">上线</a>
							</td>
						</tr>
					</table>
				</fieldset>
				  <form id="typeForm" method="post" action="/loadNotifys.do">
					<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
						
						<tr>
							<td class="CA">父类名称:</td>
							<td>
							  <input type="hidden" id="productTypeId">
							  <input type="text" id="ptype">
							</td>
							<td class="CA">类型名称:</td>
							<td>
							  <input type="text" id="typename">
							</td>
							<td class="CA">描述:</td>
							<td>
							  <input type="text"  id="remark">
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;
							  <input type="button" class="btn btn-green big" onclick="addType();" value="保存">
							</td>
						</tr>
					</table>
				  </form>
				<!--列表-->
				<div>
					<h3>产品类型列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>编号</th>
								<th>父类型</th>
								<th>名称</th>
								<th>描述</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="productTypes">
							
						</tbody>
					</table>
				</div>
				<!--列表 end-->
			 <div class="leading" id="pageTool">
					<div id="Pagination" class="pagination FR" style="text-align:center;"></div>
					<div>共 <b id="totalCount">0</b> 条，每页显示 <b><%=(String)conf.get("page.size")%></b> 条</div>
			 	</div>
			 <div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<link href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/util.js"></script>
  <script id="typeTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var type = data[i];
		#>
			<tr>
			<td class="textLeft"><#=type.id#></td>
			<td class="textLeft"><#=type.ptype#></td>
			<td class="textLeft"><#=type.typeName#></td>
			<td class="textLeft"><#=type.remark#></td>
			<td class="textLeft"><span class="CD">
				<#=getProductTypeState(type.state)#>
			</span></td>
			<td class="textLeft">
				<#if(type.state==1){#>
					<a href="#" onclick="javascript:modifyTypeState(0,<#=type.id#>)">下架</a>&nbsp;&nbsp; 
				<#}#>
				<#if(type.state==0){#>
					<a href="#" onclick="javascript:modifyTypeState(1,<#=type.id#>)">上架</a>&nbsp;&nbsp;
				<#}#>
				|&nbsp;&nbsp;<a onclick="javascript:updateType(<#=type.id#>)" href="#">编辑</a>&nbsp;&nbsp; 
				|&nbsp;&nbsp;<a onclick="javascript:deleteType(<#=type.id#>)" href="#">删除</a>&nbsp;&nbsp; 
			</td>
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
var pageCount,pageLength=4,currPageIndex=1;
//加载类型列表
	function loadData(pageIndex){
		$('#productTypes').html("");
		$('#Pagination').html("");
		var seachkey= $("#seachkey").val();
		currPageIndex = pageIndex = pageIndex||1;
		ptype = $("a.ptype[class*='current']").attr("data");
		state = $("a.State[class*='current']").attr("data");
		$.get("${pageContext.request.contextPath}/getProductTypes.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'seachkey':seachkey,'ptype':ptype,'state':state},function(rs){
			if(!rs || !rs.length)return;
	       	pageCount = rs[0];
	       	var total = rs[2];
	       	$("#totalCount").html(total);
	       	if(!pageCount)return;
	       	rs = rs[1];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#typeTmpl').html())(rs);
	    		$('#productTypes').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();

	// 绑定点击父类名称事件
	$("a.ptype").each(function(){
		$(this).bind("click", function(){
			$("a.ptype").removeClass("current");
			$(this).addClass("current");
			loadData(1);
		});
	});
	
	// 绑定点击状态事件
	$("a.State").each(function(){
		$(this).bind("click", function(){
			$("a.State").removeClass("current");
			$(this).addClass("current");
			loadData(1);
		});
	});
	

//添加或修改类型信息
function addType(){
	var productTypeId = $("#productTypeId").val();
	if(!productTypeId)productTypeId = 0;
	var pType =$("#ptype").val();
	if(!pType){
		alert("父类型不能为空");
		return;
	}
	var typename = $("#typename").val();
	if(!typename){
		alert("类型名称不能为空");
		return;
	}
	var remark = $("#remark").val();
	if(!remark){
		alert("描述不能为空");
		return;
	}
	
	$.post('saveUpdateProductType.do',{"productTypeVO.id":productTypeId,"productTypeVO.ptype":pType,"productTypeVO.typeName":typename,"productTypeVO.remark":remark},function(rs){
		if(rs=="success"){
			alert("保存成功");
				location.href='${pageContext.request.contextPath}/page/member/typeManager.jsp';
		}else{
			alert("操作失败，请稍后再试....");
		}
	});
}


// 绑定点击线路类型原因事件
function deleteType(id){
	$.post("${pageContext.request.contextPath}/deleteProductType.do?t=" + Math.random(),
			{'productTypeId':id},function(rs){
				location.href='${pageContext.request.contextPath}/page/member/typeManager.jsp';
			});
}

function modifyTypeState(value,id){
	$.post("${pageContext.request.contextPath}/modifyProductTypeState.do?t=" + Math.random(),
			{'state':value,'productTypeId':id},function(rs){
				location.href='${pageContext.request.contextPath}/page/member/typeManager.jsp';
			});
}
function updateType(id){
	$.getJSON("${pageContext.request.contextPath}/getProductTypeById.do?t=" + Math.random(),
			{'productTypeId':id},function(rs){
				rs=rs[0];
				$("#productTypeId").val(rs.id);
				$("#ptype").val(rs.ptype);
				$("#typename").val(rs.typeName);
				$("#remark").val(rs.remark);
			},'json');
}
</script>