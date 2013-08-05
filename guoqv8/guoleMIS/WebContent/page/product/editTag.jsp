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
<title>编辑标签信息</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
</head>
<body>
	<!-- Header -->
    <jsp:include page="../../menu.jsp">
		<jsp:param value="tagManager" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>标签管理 → <span>编辑标签信息</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<!--添加标签-->
				<fieldset class="SearchBox">
				  <form id="editForm" method="post" action="/addTag.do">
				    <input type="hidden" id="id" class="WidD" name="tagVO.id" value="${requestScope.tagVO.id}">
					<legend>标签管理</legend>
					<table class="table" width="50%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="CA">标签名称:</td>
							<td><input type="text" id="name" class="WidD" name="tagVO.name" value="${requestScope.tagVO.name}"><font color="red"><span id="nameError"></span></font></td>
						</tr>
						<tr>
							<td class="CA">标签描述:</td>
							<td>
							   <textarea name="tagVO.remark" id="remark" class="Select" cols="60" rows="10" value="${requestScope.tagVO.remark}">${requestScope.tagVO.remark}</textarea>
							</td>
						</tr>
						<tr>
						    <td class="CA">&nbsp;</td>
							<td align="left">
							  <c:forEach var="item" items="${sessionScope.current_user_info.permission}">   
								<c:if test="${item.addr eq 'editTag.do'}">     
									 <input type="button" class="btn btn-green big" onclick="save();" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
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
    //保存标签信息
	function save(){
    	var name = $('#name');
    	if(name.val() == null || name.val() == ''){
    		$('#nameError').html("标签名称不能为空!");
    		name.focus();
    		return;
    	}else{
    		$('#nameError').html('');
    	}
		var act = "添加";
		var url = "${pageContext.request.contextPath}/addTag.do";
		if($('#id').val() != null && $('#id').val() != ''){
			url = "${pageContext.request.contextPath}/modifyTag.do";
			act = "更新";
		}
		 $.ajax( {
			  type: "post",
			  url: url,
			  data: $('#editForm').serialize(),
			  async : true,
			  success:function callback(data){
			      if (data == "ERROR"){      
			    	  alert("标签"+act+"失败,请稍后再试!");
			      }else if(data == "EXISTS"){
			    	  $('#nameError').html("标签名称已存在,请重新输入");
			    	  name.focus();
			      }else{
			    	  alert("标签"+act+"成功!"); 
			    	  opener.qurTags();
			    	  window.close();
			      }
			  }
		 });
	}
</script>