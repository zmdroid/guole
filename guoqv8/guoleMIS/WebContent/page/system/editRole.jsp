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
			<h1>系统管理 →<span>编辑角色</span></h1>
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
						<a href="${pageContext.request.contextPath}/page/system/role.jsp">返回
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>角色</h3>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="CA">名称:</td>
								<td><input type="text" id="name" class="WidD" value="" name="name"></td>
							</tr>
							<tr>
								<td class="CA">描述:</td>
								<td><input type="text" id="detail" class="WidD" value="" name="detail"></td>
							</tr>
							<tr>
								<td class="CA">资源权限:</td>
								<td id="permission">
									
								</td>
							</tr>
							<tr>
								<td class="CA">
									<a class="btn btn-blue" style="padding:0 10px;" onclick="editRole()" href="javascript:void(0)">确定更新</a>
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
function editRole(){
	var name = $('#name').val();
	var detail = $('#detail').val();
	if(!$.trim(name)){
		alert('名称必须填写');
		return;
	}
	
	var permissions = '';
	var index = 0;
	$('input[type="checkbox"]').each(function(i){
		if(this.checked){
			permissions += '&roleVO.permission['+index+'].id='+this.value;
			index++;
		}
	});
	permissions = permissions.substring(1, permissions.length);
	$.post('${pageContext.request.contextPath}/updateRole.do?'+permissions,
			{'roleVO.name':name,'roleVO.detail':detail,'roleVO.id':'${param.id}'},
			function(rs){
		alert('更新成功');
		top.location.href='${pageContext.request.contextPath}/page/system/role.jsp';
	});
}
function chkPermissions(obj,tid){
	var tchkid = '#chk_'+tid;
	if(obj.checked){
		$(tchkid).attr("checked",true);
	}
}
function modPermissions(obj,pid,tid){
	var chkid = '#chk_'+pid;
	var tchkid = '#chk_'+tid;
	if(obj.checked){
		$(chkid).attr("checked",true);
		$(tchkid).attr("checked",true);
	}
}
$.get('${pageContext.request.contextPath}/getResources.do',{r:Math.random()},function(rs){
	var html = '<table>';
	var size = rs.length;
	var tid = -1;
	var pid = -1;
	for(var i = 0;i < size;i++){
		if(rs[i].tid != tid){
			tid = rs[i].tid;
			html += '<tr>\
			     <td><input type="checkbox" value="'+rs[i].tid+'" id="chk_'+rs[i].tid+'" onclick="chkPermissions(this);">'+rs[i].tdetail+'</td></tr>';
		}
		if(rs[i].pid != pid){
			pid = rs[i].pid;
			html += '<tr>\
			     <td>|&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="'+rs[i].pid+'" id="chk_'+rs[i].pid+'" onclick="chkPermissions(this,'+rs[i].tid+');">'+rs[i].pdetail+'</td></tr>';
		}
		html += '<tr><td>|&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="chk_'+rs[i].id+'" id="chk_'+rs[i].id+'" onclick="modPermissions(this,'+rs[i].pid+','+rs[i].tid+');" value="'+rs[i].id+'">'+rs[i].detail+'</td>';
	}
	html +='</table>';
	$('#permission').html(html);
	$.get('${pageContext.request.contextPath}/getRole.do',{'roleVO.id':'${param.id}',r:Math.random()},function(result){
		$('#name').val(result.name);
		$('#detail').val(result.detail);
		var permission = result.permission;
		var len = permission.length;
		var id;
		for(var i = 0; i < len;i++){
			id='#chk_'+permission[i].id;
			$(id).attr("checked",true);
		}
	},'json');
},'json');
</script>
</html>
