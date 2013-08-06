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
    
    <title>礼品卡类型编辑页</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
    <!-- Header -->
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>
				礼品卡类型编辑
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
						<td class="CGray" width="80">名称<input type="hidden" id="giftCardTypeId"/></td>
						<td>
								<input class="IEnter WMaxS Input"  type="text" name="title" id="gName">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">描述</td>
						<td>
								<input class="IEnter WMaxS Input" type="text" name="desc" id="gRemark">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">礼品卡主图</td>
						<td>
							<form id="picForm" action="${pageContext.request.contextPath}/uploadGiftCardTypePic.do" method="post">
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
						<td class="CGray" width="80">金额</td>
						<td>
							<input class="IEnter WMaxS Input" type="text" maxlength="5" name="gMoney" id="gMoney">
						</td>
					  </tr>
				</table>
			</div>
		</div>
		<center>
			<td class="CGray" colspan="2"><a href="javascript:void(0)" onclick="addGiftCard()" class="btn  btn-blue">确定</a></td>
			<br/><br/>
		</center>
	</div>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="text/javascript">

var _picHtml = '<img src="${imgUrl}<%=Config.getInstance().get("resTmp")%>/#pic" width="120" height="90"/>';
// 上传资讯主图片
function uploadGiftPic() {
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
	uploadGiftPic();
});

function addGiftCard(){
	var gName = $('#gName').val();
	if (!gName) {
		alert("请填写礼品卡类型名称");
		return;
	}
	var gRemark = $('#gRemark').val();
	if (!gRemark) {
		alert("请填写礼品卡类型描述");
		return;
	}
	var gMoney = $('#gMoney').val();
	if (!gMoney) {
		alert("请填写金额");
		return;
	}
	if(isNaN(gMoney)){
		alert("请填写正确的金额");
		return;
	}
	
	var picList = $("#picList img");
	if (!picList || picList.length == 0) {
		alert("请上传礼品卡主图片");
		return;
	}
	var img,pic,src;
	img = picList[0];
	src = img.src;
	pic = src.substring(src.lastIndexOf("/") + 1, src.length);
	
	var no = $('#giftCardTypeId').val();
	if(!no)no = 0;
	$.post('${pageContext.request.contextPath}/saveUpdateGiftCardType.do',{"giftCardTypeVO.name":gName,"giftCardTypeVO.money":gMoney,"giftCardTypeVO.remark":gRemark,"giftCardTypeVO.img":pic,"giftCardTypeVO.id":no},function(rs){
		if(rs=="success"){
				location.href='${pageContext.request.contextPath}/page/card/giftcardtypelist.jsp';
				alert("保存成功");
		}else{
				alert("操作失败，请稍后在试...");
		}
	});
}

var picHtml = '<img src="${imgUrl}<%=(String)conf.getString("giftDir")%>#pic" width="120" height="90"/>';
$(document).ready(function(){
	<%-- 加载数据 --%>
	var no = ${param.giftCardTypeId}+""||0;
	if(no>0){
		$.getJSON('${pageContext.request.contextPath}/getGiftCardTypeById.do',{giftTypeId:no},function(rs){
			$("#gName").val(rs[0].name);
			$("#gRemark").val(rs[0].remark);
			$("#picList").prepend(picHtml.replace("#pic", rs[0].img));
			$('#gMoney').val(rs[0].money);
			$('#giftCardTypeId').val(rs[0].id);
		});
	}
});

</script>
</body>
</html>
