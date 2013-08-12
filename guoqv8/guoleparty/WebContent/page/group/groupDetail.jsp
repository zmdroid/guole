<%@ page language="java" import="java.util.*,com.guole.util.Config" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>会员-更多折扣</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
</head>
<body>
<!--Header-->
<!--Header end--> 

<!--PageBody-->
<div id="PageBody">
						<!--列表-->
						<table class="LTable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<thead>
							<tr>
								<th scope="col">编号</th>
								<th scope="col">主图</th>
								<th scope="col">名称</th>
								<th scope="col">备注</th>
								<th scope="col">折扣</th>
								<th scope="col">操作</th>
							</tr>
							</thead>
							<tbody id="vipCardList">
							</tbody>
						</table>
						<!--列表 end-->
						<!--翻页-->
						<div class="Pages" id="Pagination">							
						</div>
</div>
<!--PageBody end-->
<!--Footer-->
<!--Footer end-->
</body>
</html>
<%@include file="/js.jsp" %>
  <script type="text/javascript" src="${pageContext.request.contextPath}/Script/fn.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/Script/util.js"></script>
  <script id="vipCardListTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var vipCard = data[i];
		#>
			<tr>
			<td scope="col">
				<#=vipCard.cardId#>
			</td>
			<td scope="col"><img src="${imgUrl}<%=conf.getString("vipDir")%><#=vipCard.mainPic#>" width="120" height="90"/></td>
			<td scope="col"><#=vipCard.name#></td>
			<td scope="col"><#=vipCard.remark#></td>
			<td scope="col"><#=vipCard.discount#></td>
			<td scope="col"><a href="javascript:(0);">申请会员</td>
		</tr>
		<#}#>
	<!--列表 end-->
</script>
<script id="pageTmpl" type="text/x-fn-tmpl">
	<#if(pageCount > 1){#>
		<div class="Pages">
			<#if(currPageIndex<2){#>
				<a class="Disabled" class="Disabled" href="javascript:void(0)">上一页</a>&nbsp;
			<#}else{#>
				<a class="" href="javascript:loadData(<#=currPageIndex-1#>)">上一页</a>&nbsp;
			<#}#>
			<%-- 出现首页导航 --%>
			<#if(currPageIndex>(pageLength+1)){#>
				<a href="javascript:loadData(1)">1...</a>&nbsp;
				<#for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){#>
					<#var tmp = j+1;#>
					<a class="" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}else{#>
				<#for(var j=1;j<currPageIndex;j++){#>
					<a class="" href="javascript:loadData(<#=j#>)"><#=j#></a>&nbsp;
				<#}#>
			<#}#>
			<a class="Active" href="javascript:void(0)"><#=currPageIndex#></a>&nbsp;
			<%-- 出现末页导航 --%>
			<#if(pageCount-pageLength>currPageIndex){#>
				<#for(var j=1;j<=pageLength;j++){#>
					<#var tmp = currPageIndex+j;#>
					<a class="" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
				<a class="" href="javascript:loadData(<#=pageCount#>)">...<#=pageCount#></a>&nbsp;
			<#}else{#>
				<#for(var j=1;j<=(pageCount-currPageIndex);j++){#>
					<#var tmp = currPageIndex+j;#>
					<a class="" href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}#>
			
			<#if(currPageIndex==pageCount){#>
				<a class="Disabled" href="javascript:void(0)">下一页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex+1#>)">下一页</a>
			<#}#>
			</div>
		<#}#>
</script>
<script type="text/javascript" charset="utf-8">
var pageCount,pageLength=4,currPageIndex=1, companyName,state;
function loadData(pageIndex){
	$('#zhaopinList').html("");
	$('#Pagination').html("");
	currPageIndex = pageIndex = pageIndex||1;
	state = $("a.State[class*='current']").attr("data");
	$.get("${pageContext.request.contextPath}/getAllVIPCards.do?t=" + Math.random(),
			{'pageIndex':pageIndex},function(rs){
		if(!rs || !rs.length)return;
       	pageCount = rs[0];
       	if(!pageCount)return;
       	rs = rs[1];
       	if(rs){
       		//初始化模版引擎
    		var tmplOpts = {varName:'data', compiler:'rapid'};
    		fn.template.setting(tmplOpts);
    		var html = fn.template($('#vipCardListTmpl').html())(rs);
    		$('#vipCardList').html(html);
    		var html = fn.template($('#pageTmpl').html())(rs);
    		$('#Pagination').html(html);
       	}
	},'json');
}

loadData();
</script>
