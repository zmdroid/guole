<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    <title>招聘列表页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
  
  <body>
   	<!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="adManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>招聘管理</h1>
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
							<td class="CA">公司名称:</td>
							<td>
								<input type="text" id="companyname"> 
							</td>
							<td><a href="javascript:void(0);" onclick="loadData()" class="btn  btn-blue">筛选</a></td>
						</tr>
						<tr>
							<td class="CA">审核状态:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="State current" data="-1">全部</a>
								<a href="javascript:;" class="State" data="1">正常</a>
								<a href="javascript:;" class="State" data="2">关闭</a>
								<a href="javascript:;" class="State" data="3">审核不通过</a>
							</td>
						</tr>
					</table>
				</fieldset>
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						招聘列表
					</h3>
					<table class="display stylized">
							<thead>
								<tr>
									<th width="40" scope="col">ID</th>
									<th width="150" scope="col">职位</th>
									<th scope="col">发布公司</th>
									<th scope="col">工作地点</th>
									<th scope="col">月薪</th>
									<th scope="col">截止时间</th>
									<th width="50" scope="col">状态</th>
									<th width="180" scope="col">操作</th>
								</tr>
							</thead>
							<tbody id="zhaopinList">
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
  <script id="zhaopinTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var zhaopin = data[i];
		#>
			<tr>
			<td class="textLeft"><#=zhaopin.id#></td>
			<td class="textLeft"><#=replaceHtml(zhaopin.position)#></td>
			<td class="textLeft"> <#=replaceHtml(zhaopin.companyName)#> </td>
			<td class="textLeft"><#=zhaopin.province#>-<#=zhaopin.city#>-<#=zhaopin.district#></td>
			<td class="textLeft"><#=zhaopin.lowSalary#>~<#=zhaopin.hightSalary#></td>
			<td class="textLeft"><#=convertDateYMD(zhaopin.dateLimit)#></td>
			<td class="textLeft"><span class="CD">
				<#=getZhaopinState(zhaopin.state)#>
			</span></td>
			<td class="textLeft">
				<a target="_new" href="${pageContext.request.contextPath}/zhaopin/getZhaopinDetail.do?recruitId=<#=zhaopin.id#>">查看详情</a>&nbsp;&nbsp; 
				<#if(zhaopin.state==1){#>
					|&nbsp;&nbsp;<a href="#" onclick="javascript:modifyRecruitState(3,<#=zhaopin.id#>)">审核不通过</a> 
				<#}#>
				<#if(zhaopin.state==3){#>
					|&nbsp;&nbsp;<a href="#" onclick="javascript:modifyRecruitState(1,<#=zhaopin.id#>)">审核通过</a>
				<#}#>
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
		$('#zhaopinList').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		companyName = $('#companyname').val();
		state = $("a.State[class*='current']").attr("data");
		$.get("${pageContext.request.contextPath}/getZhaopinlist.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'companyName':companyName,'state':state},function(rs){
			if(!rs || !rs.length)return;
	       	pageCount = rs[1];
	       	var total = rs[2];
	       	$("#totalCount").html(total);
	       	if(!pageCount)return;
	       	rs = rs[0];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#zhaopinTmpl').html())(rs);
	    		$('#zhaopinList').html(html);
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
	
	function modifyRecruitState(value,id){
		$.post("${pageContext.request.contextPath}/modifyZhaopinState.do?t=" + Math.random(),
				{'state':value,'recruitId':id},function(rs){
					alert("操作成功");
					window.location="${pageContext.request.contextPath}/page/zhaopin/zhaopinlist.jsp";
				});
	}
</script>
</html>