<%@ page language="java" import="java.util.*,com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Config conf = Config.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>会员详细信息</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
	<jsp:include page="../../menu.jsp"></jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
		<!--<div class="wrapper">
			<input type="button" class="btn btn-green big" onclick="transit(${requestScope.memberInfoVO.userId});" value="通过">&nbsp;
			<input type="button" class="btn btn-green big" onclick="refuse(${requestScope.memberInfoVO.userId});" value="拒绝">&nbsp;
			<input type="button" class="btn btn-green big" onclick="freeze(${requestScope.memberInfoVO.userId});" value="冻结">&nbsp;
		</div>-->
	<!-- End of Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>会员信息管理 → <span>审核签约会员信息</span></h1>
		</div>
	</div>
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--基本信息-->
				<div class="rightmenu">
					<h3 class="title">基本信息</h3>
					<table class="table" width="70%" border="0" cellspacing="0" cellpadding="0">
						<tr>
						    <td width="10%" class="CA">会员姓名:</td>
							<td width="20%">${requestScope.memberInfoVO.name}</td>
							<td width="10%" class="CA">会员帐号:</td>
							<td width="20%">
								 ${requestScope.memberInfoVO.userAccount}
                            </td>		
							<td width="10%" class="CA">性别:</td>
							<td width="20%">
							     <c:choose>
								  <c:when test="${requestScope.memberInfoVO.sex == 'm'}">
									 男
								  </c:when>
								  <c:when test="${requestScope.memberInfoVO.sex == 'f'}">
									 女
								  </c:when>
								  <c:otherwise> 
								            未知
								  </c:otherwise>
							     </c:choose>
                            </td>
						</tr>
						<tr>
						    <td width="10%" class="CA">QQ:</td>
							<td width="20%">${requestScope.memberInfoVO.qq}</td>
							<td width="10%" class="CA">QQ绑定:</td>
							<td width="20%">
							    <c:choose>
									  <c:when test="${requestScope.memberInfoVO.ifBind == 0}">
										 未绑定
									  </c:when>
									  <c:when test="${requestScope.memberInfoVO.ifBind == 1}">
									            已绑定
									  </c:when>
							     </c:choose>
							</td>
							<td width="10%" class="CA">邮箱:</td>
							<td width="20%">${requestScope.memberInfoVO.email}</td>
						</tr>
						<tr>
						    <td width="10%" class="CA">手机:</td>
							<td width="20%">${requestScope.memberInfoVO.mobile}</td>
							<td width="10%" class="CA">会员类型:</td>
							<td width="20%">
								 <c:choose>
								  <c:when test="${requestScope.memberInfoVO.usertype == '1'}">
									 买家
								  </c:when>
								  <c:otherwise> 
								            卖家
								  </c:otherwise>
							     </c:choose>
                            </td>
						    <td width="10%" class="CA">会员状态:</td>
							<td width="20%">
								<c:choose>
								  <c:when test="${requestScope.memberInfoVO.state == '1'}">
									 待审核
								  </c:when>
								  <c:when test="${requestScope.memberInfoVO.state == '2'}">
									 审核通过
								  </c:when>
								   <c:when test="${requestScope.memberInfoVO.state == '3'}">
									 审核拒绝
								  </c:when>
								  <c:otherwise> 
								            冻结
								  </c:otherwise>
							     </c:choose>
							</td>	
						</tr>
					</table>
				</div>
				<!--基本信息 end-->
				<!--公司信息-->
				<div class="rightmenu">
					<h3 class="title">公司信息</h3>
					<table class="table" width="70%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="10%" class="CA">公司名称:</td>
							<td width="20%">${requestScope.memberInfoVO.corname}</td>
							<td width="10%" class="CA">员工数量:</td>
							<td width="20%">${requestScope.memberInfoVO.staffnum}</td>
							<td width="10%" class="CA">所在区县:</td>
							<td width="20%">${requestScope.memberInfoVO.province}${requestScope.memberInfoVO.city}${requestScope.memberInfoVO.district}</td>
						</tr>
						<tr>
						    <td width="10%" class="CA">公司地址:</td>
							<td width="20%">${requestScope.memberInfoVO.coraddr}</td>
						    <td width="10%" class="CA">公司电话:</td>
							<td width="20%">${requestScope.memberInfoVO.officephone}</td>
						    <td width="10%" class="CA">公司传真:</td>
							<td width="20%">${requestScope.memberInfoVO.officefax}</td>
						</tr>
						<c:if test="${requestScope.memberInfoVO.usertype == '2'}">
							<tr>
							    <td width="10%" class="CA">品牌名称:</td>
								<td width="20%">${requestScope.memberInfoVO.brands}</td>
								<td width="10%" class="CA">业务类型:</td>
								<td width="20%">${requestScope.memberInfoVO.busiType}</td>
							    <td width="10%" class="CA">线路类型:</td>
								<td width="20%">${requestScope.memberInfoVO.lineType}</td>
							</tr>
						</c:if>
						<tr>
						    <td width="10%" class="CA">所属部门:</td>
							<td width="20%">${requestScope.memberInfoVO.dep}</td>
						    <td width="10%" class="CA">担任职务:</td>
							<td width="20%">${requestScope.memberInfoVO.position}</td>
						</tr>
					</table>
				</div>
				<!--公司信息 end-->
				<!--账户启用信息-->
				<div class="rightmenu">
					<h3 class="title">账户启用信息</h3>
					<table class="table" width="70%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							    <td width="10%" class="CA">启用时间:</td>
								<td width="20%"><input type="text" name="enableTime" disabled id="enableTime" value="${requestScope.memberInfoVO.enableTime}"></td>
								<td width="10%" class="CA">截止时间:</td>
								<td width="20%"><input type="text" name="cutoffTime" readonly="readonly" onClick="WdatePicker()" id="cutoffTime" value="${requestScope.memberInfoVO.cutoffTime}"></td>
							    <td width="10%" class="CA">&nbsp;</td>
							    <td width="20%">&nbsp;</td>
							</tr>
					</table>
				</div>
				<!--账户启用信息 end-->
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
		<center>
		    <a href="javascript:aduitAndModCutoffTime();" id="aduitBtn" class="btn  btn-blue">确 定</a>&nbsp;&nbsp;
			<a href="javascript:closeWin();" id="searchBtn" class="btn  btn-blue">取 消</a>
			<br/><br/>
		</center>
	</div>
	<!-- End of Page content -->
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<link href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
 $('#cutoffTime').focus();
 function daysBetween(DateOne,DateTwo) {  
     var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-')); 
     var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1); 
     var OneYear = DateOne.substring(0,DateOne.indexOf ('-')); 
     var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-')); 
     var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1); 
     var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-')); 
     var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
     return cha; 
 }

 //审核并修改签约用户的账户有效期
 function aduitAndModCutoffTime(){
	 var cutoffTime = $('#cutoffTime');
	 if(cutoffTime.val().length == 0){
		 alert("帐号有效截止日期不能为空!");
		 cutoffTime.focus();
		 return;
	 }else if(daysBetween($('#enableTime').val(),cutoffTime.val()) > 0){
		 alert("帐号有效截止日期不能等于或早于启用日期!");
		 cutoffTime.focus();
		 return;
	 }
	 if(window.confirm("审核并修改帐号有效截止日期,确认吗?")){
	     $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/aduitAndModCutoffTime.do",
			  data: "memberInfoVO.userId=${requestScope.memberInfoVO.userId}&memberInfoVO.cutoffTime="+cutoffTime.val(),
			  async : true,
			  success:function callbackFunc(data){
			      if (data == "ERROR"){      
			    	  alert('签约用户审核失败,请稍后再试!');
			      }else{
			    	  alert("签约用户审核成功!"); 
			    	  opener.qurMembers();
			    	  window.close();
			      }
			  }
		 });
	 }
 }
</script>