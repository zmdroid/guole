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
<title>会员信息管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="memberManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>会员管理 → <span>会员信息管理</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--检索-->
				<fieldset class="SearchBox">
				   <form id="qurForm" method="post" action="/loadMembers.do">
					<legend>检索</legend>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">会员类型:</td>
							<td>
								<select name="memberInfoVO.usertype" id="usertype" class="Select" style="width:120px;">
								    <option value="-1" selected>--会员类型--</option>
									<option value="1">个人</option>
									<option value="2">企业</option>
								</select>
							</td>
							<td class="CA">会员状态:</td>
							<td>
								<select name="memberInfoVO.state" id="state" class="Select" style="width:120px;">
								    <option value="-1" selected>--会员状态--</option>
									<option value="1">待审核</option>
									<option value="2">审核通过</option>
									<option value="3">审核拒绝</option>
									<option value="4">冻结</option>
								</select>
							</td>
							<td class="CA">用户姓名:</td>
							<td><input type="text" id="name" class="WidD" name="memberInfoVO.name"></td>
							<td class="CA">公司名称:</td>
							<td><input type="text" id="corname" class="WidD" name="memberInfoVO.corname"></td>
						</tr>
						<tr>
							<td class="CA">会员帐号:</td>
							<td><input type="text" id="userAccount" class="WidD" name="memberInfoVO.userAccount"></td>
							<td class="CA"></td>
							<td><input type="button" class="btn btn-green big" onclick="qurMembers();" value="搜索"></td>
							<td colspan="2">
								<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
									<c:if test="${item.addr eq 'batchTransit.do'}">     
										<input type="button" class="btn btn-green big" onclick="batchTransit();" value="通过">&nbsp;
									</c:if> 
								</c:forEach>
								
								<c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
									<c:if test="${item.addr eq 'batchRefuse.do'}">     
										<input type="button" class="btn btn-green big" onclick="batchRefuse();" value="拒绝">
									</c:if> 
								</c:forEach>						
							</td>
						</tr>
					</table>
				   </form>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>会员列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
							    <th><input type="checkbox" id="allChk" onclick="allChk(this);"/></th>
								<th>会员姓名</th>
								<th>会员帐号</th>
								<th>会员类型</th>
								<th>会员状态</th>
								<th>操作</th>
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
function loadItems(){
	  document.getElementById("allChk").checked = false;
	  var postData = $('#qurForm').serialize();
	  var pages = $("#Pagination"); 
	  $.ajax({
			url: "${pageContext.request.contextPath}/loadMembers.do?time=" + new Date().getTime(),
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
							        <td><input type="checkbox" name="chk" value="'+item.userId+'"/></td>\
							        <td>'+replaceHtml(item.name)+'</td>\
							        <td>'+replaceHtml(item.userAccount)+'</td>';
							        
							        if(item.usertype == '1'){
							        	html += '<td>个人</td>';
							        }else if(item.usertype == '2'){
							        	html += '<td>企业</td>';
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
										if(item.state == '1' || item.state == '3'){
										   html += '|&nbsp;&nbsp;<a href="javascript:transit('+item.userId+');">审核通过</a>&nbsp;&nbsp;';
										}
										if(item.state == '1' || item.state == '2'){
										   html += '|&nbsp;&nbsp;<a href="javascript:refuse('+item.userId+');">审核拒绝</a>&nbsp;&nbsp;';
										}
										if(item.state == '1' || item.state == '2' || item.state == '3'){
										   html += '|&nbsp;&nbsp;<a href="javascript:freeze('+item.userId+');">冻结</a>&nbsp;&nbsp;';
										}
										if(item.state == '4'){
										   html += '|&nbsp;&nbsp;<a href="javascript:unFreeze('+item.userId+');">解冻</a>';
										}
								   html += '</td></tr>';
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
function allChk(obj){
	 var chks = document.getElementsByName("chk");
	 if(!chks || chks.length == 0){
		   return;
	 }else{
		 var size = chks.length;
		 if(obj.checked){
			 for(var i = 0; i < size; i++ ){
				 chks[i].checked = true;
			 }
		 }else{
			 for(var i = 0; i < size; i++ ){
				 chks[i].checked = false;
			 }
		 }
	 }
}

 //批量审核通过会员账户
 function batchTransit(){
	   var chk = document.getElementsByName("chk");
	   if(!chk || chk.length == 0){
		   alert("请选择要审核通过的会员!");
		   return;
	   }
	   var len = chk.length;
	   var userIds = new Array();
	   for(var i = 0; i < len; i++){
		   if(chk[i].checked){
			   userIds.push(chk[i].value);
		   }
	   }
	   if(userIds.length == 0){
		   alert("请选择要审核通过的会员!");
		   return;
	   }
	   if(window.confirm("会员信息审核通过,确认吗?")){
		   $.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/batchTransit.do?time=" + new Date().getTime(),
				  data: "userIds="+userIds.join(","),
				  async : true,
				  success:function callbackFunc(data){
				      if (data == "ERROR"){      
				    	  alert('批量审核通过失败,请稍后再试!');
				      }else{
				    	  alert("批量审核通过成功!"); 
				    	  qurMembers();
				      }
				  }
			});
	   }
}
//批量审核拒绝会员账户
 function batchRefuse(){
	   var chk = document.getElementsByName("chk");
	   if(!chk || chk.length == 0){
		   alert("请选择要审核拒绝的会员!");
		   return;
	   }
	   var len = chk.length;
	   var userIds = new Array();
	   for(var i = 0; i < len; i++){
		   if(chk[i].checked){
			   userIds.push(chk[i].value);
		   }
	   }
	   if(userIds.length == 0){
		   alert("请选择要审核拒绝的会员!");
		   return;
	   }
	   if(window.confirm("会员信息审核拒绝,确认吗?")){
		   $.ajax( {
				  type: "post",
				  url: "${pageContext.request.contextPath}/batchRefuse.do?time=" + new Date().getTime(),
				  data: "userIds="+userIds.join(","),
				  async : true,
				  success:function callbackFunc(data){
				      if (data == "ERROR"){      
				    	  alert('批量审核拒绝失败,请稍后再试!');
				      }else{
				    	  alert("批量审核拒绝成功!"); 
				    	  qurMembers();
				      }
				  }
			});
	   }
}
 //冻结会员账户
 function freeze(userId){
     $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/freezeAccount.do?time=" + new Date().getTime(),
		  data: "memberInfoVO.userId="+userId,
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "ERROR"){      
		    	  alert('会员帐号冻结失败,请稍后再试!');
		      }else{
		    	  alert("会员帐号冻结成功!"); 
		    	  qurMembers();
		      }
		  }
	 });
 }
//解除会员账户冻结
 function unFreeze(userId){
     $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/unFreezeAccount.do?time=" + new Date().getTime(),
		  data: "memberInfoVO.userId="+userId,
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "ERROR"){      
		    	  alert('会员帐号解冻失败,请稍后再试!');
		      }else{
		    	  alert("会员帐号解冻成功!"); 
		    	  qurMembers();
		      }
		  }
	 });
 }
 //审核通过会员账户
 function transit(userId){
     $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/transit.do?time=" + new Date().getTime(),
		  data: "memberInfoVO.userId="+userId,
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "ERROR"){      
		    	  alert('会员帐号审核通过失败,请稍后再试!');
		      }else{
		    	  alert("会员帐号审核通过成功!"); 
		    	  qurMembers();
		      }
		  }
	 });
 }
//审核拒绝会员账户
 function refuse(userId){
     $.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/refuse.do?time=" + new Date().getTime(),
		  data: "memberInfoVO.userId="+userId,
		  async : true,
		  success:function callbackFunc(data){
		      if (data == "ERROR"){      
		    	  alert('会员帐号审核拒绝失败,请稍后再试!');
		      }else{
		    	  alert("会员帐号审核拒绝成功!"); 
		    	  qurMembers();
		      }
		  }
	 });
 }
 qurMembers();
</script>