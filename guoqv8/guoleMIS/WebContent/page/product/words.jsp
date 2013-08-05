<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date date = new Date();
	int year = date.getYear() + 1900;
	int month = date.getMonth() + 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>线路搜索关键字库</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<script type="text/javascript">
	<c:if test="${current_user_permission['words.jsp'] != true}">
		alert("无权访问");
		window.location.href = "${pageContext.request.contextPath}/index.jsp";
	</c:if>
</script>
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width500{
		width:500px !important;
	}
	
	.width200{
		width:200px !important;
	}
	
	.DisNo {
		display: none;
	}

	.textLeft {
		text-align: left!important;
	}
	
	.fontRed {
		color:red;
	}
	
	.searchBg {
		background-repeat: no-repeat;
		background-position: center right;
		padding-right: 23px!important;
		padding-top: 5px!important;
	}
</style>
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
			<h1>产品管理 → <span>线路搜索关键字库</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
				<c:if test="${current_user_permission['addWord.do'] == true}">
				<!--添加标签-->
				<fieldset class="SearchBox">
					<legend>添加词群</legend>					
					<p>
						<label class="required">词群:</label>
						<input type="text" name="word" id="word" class="width500"/>
						<a href="javascript:;" id="addBtn" class="btn btn-blue">添加词群</a>
						<span style="color:blue;">提示：相同意思的词汇组成词群，每个词汇之间用<span style="color: red;">空格</span>隔开。</span>
					</p>
				</fieldset>
				<!--添加标签 end-->
				</c:if>
				<!--列表-->
				<div>
					<h3>
						词群列表
						<span class="FR">
							<p>
								<a href="javascript:search();" class="btn btn-blue" style="margin-top: -3px;margin-left:3px;">搜索</a>
							</p>
						</span>
						<span class="FR">
							<p>
								<A title="输入关键字"><input onkeypress="if (event.keyCode == 13){search();}" type="text" id="keyword" class="width200 searchBg"/></A>
							</p>
						</span>
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th width="30" class="textLeft">编号</th>
								<th class="textLeft">词群</th>
								<th width="60" class="textLeft">操作</th>
							</tr>
						</thead>
						<tbody id="wordList">
						
						</tbody>
					</table>
				</div>
				<!--列表 end-->
				<div class="leading">
					<div id="Pagination" class="pagination FR" style="text-align:center;"><!-- 这里显示分页 --></div>
					<div>共 <b id="totalCount">0</b> 条，每页显示 <b>${wordsPageSize}</b> 条</div>
				</div>
			<div class="cle"></div>					
		</div>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<!-- 编辑区域窗口-->
	<a href="#modwin" class="nyroModal DisNo" id="openA">openA</a>
	<div id='modwin' style='display: none;'>
		<h3>提示</h3>
		<div class="box box-info">提示：相同意思的词汇组成词群，每个词汇之间用<span style="color: red;">空格</span>隔开。</div>
		<p>
			<input type="hidden" id="mod_id"/>
			<label class="required textLeft">词群:</label>
			<textarea type="text" id="mod_word" class="width500" rows="6"></textarea>
		</p>
		<br/>
		<center>
			<input type="button" onclick="modifyWord();" class="btn btn-blue" value="保存"/>
			<input type="button" onclick="closePopWin();" class="btn btn-blue" value="关闭"/>
		</center>
	</div>
	<!-- 编辑区域窗口结束 -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination_zh/pagination.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pagination_zh/jquery.pagination.js"></script>
	<script id="wordTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var word = data[i];
		#>
		<tr>
			<td class="textLeft"><#=word.id#></td>
			<td class="textLeft" id="word_<#=word.id#>"><#=toTxt(word.words)#></td>
			<td class="textLeft">
				<c:if test="${current_user_permission['modifyWord.do'] == true}">
					<a href="javascript:openModWin(<#=word.id#>,'<#=parseTxt(word.words)#>');">编辑</a>
				</c:if>
				<c:if test="${current_user_permission['deleteWord.do'] == true}">  
					<a href="javascript:deleteWord(<#=word.id#>);">删除</a> 
				</c:if>
			</td>
		</tr>
		<#}#>
	</script>
	<script type="text/javascript">
		//初始化模版引擎
		var tmplOpts = {varName:'data', compiler:'rapid'};
		fn.template.setting(tmplOpts);

		var _pageDis = false;
		var _limit  = "${wordsPageSize}";
		var _CURRENT_PAGE = 1;
		var _trLoading = '<tr><td colspan="3"><img src="${pageContext.request.contextPath}/img/loading1.gif"/></td></tr>';

		// 搜索框搜索
		function search() {
			_CURRENT_PAGE = 1;
			_pageDis = false;
			searchWord();
		}
		
		// 搜索词群
		function searchWord() {
			var keyword = $("#keyword").val().trim();
			var wordList = $("#wordList");
			var page = $("#Pagination");
			wordList.empty();
			wordList.html(_trLoading);
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getWordsByKeyword.do?t=" + new Date().getTime(),
				  data: {keyword: keyword.replace(/'/ig, '\''), start: (_CURRENT_PAGE - 1) * _limit},
				  async: false,
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}

					data = $.parseJSON(data);
					var html = "";
					if (data.totalCount == 0){
						_pageDis = false;
						html = "<tr><td colspan='3' class='fontRed'>没有检索到符合条件的词群</td></tr>";
						page.hide();
					}else{
						html = fn.template($('#wordTmpl').html())(data.list);
						page.show();
					}

					wordList.html(html);
					$("#totalCount").html(data.totalCount);

					var totalPage = Math.ceil(data.totalCount/_limit);
					if (totalPage == 1) {
						page.hide();
					}
					if (!_pageDis){
				    	page.pagination(totalPage, {callback: pageselectCallback});
				  	  	_pageDis = true;
				  	}
					
					refreshWords();
				  },
				  error: function(){
					  alert("服务端出错，查询词群出错");
				  }
			});
		}
		
		searchWord();
		
		// 分页控件回调
		function pageselectCallback(page_index){
			if (_CURRENT_PAGE == (page_index + 1)){
				return false;
			}

			_CURRENT_PAGE = page_index + 1;
			searchWord();
			return false;
		}

		// 刷新列表，当在非第一页下架时，且下架后当前页记录为0时刷新
		function refreshWords() {
			var lines = $("#wordList tr");
			// 下驾时如果当前页无记录
			if (lines.length == 0 && _CURRENT_PAGE != 1) {
				_CURRENT_PAGE = 1;
				_pageDis = false;
				searchWord();
				return;
			}
		}

		<c:if test="${current_user_permission['addWord.do'] == true}">
			/**
			 * 新增词群
			 */
			function addWord() {
				var word = $("#word").val().trim();
				if (word == "") {
					alert("词群不能为空");
					return;
				}
	
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/addWord.do?t=" + new Date().getTime(),
					  data: {word: word, start: (_CURRENT_PAGE - 1) * _limit},
					  success:function(data){
						if ("error" == data) {
							alert("新增词群出错了!");
						}else{
							alert("新增词群成功");
							window.location.reload();
						}
					  },
					  error:function(){
						  alert("服务出错，新增词群出错");
					  }
				});
			}
		</c:if>
		
		
		<c:if test="${current_user_permission['deleteWord.do'] == true}">
			/**
			 * 删除词群
			 */ 
			function deleteWord(id) {
				if (!window.confirm("您确定要删除吗？")) {
					return;
				}
				
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/deleteWord.do?t=" + new Date().getTime(),
					  data: {id: id},
					  success:function(data){
						if ("error" == data) {
							alert("删除词群出错了!");
						}else{
							alert("删除词群成功");
							searchWord();
						}
					  },
					  error:function(){
						  alert("服务出错，删除词群出错");
					  }
				});
			}
		</c:if>
		
		/**
		 * 编辑词群
		 */ 
		function openModWin(id, word) {
			$("#openA").trigger("click");
			$("#mod_id").val(id);
			$("#mod_word").val(word);
		}
		
		
		<c:if test="${current_user_permission['modifyWord.do'] == true}">
			// 修改词群
			function modifyWord() {
				var id = $("#mod_id").val();
				var word = $("#mod_word").val().trim();
				if (word == "") {
					alert("词群不能为空");
					return;
				}
				
				var td_word = $("#word_" + id);

				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/modifyWord.do?t=" + new Date().getTime(),
					  data: {id: id, word: word},
					  success:function(data){
						if ("error" == data) {
							alert("修改词群出错了!");
						}else{
							alert("修改词群成功");
							td_word.html(word);
							closePopWin();
						}
					  },
					  error:function(){
						  alert("服务出错，修改词群出错");
					  }
				});
			}
		</c:if>
		
		// 关闭编辑窗口
		function closePopWin() {
			$("#closeBut").trigger("click");
		}
		
		/************** 绑定事件 *************/
		$("#addBtn").click(function(){
			addWord();
		});
	</script>
</body>
</html>