<%@ page language="java" import="java.util.*,com.guole.util.Config" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
long sysTime = System.currentTimeMillis();
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>水果团购-更多优惠</title>
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
								<th scope="col">开始时间</th>
								<th scope="col">结束时间</th>
								<th scope="col">原价</th>
								<th scope="col">现价</th>
								<th scope="col">已购买人数</th>
								<th scope="col">所属类型</th>
								<th scope="col">商品详情</th>
							</tr>
							</thead>
							<tbody id="groupList">
							</tbody>
						</table>
						<!--列表 end-->
						<!--翻页-->
						<div>
							总共<span id="total">0</span>条团购							
						</div>
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
  <script id="groupListTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var gourpItem = data[i];
		#>
			<tr>
			<td scope="col">
				<#=gourpItem.recordNo#>
			</td>
			<td scope="col"><img src="${imgUrl}<%=conf.getString("tuanDir")%><#=gourpItem.image#>" width="120" height="90"/></td>
			<td scope="col"><#=gourpItem.title#></td>
			<td scope="col"><#=convertDate(gourpItem.startTime)#></td>
			<td scope="col">
				<span class="CGray">计时</span> 
				<span id="timeCount" class="F18 FFG CPink"></span>
				<input type="hidden" id="endTime" value="<#=gourpItem.endTime.time#>"/>
				<#=gourpItem.endTime.time#>
			</td>
			<td scope="col"><#=gourpItem.value#></td>
			<td scope="col"><#=gourpItem.price#></td>
			<td scope="col"><#=gourpItem.bought#></td>
			<td scope="col"><#=gourpItem.subcategory#></td>
			<td scope="col"><#=gourpItem.remark#></td>
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
	$.get("${pageContext.request.contextPath}/getGroupbuys.do?t=" + Math.random(),
			{'typeId':-1,'pageIndex':pageIndex},function(rs){
		if(!rs || !rs.length)return;
       	var total = rs[0];
       	$("#total").html(total);
       	pageCount = rs[1];
       	if(!pageCount)return;
       	rs = rs[2];
       	if(rs){
       		//初始化模版引擎
    		var tmplOpts = {varName:'data', compiler:'rapid'};
    		fn.template.setting(tmplOpts);
    		var html = fn.template($('#groupListTmpl').html())(rs);
    		$('#groupList').html(html);
    		var html = fn.template($('#pageTmpl').html())(rs);
    		$('#Pagination').html(html);
       	}
	},'json');
}

loadData();

// 倒计时定时器
setInterval(function(){
	$("#timeCount").each(function(){
		timeCount();
	});
}, 100);

// 倒计时
var lessTime = "<%=sysTime%>" - new Date().getTime();
function timeCount(){
  	var obj = $("#endTime");
    var endTime = obj.val();
    var nowTime = new Date().getTime() + lessTime;
    var nMS = endTime - nowTime;
    var myD = Math.floor(nMS/(1000 * 60 * 60 * 24));
    var myH = Math.floor(nMS/(1000*60*60)) % 24;
    var myM = Math.floor(nMS/(1000*60)) % 60;
    var myS = Math.floor(nMS/1000) % 60;
   	var myMS = Math.floor(nMS/100) % 10;
 	if(nMS>= 0){
 		var dayStr = (myD == 0) ? "" : myD + " 天 ";
 		var hourStr = (myH == 0) ? "" : myH + " 小时 ";
 		var minStr = (myM == 0 && myH == 0) ? "" : myM + " 分 ";
 		
		var str = dayStr + hourStr + minStr + myS + " ." + myMS + " 秒";
		// $("#buy").removeAttr("disabled");	
   	}else{
		var str = "该团购到期了！";
		// $("#buy").attr("disabled", "disabled");	
	}
	$("#timeCount").html(str);
}
</script>
