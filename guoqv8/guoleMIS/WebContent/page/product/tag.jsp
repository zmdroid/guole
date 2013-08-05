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
<title>标签管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="tagManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>产品管理 → <span>标签管理</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--添加标签-->
				<fieldset class="SearchBox">
				  <form id="qurForm" method="post" action="/loadTags.do">
					<legend>标签管理</legend>
					<table class="table" width="70%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">标签名称:</td>
							<td><input type="text" id="name" class="WidD" name="tagVO.name"></td>
							<td class="CA">标签状态:</td>
							<td>
							   <select name="tagVO.status" id="status" class="Select" style="width:120px;">
								    <option value="-1" selected>--标签状态--</option>
									<option value="0">无效</option>
									<option value="1">有效</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;
							  <input type="button" class="btn btn-green big" onclick="qurTags();" value="搜索">
							</td>
							<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
								<c:if test="${item.addr eq 'editTag.jsp'}">     
									<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									  <input type="button" class="btn btn-green big" onclick="addTag();" value="添加">
									</td>
							    </c:if> 
						    </c:forEach>	
						</tr>
					</table>
				  </form>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<h3>标签列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>标签名称</th>
								<th>标签说明</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="tagInfos">
							
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
function qurTags(){
	_CURRENT_PAGE = 1;
	_pageDis = false;
	loadItems();
}
function addTag(){
	window.open('${pageContext.request.contextPath}/page/product/editTag.jsp');
}
function loadItems(){
	  var postData = $('#qurForm').serialize();
	  var pages = $("#Pagination");
	  $.ajax({
			url: "${pageContext.request.contextPath}/loadTags.do?time=" + new Date().getTime(),
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
							        <td>'+replaceHtml(item.name)+'</td>\
							        <td>'+replaceHtml(item.remark)+'</td>';
							        if(item.status == '0'){
							        	html += '<td>无效</td>';
							        }else if(item.status == '1'){
							        	html += '<td>有效</td>';
							        }
						        html += '<td align="center"><a href="${pageContext.request.contextPath}/editTag.do?id='+item.id+'" target="_blank">编辑</a>&nbsp;&nbsp;';
						        if(item.status == '1'){
						           html += '|&nbsp;&nbsp;<a href="javascript:removeTag('+item.id+');">删除</a>';
						        }else if(item.status == '0'){
						           html += '|&nbsp;&nbsp;<a href="javascript:rebackTag('+item.id+');">恢复</a></td>';
						        }
						        html += ' </tr>';
						  }
						  pages.show();
					}else{
						_pageDis = false;
						pages.hide();
						html = "<tr><td colspan='5' style='height:30px;color:red;' align='center' valign='middle'>没有相关标签</td></li>";
					}
				    $('#tagInfos').html(html);
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
//分页控件回调
function pageselectCallback(page_index){
	if (_CURRENT_PAGE == (page_index+1)){
		return false;
	}
	_CURRENT_PAGE = page_index+1;
	loadItems();
	return false;
}
 //重新找回已删除标签 
 function rebackTag(id){
	 if(window.confirm("恢复该标签,确认吗?")){
		    $.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/rebackTag.do",
				  data: "id="+id,
				  async : true,
				  success:function callbackFunc(data){
				      if (data == "ERROR"){      
				    	  alert('标签恢复失败,请稍后再试!');
				      }else{
				    	  alert("标签恢复成功!"); 
				    	  qurTags();
				      }
				  }
			 });
	}
 }
 //删除标签
 function removeTag(id){
	if(window.confirm("删除该标签,确认吗?")){
	    $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/removeTag.do",
			  data: "id="+id,
			  async : true,
			  success:function callbackFunc(data){
			      if (data == "ERROR"){      
			    	  alert('标签删除失败,请稍后再试!');
			      }else{
			    	  alert("标签删除成功!"); 
			    	  qurTags();
			      }
			  }
		 });
	}
 }
 qurTags();
</script>