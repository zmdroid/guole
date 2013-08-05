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
<title>后台帐号管理</title>
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
			<h1>系统管理 →<span>用户管理</span></h1>
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
					<p class="">
						<a class="btn btn-blue" href="${pageContext.request.contextPath}/page/system/addManager.jsp">
							添加帐号
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>后台帐号列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>姓名</th>
								<th>用户名</th>
								<th>角色</th>
								<th>邮箱</th>
								<th>电话</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="memberInfos">
							
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script id="rechargeTmpl" type="text/x-fn-tmpl">
	<#
		for(var i = 0,l = data.length; i < l; i++){
			var manager = data[i];
	#>
	<tr>
		<td><#=manager.userName#></td>
		<td><#=manager.userAccount#></td>
		<td><#=parseRole(manager.role)#></td>
		<td><#=manager.email#></td>
		<td><#=manager.tel#></td>
		<td><#=manager.accountStatus==1?'正常':'冻结'#></td>
		<td>
			<#if(manager.accountStatus==1){#>
				<a href="javascript:void(0)" onclick="freeze(<#=manager.id#>)">冻结</a>
			<#}else{#>
				<a href="javascript:void(0)" onclick="unfreeze(<#=manager.id#>)">解除冻结</a>
			<#}#>
			 | <a href="${pageContext.request.contextPath}/page/system/editManager.jsp?id=<#=manager.id#>">设置角色</a>
		</td>
	</tr>
	<#}#>
</script>
<script type="text/javascript">
//初始化模版引擎
var tmplOpts = {varName:'data', compiler:'rapid'};
fn.template.setting(tmplOpts);
	$.get("${pageContext.request.contextPath}/getManagers.do",{},function(rs){
		html = fn.template($('#rechargeTmpl').html())(rs);
		$('#memberInfos').html(html);
	},'json');
	
	function parseRole(roles){
		var roleName='';
		for(var i=roles.length;i--;){
			roleName += roles[i].name+"<br/>";
		}
		return roleName;
	}
	
	function freeze(id){
		$.post("${pageContext.request.contextPath}/freeze.do",{'managerVO.id':id},function(rs){
			alert('已冻结');
			location.reload();
		});
	}
	function unfreeze(id){
		$.post("${pageContext.request.contextPath}/unfreeze.do",{'managerVO.id':id},function(rs){
			alert('冻结已解除');
			location.reload();
		});
	}
</script>
</html>
