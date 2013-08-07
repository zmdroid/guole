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
<title>用户留言管理</title>
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
			<h1>用户留言管理</h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<fieldset class="SearchBox">
				<legend>用户留言管理</legend>
					<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">状态:</td>
							<td class="Retrieval">
								<a href="javascript:;" class="State current" data="-1">全部</a>
								<a href="javascript:;" class="State" data="1">已回复</a>
								<a href="javascript:;" class="State" data="2">未回复</a>
							</td>
						</tr>
					</table>
				</fieldset>
				  <form id="typeForm" method="post" action="/loadNotifys.do">
					<table id="replyTable" class="InTable DisNo" width="100%" border="0" cellspacing="0" cellpadding="0">
						
						<tr>
							<td class="CA">留言编号:</td>
							<td>
							  <input type="text" id="commentId" readonly="readonly">
							</td>
							<td class="CA">回复内容:</td>
							<td>
							  <input type="text" id="replyMsg">
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;
							  <input type="button" class="btn btn-green big" onclick="addReplyMsg();" value="保存">
							</td>
						</tr>
					</table>
				  </form>
				<!--列表-->
				<div>
					<h3>用户留言列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>编号</th>
								<th>用户</th>
								<th>留言</th>
								<th>联系方式</th>
								<th>留言时间</th>
								<th>留言状态</th>
								<th>是否回复</th>
								<th>回复人</th>
								<th>回复内容</th>
								<th>回复时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="comments">
							
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
  <script id="commentTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var comment = data[i];
		#>
			<tr>
			<td class="textLeft"><#=comment.commentId#></td>
			<td class="textLeft"><#=comment.userName#></td>
			<td class="textLeft"><#=limitWordFromFront(comment.commentMsg,10)#></td>
			<td class="textLeft"><#=comment.linkPhone#></td>
			<td class="textLeft"><#=convertDateYMD(comment.pubtime)#></td>
			<td class="textLeft">
				<#if(comment.state==1){#>
					正常
				<#}else{#>
					关闭
				<#}#>
			</td>
			<td class="textLeft">
				<#if(comment.replyState==1){#>
					已回复
				<#}else{#>
					未回复
				<#}#>
			</td>
			<td class="textLeft"><#=comment.replyUser#></td>
			<td class="textLeft"><#=limitWordFromFront(comment.replyMsg,10)#></td>
			<td class="textLeft">
				<#if(null!=comment.replyTime){#>
					<#=convertDateYMD(comment.replyTime)#>
				<#}#>
			</td>
			<td class="textLeft">
				<#if(comment.replyState==2){#>
					<a href="#" onclick="javascript:replyComment(<#=comment.commentId#>)">回复</a>&nbsp;&nbsp;
				<#}#>
				|&nbsp;&nbsp;<a onclick="javascript:deleteComment(<#=comment.commentId#>)" href="#">删除</a>&nbsp;&nbsp; 
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
		$('#comments').html("");
		$('#Pagination').html("");
		currPageIndex = pageIndex = pageIndex||1;
		replyState = $("a.State[class*='current']").attr("data");
		$.get("${pageContext.request.contextPath}/getAllComments.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'commentVO.replyState':replyState},function(rs){
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
	    		var html = fn.template($('#commentTmpl').html())(rs);
	    		$('#comments').html(html);
	    		var html = fn.template($('#pageTmpl').html())(rs);
	    		$('#Pagination').html(html);
	       	}
		},'json');
	}
	
	loadData();

	// 绑定点击状态事件
	$("a.State").each(function(){
		$(this).bind("click", function(){
			$("a.State").removeClass("current");
			$(this).addClass("current");
			loadData(1);
		});
	});
	

//添加或修改类型信息
function addReplyMsg(){
	var commentId = $("#commentId").val();
	if(!commentId)productTypeId = 0;
	var replyMsg = $("#replyMsg").val();
	if(!replyMsg){
		alert("回复内容不能为空");
		return;
	}
	$.post('${pageContext.request.contextPath}/replyComment.do',{"commentVO.commentId":commentId,"commentVO.replyMsg":replyMsg},function(rs){
		if(rs=="success"){
			alert("保存成功");
				location.href='${pageContext.request.contextPath}/page/comment/commentManager.jsp';
		}else{
			alert("操作失败，请稍后再试....");
		}
	});
}


function deleteComment(id){
	$.post("${pageContext.request.contextPath}/delCommentById.do?t=" + Math.random(),
			{'commentId':id},function(rs){
				alert(rs);
				location.href='${pageContext.request.contextPath}/page/comment/commentManager.jsp';
				$('#replyTable').hide();
			});
}

function replyComment(id){
	$('#replyTable').show();
	$('#commentId').val(id);
}
</script>