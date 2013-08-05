<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>选择线路</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width120{
		width:120px !important;
	}
	
	.width130{
		width:130px !important;
	}
	
	.pointer{
		cursor: pointer;
	}
	
	.icon_export {
		background-image: url("${pageContext.request.contextPath}/img/export.png");
	}
	
	.icon_print {
		background-image: url("${pageContext.request.contextPath}/img/print.png");
	}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="product" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>线路推广管理 → <span>选择线路</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--添加标签-->
				<fieldset class="SearchBox">
					<legend>检索条件</legend>
					  <form id="qurForm" method="post" action="/loadLineList">
						<p>
							<label>线路名称:</label>
							<input type="text" name="lineVO.name" id="name" class="width120"/>
							&nbsp;&nbsp;<label>供应商名称:</label>
							<input type="text" name="lineVO.supplierName" id="supplierName" class="width120"/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>业务类型:</label>
							<select id="busiType" class="width130" name="lineVO.busiType">
								<option value="-1">全部</option>
								<option value="1">国内游</option>
								<option value="2">出境游</option>
								<option value="3">周边游</option>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>线路类型:</label>
							<select id="lineType" class="width130" name="lineVO.lineType">
								<option value="-1">全部</option>
								<option value="1">跟团游</option>
								<option value="2">自由行</option>
								<option value="3">地接</option>
							</select>
							<a href="javascript:loadLines();void(0);" id="searchBtn" class="btn  btn-blue">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" onclick="save();" id="saveBtn" class="btn  btn-blue">确定</a>
						</p>
					</form>
				</fieldset>
				<!--添加标签 end-->
				<!--列表-->
				<div>
					<h3 style="margin-bottom:15px;">
						线路列表
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
							    <th><input type="checkbox" id="allChk" onclick="allChk(this);"/></th>
								<th>线路名称</th>
								<th style="width:240px;">供应商名称</th>
								<th style="width:60px;">业务类型</th>
								<th style="width:60px;">线路类型</th>
								<th style="width:50px;">查看</th>
							</tr>
						</thead>
						<tbody id="lineList">
						
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

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
	<link href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
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
	//确认
	 function save(){
		   var chk = document.getElementsByName("chk");
		   if(!chk || chk.length == 0){
			   alert("请选择线路!");
			   return;
		   }
		   var len = chk.length;
		   var lineIds = new Array();
		   for(var i = 0; i < len; i++){
			   if(chk[i].checked){
				   lineIds.push(chk[i].value);
			   }
		   }
		  $.ajax({
			url: "${pageContext.request.contextPath}/addRankingLine.do",
			data:"lineIds="+lineIds.join(","),
			success: function onLoadData(data){
				if(data != null && data == "success"){
					 alert("线路添加成功!");
					 opener.qurLines();
					 window.close();
				}else{
					 alert("线路添加失败!");
				} 
			}
	     });
	}
	
	var pageIndex = 1;
	var pageLength;
	function loadLines(){
		pageIndex = 1;
		loadItems(pageIndex);
	}
	function loadMembers(){
		pageIndex = $('#pageNO').val();
		loadItems(pageIndex);
	}
	function loadItems(pageIndex){
		  document.getElementById("allChk").checked = false;
		  var postData = $('#qurForm').serialize();
		  var pages = $("#Pagination");
	      pages.html('');
		  $.ajax({
				url: "${pageContext.request.contextPath}/loadLineList.do?t=" + new Date().getTime(),
				dataType: 'json',
				data: postData+"&page="+pageIndex,
				success: function onLoadData(data){
					    pageLength = data.pageLength;
					    $('#totalCount').html(data.totalCount);
					    var html = '';
						var i=0, length=data.items.length, item;
						if(length > 0){
							  for(; i<length; i++) {
								   item = data.items[i];
								   html += '<tr>\
								        <td><input type="checkbox" name="chk" value="'+item.id+'" alt="'+item.name+'"/></td>\
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
							        html += '<td align="center"><a href="${pageContext.request.contextPath}/forwardManageLineViewPage.do?fromPage=manage&lineInfo.supplierId='+item.supplierId+'&lineId='+item.id+'" target="_blank">查看</a>&nbsp;&nbsp;\
							              </tr>';
							  }
						}
					
					    $('#lineList').html(html);
					    if(pageLength > 1){
					   		  pages.append('<a class="number" href="javascript:loadItems(1);">首页</a>');
					   		  if(pageIndex > 1){
					   			  var p = pageIndex - 1;
					   		      pages.append('<a class="number" href="javascript:loadItems('+p+');">上页</a>');
					   		  }else{
					   			  pages.append('<a class="number" href="javascript:loadItems('+pageIndex+');">上页</a>');
					   		  }
				  		      if(pageLength < 7){
					   			  for(var i = 1; i <= pageLength; i++){
					   				  pages.append('<a class="number" id="pageNo_'+i+'" href="javascript:loadItems('+i+');">'+i+'</a>');
					   			  }
				  		      }else{
				  		    	  if(pageCount - pageIndex >= 6){
				  		    		  for(var j = pageIndex; j < pageIndex+4; j++){
				  	    				  pages.append('<a class="number" id="pageNo_'+j+'" href="javascript:loadItems('+j+');">'+j+'</a>');
				  	    			  }
				  		    		  pages.append('<a class="number" href="javascript:void(0);">...</a>');
				  		    		  var ps = pageLength - 1;
				  		    		  pages.append('<a class="number" id="pageNo_'+ps+'" href="javascript:loadItems('+ps+');">'+ps+'</a>');
				  		    		  pages.append('<a class="number" id="pageNo_'+pageLength+'" href="javascript:loadItems('+pageLength+');">'+pageLength+'</a>');
				  		    	  }else{
				  		    		  for(var i = pageIndex; i <= pageLength; i++){
				  	    				  pages.append('<a class="number" id="pageNo_'+i+'" href="javascript:loadItems('+i+');">'+i+'</a>');
				  	    			  }
				  		    	  }
				  		      }
					   		  if(pageIndex < pageLength){
					   			  var p = pageIndex + 1;
					   		      pages.append('<a class="number" href="javascript:loadItems('+p+');">下页</a>');
					   		  }else{
					   			  pages.append('<a class="number" href="javascript:loadItems('+pageIndex+');">下页</a>');
					   		  }
					   		  
					   		  pages.append('<a class="number" href="javascript:loadItems('+pageLength+');">末页</a>');
					   		  pages.append('<input type="text" class="WMids Input" style="width:30px;" id="pageNO">&nbsp;<a class="number current" style="height:40px;" href="javascript:loadMembers();">跳到该页</a>');
						      var id = "#pageNo_"+pageIndex;
						   	  $(id).addClass('pagination-active');
						   	  pages.show();
					   	  }else{
					   		  pages.hide();
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
	loadLines();
	</script>
</body>
</html>