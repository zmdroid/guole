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
<title>帐号管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="/header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/menu.jsp">
		<jsp:param value="sysManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>系统管理 →<span>编辑帐号</span></h1>
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
						<a href="${pageContext.request.contextPath}/page/system/manager.jsp">返回
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>帐号</h3>
					<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="CA">原密码:</td>
								<td><input type="password" id="pwdOld" class="WidD" value="" name="firstname"></td>
							</tr>
							<tr>
								<td class="CA">密码:</td>
								<td><input type="password" id="pwd" class="WidD" value="" name="firstname"></td>
							</tr>
							<tr>
								<td class="CA">姓名:</td>
								<td><input type="text" id="name" class="WidD" value="" name="firstname"></td>
							</tr>
							<tr>
								<td class="CA">电话:</td>
								<td><input type="text" id="tel" class="WidD" value="" name="firstname"></td>
							</tr>
							<tr>
								<td class="CA">邮箱:</td>
								<td><input type="text" id="email" class="WidD" value="" name="firstname"></td>
							</tr>
							<tr>
								<td class="CA">包含角色:</td>
								<td>
									<select style="float:left;width:100px;" id="permissions" multiple="multiple">
										
									</select>
									<div style="float:left;margin:0 10px 0 10px;overflow:hidden;width:47px">
										<button id="toRight">
											&gt;&gt;&gt;
										</button>
										<button style="float:left;" id="toLeft"> 
											&lt;&lt;&lt;
										</button>
									</div>
									<select style="float:left;width:100px;" id="allPermissions" multiple="multiple">
										
									</select>
								</td>
							</tr>
							<tr>
								<td class="CA">
									<a class="btn btn-blue" style="padding:0 10px;" onclick="editManager()" href="javascript:void(0)">确定更新</a>
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
Array.prototype.indexOf = Array.prototype.indexOf||function(elt)
{
  var len = this.length;
  var from = 0;
  for (; from < len; from++){
    if (this[from] === elt)
      return from;
  }
  return -1;
};

function editManager(){
	var pwdOld = $('#pwdOld').val();
	var pwd = $('#pwd').val();
	if($.trim(pwd)){//需要修改密码
		if(!$.trim(pwdOld)){
			alert('原密码必须填写');
			return;
		}
	}
	var name = $('#name').val();
	var tel = $('#tel').val();
	var email = $('#email').val();
	
	var permissions = '';
	$('#permissions option').each(function(i){
		permissions += '&managerVO.role['+i+'].id='+this.value;
	});
	permissions = permissions.substring(1, permissions.length);
	$.post('${pageContext.request.contextPath}/updateManagerInfo.do?'+permissions,
			{'managerVO.id':'${param.id}','managerVO.pwd':pwd,'pwdOld':pwdOld,
		'managerVO.userName':name,'managerVO.tel':tel,
		'managerVO.email':email},
			function(rs){
			if(rs=='pwd_error'){
				alert('原密码错误');
				return;
			}
		alert('更新成功');
		top.location.href='${pageContext.request.contextPath}/page/system/manager.jsp';
	});
}

var roleIds = [];
$.get('${pageContext.request.contextPath}/getManager.do',{'managerVO.id':'${param.id}',r:Math.random()},function(rs){
	$('#name').val(rs.userName);
	$('#tel').val(rs.tel);
	$('#email').val(rs.email);
	var opts = '';
	var roles = rs.role;
	for(var i=roles.length;i--;){
		roleIds.push(roles[i].id);
		opts += '<option value="'+roles[i].id+'">'+roles[i].name+'</option>';
	}
	$('#permissions').html(opts);
	$.get('${pageContext.request.contextPath}/getRoles.do',{r:Math.random()},function(rs){
		var opts = '';
		for(var i=rs.length;i--;){
			if(roleIds.indexOf(rs[i].id)>-1)continue;
			opts += '<option value="'+rs[i].id+'">'+rs[i].name+'</option>';
		}
		$('#allPermissions').html(opts);
	},'json');
},'json');


$('#toLeft').click(function(){
	var permissions = $('#permissions');
	$('#allPermissions option:selected').each(function(){
		this.parentNode.removeChild(this);
		this.selected = false;
		permissions.append(this);
	});
});
$('#toRight').click(function(){
	var permissions = $('#allPermissions');
	$('#permissions option:selected').each(function(){
		this.parentNode.removeChild(this);
		this.selected = false;
		permissions.append(this);
	});
});
</script>
</html>
