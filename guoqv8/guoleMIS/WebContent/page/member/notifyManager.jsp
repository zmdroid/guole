<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
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
<title>消息管理</title>
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
			<h1>会员管理 → <span>消息管理</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<fieldset class="SearchBox">
				  <form id="qurForm" method="post" action="/loadNotifys.do">
					<legend>消息管理</legend>
					<table class="table" width="80%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">发送时间:</td>
							  <td><input type="text" id="startDate" readonly="readonly" onClick="WdatePicker()" class="width120" name="notifyVO.startDate">~
							  <input type="text" id="endDate" readonly="readonly" onClick="WdatePicker()" class="width120" name="notifyVO.endDate">
							</td>
							<td class="CA">消息类型:</td>
							<td>
							   <select name="notifyVO.type" id="type" class="Select" style="width:120px;">
								    <option value="-1" selected>--消息类型--</option>
									<option value="0">系统自动触发</option>
									<option value="1">后台手动发送</option>
									<option value="2">买家询价发送</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;
							  <input type="button" class="btn btn-green big" onclick="qurNotifys();" value="搜索">
							</td>
							<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
								<c:if test="${item.addr eq 'publishNotify.jsp'}">     
									<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									  <input type="button" class="btn btn-green big" onclick="publishNotify();" value="发布">
									</td> 
								</c:if> 
							</c:forEach> 
						</tr>
					</table>
				  </form>
				</fieldset>
				<!--列表-->
				<div>
					<h3>消息列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>信息内容</th>
								<th>信息类型</th>
								<th>发送时间</th>
								<th>发送人</th>
								<th>接收人</th>
							</tr>
						</thead>
						<tbody id="notifyInfos">
							
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var _CURRENT_PAGE = 1;
var pageLength;
var _pageDis = false;
function qurNotifys(){
	pageIndex = 1;
	_pageDis = false;
	loadItems();
}
//分页控件回调
function pageselectCallback(page_index){
	if (_CURRENT_PAGE == (page_index+1)){
		return false;
	}
	_CURRENT_PAGE = page_index+1;
	loadItems();
	return false;
}
function publishNotify(){
	window.open('${pageContext.request.contextPath}/page/member/publishNotify.jsp');
}
function loadItems(){
	  var postData = $('#qurForm').serialize();
	  var pages = $("#Pagination");
	  $.ajax({
			url: "${pageContext.request.contextPath}/loadNotifys.do?time=" + new Date().getTime(),
			dataType: 'json',
			data: postData+"&page="+_CURRENT_PAGE,
			success: function onLoadData(data){
				    pageLength = data.pageLength;
				    $('#totalCount').html(data.totalCount);
				    var html = '';
					var i=0, length=data.items.length, item;
					if(length > 0){
						  for(; i<length; i++) {
							   item = data.items[i];
							   html += '<tr>\
							        <td>'+replaceHtml(item.content)+'</td>';
							        if(item.type == '0'){
							        	html += '<td>系统自动触发</td>';
							        }else if(item.type == '1'){
							        	html += '<td>后台手动发送</td>';
							        }else if(item.type == '2'){
							        	html += '<td>买家询价发送</td>';
							        }
							   html += '<td>'+item.publishTime+'</td>\
							        <td>'+replaceHtml(item.fromByName)+'</td>\
							        <td>'+replaceHtml(item.receiverName)+'</td>\
						            </tr>';
						  }
						  pages.show();
					}else{
						_pageDis = false;
						pages.hide();
						html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有相关系统消息</td></li>";
					}
				    $('#notifyInfos').html(html);
				    if (!_pageDis){
					    if (pageLength == 1) {
				    		pages.hide();
						}
					    $("#Pagination").show();
					    $("#Pagination").pagination(pageLength, {callback: pageselectCallback});
					    _pageDis = true;
				    }
			      }
		  });
 }
qurNotifys();
</script>