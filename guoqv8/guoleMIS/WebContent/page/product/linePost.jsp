<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>线路管理</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Public.css" />
<jsp:include page="../../header.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/cityChoose.js"></script>
<link href="${pageContext.request.contextPath}/js/multiDatePicker/datepicker.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/cityChoose.css"/>
<script type="text/javascript">
window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/page/product/ueditor/";
</script>
<style type="text/css">
	.width120{
		width:120px !important;
	}
	
	.width130{
		width:130px !important;
	}
	
	.pointer{
		cursor: pointer;
	}
	
	.icon_export {
		background-image: url("${pageContext.request.contextPath}/img/export.png");
	}
	
	.icon_print {
		background-image: url("${pageContext.request.contextPath}/img/print.png");
	}
</style>
<link href="${pageContext.request.contextPath}/js/multiDatePicker/datepicker.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- Header -->
	<jsp:include page="../../menu.jsp">
		<jsp:param value="product" name="type"/>
	</jsp:include>
	<!-- End of Header -->
	<!-- Page title -->
	<div id="pagetitle">
		<div class="wrapper">
			<h1>产品管理 → <span>线路发布</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
			<!--发布商品-->
			<div class="PostTrade">
				<div class="StepBox">
					<ul class="Step StepA" id="tabs">
						<li class="Active">1.基本信息</li>
						<li id="tab_route">2.行程详情</li>
						<li id="tab_plan">3.出团计划</li>
						<li id="tab_succ">4.发布成功</li>
					</ul>
				</div>
						<div id="tabsdate" class="">
						<div class="box box-info">线路基本信息</div>
						<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<form id="baseForm">
							<tr>
								<td class="CA TTi"><b class="CD">*</b>运营商</td>
								<td>
									<input class=" WMaxS IN" type="text" readonly="readonly" onclick="selectSeller()" id="supName">
									<input type="hidden" name="lineInfo.supplierId" />
								</td>
							</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>线路名称</td>
								<td>
									<span class="IBoxTip">
										<input class="IEnter WMaxS IN" maxlength="50" type="text" name="lineInfo.name" id="name"/>
										<label class="IExplain">输入线路名称</label>
									</span>
								</td>
							</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>业务类型</td>
								<td>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.busiType" value="1" /> 国内游</label>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.busiType" value="2" /> 出境游</label>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.busiType" value="3" /> 周边游</label>
								</td>
							</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>线路类型</td>
								<td>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.lineType" value="1" /> 跟团游</label>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.lineType" value="2" /> 自由行</label>
									<label class="MR"><input class="BNo VMid" type="radio" name="lineInfo.lineType" value="3" /> 当地地接</label>
								</td>
							</tr>
							<tr>
									<td class="CA TTi"><b class="CD">*</b>产品类型</td>
									<td>
										<span class="FillA" id="productTag">
											<input class="AutoFill WMids" 
											name="lineInfo.productType" readonly="readonly" type="text" maxlength="50" id="productType" value="${lineInfo.productType }"/>
										</span>
									</td>
								</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>联系人</td>
								<td>
									<input class=" WMinS IN" maxlength="10" type="text" id="linker" name="lineInfo.linker"/>
									<span class="CA"><b class="CD">*</b>联系电话</span>
									<input class=" WMids IN" maxlength="20" type="text" id="linkphone" name="lineInfo.linkphone"/>
								</td>
							</tr>
							<tr>
									<td  class="CA TTi"><b class="CD">*</b>出发地</td>
									<td >
											<input class="WMid IN" type="text" maxlength="30"
												id="fromplace" name="lineInfo.fromplace" readonly="readonly"  onfocus="showCityChoose(this);">
									</td>
								</tr>
								<tr>
									<td  class="CA TTi"><b class="CD">*</b>目的地</td>
									<td>
										<span class="FillBox" >
											<span id="toplaceInfo">
											 </span>
											 <input  uncheck="1" style="border:none;box-shadow:none"  class=" WMids IN" type="text" maxlength="100"
													id="toplace" name=""  >
										</span>
										请输入关键字查询目的地
									</td>
								</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>行程天数</td>
								<td>
									<input class="WMin IN" type="text" maxlength="3" name="lineInfo.days" value="1" id="days"/> 天
								</td>
							</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>报名截止</td>
								<td>
									<span class="CA">出团前</span><input class="WMin IN" type="text" maxlength="3" name="lineInfo.deadline"  id="deadline"/> 天
								</td>
							</tr>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>线路主题</td>
								<td>
										<span id="topicTag">
											<input uncheck="1" class="AutoFill WMaxX" 
											name="lineInfo.topic" readonly="readonly" type="text" maxlength="50" id="topic"/>
										</span>
										最多选择10个
								</td>
							</tr>
							<tr id="t_toTrans">
								<td class="CA TTi"><b class="CD">*</b>去程交通</td>
								<td >
									<select name="lineInfo.toTransport" id="toTransport">
										<option value="-1">===选择交通方式===</option>
										<option value="飞机">飞机</option>
										<option value="高铁">高铁</option>
										<option value="火车">火车</option>
										<option value="轮船">轮船</option>
										<option value="汽车">汽车</option>
										<option value="包车">包车</option>
									</select>	
									<span class="CA ML"><b class="CD">*</b>返程交通</span>
									<select name="lineInfo.fromTransport" id="fromTransport">
										<option value="-1">===选择交通方式===</option>
										<option value="飞机">飞机</option>
										<option value="高铁">高铁</option>
										<option value="火车">火车</option>
										<option value="轮船">轮船</option>
										<option value="汽车">汽车</option>
										<option value="包车">包车</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="CA TTi VT"><b class="CD">*</b>线路特色</td>
								<td >
									<textarea 
											maxlength="1000" class=" WMaxX IN" cols="45" rows="500"
											name="lineInfo.features" id="features" style="height:87px;"></textarea>
									<span class="InNumber" style="line-height: 25px;"> <em>1000字</em>
									</span>
								</td>
							</tr>
							<tr>
								<td class="CA TTi VT"><b class="CD">*</b>注意事项:</td>
								<td >
									<textarea 
											maxlength="1000" class=" WMaxX IN" cols="45" rows="500" 
											style="height:87px;"
											name="lineInfo.attention" id="attention"></textarea>
									 <span class="InNumber" style="line-height: 25px;"> <em>1000字</em>
									</span>
								</td>
							</tr>
							</form>
							<tr>
								<td class="CA TTi"><b class="CD">*</b>线路图片:</td>
								<td >
									<ul class="PostPic" id="picList">												
									</ul>
									<form id="picForm" action="${pageContext.request.contextPath}/uploadLinePic.do" method="post">
										<input type="file" name="imageFile" id="imageFile"/>
									</form>
								</td>
							</tr>
							<tr>
								<td class="CA TTi"></td>
								<td class="TR">
									<a href="javascript:void(0)" id="saveBaseBtn" class="But3 But3C">保存，下一步</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="tabsstr" class="DisNo">
							<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi"><b class="CD">*</b>行程详情:</td>
									<td><span id="travelDocName"></span>
										<form id="lineRouteDoc" action="${pageContext.request.contextPath}/wordUpload.do" method="post">
											<input type="file" id="travelDoc" name="file">
											<input type="hidden" name="docPath" id="docPath"/>
										</form>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="ConTabs">
										<ul class="Tabs">
											<li class="Active"><b class="CD">*</b>行程信息</li>
										</ul>
										<div class="TabsCon">
											<div >
												<textarea id="routeinfo" class="large full"  cols="90" rows="10"></textarea>
											</div>
										</div>
									</td>
								</tr>		
								<tr>
									<td colspan="2">
										<div class="MainHeader">
											<span class="Text">扩展信息</span>							
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="ConTabs" id="tabsExt">
										<ul class="Tabs">
											<li class="Active"><b class="CD">*</b>费用说明</li>
											<li ><b class="CD">*</b>预订须知</li>
											<li >签证信息</li>
											<li >附加信息</li>
										</ul>
										<div class="TabsCon">
											<div >
												<textarea id="costinfo" class="large full" name="costinfo" cols="90" rows="10"></textarea>
											</div>
											<div class="DisNo" >
												<textarea id="bookinfo" class="large full" name="bookinfo" cols="90" rows="10"></textarea>
											</div>
											<div class="DisNo" >
												<textarea id="visainfo" class="large full" name="visainfo" cols="90" rows="10"></textarea>
											</div>
											<div class="DisNo" >
												<textarea id="extra" class="large full" name="extra"  cols="90" rows="10"></textarea>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="CA TTi"></td>
									<td class="TR"><a href="javascript:void(0)"  id="routeBtn" class="But3 But3C">保存，下一步</a></td>
								</tr>
							</table>
						</div>
						<div id="tabsplan" class="DisNo">
							<div class="box box-info">出团价格和时间</div>
							<div class="MainHeader">
								<span class="FR">
									<a style="color:#fff" href="javascript:void(0)" onclick="OPEN.Modal('planWindow')" class="But ButA"><img src="${pageContext.request.contextPath}/Images/blank.gif" class="E EAddPage"/> 添加出团计划</a>
								</span>
								<span class="Text">出团时间和价格</span>							
							</div>
							<table class="LTable TTable" width="100%">
								<thead>
									<tr>
										<th scope="col">
											出发日期
											
										</th>
										<th scope="col">
											成人同行结算价
											
										</th>
										<th scope="col">
											折扣价
											
										</th>
										<th scope="col">
											可售人数
											
										</th>
										<th scope="col">
											出团截至天数
											
										</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="withDrawingList"><tr><td colspan="5" style="height:30px;color:red;" align="center" valign="middle">请填写出团计划</td></tr></tbody>
							</table>
							<div class="TR">
								<a href="javascript:void(0);" id="moreBtn" class="But3 But3C">保存待发布</a>
								<a id="publishLine" href="#" target="_lineview" onclick="return saveLine(4);" class="But3 But3C">发布预览</a>
							</div>
						</div>
					</div>
					<!--发布商品 end-->
			<div>
				<div id="tabs-date">
				
				</div>
				<div id="tabs-abc">
				
				</div>
			</div> 
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<!--弹框-->


<script type="text/javascript" src="${pageContext.request.contextPath}/js/cityChoose.js"></script>

<div id="topicTagWindow" class="FillChoose DisNo">
	<div class="FillCheck">
		<img class="FillCloseImg" src="${pageContext.request.contextPath}/Images/Icon/Close.gif"/>
		<div class="FillTitle">最多选择10个主题</div>
		<div class="FillCon">
			<ul class="FillList" id="lineTags">
			</ul>
		</div>
	</div>
</div>
<div id="productTagWindow" class="FillChoose DisNo">	
	<div class="FillCheck">
		<img class="FillCloseImg" src="${pageContext.request.contextPath}/Images/Icon/Close.gif"/>
		<div class="FillTitle"></div>
		<div class="FillCon SpeCityM" id="lineProduct">
			
		</div>
	</div>
</div>

<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/page/product/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/page/product/ueditor/ueditor.all.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="text/javascript">
	<%-- ---------------------------------------处理基本信息页签--------------------------- --%>
	$("#saveBaseBtn").click(function(){
		saveLineBaseInfo();
	});
	
	$("#picBtn").click(function(){
		saveLinePics();
	});
	
	$("#imageFile").change(function(){
		uploadLinePic();
	});
	
	
	
	<%-- 目的地 --%>
	function showCountryChoose(obj) {
		var _this = $(obj);
		if($.trim(obj.value))return;
		cityChoose.show({
			id: "toPlaceCityChoose",
			renderTo: "toplace",
			callbackFn: "countryBack"
		});
	}
	function countryBack(city,fullName) {
		var tmp = $('#toplaceInfo a[sn="'+city+'"]');
		if(tmp[0])return;
		
		$("#toplaceInfo").append('<a val="'+fullName+'" class="BitBox" href="javascript:;" sn="'+city+'">'+city+'<b class="I"></b></a>');
	}
	function showCityChoose(obj) {
		var _this = $(obj);
		cityChoose.show({
			id: "fromPlaceCityChoose",
			renderTo: "fromplace",
			callbackFn: "cityBack"
		});
	}
	function cityBack(city) {
		$("#fromplace").val(city);
		cityChoose.hide("fromPlaceCityChoose");
	}
	
	
	<%-- 加载tags --%>
	//(是否多选true多选/false单选,最大数量,弹框id,初始值,全部数据)
  	AutoFill($("#productTag"),false,5,"#productTagWindow");
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
	//标签
	AutoFill($("#topicTag"),true,10,"#topicTagWindow");
	$.get('${pageContext.request.contextPath}/loadAllTags.do',null,function(tags){
		var c='';
		for(var i=tags.length;i--;){
			c += '<li><a id="topicTag_'+i+'" class="FillClick" href="javascript:;">'+tags[i].name+'</a></li>';
		}
		$('#lineTags').html(c);
	},'json');
	
	var _picHtml = '<li>\
		 <a href="javascript:void(0)" onclick="removePic(this);" class="I"></a>\
		 <img class="UserPic" src="${imgUrl}<%=Config.getInstance().get("resTmp")%>/#pic" width="120" height="90"/>\
	    </li>';
	// 上传线路图片
	function uploadLinePic() {
		var picList = $("#picList");
		$("#picForm").ajaxSubmit({
		success:function(rs){
			if ("0101" == rs) {
				alert("上传文件过大，不要超过8M");
			}else if ("0102" == rs) {
				alert("上传文件类型不对，只能上传(.png,.jpg,.gif)");
			}else if ("error" == rs) {
				alert("上传服务器出错");
			}else{
				picList.prepend(_picHtml.replace("#pic", rs));
			}
		},
		error: function(){
			//alert("服务器断访问出错");
		}
		});
	}
	
	// 移除图片
	function removePic(obj){
		$(obj).parent().detach();
		$("#picForm")[0].reset();
	}
	
	var _newLineId = 0;
	// 保存基本信息
	function saveLineBaseInfo() {
		//baseForm
		var bf = $('#baseForm')[0];
		for(var i=bf.elements.length;i--;){
			var e = bf.elements[i];
			var cls = e.className || e.getAttribute("class");
			if(e.getAttribute('uncheck')!=1 && (cls && cls.indexOf('MainInput')<0)){
				if(!$.trim(e.value)){
					var name = $(e).closest('td').prev().text().replace('*','').replace(':','');
					alert(name+"不能为空");
					e.focus();
					return;
				}
			};
		}
		
		var toInfo = '';
		$('#toplaceInfo a').each(function(){
			toInfo += ','+$(this).attr('val').replace(/,/gm,' ');
		});
		toInfo = toInfo.substring(1,toInfo.length);
		if(!toInfo){
			alert('目的地不能为空');
			$('#toplace').focus();
			return;
		}
		
		if(isNaN($('#days').val()) || parseInt($('#days').val())<1){
			alert('行程天数必须是大于0的数字');
			$('#days').focus();
			return;
		}
		if(isNaN($('#deadline').val()) || parseInt($('#deadline').val())<1){
			alert('报名截止天数必须是大于0的数字');
			$('#deadline').focus();
			return;
		}
		
		//主题值
		var topics='';
		$('#topicTag a').each(function(){
			if($.trim($(this).text()))
			topics += ','+$(this).text();
		});
		if($.trim(topics)==''){
			alert('线路主题不能为空');
			$('#topic').focus();
			return;
		}
		$('#topic').val(topics.substring(1,topics.length));
		
		var value;
		$('input[name="lineInfo.lineType"]').each(function(){
			if(this.checked){
				value = this.value;
			}
		});
		if(!value){
			alert("请选择线路类型");
			$('input[name="lineInfo.lineType"]').focus();
			return;
		}
		if(value!=3){
			var toTrans = $('#toTransport').val();
			if(toTrans=='-1'){
				alert('请选择去程交通方式');
				return;
			}
			var fromTrans = $('#fromTransport').val();
			if(fromTrans=='-1'){
				alert('请选择返程交通方式');
				return;
			}
		}
		
		
		
		var picList = $("#picList img");
		if (!picList || picList.length == 0) {
			alert("请至少上传一张图片");
			return;
		}
		var features = $('#features').val();
		if(features.length>1000){
			alert("线路特色太长，请重新编辑后再保存");
			$('#features').focus();
			return;
		}
		var recommend = $('#attention').val();
		if(recommend.length>1000){
			alert("注意事项太长，请重新编辑后再保存");
			$('#attention').focus();
			return;
		}
		
		value=null;
		$('input[name="lineInfo.busiType"]').each(function(){
			if(this.checked){
				value = this.value;
			}
		});
		if(!value){
			alert("请选择业务类型");
			$('input[name="lineInfo.busiType"]').focus();
			return;
		}
		
		//拼装图片路径
		var img, pics="", src;
		for (var i = 0; i < picList.length; i++) {
			img = picList[i];
			src = img.src;
			pics += src.substring(src.lastIndexOf("/") + 1, src.length) + ",";
		}
		
		pics = pics.substring(0, pics.length - 1);
		
		$.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/saveLineBaseInfo.do?t=" + new Date().getTime(),
			  data: $("#baseForm").serialize()+"&lineInfo.toplace="+toInfo+"&lineInfo.propics="+pics,
			  success:function(data){
				if ("error" == data){
					alert("出错了");
				}else if("login" == data){
					window.location.href = "${pageContext.request.contextPath}/login";
				}else{
					_newLineId = parseInt(data);
					$("#saveBaseBtn").hide();
					$("#baseForm input").attr("disabled", "disabled");
					$("#baseForm select").attr("disabled", "disabled");
					
					//init editors
					var options = {
					    imageUrl:UEDITOR_HOME_URL + "jsp/imageUp.jsp?lineId="+_newLineId,
					    imagePath:"",
					    initialFrameWidth:970,
					    initialFrameHeight:280,
					    focus:true
					};
					UE.getEditor('routeinfo', options);
					UE.getEditor('costinfo', options);
					UE.getEditor('bookinfo', options);
					UE.getEditor('visainfo', options);
					UE.getEditor('extra', options);
					
					//switch tab
					var tab = $("#tab_route");
					$('#tabs').attr('class','Step StepB');
					$('#tabs li.Active').removeClass('Active');
					tab.addClass('Active');
					$('#tabsdate').addClass('DisNo');
					$('#tabsstr').removeClass('DisNo');
					
					//生成天数选择
					var days = $('#days').val();
					$('#routeCount').html(days+'天'+$('#nights').val()+'夜');
					var html='';
					for(var i=1;i<=days;i++){
						html += '<li class="'+(i==1?'Active':'')+'" id="route_'+i+'" onclick="loadRouteInfo('+i+')"><span>第'+i+'天</span></li>';
					}
					$('#daynight').html(html);
				}
			  },
			  error:function(){
				  alert("服务器断访问出错");
			  }
		});
	}
	
	<%-- ---------------------------------------处理行程信息页签--------------------------- --%>
	$("#travelDoc").change(function(){
		$("#lineRouteDoc").ajaxSubmit({
			success:function(rs){
				if ("0101" == rs) {
					alert("上传文件过大，不要超过8M");
				}else if ("0102" == rs) {
					alert("上传文件类型不对，只能上传(.doc,.docx,.xls,.xlsx,.txt)");
				}else{
					var ps = rs.split(',');
					$('#docPath').val(ps[0]);
					$('#travelDocName').html(ps[1]);
				}
			},
			error: function(){
				alert("服务器断访问出错");
			}
		});
	});

	
	// 添加行程信息
	$("#routeBtn").click(function(){
		var path = $('#docPath').val();
		if(!path){
			alert('请上传行程详情文件');
			return;
		}
		
		var routeInfo = UE.getEditor('routeinfo').getContent();
		if(!routeInfo){
			alert('行程信息必须填写');
			$('#routeinfo').focus();
			return
		}
		
		var costInfo = $.trim(UE.getEditor('costinfo').getContent());
		var bookInfo = $.trim(UE.getEditor('bookinfo').getContent());
		if(!costInfo){
			alert('费用信息必须填写');
			return;
		}
		if(!bookInfo){
			alert('预定须知必须填写');
			return;
		}
		
		var rs = true;
		//添加扩展信息
		$.ajax( {
			  type: "post",
			  async:false,
			  url: "${pageContext.request.contextPath}/saveLineMoreInfo.do?lineInfo.id="+ _newLineId +"&t=" + new Date().getTime(),
			  data:'lineInfo.costinfo='+encodeURIComponent(costInfo)+
				  '&lineInfo.bookinfo='+encodeURIComponent(bookInfo)+
				  '&lineInfo.visainfo='+encodeURIComponent(UE.getEditor('visainfo').getContent())+
				  '&lineInfo.extra='+encodeURIComponent(UE.getEditor('extra').getContent())+
				  '&lineInfo.travelDocName='+$('#travelDocName').text()+
				  '&lineInfo.routeinfo='+encodeURIComponent(routeInfo)+
				  '&lineInfo.supplierId='+$('input[name="lineInfo.supplierId"]').val()+
				  '&lineInfo.travelDocPath='+$('#docPath').val(),
			  success:function(data){
				if ("error" == data){
					alert("出错了");
					rs = false;
				}
				if("login" == data){
					window.location.href = "${pageContext.request.contextPath}/login";
					return;
				}
			  },
			  error:function(){
				  alert("服务器断访问出错");
				  rs = false;
			  }
		});
		if(true){
			//switch tab
			var tab = $("#tab_plan");
			$('#tabs').attr('class','Step StepC');
			$('#tabs li.Active').removeClass('Active');
			tab.addClass('Active');
			$('#tabsstr').addClass('DisNo');
			$('#tabsplan').removeClass('DisNo');
			
			//截止日期
			$('#groupLimit').val($('#deadline').val());
		}
	});

	<%-- ---------------------------------------处理出团计划页签--------------------------- --%>
	function openPlan2(date){
		OPEN.Modal('planWindow2');
		$('#planWindow2').attr('date',date);
		//set value
		var plan = GROUPDAYS[date];
		$('#dayName').html(date);
		$('#dayPrice').val(plan.price);
		var tag = plan.tag;
		if(tag){
			$('#dayDiscount').closest('span').css('display','');
		}else{
			$('#dayDiscount').closest('span').css('display','none');
		}
		$('#dayDiscount').val(plan.discountprice);
		$('#dayNum').val(plan.num);
		$('#dayLimit').val(plan.limit);
		$('input[name="plan.tag"]')[0].checked=true;
		$('input[name="plan.tag"]').each(function(){
			if(this.value == plan.tag){
				this.checked=true;
				return false;
			}
		});
		
		var ps = date.split('-'); 
		picker2.date = new Date(ps[0], parseInt(ps[1].replace('0',''))-1, ps[2], 0, 0, 0, 0);
		picker2.viewDate = new Date(ps[0], parseInt(ps[1].replace('0',''))-1, ps[2], 0, 0, 0, 0);
		picker2.selectedDateAry = [new Date(ps[0], parseInt(ps[1].replace('0',''))-1, ps[2], 0, 0, 0, 0)];
		picker2.fill();
		picker2.disabled = true;
		picker2.show();
	}
	<%-- 在前台保存出团计划信息 --%>
	var GROUPDAYS={};
	function saveGroupDays(){
		GROUPDAYS = {};
		var num = $('#groupNum').val();
		var price = $('#groupPrice').val();
		var limit = $('#groupLimit').val();
		if(!price){
			alert('同行价格不能为空');
			$('#groupPrice').focus();
			return;
		}
		if(!num){
			alert('可售人数不能为空');
			$('#groupNum').focus();
			return;
		}
		if(!limit){
			alert('截止天数不能为空');
			$('#groupLimit').focus();
			return;
		} 
		if(isNaN(price)|| parseInt(price)<1){
			alert('同行价格必须是大于0的数字');
			$('#groupPrice').focus();
			return;
		}
		if(isNaN(num)|| parseInt(num)<1){
			alert('可售人数必须是大于0的数字');
			$('#groupNum').focus();
			return;
		}
		if(isNaN(limit)|| parseInt(limit)<1){
			alert('截止天数必须是大于0的数字');
			$('#groupLimit').focus();
			return;
		}
		var days = picker.selectedDateAry;
		if(!days){
			alert('请选择团期');
			return;
		}
		if($('input[name="start"]:checked').val()){
			var startDate = $('#groupStartDay').val();
			startDate = new Date(Date.parse(startDate.replace(/-/g, "/"))); 
			for(var i=120;i--;){
				var day = startDate;
				var dayStr = day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate();
				GROUPDAYS[dayStr]={'discountprice':0,'startDate':dayStr,'price':price,'num':num,'limit':limit};
				startDate.setDate(startDate.getDate()+1);
			}
		}else{
			for(var i=days.length;i--;){
				var day = days[i];
				var dayStr = day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate();
				GROUPDAYS[dayStr]={'discountprice':0,'startDate':dayStr,'price':price,'num':num,'limit':limit};
			}
		}
		//生成显示列表
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);
		var html = fn.template($('#tmpl').html())(GROUPDAYS);
		$('#withDrawingList').html(html);
		
		$('.IMClose').click()
	}
	function saveSelectedDay(){
		var num = $('#dayNum').val();
		var price = $('#dayPrice').val();
		var dayDiscount = $('#dayDiscount').val();
		var limit = $('#dayLimit').val();
		var tag='';
		$('input[name="plan.tag"]').each(function(){
			if(this.checked){
				tag = this.value;
				return false;
			}
		});
		if(!tag){
			dayDiscount=0;
		}
		
		if(!price){
			alert('同行价格不能为空');
			$('#dayPrice').focus();
			return;
		}
		if(!dayDiscount && tag){
			alert('折扣价格不能为空');
			$('#dayDiscount').focus();
			return;
		}
		if(!num){
			alert('可售人数不能为空');
			$('#dayNum').focus();
			return;
		}
		if(!limit){
			alert('截止天数不能为空');
			$('#dayLimit').focus();
			return;
		} 
		if(isNaN(price)|| parseInt(price)<1){
			alert('同行价格必须是大于0的数字');
			$('#dayPrice').focus();
			return;
		}
		if((isNaN(dayDiscount)|| parseInt(dayDiscount)<1) && tag){
			alert('折扣价格必须是大于0的数字');
			$('#dayDiscount').focus();
			return;
		}
		if(isNaN(num)|| parseInt(num)<1){
			alert('可售人数必须是大于0的数字');
			$('#dayNum').focus();
			return;
		}
		if(isNaN(limit)|| parseInt(limit)<1){
			alert('截止天数必须是大于0的数字');
			$('#dayLimit').focus();
			return;
		}
		var plan = GROUPDAYS[$('#planWindow2').attr('date')];
		plan.num = num;
		plan.price = price;
		plan.discountprice = dayDiscount;
		if(!tag){
			plan.discountprice = 0;
		}
		plan.tag = tag;
		//GROUPDAYS[$('#openPlan2').attr('date')]=plan;
		//生成显示列表
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);
		var html = fn.template($('#tmpl').html())(GROUPDAYS);
		$('#withDrawingList').html(html);
		
		$('.IMClose').click();
	}
	<%-- 创建团期时日期选择控制 --%>
	function changeStart(input){
		if(!input.value){
			$('#groupStartDayTr').css('display','none');
			//多选
			picker.config.canMultipleChoose = true;
		}else{
			$('#groupStartDayTr').css('display','');
			//清空日历
			//picker.date = new Date();
			var d = new Date();
			d.setHours(0);
			d.setMinutes(0);
			d.setSeconds(0);
			d.setMilliseconds(0);
			picker.selectedDateAry = [d];
			picker.fill();
			picker.show();
			//变成单选
			picker.config.canMultipleChoose = false;
			$('#groupStartDay').val(picker.date.getFullYear()+"-"+(picker.date.getMonth()+1)+"-"+picker.date.getDate());
		}
	}

	<%-- 修改日期时特价选项控制 --%>
	function changeTag(input){
		if(!input.value){
			$('#dayDiscount').closest('span').css('display','none');
		}else{
			$('#dayDiscount').closest('span').css('display','');
		}
	}
	
	function saveLine(state) {
		var param='',l=0;
		
		for(var i in GROUPDAYS){
			var plan = GROUPDAYS[i];
			param += '&linePlanList['+l+'].startDate='+i+'&linePlanList['+l+'].adultprice2='+plan.price
			+'&linePlanList['+l+'].num='+plan.num
			+'&linePlanList['+l+'].days='+plan.limit
			+'&linePlanList['+l+'].discountprice='+(plan.discountprice||0)
			+'&linePlanList['+l+'].discounttag='+(plan.tag||'');
			l++;
		}
		if(l==0){
			alert('请填写出团计划后保存');
			if(window.event){
				$('#publishLine').removeAttr('target');
			}
			return false;
		}
		param = param.substring(1,param.length);

		var b = false;
		$.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/saveLinePlanBatch.do?lineInfo.id="+ _newLineId,
			  data: param,
			  async:false,
			  success:function(data){
				if ("error" == data){
					alert("出错了");
					b = true;
					return;
				}else if("login" == data){
					window.location.href = "${pageContext.request.contextPath}/login";
				}
			  },
			  error:function(){
				  alert("服务器断访问出错");
			  }
		});
			
		if(b){
			return false;
		}

		<%-- 如果是发布，执行上架 --%>
		try{
			if(state==4){
				$('#publishLine').attr('target','_lineview');
				$('#publishLine').attr('href','${pageContext.request.contextPath}/forwardManageLineViewPage.do?lineInfo.supplierId='+$('input[name="lineInfo.supplierId"]').val()+'&lineId='+_newLineId+'&pub=1');
				return true;
			}
		}finally{
			window.location.href = "${pageContext.request.contextPath}/page/product/lineManager.jsp";
		}

	}
	
	$("#moreBtn").click(function(){
		saveLine(5);
	});
	
	$("input[name='lineInfo.lineType']").change(function(){
		var _this = $(this);
		var fTrans = $("#fromTransport");
		var tTrans = $("#toTransport");
		if (_this.val() == 3) {
			fTrans.hide();
			tTrans.hide();
			$('#t_toTrans').hide();
		}else{
			fTrans.show();
			tTrans.show();
			$('#t_toTrans').show();
		}
	});
	
	</script>
	<script type="text/javascript">		
	
	<%--                 查询卖家                                                          --%>
	function selectSeller(){
		$('#openA').trigger('click');
		loadItems(1);
	}
	
	var pageIndex = 1;
	function loadItems(pageIndex){
		  var postData = "memberInfoVO.usertype=2&memberAccountVO.accounttype=-1";
		  var pages = $("#pageBar");
	      pages.html('');
		  $.ajax({
				url: "${pageContext.request.contextPath}/loadMembers.do?r="+Math.random(),
				dataType: 'json',
				data: postData+"&page="+pageIndex,
				success: function onLoadData(data){
					    pageLength = data.pageLength;
					    $('#totalCount').html(data.totalCount);
					    $('#toolBar').show();
					    var html = '';
						var i=0, length=data.items.length, item;
						if(length > 0){
							  for(; i<length; i++) {
								   item = data.items[i];
								   html += '<tr name="'+item.name+'" uid="'+item.userId+'" mobile="'+item.mobile+'">\
								        <td>'+item.name.replace(/</g,'&lt;').replace(/>/g,'&gt;')+'</td>';
								        if(item.sex == 'm'){
								        	html += '<td>男</td>';
								        }else if(item.sex == 'f'){
								        	html += '<td>女</td>';
								        }else{
								        	html += '<td>未知</td>';
								        }
								        
								        html += '<td>'+item.qq+'</td>\
								        <td>'+item.email+'</td>\
								        <td>'+item.mobile+'</td>';
								        if(item.state == '1'){
								        	html += '<td>待审核</td>';
								        }else if(item.state == '2'){
								        	html += '<td>审核通过</td>';
								        }else if(item.state == '3'){
								        	html += '<td>审核拒绝</td>';
								        }else if(item.state == '4'){
								        	html += '<td>冻结</td>';
								        }
								        html += '<td align="center"><a href="${pageContext.request.contextPath}/memberDetail.do?userId='+item.userId+'" target="_blank">查看</a>&nbsp;&nbsp;';
									   html += '</td></tr>';
							  }
						}
					    $('#memberInfos').html(html);
					    if(pageLength > 1){
					   		  pages.append('<a class="number" href="javascript:loadItems(1);">首页</a>');
					   		  if(pageIndex > 1){
					   			  var p = pageIndex - 1;
					   		      pages.append('<a class="number" href="javascript:loadItems('+p+');">上页</a>');
					   		  }else{
					   			  pages.append('<a class="number" href="javascript:loadItems('+pageIndex+');">上页</a>');
					   		  }
				  		      if(pageLength < 7){
					   			  for(var i = 1; i <= pageLength; i++){
					   				  pages.append('<a class="number" id="pageNo_'+i+'" href="javascript:loadItems('+i+');">'+i+'</a>');
					   			  }
				  		      }else{
				  		    	  if(pageCount - pageIndex >= 6){
				  		    		  for(var j = pageIndex; j < pageIndex+4; j++){
				  	    				  pages.append('<a class="number" id="pageNo_'+j+'" href="javascript:loadItems('+j+');">'+j+'</a>');
				  	    			  }
				  		    		  pages.append('<a class="number" href="javascript:void(0);">...</a>');
				  		    		  var ps = pageLength - 1;
				  		    		  pages.append('<a class="number" id="pageNo_'+ps+'" href="javascript:loadItems('+ps+');">'+ps+'</a>');
				  		    		  pages.append('<a class="number" id="pageNo_'+pageLength+'" href="javascript:loadItems('+pageLength+');">'+pageLength+'</a>');
				  		    	  }else{
				  		    		  for(var i = pageIndex; i <= pageLength; i++){
				  	    				  pages.append('<a class="number" id="pageNo_'+i+'" href="javascript:loadItems('+i+');">'+i+'</a>');
				  	    			  }
				  		    	  }
				  		      }
					   		  if(pageIndex < pageLength){
					   			  var p = pageIndex + 1;
					   		      pages.append('<a class="number" href="javascript:loadItems('+p+');">下页</a>');
					   		  }else{
					   			  pages.append('<a class="number" href="javascript:loadItems('+pageIndex+');">下页</a>');
					   		  }
					   		  
					   		  pages.append('<a class="number" href="javascript:loadItems('+pageLength+');">末页</a>');
					   		  pages.append('<input type="text" class="WMids Input" style="width:30px;" id="pageNO">&nbsp;<a class="number current" style="height:40px;" href="javascript:loadMembers();">跳到该页</a>');
						      var id = "#pageNo_"+pageIndex;
						   	  $(id).addClass('pagination-active');
						   	  pages.show();
					   	  }else{
					   		  pages.hide();
					   	  } 
					    
					    //绑定效果
					    $('#memberInfos tr').css('cursor','pointer').mousemove(function(){
							$(this).css('background','#B8E2FB ');
						}).mouseout(function(){
							$(this).css('background-color','');
						}).click(function(){
							$("#closeBut").click();
							//设置选值
							var tr = $(this);
							$('#supName').val(tr.attr('name'));
							$('input[name="lineInfo.supplierId"]').val(tr.attr('uid'));
							//设置联系人
							if(!$('#linker').val())$('#linker').val(tr.attr('name'));
							if(!$('#linkphone').val())$('#linkphone').val(tr.attr('mobile'));
						});
				       }
			  });
	 }
	</script>
<!-- 编辑区域窗口 -->
<a href="#foobar" style="display:none;" class="nyroModal DisNo" id="openA"></a>
	<div id='foobar' style='display: none;width:800px;'>
		<h3>卖家列表</h3>(点击选取卖家)
		<table id="changeSeller" class="display stylized">
			<thead>
				<tr>
					<th>会员姓名</th>
					<th>性别</th>
					<th>QQ</th>
					<th>邮箱</th>
					<th>电话</th>
					<th>会员状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="memberInfos">
				
			</tbody>
		</table>
	</div>
<!-- 编辑区域窗口结束 -->
<%-- 添加出团计划弹窗 --%>

<style>
#datepicker table{
	border-spacing: 2px;
	border-collapse: separate;
}
</style>
<script src="${pageContext.request.contextPath}/js/multiDatePicker/kit.js"></script>
<!--[if IE]>
<script src="${pageContext.request.contextPath}/js/multiDatePicker/ieFix.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/js/multiDatePicker/datepicker.js"></script>
<div id="planWindow" class="ModalBG DisNo">
	<div class="ModalBox">
		<div class="ModalBor">
			<div class="MBoxT">
				<span class="MClose Cur ModalClose FR"><img class="I IMClose" alt="" src="${pageContext.request.contextPath}/Images/blank.gif" /></span>
				<div class="MBTi">新增团期和批量价格</div>
			</div>
			<div class="MBoxC ">
				<table class="" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="VT">
							<div id="datepicker"></div>
						</td>
					</tr>
					<tr>					
						<td class="MW6 VT">
							<div class="MainHeader">
								<span class="Text">共选择了<span id="dayCount"></span>个团期</span> ( 点击日期，增加出团日期 ，拖动鼠标可以连续多选)
							</div>
							<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi">*团期选择</td>
									<td>
										<label class="ML">
											<input class="VMid" type="radio" name="start" onclick="changeStart(this)"  checked="checked" value=""/>日历选择
										</label>
										<label>
											<input class="VMid" type="radio" name="start" onclick="changeStart(this)"  value="everyday"/>天天发团
										</label> 
									</td>
								</tr>
								<tr id="groupStartDayTr" style="display:none">
									<td class="CA TTi">*发团开始日期</td>
									<td>
										<input id="groupStartDay" class=" WMid IN" type="text" value="点击上面日历选择" readonly="readonly"/>
										<span class="CD">(点击上面日历选择)</span>
									</td>
								</tr>
								<tr>
									<td class="CA TTi">*同行结算价</td>
									<td>
										<input maxlength="6" class="WMin IN" type="text" id="groupPrice"/>元
										<span class="CA ML">*每日可售</span>
										<input maxlength="3" id="groupNum" class="WMin IN" type="text" />
										位
										<span class="CA">*报名截止</span>
										出团前<input class="WMin IN" maxlength="3" value="${lineInfo.days }" type="text" id="groupLimit"/>天
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div class="MBoxB">
				<a href="javascript:void(0)" onclick="$('.IMClose').click()" class="ModalClose But">取消</a>
				<a href="javascript:void(0)" onclick="saveGroupDays()" class="But ButA">确认</a>
			</div>
		</div>
	</div>
</div>
<div id="planWindow2" class="ModalBG DisNo">
	<div class="ModalBox">
		<div class="ModalBor">
			<div class="MBoxT">
				<span class="MClose Cur ModalClose FR"><img class="I IMClose" style="display:none" alt="" src="${pageContext.request.contextPath}/Images/blank.gif" /></span>
				<div class="MBTi">修改单个团期和价格属性</div>
			</div>
			<div class="MBoxC">
				<table class="" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="VT" style="width:190px">
							<div id="datepicker2"></div>
						</td>
						<td style="width:20px"></td>
						<td class="VT MW4">
							<div class="MainHeader">
								<span class="Text">当前选择 <span id="dayName"></span></span>
							</div>
							<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi">*是否促销</td>
									<td>
										<label class="ML">
											<input type="radio" onclick="changeTag(this)" name="plan.tag" checked="checked" value=""/>无促销
										</label>
										<label>
											<input type="radio" onclick="changeTag(this)" name="plan.tag" value="特价"/>特价
										</label>
										<label>
											<input type="radio" onclick="changeTag(this)" name="plan.tag" value="尾货"/>尾货
										</label>
									</td>
								</tr>
								<tr>
									<td class="CA TTi">*同行结算价</td>
									<td>
										<input class="WMin IN" maxlength="6" type="text" id="dayPrice"/>元
										<span style="display:none">
											<span class="CA">折扣价</span>
											<input class="WMin IN" maxlength="6" type="text" id="dayDiscount"/>元
										</span>
									</td>
								</tr>
								<tr>
									<td class="CA TTi">*每日可售</td>
									<td>
										<input class="WMin IN" maxlength="3" type="text" id="dayNum"/>
										位
										<span class="CA">*报名截止</span>
										出团前<input class="WMin IN" maxlength="3" type="text" id="dayLimit"/>天
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div class="MBoxB">
				<a href="javascript:void(0)" onclick="$('.IMClose').click()" class="ModalClose But">取消</a>
				<a href="javascript:void(0)" onclick="saveSelectedDay()" class="But ButA">确认</a>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript">
var picker = new $kit.ui.DatePicker.NMonths();
picker.init();
$kit.el('#datepicker').appendChild(picker.picker);
picker.show();
picker.ev({
	ev : 'change',
	fn : function(e) {
		var days = picker.selectedDateAry;
		if($('input[name="start"]:checked').val()){
			var day = days[0];
			$('#groupStartDay').val(day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate());
		}else{
			if(days.length>120){
				alert('最多只能选择120个日期');
				return;
			}
		}
		
		var html='';
		$('#dayCount').html(days.length);
		for(var i=days.length;i--;){
			var day = days[i];
			
			html += '<a href="javascript:void(0)">'+day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()+'</a> ';
		}
		$('#selectedDays').html(html);
	}
})

var picker2 = new $kit.ui.DatePicker({canMultipleChoose : false});
picker2.init();
$kit.el('#datepicker2').appendChild(picker2.picker);



</script>
<script id="tmpl" type="text/x-fn-tmpl">
	<#
		for(var i in data){
			var plan = data[i];
			var day = plan.startDate;
	#>
	<tr>
		<td><#=day#></td>
		<td><#=plan.price#>&nbsp;<#=plan.tag=='特价'?'<span class="LB LBTE LBHA">特价</span>':plan.tag=='尾货'?'<span class="LB LBWH LBHA">尾货</span>':''#></td>
	<td><#=plan.discountprice?plan.discountprice:'-'#></td>		
<td><#=plan.num#></td>
<td><#=plan.limit#></td>
		<td><a href="javascript:void(0)" onclick="openPlan2('<#=day#>')">修改</a></td>
	</tr>
	<#}#>

</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css"/>
<jsp:include page="/sug.jsp"/>
<script type="text/javascript">
	citySug.init({
		el: "toplace",
		callback: "fillView",
		sugWidth : 300,
		keyUpEventFn: function(){
			cityChoose.hide("toPlaceCityChoose");
		}
	});

	function fillView(value, allValue) {
		var tmp = $('#toplaceInfo a[sn="'+value+'"]');
		if(tmp[0])return;
		var fullpath = allValue.split('-').reverse().join(',');
		$("#toplaceInfo").append('<a val="'+fullpath+'" class="BitBox" href="javascript:;" sn="'+value+'">'+value+'<b class="I"></b></a>');
		$('#toplace').val('');
	}
	
	$(".ModalClose").click(function(){$(this).ModalClose();return false;});
</script>
</body>
</html>

