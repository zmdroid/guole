<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    
    <title>会员卡编辑页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
    <!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="cardManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				会员卡编辑
			</h1>
		</div>
	</div>
	<!-- End of Page title -->
		<!-- Page content -->
	<div id="page">
	
		<!-- Wrapper -->
		<div class="wrapper">	
			<div class="rightmenu">
				<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="CGray" width="80">标题<input type="hidden" id="advertId"/></td>
						<td>
								<input class="IEnter WMaxS Input"  type="text" name="title" id="aTitle">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">描述</td>
						<td>
								<input class="IEnter WMaxS Input" type="text" name="desc" id="aDesc">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">广告主图</td>
						<td>
							<form id="picForm" action="${pageContext.request.contextPath}/uploadAdvertPic.do" method="post">
							<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
										<td class="CA"></td>
										<td><input type="file" name="imageFile" id="imageFile"/>
										</td>
									</tr>
									<tr>
										<td class="CA"></td>
										<td>
											<div class="PostPic" id="picList">												
											</div>
										</td>
									</tr>							
							</table>
							</form>
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">链接</td>
						<td>
							<input class="IEnter WMaxS Input" type="text" name="iSource" id="aPicUrl">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">广告位置</td>
						<td>
							<select name="recruit.province" id="pages">
								<option value="0">===请选择展示页面===</option>
								<option value="1">首页</option>
								<option value="2">今日特价</option>
								<option value="3">首页中部</option>
							</select>
						</td>
					  </tr>
				</table>
			</div>
		</div>
		<center>
			<td class="CGray" colspan="2"><a href="javascript:void(0)" onclick="addAdvert()" class="btn  btn-blue">确定</a></td>
			<br/><br/>
		</center>
	</div>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="text/javascript">

var _picHtml = '<img src="${imgUrl}<%=Config.getInstance().get("resTmp")%>/#pic" width="120" height="90"/>';
// 上传资讯主图片
function uploadAdvertPic() {
	var picList = $("#picList");
	$("#picForm").ajaxSubmit({
		success:function(rs){
			if ("error" == rs) {
				alert("上传服务器出错");
			}else{
				picList.html(_picHtml.replace("#pic", rs));
			}
		},
		error: function(){
			alert("服务器断访问出错");
		}
	});
}

$("#imageFile").change(function(){
	uploadAdvertPic();
});

function addAdvert(){
	var title = $('#aTitle').val();
	var desc = $('#aDesc').val();
	var pages = $('#pages').val();
	if(pages<=0){
		alert("请选择广告展示位置");
		return;		
	}
	var linkUrl = $('#aPicUrl').val();
	if (!linkUrl) {
		alert("请填写广告URL");
		return;
	}
	
	var picList = $("#picList img");
	if (!picList || picList.length == 0) {
		alert("请上传资讯主图片");
		return;
	}
	var img,pic,src;
	img = picList[0];
	src = img.src;
	pic = src.substring(src.lastIndexOf("/") + 1, src.length);
	
	var no = $('#advertId').val();
	if(!no)no = 0;
	$.post('saveUpdateAdvert.do',{"advertVO.adTitle":title,"advertVO.pages":pages,"advertVO.adRemark":desc,"advertVO.linkUrl":linkUrl,"advertVO.adPic":pic,"advertVO.id":no},function(rs){
		if(rs=="success"){
				location.href='${pageContext.request.contextPath}/page/advert/advertlist.jsp';
				alert("保存成功");
		}else{
				alert("操作失败，请稍后在试...");
		}
	});
}

var picHtml = '<img src="${imgUrl}<%=(String)conf.getString("advertImageDir")%>/#pic" width="120" height="90"/>';
$(document).ready(function(){
	<%-- 加载数据 --%>
	var no = ${param.advertId}+""||0;
	if(no>0){
		$.getJSON('getAdvertById.do',{advertId:no},function(rs){
			$("#aTitle").val(rs[0].adTitle);
			$("#aDesc").val(rs[0].adRemark);
			$("#picList").prepend(picHtml.replace("#pic", rs[0].adPic));
			$('#aPicUrl').val(rs[0].linkUrl);
			$('#pages').val(rs[0].pages);
			$('#advertId').val(rs[0].id);
		});
	}
});

</script>
</body>
</html>
