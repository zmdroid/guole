<%@page import="com.guoleMIS.util.Config"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.tts800.com/fnx" prefix="fnx" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>线路详细页</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<jsp:include page="../../header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style type="text/css">
.PostPic li{display:inline-block;margin:3px}
.PostPic li img{border:1px solid #EEE;padding:3px}
.PostPic li b{display:block;cursor:pointer;position:absolute;width:20px;height:20px;background:#F60;color:#FFF;text-align:center}
</style>
<link href="${pageContext.request.contextPath}/css/Public.css" rel="stylesheet" type="text/css">
<style>
#datepicker2{padding:10px 0}
#datepicker2 table{
	border- spacing: 1px;
	border- collapse: separate;
}
#datepicker2 table td{width:50px;padding:3px;border:1px solid #EEE;height:38px;-webkit-border-radius: 0px;
-moz-border-radius: 0px;
border-radius: 0px;color:#aaa;}
#datepicker2 .datepicker td {
	position:relative;
	text-align: left;
}
#datepicker2 .datepicker thead tr:first-child th:hover{background:#FFF}
#datepicker2 .datepicker td.active{background:#F0F8FF;color:#333;text-shadow:none}
#datepicker2 .datepicker td.day:hover{background:#F9F9F9}
#datepicker2 .switch,
#datepicker2 .datepicker th{padding:3px 17px;font-size:14px}
#datepicker2 .datepicker thead{border:1px solid #EEE;}
#datepicker2 .datepicker:before{content: '';
display: none;
border:0;
position: absolute;
top: 0;
left:0;}
</style>
<script src="${pageContext.request.contextPath}/js/multiDatePicker/kit.js"></script>
<!--[if IE]>
<script src="${pageContext.request.contextPath}/js/multiDatePicker/ieFix.js"></script>
<![endif]-->
<script src="${pageContext.request.contextPath}/js/multiDatePicker/datepicker.js"></script>
</head>
<body>
	<div id="PageBody">
		<div class="WAll"> 
		<div class="MainBox">			
			<div class="BoxA ">				
				<span class="F14 FB FF CB" style="margin-right:20px">线路预览</span> 
				<c:if test="${param.pub==1 && lineInfo.state!='4'}">
					<a href="javascript:;" onclick="publishLine()" class="But ButB" style="color:#FFF">确定发布</a>
				</c:if>	
				<a href="javascript:;" onclick="window.close()" class="But ButA" style="color:#FFF">关闭</a>
			</div>
			<div class="Box">
				<div class="LineBox PR">
					<div class="Stamp ${lineInfo.lineType == '1' ? "StampB" : (lineInfo.lineType == '2' ? "StampA" : "StampC")}"></div>
					<h1 class="LineTi">
						${fnx:decodeText(lineInfo.name)}
					</h1>
					<div class="LineInfo">
						<div class="FR LineR">
							<table class="BTable TableL" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="TTi CA">线路编号</td>
									<td>${lineInfo.id}</td>
								</tr>
								<tr>
									<td class="TTi CA">同行价</td>
									<td>
										<span class="FF F20 CB">
											<span id="lowestPrice"></span>元
										</span>  起
									</td>
								</tr>
								<tr>
									<td class="TTi CA">行程天数</td>
									<td>${lineInfo.days}天<c:if test="${lineInfo.nights != 0}">${lineInfo.nights}夜</c:if>  <c:if test="${lineInfo.deadline != 0}">提前${lineInfo.deadline}天报名</c:if></td>
								</tr>
								<tr>
									<td class="TTi CA">出发城市</td>
									<td>
										<span class="LBor ">${lineInfo.fromplace}</span>
										<span class="CA ML">到达城市</span>
										<script type="text/javascript">
											var toplace = "${lineInfo.toplace}".split(",");
											var html = "";
											for (var i = 0; i < toplace.length; i++) {
												html += '<span class="LBor  MR" title="'+ toplace[i] +'">'+ toplace[i].split(' ')[0] +'</span>';
											}
											document.write(html);
										</script>
									</td>
								</tr>
								<c:if test="${lineInfo.lineType != 3}">
									<tr>
										<td class="TTi CA">交通方式</td>
										<td>
											<span class="LBor">去：${lineInfo.toTransport}</span>
											<span class="LBor ML">回：${lineInfo.fromTransport}</span>
										</td>
									</tr>
								</c:if>
								<tr>
									<td class="TTi CA VT">产品特色</td>
									<td><div class="OH WW WB" style="height:133px">${fnx:decodeText(lineInfo.features)}</div></td>
								</tr>
								<tr>
									<td class="TTi CB VT">注意事项</td>
									<td><div class="OH CB WW WB" style="height:133px">${fnx:decodeText(lineInfo.attention)}</div></td>
								</tr>
							</table>
							<div class="Contact">
								<h1>该产品联系方式</h1>
								<ul>
									<li><span class="CA">联系人：</span> ${lineInfo.linker}</li>
									<li><span class="CA">联系电话：</span>${lineInfo.linkphone}</li>
								</ul>
							</div>
						</div>
						<div class="FL LineL">
							<!--图片展示-->
							<div class="CommImg">
								<div class="CommImgView BA">
									<div class="FF PicPrompt PA">支持键盘← →键翻阅图片 <span class="XW PicPromptClose Cur"><b></b></span></div>
									<ul>
										<c:forEach items="${lineInfo.pics}" var="pic" varStatus="cou">
											<li id="img${cou.count}" class="DisNo">
												<a href="javascript:void(0)" rel="${imgUrl}<%=Config.getInstance().get("lineUrl")%>/${pic}" class="PicPreview">
													<img src="${imgUrl}<%=Config.getInstance().get("lineUrl")%>/${pic}"/>
												</a>
											</li>
										</c:forEach>
									</ul>
								</div>
								<div class="CommImgThumb">
									<div class="ImgBut ImgLeft"></div>
									<div class="CommImgThumbBox">
										<ul>
											<c:forEach items="${lineInfo.pics}" var="pic" varStatus="cou">
												<li><a rel="img${cou.count}" href="javascript:;"><img src="${imgUrl}<%=Config.getInstance().get("lineUrl")%>/${pic}"/></a></li>
											</c:forEach>
										</ul>
									</div>
									<div class="ImgBut ImgRight"></div>
								</div>
							</div>
							<!--图片展示 end-->
							<div id="datepicker2"></div>
						</div>
						<div class="Cle"></div>
					</div>
				</div>
				<div>
					<div class="FR MainM">
						<!--优质线路推荐-->
						<div class="LBoxA">
							<div class="LBTi">优质线路推荐</div>
							<div class="LBCon">
								<ul class="RecList">
									
								</ul>
							</div>
						</div>
						<!--优质线路推荐 end-->
					</div>
					<div class="FL MainC">
					<!--行程概况-->
					<div class="OutlineBox">
						<div class="Title">
							<div class="TiB LineTab">
								<ul>
									<li class="Current"><a href="javascript:;" class="">该线路价格趋势图</a></li>
									<li><a href="javascript:;" class="">行程概况</a></li>
									<li><a href="javascript:;" class="">费用说明</a></li>
									<li><a href="javascript:;" class="">预订须知</a></li>
								</ul>
							</div>
						</div>
						<div class="OutlineCon">
							<div class="Ti LineTabTi">该线路价格趋势图(鼠标按住线路可拖动)</div>
							<div class="OlineC">
								<div id="container" style="height: 300px; width: 740px"></div>
							</div>
							<div class="Ti LineTabTi">行程概况</div>
							<div class="OlineC">
								<iframe style="background:none;" src="about:blank" id="routeInfo" frameborder="0" marginheight="0" marginwidth="0"
								onload="var TH=this;setTimeout(function(){TH.height=Math.max(TH.contentWindow.document.body.scrollHeight,TH.contentWindow.document.documentElement.offsetHeight);},100)" width="100%" scrolling="no">
									${lineInfo.routeinfo}
								</iframe>
								<script type="text/javascript">
									var ri = document.getElementById('routeInfo');
									var doc = ri.contentWindow.document;
									doc.open();
									doc.write(ri.innerHTML.replace(/&gt;/gm,'>').replace(/&lt;/gm,'<').replace(/&amp;/gm,'&'));
									doc.close();
								</script>
							</div>
							<div class="Ti LineTabTi">费用说明</div>
							<div class="OlineC">
								<iframe style="background:none;" src="about:blank" id="costinfo" frameborder="0" marginheight="0" marginwidth="0"
								onload="var TH=this;setTimeout(function(){TH.height=Math.max(TH.contentWindow.document.body.scrollHeight,TH.contentWindow.document.documentElement.offsetHeight);},100)" width="100%" scrolling="no">
									${lineInfo.costinfo}
								</iframe>
								<script type="text/javascript">
									var fri = document.getElementById('costinfo');
									var fdoc = fri.contentWindow.document;
									
									fdoc.open();
									fdoc.write(fri.innerHTML.replace(/&gt;/gm,'>').replace(/&lt;/gm,'<').replace(/&amp;/gm,'&'));
									fdoc.close();
								</script>
							</div>
							<div class="Ti LineTabTi">预订须知</div>
							<div class="OlineC">
								<iframe style="background:none;" src="about:blank" id="bookinfo" frameborder="0" marginheight="0" marginwidth="0"
								onload="var TH=this;setTimeout(function(){TH.height=Math.max(TH.contentWindow.document.body.scrollHeight,TH.contentWindow.document.documentElement.offsetHeight);},100)" width="100%" scrolling="no">
									${lineInfo.bookinfo}
								</iframe>
								<script type="text/javascript">
									var yri = document.getElementById('bookinfo');
									var ydoc = yri.contentWindow.document;
									ydoc.open();
									ydoc.write(yri.innerHTML.replace(/&gt;/gm,'>').replace(/&lt;/gm,'<').replace(/&amp;/gm,'&'));
									ydoc.close();
								</script>
							</div>
						</div>
					</div>
					<!--行程概况 end-->
				</div>
					<div class="Cle"></div>
				</div>
			</div>
			<c:if test="${param.pub==1 && lineInfo.state!='4'}">
				<a href="javascript:;" onclick="publishLine()" class="But MTB ButB" style="color:#FFF">确定发布</a>
			</c:if>
			<a href="javascript:;" onclick="window.close()" class="But MTB ButA" style="color:#FFF">关闭</a>
		</div>
	</div>
	</div>

	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
</body>
<script type="text/javascript">
function replaceHtml(str) {
	return str.replace(/</ig, "&lt;").replace(/>/ig, "&gt;");
}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/highstock.js"></script>
<script type="text/javascript">
function publishLine(){
		$.ajax( {
			  type: "post",
			  url: "${pageContext.request.contextPath}/lineSelling.do",
			  data: "lineIds=${lineInfo.id}&lineInfo.supplierId=${lineInfo.supplierId}",
			  success:function(data){
				if ("error" == data){
					alert("上架失败,请检查该线路信息是否完整");
				}else if("login" == data){
					window.close();
				}else{
					alert("发布成功");
					window.close();
				}
			  },
			  error:function(){
				  alert("服务器断访问出错");
			  }
		});
}

<%-- 初始化日历 --%>
var dates=[],d,planData={};
<c:forEach items="${linePlanList}" var="plan">
<c:if test="${plan.state==1}" >
d = new Date();
d.setTime(${plan.startDate.time});
dates.push(d);
planData[d.getFullYear()+"-"+d.getMonth()+"-"+d.getDate()]={price:'${(plan.discountprice>0 && plan.discountprice<plan.adultprice2)?plan.discountprice:plan.adultprice2}',num:'${plan.num}',tag:'${plan.discounttag}'};
</c:if>
</c:forEach>
dates.sort(function(a,b){
	return a.getTime()-b.getTime();
});
var picker2 = new $kit.ui.DatePicker({
	date : dates[0],
	canMultipleChoose : false,
	planData:planData<%-- 日历数据 --%>
});
picker2.init();
$kit.el('#datepicker2').appendChild(picker2.picker);
//picker2.date = new Date(ps[0], parseInt(ps[1])-1, ps[2], 0, 0, 0, 0);
//picker2.viewDate = new Date(ps[0], parseInt(ps[1])-1, ps[2], 0, 0, 0, 0);
picker2.selectedDateAry = dates;
picker2.fill();
picker2.disabled = true;
picker2.show();
var A="Active";
	$("#viewAllDates").click(function(){
		var allDates = $("#allDates");
		if (allDates.is(":visible")) {
			allDates.hide();
		}else{
			allDates.show();
		}
	});
	
	$(document).ready(function(){
		$(".CommImgView li").eq(0).show();
		$(".CommImgThumb").find("li").first().addClass(A).end().find("a").live("click",function(){
			$(this).parent().addClass(A).siblings().removeClass(A);
			if ( $("#" + this.rel).is(":hidden") ) {
				$(".CommImgView li").hide();
				$("#" + this.rel).fadeIn();
			}
		});
		function ShellW(th){
			var $Th = $(th),
				_Width = $Th.find(">*").width(),
				_Count = $Th.find(">*").size();
			return $Th.css("width",(_Width+6)*_Count),
			this;
		}
		ShellW($(".CommImgThumb ul"));
		function ImageTurn(th,id){
			var $Th=$(th),
				_Next = $(".ImgRight"),
				_Prev = $(".ImgLeft"),
				_Span=0,
				_UlElement = $Th.find("ul");
			var FnThumbWid=function(dir){
				var _BoxWidth=_UlElement.parent().width(),//外框宽度
					_Width=_UlElement.width(),//元素总宽度
					_Position=_UlElement.position(),//外框当前位置
					_LiElement=$Th.find('li[class='+A+']'),//当前元素
					_Index=_LiElement.index(),//当前元素索引值
					_OffsetLeft=$Th.offset().left,//外框距页面边框位置
					_LiWidth=_LiElement.width(),//元素单个宽度
					_LiOffsetLeft =_LiElement.offset().left;//当前元素距页面边框位置
				if(dir=="r"){
					if(_Position.left<=0){
						$Th.find('li').eq($Th.find('li[class='+A+']').index()+1).addClass(A).siblings().removeClass(A);
						var _Rel=$Th.find('li[class='+A+']').find("a").attr("rel");
						var $Rel=$(document.getElementById(_Rel));
						if($Rel.is(":hidden") ) {
							$(id+" li").hide();
							$Rel.stop(!0,!1).fadeIn();
						};
						if((_LiOffsetLeft+_LiWidth)>(_OffsetLeft+_BoxWidth)){
							var _Left=_Width-_BoxWidth+_Position.left;
							_Left>_BoxWidth && (_Span=_BoxWidth/1.5);
							_Left<_BoxWidth && (_Span=_Left-1);
							_UlElement.stop(!0,!1).animate({left:"-="+_Span},8E2,EOQ);
						};
						if((_Width-_BoxWidth+_Position.left)==1){
							_UlElement.Rebound('Left',"-=50",_Position.left);
						};
					};
				}else if(dir=="l"){
					if(!_Index==0){
						$Th.find('li').eq($Th.find('li[class='+A+']').index()-1).addClass(A).siblings().removeClass(A);
						var _Rel=$Th.find('li[class='+A+']').find("a").attr("rel");
						var $Rel=$(document.getElementById(_Rel));
						if($Rel.is(":hidden") ) {
							$(id+" li").hide();
							$Rel.stop(!0,!1).fadeIn();
						};
					};
					if(_LiOffsetLeft<_OffsetLeft){
						if(-_Position.left<_BoxWidth){
							_Span=-_Position.left;
						}else if(-_Position.left>_BoxWidth){
							var _Left=_Width-_BoxWidth-_Position.left;
							_Left>_BoxWidth && (_Span=_BoxWidth/1.5);
							_Left<_BoxWidth && (_Span=_Left+1);
						};
						_UlElement.stop(!0,!1).animate({left:"+="+_Span},8E2,EOQ);
						if(_Position.left==0){
							_UlElement.Rebound('Left',"+=50",_Position.left);
						};
					};
				};
			};
			_Next.live('click',function(){
				FnThumbWid('r');
			});
			_Prev.live('click',function(e){
				FnThumbWid('l');
			});
			$(document).unbind("keyup").live("keyup",function(event){
				var _Evevt = event.target||event.srcElement;
				if(_Evevt.tagName.toLocaleUpperCase()=="INPUT"||_Evevt.tagName.toLocaleUpperCase()=="TEXTAREA"||(_Evevt.tagName.toLocaleUpperCase()=="DIV" && _Evevt.contentEditable=='true'))return;
				if(event.keyCode == 39){//右
					_Next.click();
				}else if (event.keyCode == 37){//左
					_Prev.click();
				};
			});
		}
		ImageTurn($(".CommImgThumbBox"),".CommImgView");
		function ImgSize(th,scaling,MaxWidth,MaxHeight){
			return th.each(function(){
				var $Th=$(th),
					_Src=$Th.attr("src"),
					_Image=new Image();
				_Image.src=_Src;
				//自动缩放图片
				var FnAutoScaling=function(){
					if(scaling){
						if(_Image.width>0 && _Image.height>0){
							if(_Image.width/_Image.height>=MaxWidth/MaxHeight){
								if(_Image.width>MaxWidth){
									$Th.width(MaxWidth).height((_Image.height*MaxWidth)/_Image.width).css({
										"margin-top":(MaxHeight-$Th.height())/2,
										"margin-left":(MaxWidth-$Th.width())/2
									});
								}else{
									$Th.width(_Image.width).height(_Image.height).css({
										"margin-top":(MaxHeight-$Th.height())/2,
										"margin-left":(MaxWidth-$Th.width())/2
									});
								}
							}else{
								if(_Image.height>MaxHeight){
									$Th.height(MaxHeight).width((_Image.width*MaxHeight)/_Image.height).css({
										"margin-top":(MaxHeight-$Th.height())/2,
										"margin-left":(MaxWidth-$Th.width())/2
									});
								}else{
									$Th.width(_Image.width).height(_Image.height).css({
										"margin-top":(MaxHeight-$Th.height())/2,
										"margin-left":(MaxWidth-$Th.width())/2
									});
								}
							}
						}
					}
				};
				if(_Image.complete){
				 FnAutoScaling();
				 return;
				}
				$(th).attr("src","about:blank");
				$Th.hide();
				$(_Image).load(function(){
					FnAutoScaling();
					$Th.attr("src",this.src).show();
				});
			});
		}
			ImgSize($(".CommImgView img"),true,400,260);
		$(".PicPreview").live("click",function(){
			$(this).ImgShow();
		});
		$(".FDComList li").live("mouseenter",function(){
			$(this).find(".Delete").show();
		}).live("mouseleave",function(){
			$(this).find(".Delete").hide();
		});
	});
	
	/**
	 * 收藏线路
	 * @param {Object} id
	 */
	function favLine(id) {
		$.ajax({
			url: '${pageContext.request.contextPath}/favLine.do?time=' + new Date().getTime(),
			data: {lineId: id},
			success: function(data){
				if ("nologin" == data) {
					window.location.href = "${pageContext.request.contextPath}/login";
				}else if ("error" == data){
					alert("收藏失败");
				}else{
					$("#favBtn").hide();
					alert("收藏成功");
				}
			},
			error: function(){
				alert("服务端出错，收藏线路失败");
			}
		});
	}
	//加载线路推广
	function loadLineRanking() {
		var url = '${rankingDir}/lineRanking.json?callback=?&time=' + new Date().getTime();
		$.getJSON(url,jsonfeed=function(data) {
			
			var i = 0, length = data.totalCount, item;
			var html = "";
			var pics;
			if(length > 0){
				for(; i < length; i++) {
					 item = data.lines[i];
					 if(i < 3){
						 html += '<li class="RecHot">';
						 html += '<div class="Number NumberTop">0'+(i+1)+'</div>';
					 }else if(i < 10){
						 html += '<li>';
						 html += '<div class="Number">0'+(i+1)+'</div>';
					 }else{
						 html += '<li>';
						 html += '<div class="Number">'+(i+1)+'</div>';
				     }
					 if(i < 3 && item.propics != null && item.propics != ""){
						   pics = item.propics.split(",");
					       html +='<div class="Pic"><a href="javascript:pupLineWindow('+item.id+');"><img src="${lineImageResurl}/'+pics[0]+'" width="80" height="50"/></a></div>';
					 }
					 html +='<div class="Title"><a href="javascript:pupLineWindow('+item.id+');">'+ replaceHtml(decodeURIComponent(item.name))+'</a></div>\
					 <div class="CA TR"><span class="FF F16 CB">&nbsp;</span></div></li>';
				 }
				 $('.RecList').append(html);
			}
		});
	};
	
	//loadLineRanking();
	
	
	<%-- 加载趋势图 --%>
	<%-- 至少1个月的数据 --%>
	var scData=[];
	<c:forEach items="${linePlanList}" var="plan">
	<c:if test="${plan.state==1}" >
	scData.push({name:'<fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>',x:${plan.startDate.time},y:${(plan.discountprice>0 && plan.discountprice<plan.adultprice2)?plan.discountprice:plan.adultprice2}});
	</c:if>
	</c:forEach>

	scData.sort(function(a,b){
		return a.x-b.x;
	});
	
	Highcharts.setOptions({
		lang: {
			numericSymbols:['千', 'M', 'G', 'T', 'P', 'E'],
			rangeSelectorZoom:'范围',
			loading:'加载中...',
			months:['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
		}
	});
	$('#container').highcharts('StockChart', {
		rangeSelector : {
			enabled:true,
			buttons: [{
				type: 'day',
				count: 1,
				text: '1天'
			},{
				type: 'week',
				count: 2,
				text: '1周'
			}],
			inputEnabled:false
		},
		scrollbar:{
			enabled:true
		},
		navigator:{
			enabled:true,
			xAxis:{
				ordinal:false,
	        	type: 'datetime',
	        	tickInterval:24 * 3600 * 1000*7,
				dateTimeLabelFormats:{
	        		day: '%m.%d',
	        		week: '%m.%d',
	        		month: '%m',
	        		millisecond:'%Y<br/>%m-%d'
	        	}
			}
		},
        yAxis: {
            title: { 
                text: '价格(元)'
            }
        }, 
        xAxis:{
        	ordinal:false,
        	type: 'datetime',
        	tickInterval:24 * 3600 * 1000,
        	dateTimeLabelFormats:{
        		day: ' ',
        		millisecond:'%Y<br/>%m-%d'
        	}
        },
		series : [{
			name : '同行价',
			data : scData,
			tooltip: {
				valueDecimals: 1
			},
			//shadow : true,
			marker : {
				enabled : true,
				radius : 3
			}
		}],
		credits:{
			enabled:false
		}
	});
	
	<%-- 设置同行价 --%>
	scData.sort(function(a,b){
		return a.y-b.y;
	});
	$('#lowestPrice').html(scData[0].y);
</script>
</html>