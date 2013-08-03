<%@ page language="java" import="java.util.*,com.guole.util.Config" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>留言信息</title>
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
				<th scope="col">发布人姓名</th>
				<th scope="col">发布人联系方式</th>
				<th scope="col">发布的信息</th>
				<th scope="col">发布的时间</th>
			</tr>
		</thead>
		<tbody id="commentList">
		</tbody>
	</table>
	<!--列表 end-->
	<!--翻页-->
	<div>
	一共有<span id="total"></span>条留言							
	</div>
	<div class="Pages" id="Pagination">							
	</div>
	
	<br>
	<!-- 留言 -->
	<div>
		发布留言
		<br>
		<form id="commentForm" name="commentForm" action="modifyUserInfo.do" method="POST">
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">留言内容:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="commentVO.commentMsg" id="commentMsg" maxlength="120""> 
					<font color="red"> <span id="nameError"></span></font>
				</span></td>
			</tr>
			<tr>
				<td class="CA">联系方式:</td>
				<td>
					<span class="IBoxTip"> 
					<input class="IEnter WMax" type="text" name="commentVO.linkPhone" id="linkPhone" maxlength="60" value="${sessionScope.current_user_info.qq}"> 
					<font color="red"><span id="qqError"></span></font>
					</span>
				</td>
			</tr>
		</table>
		<div class="PostBut">
			<a href="javascript:void(0);" class="But" id="addComment">提交</a>
		</div>
	</form>
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
  <script id="commentTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var comment = data[i];
		#>
			<tr>
			<td scope="col">
				<#=comment.commentId#>
			</td>
			<td scope="col"><#=comment.userName#></td>
			<td scope="col"><#=comment.linkPhone#></td>
			<td scope="col"><#=comment.commentMsg#></td>
			<td scope="col"><#=comment.commentMsg#></td>
			<td scope="col"><#=convertDate(comment.pubtime)#></td>
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
	$('#commentList').html("");
	$('#Pagination').html("");
	currPageIndex = pageIndex = pageIndex||1;
	state = $("a.State[class*='current']").attr("data");
	$.get("${pageContext.request.contextPath}/getAllComments.do?t=" + Math.random(),
			{'pageIndex':pageIndex},function(rs){
		if(!rs || !rs.length)return;
       	var total = rs[0];
       	$('#total').html(total);
       	pageCount = rs[1];
       	if(!pageCount)return;
       	rs = rs[2];
       	if(rs){
       		//初始化模版引擎
    		var tmplOpts = {varName:'data', compiler:'rapid'};
    		fn.template.setting(tmplOpts);
    		var html = fn.template($('#commentTmpl').html())(rs);
    		$('#commentList').html(html);
    		var html = fn.template($('#pageTmpl').html())(rs);
    		$('#Pagination').html(html);
       	}
	},'json');
}

loadData();

//基本信息维护
function clickButton(){
	  var commentMsg = $('#commentMsg');
	  if($.trim(commentMsg.val()).length == 0){
		  $('#nameError').show();
		  $('#nameError').html("内容不能为空!");
		  setFocus(commentMsg);
		  return;
	  }else{
		  $('#nameError').html('');
		  $('#nameError').hide();
	  }
	  var linkPhone = $('#linkPhone');
	  if($.trim(linkPhone.val()).length == 0){
		  $('#emailError').show();
		  $('#emailError').html("联系方式不能为空!");
		  setFocus(linkPhone);
		  return;
	  }else{
			  $('#emailError').html('');
			  $('#emailError').hide();
		  }
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/addComment.do?time=" + new Date().getTime(),
		  data: $("#commentForm").serialize(),
		  async : true,
		  success:function callbackFunc(data){
		     if(data == "ERROR"){
		    	  alert("系统繁忙,,请稍后再试!");
		      }else{
		    	  alert("留言成功!");
		      }
		    window.location.reload();
		  }
   	 });
	 return true;
}


$("#addComment").click(function(){   
    clickButton(); 
}); 
</script>
