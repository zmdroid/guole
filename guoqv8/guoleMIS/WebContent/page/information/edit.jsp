<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    
    <title>资讯编辑页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
	<script type="text/javascript" charset="utf-8" src="uedit2.3/editor_config.js"></script>
    <script type="text/javascript" charset="utf-8" src="uedit2.3/editor_all.js"></script>
    <link rel="stylesheet" type="text/css" href="uedit2.3/themes/default/ueditor.css"/>
    <style type="text/css">
        .clear {
            clear: both;
        }
    </style>
</head>
<body>
    <!-- Header -->
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				资讯编辑
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
						<td class="CGray" width="80">标题<input type="hidden" id="infoNo"/></td>
						<td>
							<input class="IEnter WMaxS Input" maxlength="50" style="width:300px" type="text" name="iTitle" id="iTitle">
						</td>
					  </tr>
					  <tr>
						<td class="CGray">来源</td>
						<td>
								<input class="IEnter WMaxS Input" type="text" name="iSource" id="iSource">
						</td>
					  </tr>
					  <tr id="Infoimg">
						<td class="CGray">资讯主图</td>
						<td>
							<form id="picForm" action="${pageContext.request.contextPath}/uploadInfoPic.do" method="post">
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
						<td class="CGray">内容(*图片最大宽度690)</td>
						<td class="VT">
						  <script type="text/plain" id="editor" style="width:708px;"></script>
						</td>
					  </tr>
				</table>
			</div>
		</div>
		<center>
			<td class="CGray" colspan="2"><a href="javascript:void(0)" onclick="addRecord()" class="btn  btn-blue">确定</a></td>
			<br/><br/>
		</center>
	</div>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="text/javascript">
var type = 1 ;
var ue = new UE.ui.Editor( {} );
ue.render( 'editor' );

var _picHtml = '<img src="${imgUrl}<%=Config.getInstance().get("resTmp")%>/#pic" width="120" height="90"/>';
// 上传资讯主图片
function uploadInfoPic() {
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
	uploadInfoPic();
});

function addRecord(){
	var title = $('#iTitle').val();
	if(!title){
		alert('标题不能为空');
		return;
	}
	var content = ue.getContent();
	if(!content){
		alert('内容不能为空');
		return;
	}
	var source = $('#iSource').val();
	if(!source){
		alert('来源不能为空');
		return;
	}
	var img,pic,src;
	if(type==1){
		var picList = $("#picList img");
		if (!picList || picList.length == 0) {
			alert("请上传资讯主图片");
			return;
		}
		img = picList[0];
		src = img.src;
		pic = src.substring(src.lastIndexOf("/") + 1, src.length);
	}
	
	var no = $('#infoNo').val();
	if(!no)no = 0;
	$.post('saveUpdateInfo.do',{"informationVO.title":title,"informationVO.content":content,"informationVO.source":source,"informationVO.picUrl":pic,"informationVO.id":no,"informationVO.type":parseInt(type)},function(rs){
		if(rs="success"){
			alert("操作成功");
				if(type==1){
					location.href='${pageContext.request.contextPath}/page/information/informationlist.jsp';
				}else{
					location.href='${pageContext.request.contextPath}/page/annou/announcement.jsp';
				}
		}else{
			alert("操作失败，请稍后再试");
		}
	});
}

var picHtml = '<img src="${imgUrl}<%=Config.getInstance().get("infoUrl")%>/#pic" width="120" height="90"/>';
$(document).ready(function(){
	<%-- 加载数据 --%>
	type = ${param.type}+""||1;
	if(parseInt(type)==2){
		$("#Infoimg").hide();
	}
	var no = ${param.infoNo}+""||0;
	if(no>0){
		$.getJSON('getInformationById.do',{infoNo:no},function(rs){
			$("#iTitle").val(rs[0].title);
			$("#iSource").val(rs[0].source);
			ue.ready(function(){
			    //需要ready后执行，否则可能报错
				ue.setContent(rs[0].content);
			})
			$("#picList").prepend(picHtml.replace("#pic", rs[0].picUrl));
			$('#infoNo').val(rs[0].id);
		});
	}
});

</script>
</body>
</html>
