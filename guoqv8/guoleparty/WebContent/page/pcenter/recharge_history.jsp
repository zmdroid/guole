<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户中心</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>

<body>
<!--Header-->
	<jsp:include page="/page/pcenter/humanMenu.jsp">
		<jsp:param value="index" name="type" />
	</jsp:include>
<!--Header end--> 
<!--PageBody-->
<div id="PageBody">
	<div class="WAll">
		<div class="ManBox MainBG">
			
			<div class="FR Right">
				<div class="RBody">
					<!--面包屑-->
					<div class="Breadcrumbs">
						<a href="">首页</a> >
						<a href="">旅财金账户</a> >
						充值记录
					</div>
					<!--面包屑 end-->
					<!--查询-->
					<div class="Inquiry">
						<table class="InTable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="CA">起止日期:</td>
								<td>
									<span class="IBoxTip">
										<input class="IEnter WMid" type="text" id="timeRange1">
										<label class="IExplain">
											yyyy-MM-dd
										</label>
									</span>
									<span class="IBoxTip">
										<input class="IEnter WMid" type="text" id="timeRange2">
										<label class="IExplain">
											yyyy-MM-dd
										</label>
									</span>
								</td>
								<td class="CA"></td>
								<td><a href="javascript:void(0)" onclick="loadData()" class="But">筛选</a></td>
							</tr>
						</table>
					</div>
					<!--查询 end-->
					<!--检索-->
					<div class="Retrieval">
						<dl>
							<dt>充值方式:</dt>
							<dd id="rechargeTypes">
								<a href="javascript:void(0)" class="Active" onclick="changeType(0)">全部</a>
								<a href="javascript:void(0)" onclick="changeType(1)">支付宝</a>
								<a href="javascript:void(0)" onclick="changeType(2)">线下银行汇款</a>
							</dd>
						</dl>
						<dl>
							<dt>状态:</dt>
							<dd id="rechargeState">
								<a href="javascript:void(0)" class="Active" onclick="changeState(-1)">全部</a>
								<a href="javascript:void(0)" onclick="changeState(0)">申请</a>
								<a href="javascript:void(0)" onclick="changeState(1)">成功</a>
								<a href="javascript:void(0)" onclick="changeState(2)">失败</a>
							</dd>
						</dl>
					</div>
					<!--检索 end-->
					<div class="ManList">
						<div class="Title">
							<div class="FR">
								<a href="${pageContext.request.contextPath}/pcenter/recharge" class="But">充值</a>
							</div>
						</div>
						<div class="List" id="container">
							
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>
<!--PageBody end--> 
<!--Footer-->
<!--Footer end-->
<%@include file="/js.jsp" %>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/fn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/Script/util.js"></script>
<script id="dataTmpl" type="text/x-fn-tmpl">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th scope="col">充值单号</th>
			<th scope="col">运营商</th>
			<th scope="col">充值方式</th>
			<th scope="col">所属机构</th>
			<th scope="col">帐号名称</th>
			<th scope="col">充值金额</th>
			<th scope="col">充值时间</th>
			<th scope="col">状态</th>
		</tr>
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var vo = data[i];
		#>
		<tr>
			<td><a target="_new" href="${pageContext.request.contextPath}/pcenter/rechargeDetail/<#=vo.rechargeId#>"><#=vo.rechargeId#></a></td>
			<td>平台</td>
			<td>
				<#=convertTradeChannel(vo.type>>0)#>
			</td>
			<td><#=vo.corName#></td>
			<td><#=vo.userName#></td>
			<td><span class="CD"><#=vo.moneynum#></span></td>
			<td class="CA"><#=convertDate(vo.optime)#></td>
			<td class="CA"><#=convertWithdrawingState(vo.state>>0)#></td>
		</tr>
		<#}#>
	</table>
	<!--列表 end-->
	<#if(pageCount > 1){#>
		<div class="Pages">
			<#if(currPageIndex<2){#>
				<a class="Disabled" href="javascript:void(0)">上页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex-1#>)">上页</a>&nbsp;
			<#}#>
			<%-- 出现首页导航 --%>
			<#if(currPageIndex>(pageLength+1)){#>
				<a href="javascript:loadData(1)">1...</a>&nbsp;
				<#for(var k=0,j=currPageIndex-pageLength-1;k<pageLength;j++,k++){#>
					<#var tmp = j+1;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}else{#>
				<#for(var j=1;j<currPageIndex;j++){#>
					<a href="javascript:loadData(<#=j#>)"><#=j#></a>&nbsp;
				<#}#>
			<#}#>
			<a class="Active" href="javascript:void(0)"><#=currPageIndex#></a>&nbsp;
			<%-- 出现末页导航 --%>
			<#if(pageCount-pageLength>currPageIndex){#>
				<#for(var j=1;j<=pageLength;j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
				<a href="javascript:loadData(<#=pageCount#>)">...<#=pageCount#></a>&nbsp;
			<#}else{#>
				<#for(var j=1;j<=(pageCount-currPageIndex);j++){#>
					<#var tmp = currPageIndex+j;#>
					<a href="javascript:loadData(<#=tmp#>)"><#=tmp#></a>&nbsp;
				<#}#>
			<#}#>
			
			<#if(currPageIndex==pageCount){#>
				<a class="Disabled" href="javascript:void(0)">下页</a>&nbsp;
			<#}else{#>
				<a href="javascript:loadData(<#=currPageIndex+1#>)">下页</a>
			<#}#>
			</div>
		<#}#>
</script>
<script type="text/javascript">
	//测试
	var map = {'0':{'出纳通过':2,'出纳拒绝':1,'取消':'D'},
	           '2':{'会计拒绝':3,'完成':9}};
	function change(orderNo,state){
		if(state==-1)return;
		$.post("${pageContext.request.contextPath}/testOpRecharge.do",{'rechargeVO.orderNo':orderNo,'state':state},function(){
			loadData();
		});
	}
	

	var pageCount,pageLength=4,currPageIndex=1, timeRange, moneyRange,types,state;
	function changeType(t){
		if(t==1){
			types = t;
			$('#rechargeTypes a').removeClass('Active');
			$('#rechargeTypes a:nth-child(2)').addClass('Active');
		}else 
		if(t==2){
			types = t;
			$('#rechargeTypes a').removeClass('Active');
			$('#rechargeTypes a:nth-child(3)').addClass('Active');
		}else 
		if(t==0){
			types=null;
			$('#rechargeTypes a').removeClass('Active');
			$('#rechargeTypes a:nth-child(1)').addClass('Active');
		}
		loadData();
	}
	function changeState(t){
		$('#rechargeState a').removeClass('Active');
		if(t==-1){
			state=null;
			$('#rechargeState a:nth-child(1)').addClass('Active');
		}else
		if(t==0){
			state = t;
			$('#rechargeState a:nth-child(2)').addClass('Active');
		}else  if(t==1){
			state = t;
			$('#rechargeState a:nth-child(3)').addClass('Active');
		}else  if(t==2){
				state = t;
				$('#rechargeState a:nth-child(4)').addClass('Active');
			} 
		loadData();
	}
	function loadData(pageIndex){
		
		$('#container').html("");
		currPageIndex = pageIndex = pageIndex||1;
		if($('#timeRange1').val()){
			timeRange = $('#timeRange1').val()+','+$('#timeRange2').val();
		}
		$.get("${pageContext.request.contextPath}/getRechargeList.do?t=" + Math.random(),
				{'pageIndex':pageIndex,'state':state,
				'timeRange':timeRange,'moneyRange':moneyRange,
				'types':types},function(rs){
			if(!rs || !rs.length)return;
	       	pageCount = rs.shift();
	       	if(!pageCount)return;
	       	rs = rs[0];
	       	if(rs){
	       		//初始化模版引擎
	    		var tmplOpts = {varName:'data', compiler:'rapid'};
	    		fn.template.setting(tmplOpts);
	    		var html = fn.template($('#dataTmpl').html())(rs);
	    		$('#container').html(html);
	       	}
		},'json');
	}
	
	loadData();
	
	
</script>
</html>