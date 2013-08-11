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
<title>供应商榜单</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="supplyRankingManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>会员管理 → <span>供应商榜单</span></h1>
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
									<c:if test="${item.addr eq '/selSupply.jsp'}">     
										<input type="button" class="btn btn-green big" onclick="popupAddSupply();" value="添加">&nbsp;
									</c:if> 
								</c:forEach>
								
								<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
									<c:if test="${item.addr eq '/generateSupplyRanking.do'}">     
										<input type="button" class="btn btn-green big" onclick="generateSupplyRanking();" value="生成榜单">
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
					<h3>供应商列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>会员姓名</th>
								<th>邮箱</th>
								<th>电话</th>
								<th>会员类型</th>
								<th>会员状态</th>
								<th>操作</th>
								<th style="width:70px;">排序</th>
							</tr>
						</thead>
						<tbody id="memberInfos">
							
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
function qurMembers(){
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
function removeSupply(id){
	if(window.confirm("删除榜单中的供应商,确认吗?")){
		 $.ajax({
				url: "${pageContext.request.contextPath}/removeSupply.do",
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
function resetSupplyRanking(id,obj,sortNo){
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
			 obj.value == sortNo;
			 return;
		 }
	 }
	 var postData = "id="+id+"&sortNo="+obj.value+"&oldSortNo="+sortNo;
	 $.ajax({
			url: "${pageContext.request.contextPath}/resetSupplyRanking.do",
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
function generateSupplyRanking(){
	if(window.confirm("生成供应商榜单,确认吗?")){
		 $.ajax({
			url: "${pageContext.request.contextPath}/generateSupplyRanking.do",
			success: function onLoadData(data){
				if(data != null && data == "success"){
					 alert("供应商榜单生成成功!");
				}else{
					 alert("供应商榜单生成失败!");
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
			url: "${pageContext.request.contextPath}/loadSupplyRanking.do?t=" + new Date().getTime(),
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
							        <td>'+replaceHtml(item.name)+'</td>\
							        <td>'+item.email+'</td>\
							        <td>'+item.mobile+'</td>';
							        if(item.usertype == '1'){
							        	html += '<td>买家</td>';
							        }else if(item.usertype == '2'){
							        	html += '<td>卖家</td>';
							        }else{
							        	html += '<td>平台</td>';
							        }
							        if(item.state == '1'){
							        	html += '<td>待审核</td>';
							        }else if(item.state == '2'){
							        	html += '<td>审核通过</td>';
							        }else if(item.state == '3'){
							        	html += '<td>审核拒绝</td>';
							        }else if(item.state == '4'){
							        	html += '<td>冻结</td>';
							        }
							        html += '<td align="center"><a href="${pageContext.request.contextPath}/memberDetail.do?userId='+item.userId+'" target="_blank">查看</a>&nbsp;&nbsp;';
							        <c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
										<c:if test="${item.addr eq '/removeSupply.do'}">     
										   html += '|&nbsp;&nbsp;<a href="javascript:removeSupply('+item.id+');">删除</a>&nbsp;&nbsp;';
										</c:if>   
								    </c:forEach>
								    html += '<td align="center"><input onkeydown="resetSupplyRanking('+item.id+',this,'+item.sortNo+');" style="width:50px;" type="text" value="'+item.sortNo+'"/></td>\
								          </td></tr>';
						  }
						  pages.show();
					}else{
						_pageDis = false;
						pages.hide();
						html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有相关会员信息</td></li>";
					}
				    $('#memberInfos').html(html);
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
 function popupAddSupply(){
	window.open("${pageContext.request.contextPath}/page/member/selSupply.jsp"); 
 }
 qurMembers();
</script>