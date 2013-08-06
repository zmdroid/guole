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
    
    <title>礼品卡编辑页</title>
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
				礼品卡编辑
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
						<td class="CGray" width="80">卡类型</td>
						<td>
							<select id="giftType">
							</select>
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">编号</td>
						<td>
							<input class="IEnter WMaxS Input" type="hidden" name="giftCardId" id="giftCardId">
							<input class="IEnter WMaxS Input" type="text" name="cardNum" id="cardNum">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">密码</td>
						<td>
								<input class="IEnter WMaxS Input" type="text" name="pwd" id="pwd">
						</td>
					  </tr>
					  <tr>
						<td class="CGray" width="80">描述</td>
						<td>
							<input class="IEnter WMaxS Input" type="text" name="remark" id="remark">
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


function addGiftCard(){
	var cardNum = $('#cardNum').val();
	if(!cardNum){
		alert("礼品卡的编号不能为空");
		return;
	}
	var pwd = $('#pwd').val();
	if(!pwd){
		alert("密码不能为空");
		return;
	}
	var remark = $('#remark').val();
	if(!remark){
		alert("描述不能为空");
		return;
	}
	var giftType = $('#giftType').val();
	if(!giftType){
		alert("选择礼品卡的类型");
		return;
	}
	var no = $('#giftCardId').val();
	
	if(!no)no = 0;
	$.post('${pageContext.request.contextPath}/saveUpdateGiftCard.do',{"giftCardVO.cardType":giftType,"giftCardVO.cardNum":cardNum,"giftCardVO.pwd":pwd,"giftCardVO.remark":remark,"advertVO.id":no},function(rs){
		if(rs=="success"){
				location.href='${pageContext.request.contextPath}/page/card/giftcardlist.jsp';
				alert("保存成功");
		}else{
				alert("操作失败，请稍后在试...");
		}
	});
}

function loadGiftType(){
	<%-- 加载数据 --%>
		$.getJSON('${pageContext.request.contextPath}/getGiftCardTypes.do',{pageIndex:1},function(rs){
			var type = rs[2];
			typeSelect = $("#giftType");
			for(var i=0,l=type.length;i<l;i++){
				var temp = type[i];
				var html = '<option value='+temp.id+'>'+temp.name+'</option>';				
				typeSelect.append(html);
			}
		});
	
}
loadGiftType();

</script>
</body>
</html>
