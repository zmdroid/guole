<%@ page language="java" import="com.guoleMIS.util.Config" pageEncoding="UTF-8"%>
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
<title>发布消息</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="notifyManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>消息管理 → <span>发布信息</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<fieldset class="SearchBox">
				  <form id="editForm" method="post" action="/addTag.do">
				    <input type="hidden" id="id" class="WidD" name="tagVO.id" value="${requestScope.tagVO.id}">
					<legend>发布信息</legend>
					<table class="table" width="50%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">消息内容:</td>
							<td>
							   <textarea name="content" id="content" class="Select" cols="70" rows="8" maxlength="1000"></textarea>
							   <font color="red"><span id="contentError"></span></font>
							</td>
						</tr>
						<tr>
							<td class="CA">接收人:</td>
							<td><input type="hidden" name="receivers" id="receivers">
							  <textarea name="receiverNames" id="receiverNames" disabled class="Select" cols="70" rows="8" maxlength="1000"></textarea>
							  <a href="javascript:selMember();">添加接收人</a>
							  &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:$('#receivers').val('');$('#receiverNames').val('');void(0);">清除接收人</a>
							  <font color="red"><span id="receiversError"></span></font>
							</td>
						</tr>
						<tr>
						    <td class="CA">&nbsp;</td>
							<td align="left">
							  <c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
								<c:if test="${item.addr eq 'publishNotify.do'}">     
									<input type="button" class="btn btn-green big" onclick="save();" value="发布">&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if> 
							  </c:forEach> 
							  <input type="button" class="btn btn-green big" onclick="window.close();" value="取消">
							</td>
						</tr>
					</table>
				  </form>
				</fieldset>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
</body>
</html>
<script type="text/javascript">
	function selMember(){
		window.open('${pageContext.request.contextPath}/page/member/selMember.jsp');
	}
    //保存消息信息
	function save(){
    	var content = $('#content');
    	if(content.val() == null || content.val() == ''){
    		$('#contentError').html("消息内容不能为空!");
    		content.focus();
    		return;
    	}else{
    		$('#contentError').html('');
    	}
    	var receivers = $('#receivers');
    	if(receivers.val() == null || receivers.val() == ''){
    		$('#receiversError').html("消息接收人不能为空!");
    		receivers.focus();
    		return;
    	}else{
    		$('#receiversError').html('');
    	}
		$.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/publishNotify.do",
			  data: "content="+content.val()+"&receivers="+receivers.val(),
			  async : true,
			  success:function callback(data){
			      if (data == "ERROR"){      
			    	  alert("消息发送失败,请稍后再试!");
			      }else{
			    	  alert("消息发送成功!"); 
			    	  opener.qurNotifys();
			    	  window.close();
			      }
			  }
		 });
	}
</script>