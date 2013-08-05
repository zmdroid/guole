<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    <title>公告列表页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
  
  <body>
   	<!-- Header -->
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>公告管理</h1>
		</div>
	</div>
	<!-- End of Page title -->
    
    <!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--添加资讯-->
				<a href="${pageContext.request.contextPath }/page/information/edit.jsp?type=2" class="btn  btn-blue">添加公告</a>
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						公告列表
					</h3>
					<table class="display stylized">
							<thead>
								<tr>
									<th scope="col">公告ID</th>
									<th scope="col">资讯标题</th>
									<th scope="col">发布时间</th>
									<th scope="col">操作</th>
								</tr>
							</thead>
							<tbody id="annouList">
							</tbody>
						</table>
				</div>
			 <div class="leading" id="pageTool">
					<div id="Pagination" class="pagination FR" style="text-align:center;"></div>
					<div>共 <b id="totalCount">0</b> 条，每页显示 <b><%=(String)conf.get("page.size")%></b> 条</div>
			 	</div>
		</div>
		<!--列表-->
	</div>
	<!-- End of Page content -->

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
  </body>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
  <script id="annouTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var info = data[i];
		#>
			<tr>
			<td class="textLeft"><#=info.id#></td>
			<td class="textLeft"><#=info.title#> </td>
			<td class="textLeft"><#=convertDate(info.publishTime)#></td>
			<td class="textLeft">
				<a href="#" onclick="javascript:updateInfo(<#=info.id#>)">编辑</a>&nbsp;&nbsp; 
				<#if(info.state==0){#>
					|&nbsp;&nbsp;<a  href="#" onclick="javascript:updateInfoState(<#=info.id#>,1)">上架</a>&nbsp;&nbsp; 
				<#}else{#>
					|&nbsp;&nbsp;<a  href="#" onclick="javascript:updateInfoState(<#=info.id#>,0)">下架</a>&nbsp;&nbsp; 
				<#}#>
				|&nbsp;&nbsp;<a href="#" onclick="javascript:deleteInfo(<#=info.id#>)">删除</a> 
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
	var pageCount,pageLength=4,currPageIndex=1, companyName,state;
	function loadData(pageIndex){
		$('#annouList').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		$.get("${pageContext.request.contextPath}/getInformations.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'type':2},function(rs){
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
	    		var html = fn.template($('#annouTmpl').html())(rs);
	    		$('#annouList').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();
	
	function deleteInfo(id){
		$.get("${pageContext.request.contextPath}/deleteInformation.do?t=" + Math.random(),
				{'infoNo':id},function(rs){
					alert("操作成功");
				location.href='${pageContext.request.contextPath}/page/annou/announcement.jsp';
		});
	}
	
	function updateInfoState(id,state){
		$.get("${pageContext.request.contextPath}/modifyInformationState.do?t=" + Math.random(),
				{'infoNo':id,'state':state},function(rs){
					alert("操作成功");
				location.href='${pageContext.request.contextPath}/page/annou/announcement.jsp';
		});
	}
	
	function updateInfo(id){
		location.href='${pageContext.request.contextPath}/page/information/edit.jsp?type=2&infoNo='+id
	}

</script>
</html>
