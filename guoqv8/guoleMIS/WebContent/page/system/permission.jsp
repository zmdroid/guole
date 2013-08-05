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
<title>资源管理</title>
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
			<h1>系统管理 →<span>资源管理</span></h1>
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
						<a class="btn btn-blue" href="${pageContext.request.contextPath}/page/system/addPermission.jsp">
							添加资源
						</a>
					</p>
				</fieldset>
				<!--检索 end-->
				<!--列表-->
				<div>
					<h3>资源列表</h3>
					<table class="display stylized leftCls">
						<thead>
							<tr>
								<th align="left">资源URL</th>
								<th>描述</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="memberInfos">
							
						</tbody>
					</table>
					<style>
						table.leftCls td {
							text-align: left;
						}
					</style>
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
			var p = data[i];
			var lv = p.lv;
			if(!p.addr){continue;
}
	#>
	<tr>
		<td >
			<#for(var v=lv-1;v--;){#>|<span style="display:inline-block;text-indent:1em">&nbsp;</span><#}#><#=p.addr#>
		</td>
		<td style="text-indent:<#=p.lv*2#>em"><#=p.detail#></td>
		<td><a href="${pageContext.request.contextPath}/page/system/editPermission.jsp?id=<#=p.id#>">编辑</a> <!--| <a href="javascript:void(0)" onclick="removePermission(<#=p.id#>)">删除</a>--></td>
	</tr>
	<#}#>
</script>
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

//初始化模版引擎
var tmplOpts = {varName:'data', compiler:'rapid'};
fn.template.setting(tmplOpts);
	$.get("${pageContext.request.contextPath}/getPermissions.do",{r:Math.random()},function(rs){
		//gen tree struct
		//lv1
		var lv1=[],lv1Ids=[],lv1Map={},lv2Ids=[],lv2Map={},lv3Ids=[];
		for(var i=rs.length;i--;){
			var p = rs[i];
			if(lv1Ids.indexOf(p.id1)<0){
				lv1Ids.push(p.id1);
				lv1.push({id:p.id1,pid:p.pid1,addr:p.addr1,detail:p.detail1,lv:1});
			}
			if(p.id2 && lv2Ids.indexOf(p.id2)<0){
				if(!lv1Map[p.id1]){
					lv1Map[p.id1] = [];
				}
				lv2Ids.push(p.id2);
				lv1Map[p.id1].push({id:p.id2,pid:p.pid2,addr:p.addr2,detail:p.detail2,lv:2});
			}
			if(p.id3 && lv3Ids.indexOf(p.id3)<0){
				if(!lv2Map[p.id2]){
					lv2Map[p.id2] = [];
				}
				lv3Ids.push(p.id3);
				lv2Map[p.id2].push({id:p.id3,pid:p.pid3,addr:p.addr3,detail:p.detail3,lv:3});
			}
		}
		
		var d = [];
		for(var i = 0,l = lv1.length; i < l; i++){
			var id = lv1[i].id;
			var map = lv1Map[id];
			d.push(lv1[i]);
			for(var k in map){
				d.push(map[k]);
				for(var k2 in lv2Map[map[k].id]){
					d.push(lv2Map[map[k].id][k2]);
				}
			}
		}
		
		html = fn.template($('#rechargeTmpl').html())(d);
		$('#memberInfos').html(html);
	},'json');
	
	
	function removePermission(id){
		if(confirm('是否要删除该权限？')){
			$.post('${pageContext.request.contextPath}/removePermission.do',{'permissionVO.id':id},function(){
				alert('删除成功');
				location.reload();
			});
		}
	}
</script>
</html>
