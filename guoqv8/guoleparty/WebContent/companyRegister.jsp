<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <title>供应商注册</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
</head>
<body>
<!--Header-->
<!--Header end--> 


<!--PageBody-->
<div id="PageBody">
	<!--注册-->
	<form id="registerForm" name="registerForm" action="register.do" method="POST">
	    <input type="hidden" name="userInfoVO.usertype" id="usertype" value="2"/>
				<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 用户名</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" name="userInfoVO.userAccount" id="userAccount" maxLength="60"/>
							<label class="IExplain">输入用户名</label>
						</span>
						&nbsp;&nbsp;<font color="red"><span id="userAccountError"></span></font>
					</td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 密码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="password" id="pwd" name="userInfoVO.pwd"  maxLength="32"/>
							<label class="IExplain">输入登录密码</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="pwdError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 确认密码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="password" id="pwd2" maxLength="32"/>
							<label class="IExplain">重复登录密码</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="pwd2Error"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 注册人姓名</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="name" name="userInfoVO.name" maxLength="20"/>
							<label class="IExplain">输入注册人姓名</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="nameError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 公司全称</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMaxS IN" type="text" id="corname" name="userInfoVO.corname" maxLength="60"/>
							<label class="IExplain">输入公司名称全称</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="cornameError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 电话</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="officephone" name="userInfoVO.officephone" maxLength="18"/>
							<label class="IExplain">电话号码</label>
						</span>
						<span>&nbsp;示例：029-88888888</span>
					    &nbsp;&nbsp;<font color="red"><span id="officephoneError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 传真</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="officefax" name="userInfoVO.officefax" maxLength="18"/>
							<label class="IExplain">输入传真号码</label>
						</span>
						<span>&nbsp;示例：029-88888888</span>
					    &nbsp;&nbsp;<font color="red"><span id="officefaxError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> 手机</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="mobile" name="userInfoVO.mobile" maxLength="15"/>
							<label class="IExplain">输入手机号码</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="mobileError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> Email</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text" id="email" name="userInfoVO.email" maxLength="60"/>
							<label class="IExplain">输入联系邮箱</label>
						</span>
					    &nbsp;&nbsp;<font color="red"><span id="emailError"></span></font></td>
				  </tr>
				  <tr>
					<td class="CA TTi"><span class="CD">*</span> QQ号码</td>
					<td>
						<span class="IBoxTip">
							<input class="IEnter WMids IN" type="text"  name="userInfoVO.qq" id="qq" maxlength="15"/>
							<label class="IExplain">输入QQ号码</label>
						</span>
						&nbsp;&nbsp;<font color="red"><span id="qqError"></span></font>
					</td>
				  </tr>
				  <tr>
					<td class="CA TTi"></td>
					<td><input type="checkbox" name="protocol" id="protocol" class="VMid" onclick="agreeProtocol(this);"/> <a href="javascript:void(0);">阅读并同意《网络服务使用协议》</a></td>
				  </tr>
				  <tr>
					<td class="CA TTi"></td>
					<td><a href="javascript:register();void(0);" id="regBtn" class="RegBut RegAgree RegAgreeN">同意并注册</a> <a href="javascript:resetForm();" class="RegBut RegReFill">重填</a></td>
				  </tr>
				</table>
	</form>
	<!--注册 end-->
</div>
<!--PageBody end-->
<div id="Fill-S" class="FillChoose DisNo">	
	<div class="FillCheck">
		<img class="FillCloseImg" src="${pageContext.request.contextPath}/Images/Icon/Close.gif"/>
		<div class="FillTitle">选择产品类型(最多选5个)</div>
		<div class="FillCon SpeCityM" id="lineProduct">
	
		</div>
	</div>
</div>
<!--Footer-->
<!--Footer end-->
</body>
</html>
<%@include file="/js.jsp" %>
<script type="text/javascript" charset="utf-8">
	$("#ArrivalCity").AutoFill(true,5,"#Fill-S");
	$.get('${pageContext.request.contextPath}/getAllProductTypes.do?t=' + new Date().getTime(),null,function(data){
		var pTypes = {};
		for (var i = 0; i < data.length; i++) {
			productType = data[i];
			pTypes[productType.pType] = 1;
		}
		
		var html = "";
		for (var pType in pTypes) {
			html += "<dl><dt>"+ pType +"</dt><dd>";
			for (var i = 0; i < data.length; i++) {
				productType = data[i];
				if (pType == productType.pType) {
					html += "<a href='javascript:;' class='FillClick'>" + productType.typeName + "</a>";	
				}
			}
			html += "</dd></dl><dl>";
		}

		$("#lineProduct").html(html);
	},'json');
    function resetForm(){
    	window.location.reload();
    }
    function agreeProtocol(chk){
  	  if(chk.checked) {
  		  $('#regBtn').removeClass("RegAgreeN");
	  }else{
		  $('#regBtn').addClass("RegAgreeN");
	  }
    }
    $('#staffnum').bind("keypress", function(event) {
    	//控制只能输入的值
    	if (event.which && (event.which < 48 || event.which > 57) && event.which != 8 ) {
	    	event.preventDefault();
	    	return;
    	}
    });
    function checkNumber(value){    
    	//定义正则表达式部分    
    	var reg = /^\d+$/;    
    	if( value.constructor === String ){        
    		var re = value.match( reg );        
    		return re;    
    	}    
    	return false;
    }
    $(document).keydown(function(event){
		if(event.keyCode==13){
			register(); 
		}
    });
	var canClick = true;
    //注册
    function register(){
    	  if(!canClick)return;
    	  if(!$('#protocol').is(":checked")){
    		  $(this).Point('PointC','请选择阅读并同意《网络服务使用协议》!');
    		  return;
    	  }
		  canClick = false;
    	  //用户名
		  var userAccount = $('#userAccount');
		  if($.trim(userAccount.val()).length == 0){
			  $('#userAccountError').html("用户名不能为空!");
			  setFocus(userAccount);
			  canClick = true;
			  return;
		  }else{
			  $('#userAccountError').html('');
		  }
		  //密码
		  var pwd = $('#pwd');
		  if($.trim(pwd.val()).length == 0){
			  $('#pwdError').html("密码不能为空!");
			  setFocus(pwd);
			  canClick = true;
			  return;
		  }else{
			  $('#pwdError').hide();
		  }
		  //确认密码
		  var pwd2 = $('#pwd2');
		  if($.trim(pwd2.val()).length == 0){
			  $('#pwd2Error').html("确认密码不能为空!");
			  setFocus(pwd2);
			  canClick = true;
			  return;
		  }else{
			  $('#pwd2Error').html('');
		  }
		  if($.trim(pwd.val()) != $.trim(pwd2.val())){
			  $('#pwd2Error').html("两次输入的密码不一致!");
			  setFocus(pwd2);
			  canClick = true;
			  return;
		  }else{
			  $('#pwd2Error').html('');
		  }
		  //姓名
		  var name = $('#name');
		  if($.trim(name.val()).length == 0){
			  $('#nameError').html("注册人姓名不能为空!");
			  setFocus(name);
			  canClick = true;
			  return;
		  }else{
			  $('#nicknameError').html('');
		  }
		  //公司名称
		  var corname = $('#corname');
		  if($.trim(corname.val()).length == 0){
			  $('#cornameError').html("公司名称不能为空!");
			  setFocus(corname);
			  canClick = true;
			  return;
		  }else{
			  $('#cornameError').html('');
		  }
		  //品牌名称
		  var brands = $('#brands');
		  if($.trim(brands.val()).length == 0){
			  $('#brandsError').html("品牌名称不能为空!");
			  setFocus(brands);
			  canClick = true;
			  return;
		  }else{
			  $('#brandsError').html('');
		  }
		  //业务类型
		  var busiTypeCheck = false;
		  $('#busiType input:checkbox').each(function(index){
			  if($(this).is(":checked")){
				  busiTypeCheck = true;
			  }
		  });
		  if(!busiTypeCheck){
			  $('#busiTypeError').html("业务类型不能为空!");
			  canClick = true;
			  return;
		  }else{
			  $('#busiTypeError').html('');
		  }
		  //线路类型
		  var lineTypeCheck = false;
		  $('#lineType input:checkbox').each(function(index){
			  if($(this).is(":checked")){
			    lineTypeCheck = true;
			  }
		  });
		  if(!lineTypeCheck){
			  $('#lineTypeError').html("线路类型不能为空!");
			  canClick = true;
			  return;
		  }else{
			  $('#lineTypeError').html('');
		  }
		  //员工数量
		  var staffnum = $('#staffnum');
		  if($.trim(staffnum.val()).length > 0){
			  if(!checkNumber(staffnum.val())){
				  $('#staffnumError').html("员工数量只能输入数字!");
				  setFocus(staffnum);
				  canClick = true;
				  return;
			  }else{
				  $('#staffnumError').html('');
			  }
		  }
		  //产品类型
		  var productTypes = $('#productTypes');
		  if($.trim(productTypes.val()).length == 0){
			  $('#productTypesError').html("产品类型不能为空!");
			  setFocus(productTypes);
			  canClick = true;
			  return;
		  }else{
			  $('#productTypesError').html('');
		  }
		  //电话
		  var officephone = $('#officephone');
		  if($.trim(officephone.val()).length == 0){
			  $('#officephoneError').html("电话不能为空!");
			  setFocus(officephone);
			  canClick = true;
			  return;
		  }else{
			  var pattern=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
			  if(!pattern.exec($.trim(officephone.val()))) { 
			    $('#officephoneError').html('电话号码有误，请重新输入!');
			    setFocus(officephone);
				canClick = true;
				return;
			  } else{
			    $('#officephoneError').html('');
			  }
		  }
		  //传真
		  var officefax = $('#officefax');
		  if($.trim(officefax.val()).length == 0){
			  $('#officefaxError').html("传真不能为空!");
			  setFocus(officefax);
			  canClick = true;
			  return;
		  }else{
			  var pattern=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
			  if(!pattern.exec($.trim(officefax.val()))) { 
			    $('#officefaxError').html('传真号码有误，请重新输入!');
			    setFocus(officefax);
				canClick = true;
				return;
			  } else{
			    $('#officefaxError').html('');
			  }
		  }
		  //手机
		  var mobile = $('#mobile');
		  if($.trim(mobile.val()).length == 0){
			  $('#mobileError').html("手机号码不能为空!");
			  setFocus(mobile);
			  canClick = true;
			  return;
		  }else{
			  var pattern=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
			  if(!pattern.exec($.trim(mobile.val())) || $.trim(mobile.val()).length > 11) { 
			    $('#mobileError').html('手机号码输入有误，请输入!');
			    setFocus(mobile);
				canClick = true;
				return;
			  } else{
			    $('#mobileError').html('');
			  }
		  }
		  //邮箱
		  var email = $('#email');
		  if($.trim(email.val()).length == 0){
			  $('#emailError').html("联系邮箱不能为空!");
			  setFocus(email);
			  canClick = true;
			  return;
		  }else{
			  if(!checkEmail(email)){
				  $('#emailError').html("联系邮箱格式不正确!");
				  setFocus(email);
				  canClick = true;
				  return;
			  }else{
				  $('#emailError').html('');
			  }
		  }
		  //QQ
		  if($.trim($('#qq').val()).length == 0){
			  $('#qqError').html('QQ号码不能为空!');
			  setFocus($('#qq'));
			  canClick = true;
			  return;
		  }else{
			  if(!checkNumber($.trim($('#qq').val()))){
				  $('#qqError').html("QQ号码只能输入数字!");
				  setFocus($('#qq'));
				  canClick = true;
				  return;
			  }else{
				  $('#qqError').html('');
			  }
		  }
		  //所在省份
		  var province = $('#province');
		  if($.trim(province.val()).length == 0){
			  $('#provinceError').html("所在省份不能为空!");
			  setFocus(province);
			  canClick = true;
			  return;
		  }else{
			  $('#provinceError').html('');
		  }
		  //所在城市
		  var city = $('#city');
		  if($.trim(city.val()).length == 0){
			  $('#cityError').html("所在城市不能为空!");
			  setFocus(city);
			  canClick = true;
			  return;
		  }else{
			  $('#cityError').html('');
		  }
		  //所在区县
		  var district = $('#district');
		  if($.trim(district.val()).length == 0){
			  $('#districtError').html("所在区县不能为空!");
			  setFocus(district);
			  canClick = true;
			  return;
		  }else{
			  $('#districtError').html('');
		  }
		  //公司地址
		  var coraddr = $('#coraddr');
		  if($.trim(coraddr.val()).length == 0){
			  $('#coraddrError').html("公司地址不能为空!");
			  setFocus(coraddr);
			  canClick = true;
			  return;
		  }else{
			  $('#coraddrError').html('');
		  }
		  var postData = $("#registerForm").serialize();
    	  $.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/register.do?t=" + new Date().getTime(),
			  data: postData,
			  async : true,
			  success:function callbackFunc(data){
				  if (data == "FAILURE"){    
			    	  $(this).Point('PointC','注册失败,请稍后再试!');
			      }else if(data == "EXISTS"){
			    	  $(this).Point('PointC','用户帐号已存在,请重新输入!');
			    	  setFocus(userAccount);
			      }else if(data == "QQEXISTS"){
			    	  $(this).Point('PointC','联系QQ已存在,请重新输入!');
			    	  setFocus($('#qq'));
			      }else if(data == "COREXISTS"){
			    	  $(this).Point('PointC','公司名称及品牌名称已存在,请重新输入!');
			    	  setFocus($('#corname'));
			      }else if(data == "ERROR"){
			    	  $(this).Point('PointC','系统繁忙,请稍后再试!');
			    	  setFocus(userAccount);
			      }else{
			          window.location.href = "${pageContext.request.contextPath}/pCenter";  
			      }
			      canClick = true;
			  }
	   	 });
		  return false;
    }
	function setFocus(obj){
	   if(obj != null){
		   obj.focus();
		   obj.select();
	   }
	}
	//邮箱校验
    function checkEmail(userAccount){
       //对电子邮件的验证
       var myreg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
       return myreg.test($.trim(userAccount.val()));
	}
</script>