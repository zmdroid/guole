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
<title>添加资源信息</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="/header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>系统管理 →<span>添加资源</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--检索-->
				<fieldset class="SearchBox">
					<legend></legend>
					<p class="box">
						<a href="${pageContext.request.contextPath}/page/system/permission.jsp">返回
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>资源信息</h3>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						    <tr>
								<td class="CA">上级资源:</td>
								<td>
								   <select id="pid" style="width:160px;" name="permissionVO.pid">
								      <option value="-1">--上级资源--</option>
								   </select>
								</td>
							</tr>
							<tr>
								<td class="CA">URL:</td>
								<td><input type="text" id="addr" class="WidD" value="" name="permissionVO.addr"></td>
							</tr>
							<tr>
								<td class="CA">描述:</td>
								<td><input type="text" id="detail" class="WidD" value="" name="permissionVO.detail"></td>
							</tr>
							<tr>
								<td colspan="2">
									<a class="btn btn-blue" style="padding:0 10px;" onclick="addPermission()" href="javascript:void(0)">确定添加</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--列表 end-->
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
</body>
<script type="text/javascript">
$.get("${pageContext.request.contextPath}/getTopPermissions.do",{},function(rs){
	var len = rs.length;
	var html = '<option value="-1">--上级资源--</option>';
	for(var index = 0; index < len; index++){
		html += '<option value="'+rs[index].id+'">'+rs[index].detail+'</option>';
	}
	$('#pid').html(html);
},'json');
function addPermission(){
	var pid = $('#pid').val();
	var addr = $('#addr').val();
	var detail = $('#detail').val();
	if(!$.trim(addr)){
		alert('URL必须填写');
		return;
	}
	if(!$.trim(detail)){
		alert('描述必须填写');
		return;
	}
	
	$.post('${pageContext.request.contextPath}/addPermission.do',
			{'permissionVO.addr':addr,'permissionVO.detail':detail,'permissionVO.pid':pid},
			function(rs){
		alert('添加成功');
		top.location.href='${pageContext.request.contextPath}/page/system/permission.jsp';
	});
}


</script>
</html>
