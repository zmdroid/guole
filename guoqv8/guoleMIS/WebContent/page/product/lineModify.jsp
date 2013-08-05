<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="copyright" content="ihunle.com">
<meta name="description" content="这里填您网站的简介">
<meta name="keywords" content="关键字1,关键字2,关键字3,...">
<title>线路管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Public.css" />
<jsp:include page="../../header.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/js/multiDatePicker/datepicker.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/cityChoose.css"/>
<script type="text/javascript">
window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/page/product/ueditor/";
</script>
</head>

<body>
<jsp:include page="../../menu.jsp">
		<jsp:param value="product" name="type"/>
	</jsp:include>

<!--PageBody-->
<div id="PageBody">
	<div class="WAll"> 
		<div class="MainBox">
			<div class="BreadCrumb"><span class="Current">当前位置：</span> <a href="${pageContext.request.contextPath}/home">首页</a> / <a href="${pageContext.request.contextPath}/pCenter">管理中心</a> / 我的线路产品</div>
			<div class="Box">
				<div class=" ">
					<div class="Pad">
						<div class="MainHeader">
							<span class="Text">线路编辑</span>
						</div>
						<div class="BoxA">基本信息</div>
							<form id="baseForm">
							<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi"><b class="CD">*</b>线路名称</td>
									<td>
											<input class="WMaxS IN" maxlength="50" type="text" name="lineInfo.name" id="name" value="${lineInfo.name}"/>
											<input type="hidden" value="${lineInfo.state}" name="lineInfo.state"/>
									</td>
								</tr>
								<tr>
									<td class="CA TTi"><b class="CD">*</b>业务类型</td>
									<td>
										<label class="MR"><input class="BNo VMid" type="radio" ${lineInfo.busiType == '1' ? "checked" : ""}  name="lineInfo.busiType" value="1" /> 国内游</label>
										<label class="MR"><input class="BNo VMid" type="radio" ${lineInfo.busiType == '2' ? "checked" : ""}  name="lineInfo.busiType" value="2" /> 出境游</label>
										<label class="MR"><input class="BNo VMid" type="radio" ${lineInfo.busiType == '3' ? "checked" : ""}  name="lineInfo.busiType" value="3" /> 周边游</label>
									</td>
								</tr>
								<tr>
									<td class="CA TTi"><b class="CD">*</b>线路类型</td>
									<td>
										<label class="MR"><input class="BNo VMid" ${lineInfo.lineType == '1' ? "checked" : ""}  type="radio" name="lineInfo.lineType" value="1" /> 跟团游</label>
										<label class="MR"><input class="BNo VMid" ${lineInfo.lineType == '2' ? "checked" : ""}  type="radio" name="lineInfo.lineType" value="2" /> 自由行</label>
										<label class="MR"><input class="BNo VMid" ${lineInfo.lineType == '3' ? "checked" : ""}  type="radio" name="lineInfo.lineType" value="3" /> 当地地接</label>
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
										<input class=" WMinS IN" type="text" maxlength="10" id="linker" name="lineInfo.linker"  value="${lineInfo.linker}"/>
										<span style="color: #777;"><b class="CD">*</b>联系电话</span>
										<input class=" WMids IN" type="text" maxlength="20" id="linkphone" name="lineInfo.linkphone" value="${lineInfo.linkphone}"/>
									</td>
								</tr>
								<tr>
									<td  class="CA TTi"><b class="CD">*</b>出发地</td>
									<td >
											<input class="WMid IN" type="text" maxlength="30"
												id="fromplace" name="lineInfo.fromplace" readonly="readonly" value="${lineInfo.fromplace }" onfocus="showCityChoose(this);">
									</td>
								</tr>
								<tr>
									<td  class="CA TTi"><b class="CD">*</b>目的地</td>
									<td>
										<span class="FillBox" >
											<span id="toplaceInfo">
											 </span>
											 <input uncheck="1" style="border:none;box-shadow:none"  class=" WMids IN" type="text" maxlength="100"
													id="toplace" name=""  >
										</span>
										请输入关键字查询目的地
									</td>
								</tr>
								<tr>
									<td class="CA TTi"><b class="CD">*</b>行程天数</td>
									<td>
										<input class="WMin IN" type="text" maxlength="3" name="lineInfo.days" value="${lineInfo.days}" id="days"/> 天
									</td>
								</tr>
								<tr>
									<td class="CA TTi"><b class="CD">*</b>报名截止</td>
									<td>
										<span style="color: #777;">出团前</span><input class="WMin IN" type="text" maxlength="3" name="lineInfo.deadline" value="${lineInfo.deadline}" id="deadline"/> 天
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
								<tr id="t_toTrans" class="${lineInfo.busiType == '3'?'DisNo':''}">
									<td class="CA TTi"><b class="CD">*</b>去程交通</td>
									<td >
										<select name="lineInfo.toTransport" id="toTransport">
											<option value="飞机" ${lineInfo.toTransport=='飞机'?'selected':''}>飞机</option>
											<option value="高铁" ${lineInfo.toTransport=='高铁'?'selected':''}>高铁</option>
											<option value="火车" ${lineInfo.toTransport=='火车'?'selected':''}>火车</option>
											<option value="轮船" ${lineInfo.toTransport=='轮船'?'selected':''}>轮船</option>
											<option value="汽车" ${lineInfo.toTransport=='汽车'?'selected':''}>汽车</option>
											<option value="包车" ${lineInfo.toTransport=='包车'?'selected':''}>包车</option>
										</select>	
										<span class="CA ML"><b class="CD">*</b>返程交通</span>
										<select name="lineInfo.fromTransport" id="fromTransport">
											<option value="飞机" ${lineInfo.fromTransport=='飞机'?'selected':''}>飞机</option>
											<option value="高铁" ${lineInfo.fromTransport=='高铁'?'selected':''}>高铁</option>
											<option value="火车" ${lineInfo.fromTransport=='火车'?'selected':''}>火车</option>
											<option value="轮船" ${lineInfo.fromTransport=='轮船'?'selected':''}>轮船</option>
											<option value="汽车" ${lineInfo.fromTransport=='汽车'?'selected':''}>汽车</option>
											<option value="包车" ${lineInfo.fromTransport=='包车'?'selected':''}>包车</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="CA TTi VT"><b class="CD">*</b>线路特色</td>
									<td >
										<textarea 
											maxlength="1000" class=" WMaxX IN" cols="45" rows="500"
											name="lineInfo.features" id="features" style="height:87px;">${lineInfo.features}</textarea>
										<span class="InNumber" style="line-height: 25px;"> <em>1000字</em>
										</span>
									</td>
								</tr>
								<tr>
									<td class="CA TTi VT"><b class="CD">*</b>注意事项</td>
									<td >
										<textarea 
											maxlength="1000" class=" WMaxX IN" cols="45" rows="500" 
											style="height:87px;"
											name="lineInfo.attention" id="attention">${lineInfo.attention}</textarea>
										 <span class="InNumber" style="line-height: 25px;"> <em>1000字</em>
										</span>
									</td>
								</tr>
							</table>
							</form>
							<table class="BTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi"><b class="CD">*</b>线路图片</td>
									<td>
										<form id="picForm" action="${pageContext.request.contextPath}/uploadLinePic.do" method="post">
											<input type="file" name="imageFile" id="imageFile"/>
										</form>
									</td>
								</tr>
								<tr>
									<td class="CA TTi"></td>
									<td>
										<div class="LinePic">
										<ul class="PostPic" id="picList">
											<script type="text/javascript">
												var pics = "${lineInfo.propics}".split(",");
												var smallPics = "";
												for(var i = 0; i < pics.length; i++){
													smallPics += '<li '+ (i == 0 ? 'class="mPic"' : '') +' ondblclick="toBeFirshtPic(this);">\
																	<a href="javascript:void(0)" onclick="removePic(this);" class="I"></a>\
																	<img class="UserPic" src="${imgUrl}<%=Config.getInstance().get("lineUrl")%>/'+ pics[i] +'" width="120" height="90"/>\
																  </li>';
												}
												document.write(smallPics);
											</script>
										</ul>
										</div>
									</td>
								</tr>							
							</table>
							<div class="BoxA">行程详情</div>
							<table class="BTable" width="100%" id="routeTable" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="CA TTi"><b class="CD">*</b>行程详情:</td>
									<td><span id="travelDocName"><a href="${fileUrl}<%=Config.getInstance().get("lineUrl") %>/${lineInfo.travelDocPath}" target="new">${lineInfo.travelDocName }</a></span>
										<form id="lineRouteDoc" action="${pageContext.request.contextPath}/wordUpload.do" method="post" enctype="multipart/form-data">
											<input type="file" id="travelDoc" name="file">
											<input type="hidden" name="docPath" id="docPath" value="${lineInfo.travelDocPath }"/>
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
												<textarea id="routeinfo" class="large full"  cols="90" rows="10">${lineInfo.routeinfo}</textarea>
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
											<textarea id="costinfo" class="large full" name="costinfo" cols="90" rows="10">${lineInfo.costinfo}</textarea>
										</div>
										<div class="DisNo" >
											<textarea id="bookinfo" class="large full" name="bookinfo" cols="90" rows="10">${lineInfo.bookinfo}</textarea>
										</div>
										<div class="DisNo" >
											<textarea id="visainfo" class="large full" name="visainfo" cols="90" rows="10">${lineInfo.visainfo}</textarea>
										</div>
										<div class="DisNo" >
											<textarea id="extra" class="large full" name="extra"  cols="90" rows="10">${lineInfo.extra}</textarea>
										</div>
									</div>
								</td>
							</tr>
							</table>
							<div class="BoxA">出团计划</div>
							<div class="MainHeader">
								<span class="FR">
									<a href="javascript:void(0)" id="openPlanBtn" class="But ButA"><img src="${pageContext.request.contextPath}/Images/blank.gif" class="E EAddPage"/> 编辑出团计划</a>
									<a href="javascript:void(0)" id="terminateLinePlansBtn" class="But "><img src="${pageContext.request.contextPath}/img/blank.gif" class="E EDelPage"> 批量终止</a>
									<a href="javascript:void(0)" id="openLinePlansBtn" class="But "><img src="${pageContext.request.contextPath}/img/blank.gif" class="E EDelPage"> 批量开启</a>
									<a href="javascript:void(0)" onclick="deleteLinePlans()" class="But "><img src="${pageContext.request.contextPath}/Images/blank.gif" class="E EOpen"> 批量删除</a>
								</span>
								<span class="Text">出团时间和价格</span>
							</div>
							<table class="LTable TTable" width="100%">
								<thead>
									<tr>
										<th width="20" scope="col"><input class="VMid BNo" type="checkbox" name="checkbox" id="checkAll" onclick="checkAll(this)"></th>
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
											出团截止天数
											
										</th>
										<th scope="col">
											状态
											
										</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="withDrawingList">
									<c:forEach items="${linePlanList }" var="plan">
										<tr sn="${plan.id}" limit="${plan.days}" price="${plan.adultprice2}" tag="${plan.discounttag}" num="${plan.num}" discountprice="${plan.discountprice}">
											<td><input sn="${plan.id}" class="VMid BNo" type="checkbox" name="checkbox"></td>
											<td><fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/></td>
											<td>
												${plan.adultprice2}&nbsp;${plan.discounttag=='特价'?'<span class="LB LBTE LBHA">特价</span>':plan.discounttag=='尾货'?'<span class="LB LBWH LBHA">尾货</span>':''}
											</td>
											<td>${(plan.discounttag=='特价'||plan.discounttag=='尾货')?plan.discountprice:'-'}</td>
											<td>${plan.num}</td>
											<td>${plan.days}</td>
											<td>${plan.state==1?'正常':'终止'}</td>
											<td><a href="javascript:void(0)" onclick="openPlan2(this.parentNode.parentNode,'<fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>')">修改</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="TR">
								<a href="javascript:;" onclick="saveLineInfo()" class="But3 But3C">保存修改</a>
								<a href="${pageContext.request.contextPath}/forwardManageLineViewPage.do?lineInfo.supplierId=${lineInfo.supplierId}&lineId=${lineInfo.id}&pub=1" target="_lineview" onclick="return saveLineInfo(true);" class="But3 But3C">发布预览</a>
							</div>
					</div>
				</div>
				<div class="Cle"></div>
			</div>
		</div>
	</div>
</div>
<!--PageBody end-->

<!--Footer-->
<!--Footer end-->

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
	<div class="FillCheck ">
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
$("#imageFile").change(function(){
	uploadLinePic();
});
<%-- 目的地函数开始 --%>
var selectedPlace='${lineInfo.toplace}'.split(',');
var tohtml='';
for(var i=0,l=selectedPlace.length;i<l;i++){
	var fullName = selectedPlace[i].replace(/ /gm,',');
	var city = fullName.split(',')[0];
	
	tohtml += '<a class="BitBox" val="'+fullName+'" href="javascript:;" sn="'+city+'">'+city+'<b class="I"></b></a>';
}
$("#toplaceInfo").html(tohtml);
function showCountryChoose(obj) {
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
<%-- 目的地函数结束 --%>


<%-- 加载tags --%>
//(是否多选true多选/false单选,最大数量,弹框id,初始值,全部数据)
AutoFill($("#productTag"),false,1,"#productTagWindow",[{id:1,name:'${lineInfo.productType}'}]);
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
var selectedTags = '${lineInfo.topic}'.split(',');
var tmp =[];
for(var i=selectedTags.length;i--;){
	tmp.push({id:i,name:selectedTags[i]});
}
AutoFill($("#topicTag"),true,10,"#topicTagWindow",tmp);
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
				picList.append(_picHtml.replace("#pic", rs));
			}
		},
		error: function(){
			alert("服务器断访问出错");
		}
	});
}

// 移除图片
function removePic(obj){
	var par = $(obj).parent();
	var li = $("#picList li");
	if (!li || li.length == 1) {
		alert("最少必须保留一张线路照片");
		return;
	}

	par.detach();
	li = $("#picList li");
	$(li[0]).addClass("mPic");
	$("#picForm")[0].reset();
}

// 双击直接设为主图
function toBeFirshtPic(obj) {
	var o = $(obj);
	if (o.hasClass("mPic")) {	// 已经是主图了
		return;
	}
	var src = o.find("img").attr("src");
	src = src.substring(src.lastIndexOf("/") + 1, src.length) + ",";
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/changeFirstPic.do?t=" + new Date().getTime(),
		  data: {lineId: ${lineInfo.id},newFirstPicName: src,"lineInfo.supplierId":'${lineInfo.supplierId}'},
		  success:function(data){
			if ("error" == data){
				alert("出错了");
			}else if("login" == data){
				window.location.href = "${pageContext.request.contextPath}/login";
			}else{
				alert("主图设置成功");
				o.addClass("mPic");
				o.detach();
				var html = obj.outerHTML;
				$("#picList li").removeClass("mPic");
				$("#picList").prepend(html);
			}
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
}

// 获取上传图片
function getPics(){
	var picList = $("#picList img");
	if (!picList || picList.length == 0) {
		return "";
	}

	var img, pics="", src;
	for (var i = 0; i < picList.length; i++) {
		img = picList[i];
		src = img.src;
		pics += src.substring(src.lastIndexOf("/") + 1, src.length) + ",";
	}
	
	pics = pics.substring(0, pics.length - 1);
	return pics;
}

// 隐藏和显示出/返程交通
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

<%-- 修改基本信息 --%>
function saveLineInfo(publish) {
	var txt = $('#productTag a').text();
	var pt = $('#productType');
	pt.val(txt);
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
				return false;
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
		return false;
	}
	
	if(isNaN($('#days').val()) || parseInt($('#days').val())<1){
		alert('行程天数必须是大于0的数字');
		$('#days').focus();
		return false;
	}
	if(isNaN($('#deadline').val()) || parseInt($('#deadline').val())<1){
		alert('报名截止天数必须是大于0的数字');
		$('#deadline').focus();
		return false;
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
		return false;
	}
	$('#topic').val(topics.substring(1,topics.length));
	
	var pics = getPics();
	if (pics == ""){
		alert("请至少上传一张线路图片！");
		return false;
	}
	
	var path = $('#docPath').val();
	if(!path){
		alert('请上传行程详情文件');
		return false;
	}
	
	var costInfo = $.trim(UE.getEditor('costinfo').getContent());
	var bookInfo = $.trim(UE.getEditor('bookinfo').getContent());
	if(!costInfo){
		alert('费用信息必须填写');
		return false;
	}
	if(!bookInfo){
		alert('预定须知必须填写');
		return false;
	}
	var moreParam = 'lineInfo.costinfo='+encodeURIComponent(costInfo)+
				  '&lineInfo.bookinfo='+encodeURIComponent(bookInfo)+
				  '&lineInfo.visainfo='+encodeURIComponent(UE.getEditor('visainfo').getContent())+
				  '&lineInfo.extra='+encodeURIComponent(UE.getEditor('extra').getContent())+
				  '&lineInfo.travelDocName='+$('#travelDocName').text()+
				  '&lineInfo.toplace='+toInfo +
				  '&lineInfo.travelDocPath='+$('#docPath').val();

	var routeInfo = encodeURIComponent(UE.getEditor('routeinfo').getContent());
	if(!routeInfo){
		alert('行程信息必须填写');
		$('#routeinfo').focus();
		return false;
	}
	
	if(${empty linePlanList }){
		alert('出团计划必须填写');
		return false;
	}
	
	var rs = false;
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/modifyLineInfo.do?lineInfo.supplierId=${lineInfo.supplierId}&t=" + new Date().getTime(),
		  data: $("#baseForm").serialize() +"&lineInfo.routeinfo="+(routeInfo)+ "&" + moreParam + "&lineInfo.propics=" + pics + "&lineInfo.id=" + ${lineInfo.id},
		  async:false,
		  success:function(data){
			if ("error" == data){
				alert("出错了");
			}else if("login" == data){
				window.location.href = "${pageContext.request.contextPath}/login";
			}else{
				alert("保存成功");
				if(publish){
					rs = true;
					window.location.href = "${pageContext.request.contextPath}/page/product/lineManager.jsp";
				}else
				window.location.reload();
			}
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
	return rs;
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
//实例化编辑器
var options = {
    imageUrl:UEDITOR_HOME_URL + "jsp/imageUp.jsp?lineId=${lineInfo.id}",
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


<%-- ---------------------------------------处理出团计划页签--------------------------- --%>
var CURRTR,CURRPLANID;
function openPlan(){
	OPEN.Modal('planWindow');
	
	var dates=[],d;
	<c:forEach items="${linePlanList}" var="plan">
	d = new Date();
	d.setTime(${plan.startDate.time});
	dates.push(d);
	</c:forEach>
	
	$('#dayCount').html(dates.length);
	var html='';
	for(var i=dates.length;i--;){
		var day = dates[i];
		html += '<a href="javascript:void(0)">'+day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()+'</a> ';
	}
	
	picker.selectedDateAry = dates;
	picker.fill();
	picker.show();
	
	
}
$('#openPlanBtn').click(openPlan);

function openPlan2(tr,date){
	CURRTR = tr;
	OPEN.Modal('planWindow2');
	$('#openPlan2').attr('date',date);
	//set value
	tr = $(tr);
	CURRPLANID = tr.attr('sn');
	$('#dayName').html(date);
	$('#dayPrice').val(tr.attr('price'));
	var tag = tr.attr('tag');
	if(tag!=''){
		$('#dayDiscount').closest('span').css('display','');
	}else{
		$('#dayDiscount').closest('span').css('display','none');
	}
	$('#dayDiscount').val(tr.attr('discountprice'));
	$('#dayNum').val(tr.attr('num'));
	$('#dayLimit').val(tr.attr('limit'));
	$('input[name="plan.tag"]')[0].checked=true;
	$('input[name="plan.tag"]').each(function(){
		if(this.value == tr.attr('tag')){
			this.checked=true;
			return false;
		}
	});
	
	var ps = date.split('-'); 
	picker2.date = new Date(ps[0], parseInt(ps[1])-1, ps[2], 0, 0, 0, 0);
	picker2.viewDate = new Date(ps[0], parseInt(ps[1])-1, ps[2], 0, 0, 0, 0);
	picker2.selectedDateAry = [new Date(ps[0], parseInt(ps[1])-1, ps[2], 0, 0, 0, 0)];
	picker2.fill();
	picker2.disabled = true;
	picker2.show();
}

<%-- 新增计划立即入库 --%>
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
			GROUPDAYS[day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()]={'startDate':day,'price':price,'num':num,'limit':limit};
			startDate.setDate(startDate.getDate()+1);
		}
	}else{
		for(var i=days.length;i--;){
			var day = days[i];
			GROUPDAYS[day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()]={'startDate':day,'price':price,'num':num,'limit':limit};
		}
	}
	
	<%-- 保存数据库 --%>
	var param='',l=0;
	
	for(var i in GROUPDAYS){
		var plan = GROUPDAYS[i];
		param += '&linePlanList['+l+'].startDate='+i+'&linePlanList['+l+'].adultprice2='+plan.price
		+'&linePlanList['+l+'].num='+plan.num
		+'&linePlanList['+l+'].days='+plan.limit
		+'&linePlanList['+l+'].discounttag='+(plan.tag||'');
		l++;
	}
	param = param.substring(1,param.length);
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/saveLinePlanBatch.do?lineInfo.supplierId=${lineInfo.supplierId}&lineInfo.id=${lineInfo.id}",
		  data: param,
		  async:false,
		  success:function(data){
			if ("error" == data){
				alert("出错了");
			}else if("login" == data){
				window.location.href = "${pageContext.request.contextPath}/login";
			}
			location.reload();
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
	//生成显示列表
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

function updatePlan(){
	var num = $('#dayNum').val();
	var price = $('#dayPrice').val();
	var limit = $('#dayLimit').val();
	var dayDiscount = $('#dayDiscount').val();
	
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
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/updateLinePlan.do?lineInfo.supplierId=${lineInfo.supplierId}&linePlanVO.id="+CURRPLANID,
		  data: {'linePlanVO.lineId':${lineInfo.id},'linePlanVO.discountprice':dayDiscount,'linePlanVO.days':limit,'linePlanVO.adultprice2':price,'linePlanVO.num':num,'linePlanVO.discounttag':tag},
		  async:false,
		  success:function(data){
			  //修改页面
			 /*  var tds = CURRTR.getElementsByTagName('td');
			  tds[2].innerHTML = price+'&nbsp;'+(tag=='特价'?'<span class="LB LBTE LBHA">特价</span>':tag=='尾货'?'<span class="LB LBWH LBHA">尾货</span>':'');
			  tds[3].innerHTML = num; */
			 // alert('修改成功');
			  location.reload();
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
	
	$('.IMClose').click();
}

function openLinePlans(){
	var ids='';
	var i=0;
	$('input:checked',withDrawingList).each(function(){
		ids += ','+$(this).attr('sn');
		i++;
	});
	if(!i){
		alert('请选择要开启的出团计划');
		return;
	}
	
	if(!window.confirm('确定要开启'+i+'条出团计划吗？')){
		return;
	}
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/openLinePlans.do?lineInfo.supplierId=${lineInfo.supplierId}",
		  data: {'lineInfo.id':${lineInfo.id},'planIds':ids.substring(1,ids.length)},
		  async:false,
		  success:function(data){
			  alert('修改成功');
			  location.reload();
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
}
$('#openLinePlansBtn').click(openLinePlans);

function terminateLinePlans(){
	var ids='';
	var i=0;
	$('input:checked',withDrawingList).each(function(){
		ids += ','+$(this).attr('sn');
		i++;
	});
	if(!i){
		alert('请选择要终止的出团计划');
		return;
	}
	
	if(!window.confirm('确定要终止'+i+'条出团计划吗？')){
		return;
	}
	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/terminateLinePlans.do",
		  data: {'lineInfo.id':${lineInfo.id},'planIds':ids.substring(1,ids.length)},
		  async:false,
		  success:function(data){
			  alert('修改成功');
			  location.reload();
		  },
		  error:function(){
			  alert("服务器断访问出错");
		  }
	});
}
$('#terminateLinePlansBtn').click(terminateLinePlans);

function deleteLinePlans(){ 
	var ids='';
	var i=0;
	$('input:checked',withDrawingList).each(function(){
		ids += ','+$(this).attr('sn');
		i++;
	});
	if(!i){
		alert('请选择要删除的出团计划');
		return;
	}
	
	if(!window.confirm('确定要开启'+i+'条出团计划吗？')){
		return;
	}

	$.ajax( {
		  type: "post",
		  url: "${pageContext.request.contextPath}/delelePlans.do?t=" + new Date().getTime(),
		  data: {'lineId' : ${lineInfo.id}, 'planIds': ids.substring(1, ids.length)},
		  async:false,
		  success:function(data){
			 if (data == "error") {
			 	alert("删除失败");
			}else if (data == "nologin") {
				window.location.href = "${pageContext.request.contextPath}/login";
			}else if (data == "invalid") {
				alert("您的帐号状态不可用");
			}else{
				alert("删除成功");
				location.reload();
			}
		  },
		  error:function(){
			  alert("服务器访问出错");
		  }
	});
}

function checkAll(){
	var checked = document.getElementById("checkAll").checked;
	$('#withDrawingList :checkbox').each(function(){
		this.checked = checked;
	});
}
</script>
<script id="tmpl" type="text/x-fn-tmpl">
	<#
		for(var i in data){
			var plan = data[i];
			var day = plan.startDate;
	#>
	<tr sn="<#=plan.id#>">
		<td><input sn="<#=plan.id#>" class="VMid BNo" type="checkbox" name="checkbox"></td>
		<td><#=day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()#></td>
		<td><#=plan.price#>&nbsp;<#=plan.tag==1?'<span class="LB LBTE LBHA">特价</span>':plan.tag==2?'<span class="LB LBWH LBHA">尾货</span>':''#></td>
		<td><#=plan.discountprice#></td>
<td><#=plan.num#></td>
		<td><#=plan.limit#></td>
		<td><#=plan.state==1?'正常':'终止'#></td>
		<td><a href="javascript:void(0)" onclick="openPlan2(this.parentNode.parentNode,'<#=day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate()#>')">修改</a></td>
	</tr>
	<#}#>
</script>
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
										出团前<input class="WMin IN" maxlength="3" value="${lineInfo.deadline }" type="text" id="groupLimit"/>天
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
				<a href="javascript:void(0)" onclick="updatePlan()" class="But ButA">确认</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

//多选日历
var picker = new $kit.ui.DatePicker.NMonths();
picker.init();
$kit.el('#datepicker').appendChild(picker.picker);
picker.show();
picker.disableNav = true;
picker.ev({
	ev : 'change',
	fn : function(e) {
		var days = picker.selectedDateAry;
		if($('input[name="start"]:checked').val()){
			var day = days[0];
			$('#groupStartDay').val(day.getFullYear()+"-"+(day.getMonth()+1)+"-"+day.getDate());
		}
		
		var html='';
		$('#dayCount').html(days.length);
	}
});

var picker2 = new $kit.ui.DatePicker({canMultipleChoose : false});
picker2.init();
$kit.el('#datepicker2').appendChild(picker2.picker);

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