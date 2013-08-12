<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    <title>礼品卡类型列表页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
  
  <body>
   	<!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="cardManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>礼品卡类型管理</h1>
		</div>
	</div>
	<!-- End of Page title -->
    
    <!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<a href="${pageContext.request.contextPath }/page/card/editgifttype.jsp" class="btn  btn-blue">添加礼品卡类型</a>
				<!--添加标签-->
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						礼品卡类型列表
					</h3>
					<table class="display stylized">
							<thead>
								<tr>
									<th scope="col">编号ID</th>
									<th scope="col">主图</th>
									<th scope="col"> 名称</th>
									<th scope="col"> 金额</th>
									<th scope="col">描述</th>
									<th scope="col">状态</th>
									<th scope="col">操作</th>
								</tr>
							</thead>
							<tbody id="gifttypeList">
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
  <script id="gifttypeTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var type = data[i];
		#>
			<tr>
			<td class="textLeft"><#=type.id#></td>
			<td class="textLeft"><img src="${imgUrl}<%=conf.getString("giftDir")%><%=conf.getString("thumb")%>/<#=type.img#>" width="120" height="90"/></td>
			<td class="textLeft"><#=type.name#></td>
			<td class="textLeft"><#=type.money#></td>
			<td class="textLeft"><#=type.remark#></td>
			<td class="textLeft"><span class="CD">
				<#=getGiftCardTypeState(type.state)#>
			</span></td>
			<td class="textLeft">
					<a  href="${pageContext.request.contextPath }/page/card/editgifttype.jsp?giftCardTypeId=<#=type.id#>">查看详情</a>&nbsp;&nbsp;
				<#if(type.state==1){#>
					|&nbsp;&nbsp;<a  href="#" onclick="javascript:modifyCardTypeState(2,<#=type.id#>)">下架</a>&nbsp;&nbsp;
				<#}#>
				<#if(type.state==2){#>
					|&nbsp;&nbsp;<a  href="#" onclick="javascript:modifyCardTypeState(1,<#=type.id#>)">上架</a>&nbsp;&nbsp;
				<#}#>
				|&nbsp;&nbsp;<a  onclick="javascript:deleteCardType(<#=type.id#>)" href="#">删除</a> 
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
		$('#gifttypeList').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		state = 0;
		$.get("${pageContext.request.contextPath}/getGiftCardTypes.do?t=" + Math.random(),
				{'pageIndex':pageIndex},function(rs){
			if(!rs || !rs.length)return;
	    	var total = rs[0];
	       	$("#totalCount").html(total);
	       	pageCount = rs[1];
	       	if(!pageCount)return;
	       	rs = rs[2];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#gifttypeTmpl').html())(rs);
	    		$('#gifttypeList').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();
	
	// 绑定点击线路类型原因事件
	function deleteCardType(id){
		$.post("${pageContext.request.contextPath}/delGiftCardTypeById.do?t=" + Math.random(),
				{'giftTypeId':id},function(rs){
					alert("操作成功");
					window.location="${pageContext.request.contextPath}/page/card/giftcardtypelist.jsp";
				});
	}
	
	function modifyCardTypeState(value,id){
		$.post("${pageContext.request.contextPath}/modifyGifyCardTypeById.do?t=" + Math.random(),
				{'state':value,'giftTypeId':id},function(rs){
					alert("操作成功");
					window.location="${pageContext.request.contextPath}/page/card/giftcardtypelist.jsp";
				});
	}
</script>
</html>
