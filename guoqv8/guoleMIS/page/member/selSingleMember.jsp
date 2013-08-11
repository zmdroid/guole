<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>选择会员</title>
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
			<h1>会员管理 → <span>选择会员</span></h1>
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
									<option value="1">买家</option>
									<option value="2">卖家</option>
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
						</tr>
					</table>
				   </form>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>会员列表(单击选择会员)</h3>
					<table id="memberList" class="display stylized">
						<thead>
							<tr>
								<th>会员姓名</th>
								<th>性别</th>
								<th>QQ</th>
								<th>邮箱</th>
								<th>电话</th>
								<th>会员类型</th>
								<th>会员状态</th>
							</tr>
						</thead>
						<tbody id="memberInfos">
							
						</tbody>
					</table>
				</div>
				<!--列表 end-->
			<div class="leading">
				<div class="FR">
					<p class="pagination ta-right" id="pageBar" style="display:none;">
						
					</p>
				</div>
				<div id="toolBar" style="display:none;">共 <b><span id="totalCount"></span></b> 条，每页显示 <b><%=(String)conf.get("page.size")%></b> 条</div>
			</div>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
</body>
</html>
<script type="text/javascript">
var pageIndex = 1;
var pageLength;
function qurMembers(){
	pageIndex = 1;
	loadItems(pageIndex);
}
function loadMembers(){
	pageIndex = $('#pageNO').val();
	loadItems(pageIndex);
}

function loadItems(pageIndex){
	  var postData = $('#qurForm').serialize();
	  var pages = $("#pageBar");
      pages.html('');
	  $.ajax({
			url: "${pageContext.request.contextPath}/loadMembers.do?t=" + new Date().getTime(),
			dataType: 'json',
			data: postData+"&page="+pageIndex,
			success: function onLoadData(data){
				    pageLength = data.pageLength;
				    $('#totalCount').html(data.totalCount);
				    $('#toolBar').show();
				    var html = '';
					var i=0, length=data.items.length, item;
					if(length > 0){
						  for(; i<length; i++) {
							   item = data.items[i];
							   html += '<tr onclick="save('+item.userId+',\''+item.name+'\');" onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);"><td>'+item.name+'</td>';
							        if(item.sex == 'm'){
							        	html += '<td>男</td>';
							        }else if(item.sex == 'f'){
							        	html += '<td>女</td>';
							        }else{
							        	html += '<td>未知</td>';
							        }
							        
							        html += '<td>'+item.qq+'</td>\
							        <td>'+item.email+'</td>\
							        <td>'+item.mobile+'</td>';
							        if(item.usertype == '1'){
							        	html += '<td>买家</td>';
							        }else if(item.usertype == '2'){
							        	html += '<td>卖家</td>';
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
							        html += '</tr>';
						  }
					}
				    $('#memberInfos').html(html);
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
 
 function mouseOver(obj){
	$(obj).css({"background":"#87CEEB"});  
 }

 function mouseOut(obj){
	 $(obj).css({"background":"#fff"});   
 }

 //确认
 function save(userId,userName){
	   opener.$('#userId').val(userId);
	   opener.$('#userName').val(userName);
 	   window.close();
 }
 qurMembers();
</script>