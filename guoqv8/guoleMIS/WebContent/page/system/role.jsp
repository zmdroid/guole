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
<title>角色管理</title>
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
			<h1>系统管理 →<span>角色管理</span></h1>
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
						<a class="btn btn-blue" href="${pageContext.request.contextPath}/page/system/addRole.jsp">
							添加角色
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>角色列表</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th>名称</th>
								<th>描述</th>
								<th>功能</th>
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
			var role = data[i];
	#>
	<tr>
		<td><#=role.name#></td>
		<td><#=role.detail#></td>
		<td>
			<div style="height:20px;overflow:hidden;">
			<#if(role.permission.length>1){#>
				<a href="javascript:void(0)" onclick="toggleMore(this.parentNode)">更多</a>		
			<#}#>
			<#=parsePermission(role.permission)#>
			</div>
		</td>
		<td ><a href="${pageContext.request.contextPath}/page/system/editRole.jsp?id=<#=role.id#>">编辑</a> | <a href="javascript:void(0)" onclick="removeRole(<#=role.id#>)">删除</a></td>
	</tr>
	<#}#>
</script>
<script type="text/javascript">
//初始化模版引擎
var tmplOpts = {varName:'data', compiler:'rapid'};
fn.template.setting(tmplOpts);
	$.get("${pageContext.request.contextPath}/getRoles.do",{},function(rs){
		html = fn.template($('#rechargeTmpl').html())(rs);
		$('#memberInfos').html(html);
	},'json');
	
	function parsePermission(ps){
		var name='';
		for(var i=ps.length;i--;){
			name += ps[i].detail+"<br/>";
		}
		return name;
	}
	
	function toggleMore(n){
		if($(n).css('overflow')=='hidden'){
			n.style.overflow = 'auto';
			n.style.height = '100%';
		}else{
			$(n).css('overflow','hidden');
			n.style.height = '20px';
		}
	}
	
	function removeRole(id){
		if(confirm('是否要删除该角色？')){
			$.post('${pageContext.request.contextPath}/removeRole.do',{'roleVO.id':id},function(){
				alert('删除成功');
				location.reload();
			});
		}
	}
	
</script>
</html>
