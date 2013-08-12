<%@ page language="java" import="java.util.*,com.guole.util.Config" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
   Config conf = Config.getInstance();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>个人中心-送货地址</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body>
	个人中心
	<br>
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>
	
	<div>
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<thead>
				<th>联系人</th>
				<th>联系电话</th>
				<th>送货地址</th>
				<th>操作</th>
			</thead>
			<tbody id="linkaddrs">
			
			</tbody>
		</table>
		
	</div>
	<div>
	<form id="modifyLinkAddrForm" name="modifyLinkAddrForm" action="addUpdateLinkAddr.do" method="POST">
		<input type="hidden" name="linkAddrVO.id" id="id" value="">
		<table class="PTTable BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="CA">联系人:</td>
				<td>
					<input class="IEnter WMax" type="text" name="linkAddrVO.linkMan" id="linkMan" maxlength="30"> 
				</td>
			</tr>
			<tr>
				<td class="CA">联系电话:</td>
				<td>
					<input class="IEnter WMax" type="text" name="linkAddrVO.linkPhone" id="linkPhone" maxlength="30"> 
				</td>
			</tr>
			<tr>
				<td class="CA">送货地址:</td>
				<td>
					<input class="IEnter WMax" type="text" name="linkAddrVO.address" id="address" maxlength="30" > 
				</td>
			</tr>
		</table>
		<div class="PostBut">
			<a href="javascript:void(0);" class="But" id="updateBtn">保存</a>
		</div>
	</form>
	</div>
</body>
<%@include file="/js.jsp" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/Script/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/util.js"></script>
<script id="linkaddrTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var linkaddr = data[i];
		#>
		<tr>
			<td><#=linkaddr.linkMan#></td>
			<td><#=linkaddr.linkPhone#></td>
			<td><#=linkaddr.address#></td>
			<td>
				<a href="javascript:void(0);" onclick="editLinkAddr(<#=linkaddr.id#>,'<#=linkaddr.linkMan#>','<#=linkaddr.linkPhone#>','<#=linkaddr.address#>')">编辑</a>
				<a href="javascript:void(0);" onclick="delLinkAddr(<#=linkaddr.id#>)">删除</a>
			</td>
		</tr>
		<#}#>
	<!--列表 end-->
	<#if(pageCount > 1){#>
		<div class="Pages">
			<#if(currPageIndex<2){#>
				<a class="Disabled" href="javascript:void(0)">上页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex-1#>)">上页</a>&nbsp;
			<#}#>
			<%-- 出现首页导航 --%>
			<#if(currPageIndex>(pageLength+1)){#>
				<a href="javascript:loadData(1)">1...</a>&nbsp;
				<#for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){#>
					<#var tmp = j+1;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}else{#>
				<#for(var j=1;j<currPageIndex;j++){#>
					<a href="javascript:loadData(<#=j#>)"><#=j#></a>&nbsp;
				<#}#>
			<#}#>
			<a class="Active" href="javascript:void(0)"><#=currPageIndex#></a>&nbsp;
			<%-- 出现末页导航 --%>
			<#if(pageCount-pageLength>currPageIndex){#>
				<#for(var j=1;j<=pageLength;j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
				<a href="javascript:loadData(<#=pageCount#>)">...<#=pageCount#></a>&nbsp;
			<#}else{#>
				<#for(var j=1;j<=(pageCount-currPageIndex);j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}#>
			
			<#if(currPageIndex==pageCount){#>
				<a class="Disabled" href="javascript:void(0)">下页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex+1#>)">下页</a>
			<#}#>
			</div>
		<#}#>
</script>
<script type="text/javascript">
var pageCount,pageLength=4,currPageIndex=1;

function loadData(pageIndex){
	currPageIndex = pageIndex||1;
	$.get("${pageContext.request.contextPath}/getAllLinkAddrByUserId.do?t=" + Math.random(),
			{'pageIndex':currPageIndex},function(rs){
		if(!rs || !rs.length)return;
	    var total = rs[0];
       	pageCount = rs[1];
       	if(!pageCount)return;
       	rs = rs[2];
       	if(rs){
       		//初始化模版引擎
    		var tmplOpts = {varName:'data', compiler:'rapid'};
    		fn.template.setting(tmplOpts);
    		var html = fn.template($('#linkaddrTmpl').html())(rs);
    		$('#linkaddrs').html(html);
       	}
	},'json');
}

loadData();
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/Script/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8">

var canClick = true;
//基本信息维护
function clickButton(){
	  if(!canClick)return;
	  canClick = false;
	  var name = $('#linkMan');
	  if($.trim(name.val()).length == 0){
		  alert("姓名不能为空!");
		  setFocus(name);
		  canClick = true;
		  return;
	  }
	  var linkPhone = $('#linkPhone');
	  if($.trim(linkPhone.val()).length == 0){
		  alert("联系电话不能为空!");
		  setFocus(linkPhone);
		  canClick = true;
		  return;
	  }
	  var address = $('#address');
	  if($.trim(address.val()).length == 0){
		  alert("送货地址不能为空!");
		  setFocus(address);
		  canClick = true;
		  return;
	  }
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/addUpdateLinkAddr.do?time=" + new Date().getTime(),
		  data: $("#modifyLinkAddrForm").serialize(),
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "login"){    
		    	 location.href="${pageContext.request.contextPath}/login";
		      }else if(data == "error"){
		    	  alert("系统繁忙,,请稍后再试!");
		      }else{
		    	  alert("地址修改成功!");
		    	  window.location.reload();
		      }
		      canClick = true;
		  }
   	 });
	 return true;
}


$("#updateBtn").click(function(){   
    clickButton(); 
}); 

function editLinkAddr(id,linkMan,linkPhone,address){
	$("#id").val(id);
	$("#linkMan").val(linkMan);
	$("#linkPhone").val(linkPhone);
	$("#address").val(address);
}

function delLinkAddr(id){
	  $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/delLinkAddr.do?time=" + new Date().getTime(),
		  data: {'linkAddrVO.id':id},
		  async : true,
		  success:function callbackFunc(data){
		    if(data == "error"){
		    	  alert("系统繁忙,,请稍后再试!");
		     }else{
		    	  alert("删除成功!");
		    	  window.location.reload();
		      }
		  }
   	 });
}


</script>
</html>
