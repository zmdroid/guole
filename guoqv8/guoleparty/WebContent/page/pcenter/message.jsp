<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="copyright" content="wohunle.com">
<meta name="description" content="我们结婚了,我婚了网，您身边的婚嫁专家；婚礼筹备，特价结婚购物，结婚攻略，一站式结婚服务。">
<meta name="keywords" content="我们结婚了,我婚了，婚嫁购物推荐,婚礼测试，选日子，结婚计划，结婚预算，结婚攻略,结婚商品，一站式结婚购物，婚纱摄影，钻戒首饰，婚庆公司，婚纱礼服，婚宴酒店，婚礼用品，婚鞋，婚包，新郎礼服，新娘妆扮。">
<title>个人中心-消息中心</title>
</head>
<body>
消息中心
	<br>
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>
<!--PageBody-->
<div id="PageBody">
	<div class="SinkBG">
		<div class="WAll">
	  		<!--FamilyHeader-->
	  		<!-- FamilyHeader end -->
			<div class="PartTwoRow MainBody MainCB BRTLR">
				<div class="SideBar PartR FR">
					<dl class="BorB SideBox">
						
					</dl>
				</div>
				<div class="PartL FL">
					<div class="MainHeader">
						<b class="Text">我的通知</b>
					</div>
					<div class="MainContent">
						<div class="TabsCon">
							<div>
								<ul class="NoticeList">
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="Cle"></div>
			</div>
		</div>
	</div>
</div>
<!--PageBody end-->
</body>
<%@include file="/js.jsp" %>
<script>
var pageLength=4;<%-- pageLength当前页前后记录数 --%>

function fetchMessage(pageIndex,type){
	var container = $('.NoticeList');
	container.html('<div class="BlankContent" >\
				<div class="Con">家庭信箱还没有通知哦~</div>\
				</div>');
	currPageIndex = pageIndex = pageIndex||1;
	$.ajax({
        url: '${pageContext.request.contextPath}/getMessage.do',
        type: 'get',
        async:false,
        dataType:"json",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        data: {"pageIndex":currPageIndex,
        		"time":new Date().getTime()
        },
        success: function(rs){
        	if(!rs || !rs.length)return;
        	var pageCount = rs.shift();
        	if(!pageCount)return;
        	var currPageIndex = pageIndex;
        	var con = '';
        	rs = rs[0];
        	if(rs)
        	for(var i=0,l=rs.length;i<l;i++){
        		con += '<li><div class="FR CGray"><a onclick="del(this,'+rs[i].id+')" href="javascript:void(0)">删除</a></div>\
        					<div class="FL Name">'+rs[i].fromBy+'</div>';
        					var date = rs[i].publishTime;
        					con+='<div class="Text"><p>'+' <span class="CGray">('+(date.year+1900)+'.'+(date.month+1)+'.'+date.date+' '+date.hours+':'+date.minutes+')</span></p>\
								<p class="CGray">';
								con+=rs[i].content.replace(/(?:href=['|"]\/)/mg,"class=\"CLA\" href='${pageContext.request.contextPath}/")+'</p>\
							</div><div class="Cle"></div>\
						</li>';
        	}
        	container.text('');
        	container.append(con);
        	<%--	-------------------分页开始--------------------	 --%>
			if(pageCount > 1){
				var page = '<div class="Pages">';
				if(currPageIndex<2){
					page += '<a class="Disabled" href="javascript:void(0)">上页</a>&nbsp;';
				}else{
					page += '<a href="javascript:fetchMessage('+(currPageIndex-1)+')">上页</a>&nbsp;';
				}
				<%-- 出现首页导航 --%>
				if(currPageIndex>(pageLength+1)){
					page += '<a href="javascript:fetchMessage(1)">1...</a>&nbsp;';
					for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){
						var tmp = j+1;
						page += '<a href="javascript:fetchMessage('+tmp+')">'+tmp+'</a>&nbsp;';
					}
				}else{
					for(var j=1;j<currPageIndex;j++){
						page += '<a href="javascript:fetchMessage('+j+')">'+j+'</a>&nbsp;';
					}
				}
				page += '<a class="Active" href="javascript:void(0)">'+currPageIndex+'</a>&nbsp;';
				<%-- 出现末页导航 --%>
				if(pageCount-pageLength>currPageIndex){
					for(var j=1;j<=pageLength;j++){
						var tmp = currPageIndex+j;
						page += '<a href="javascript:fetchMessage('+tmp+')">'+tmp+'</a>&nbsp;';
					}
					page += '<a href="javascript:fetchMessage('+pageCount+')">...'+pageCount+'</a>&nbsp;';
				}else{
					for(var j=1;j<=(pageCount-currPageIndex);j++){
						var tmp = currPageIndex+j;
						page += '<a href="javascript:fetchMessage('+tmp+')">'+tmp+'</a>&nbsp;';
					}
				}
				
				if(currPageIndex==pageCount){
					page += '<a class="Disabled" href="javascript:void(0)">下页</a>&nbsp;';
				}else{
					page += '<a href="javascript:fetchMessage('+(currPageIndex+1)+')">下页</a>';
				}
				page += '</div>';
				container.append(page);
				<%--	-------------------分页结束--------------------	 --%>
        }
        }
	});
	}
	
	function del(node,mid){
 			$.get('${pageContext.request.contextPath}/deleteMessage.do', {'messageNo':mid,'r':Math.random()}, function(rs){
				if ("ok" == rs){
					fetchMessage(1,1);
					alert('信息已删除');
				}
			});
	}
	
	<%-- 根据请求参数获取第一页数据 --%>
	fetchMessage(1,1);
</script>
</html>