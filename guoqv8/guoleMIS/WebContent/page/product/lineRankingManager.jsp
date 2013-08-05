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
<title>线路推广</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="lineRankingManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>产品管理 → <span>线路推广</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--操作-->
				<fieldset class="SearchBox">
				   <form id="qurForm" method="post" action="/loadMembers.do">
					<legend>操作</legend>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2">
								<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
									<c:if test="${item.addr eq '/selLine.jsp'}">     
										<input type="button" class="btn btn-green big" onclick="popupAddLine();" value="添加">&nbsp;
									</c:if> 
								</c:forEach>
								
								<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
									<c:if test="${item.addr eq '/generateLineRanking.do'}">     
										<input type="button" class="btn btn-green big" onclick="generateLineRanking();" value="生成榜单">
									</c:if> 
								</c:forEach>						
							</td>
						</tr>
					</table>
				   </form>
				</fieldset>
				<!--操作 end-->
				<!--列表-->
				<div>
					<h3>线路列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
							    <th>线路名称</th>
								<th style="width:240px;">供应商名称</th>
								<th style="width:60px;">业务类型</th>
								<th style="width:60px;">线路类型</th>
								<th style="width:80px;">操作</th>
								<th style="width:60px;">排序</th>
							</tr>
						</thead>
						<tbody id="lineInfos">
							
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
</div>
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<link href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var _CURRENT_PAGE = 1;
var _pageDis = false;
var pageLength;
var maxSortNo;
function qurLines(){
	_CURRENT_PAGE = 1;
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
function removeRankingLine(id){
	if(window.confirm("删除榜单中的线路,确认吗?")){
		 $.ajax({
				url: "${pageContext.request.contextPath}/removeRankingLine.do",
				data:"id="+id,
				success: function onLoadData(data){
					if(data != null && data == "success"){
						 alert("移除成功!");
						 loadItems();
					}else{
						 alert("移除失败!");
					} 
				}
	     });
	}
}
function resetLineRanking(id,obj,sortNo){
	 if(event && event.keyCode != 13){ 
    	return;
    }
	 if(!validateNum(obj.value)){
		 alert("排序号只能输入数字!");
		 obj.value = sortNo;
		 return;
	 }else{
		 if(parseInt(obj.value) < 0){
			 alert("排序号只能输入正整数!");
			 obj.value = sortNo;
			 return;
		 }else if(parseInt(obj.value) > maxSortNo){
			 alert("排序号不能大于"+maxSortNo+"!");
			 obj.value = sortNo;
			 return;
		 }
	 }
	 var postData = "id="+id+"&sortNo="+obj.value+"&oldSortNo="+sortNo;
	 $.ajax({
			url: "${pageContext.request.contextPath}/resetLineRankingSort.do",
			data:postData,
			success: function onLoadData(data){
				if(data != null && data == "success"){
					 alert("设置成功!");
					 loadItems();
				}else{
					 alert("设置失败!");
				} 
			}
    });
}
function generateLineRanking(){
	if(window.confirm("生成线路推广榜单,确认吗?")){
		 $.ajax({
			url: "${pageContext.request.contextPath}/generateLineRanking.do",
			success: function onLoadData(data){
				if(data != null && data == "success"){
					 alert("线路推广榜单生成成功!");
				}else{
					 alert("线路推广榜单生成失败!");
				} 
			}
	     });
	}
}
function validateNum(val){//验证整数
	   var patten = /^-?\d+$/;
	   return patten.test(val);
}
function loadItems(){
	  var pages = $("#Pagination"); 
	  $.ajax({
			url: "${pageContext.request.contextPath}/loadLineRanking.do?t=" + new Date().getTime(),
			dataType: 'json',
			data: "page="+_CURRENT_PAGE,
			success: function onLoadData(data){
				    pageLength = data.pageLength;
				    maxSortNo = data.maxSortNo;
				    $('#totalCount').html(data.totalCount);
				    var html = '';
					var i=0, length=data.items.length, item;
					if(length > 0){
						  for(; i<length; i++) {
							   item = data.items[i];
							   html += '<tr>\
							        <td>'+limitWord(replaceHtml(item.name),30)+'</td>\
							        <td>'+replaceHtml(item.supplierName)+'</td>';
							        if(item.busiType == '1'){
							        	html += '<td>国内游</td>';
							        }else if(item.busiType == '2'){
							        	html += '<td>境外游</td>';
							        }else{
							        	html += '<td>周边游</td>';
							        }
							        if(item.lineType == '1'){
							        	html += '<td>跟团游</td>';
							        }else if(item.lineType == '2'){
							        	html += '<td>自由行</td>';
							        }else{
							        	html += '<td>当地地接</td>';
							        }
							        html += '<td align="center"><a href="${pageContext.request.contextPath}/forwardManageLineViewPage.do?fromPage=manage&lineInfo.supplierId='+item.supplierId+'&lineId='+item.id+'" target="_blank">查看</a>&nbsp;&nbsp;';
							        <c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
										<c:if test="${item.addr eq '/removeRankingLine.do'}">     
										   html += '|&nbsp;&nbsp;<a href="javascript:removeRankingLine('+item.rankingId+');">删除</a>&nbsp;&nbsp;';
										</c:if>   
								    </c:forEach>
								    html += '<td align="center"><input onkeydown="resetLineRanking('+item.rankingId+',this,'+item.sortNo+');" style="width:50px;" type="text" value="'+item.sortNo+'"/></td>\
								          </td></tr>';
						  }
						  pages.show();
					}else{
						_pageDis = false;
						pages.hide();
						html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有相关线路信息</td></li>";
					}
				    $('#lineInfos').html(html);
				    if (!_pageDis){
					    if (pageLength == 1) {
				    		pages.hide();
						}
					    pages.show();
					    pages.pagination(pageLength, {callback: pageselectCallback});
					    _pageDis = true;
				    }
			     }
		  });
 }
/**
 * 截取字符
 * @param {Object} str 字符串
 * @param {Object} limit 截取长度
 * @return {TypeName} 
 */
function limitWord(str, limit){
	if (str) {
		if (str.length >= limit) {
			str = str.substring(0, limit) + "...";
		}
	}
	
	return str;
}
 function popupAddLine(){
	window.open("${pageContext.request.contextPath}/page/product/selLine.jsp"); 
 }
 qurLines();
</script>