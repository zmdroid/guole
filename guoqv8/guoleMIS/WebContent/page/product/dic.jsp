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
<title>分词器字典</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<script type="text/javascript">
	<c:if test="${current_user_permission['dic.jsp'] != true}">
		alert("无权访问");
		window.location.href = "${pageContext.request.contextPath}/index.jsp";
	</c:if>
</script>
<jsp:include page="../../header.jsp"></jsp:include>
<style type="text/css">
	.width400{
		width:400px !important;
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
	
	.word {
		color:fuchsia;
		border:1px #cccccc solid;
		padding:3px 3px 3px 3px;
		height:30px;
		float:left;
		line-height:30px;
		margin:3px 3px 3px 3px;
	}
	
	.recordCount {
		font-size:12px;
		color:red;
		font-weight:normal;
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
			<h1>产品管理 → <span>分词器字典</span></h1>
		</div>
	</div>
	<!-- End of Page title -->
	<!-- Page content -->
	<div id="page">
		<!-- Wrapper -->
		<div class="wrapper">
			<div class="box box-info" style="margin-top: 15px;">
				1） 您可以搜索词汇，并对词汇进行编辑或删除操作<br/>
				2） 列表上的操作只更新字库表，不更新字典文件<br/>
				3） 当字典文件需要更新时，系统会在下方提示，点击更新字典文件按钮即可更新
			</div>
			<div style="margin-top:15px;">
				<div class="box box-info" style="padding-top:10px;padding-bottom:10px;font-size:14px;">
				  	词库词数：
					<span class="fontRed" id="tableCount">--</span>&nbsp;&nbsp;
					字典词数：
					<span class="fontRed" id="dicCount">--</span>
					
					<div class="box box-warning DisNo fontRed FR" style="font-size:12px;margin-top:-7px;margin-right: 200px;" id="dicInfo"></div>
				</div>
				<p class="FR" style="margin-top: -43px;margin-right: 10px;">
					<c:if test="${current_user_permission['addDicWord.do'] == true}">
						<a href="javascript:;" id="addBtn" class="btn btn-blue">添加新词...</a>
					</c:if>
					<c:if test="${current_user_permission['renewDic.do'] == true}">
						<a href="javascript:;" id="modDicBtn" class="btn btn-blue">更新字典文件</a>
					</c:if>
				</p>
			</div>
				<!--列表-->
				<div>
					<h3>
						词汇列表 <span class="recordCount">（<span id="ifAdd"></span>词汇数：<span id="totalCount">--</span>）</span>
						<span class="FR">
							<p>
								<a href="javascript:search();" class="btn btn-blue" style="margin-top: -2px;margin-left:3px;">搜索</a>
							</p>
						</span>
						<span class="FR">
							<p>
								<A title="请输入关键字"><input onkeypress="if (event.keyCode == 13){search();}" type="text" id="keyword" class="width200 searchBg"/></A>
							</p>
						</span>
					</h3>
					<table class="display stylized">
						<thead>
							<tr>
								<th width="80" class="textLeft">编号</th>
								<th class="textLeft">词汇</th>
								<th width="160" class="textLeft">更新时间</th>
								<th width="60" class="textLeft">操作</th>
							</tr>
						</thead>
						<tbody id="wordList">
							<tr>
								<td colspan="4" class="fontRed">
									没有可显示的词汇
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--列表 end-->
			<div class="cle"></div>					
		</div>
		<br/><br/><br/>
		<!-- End of Wrapper -->
	</div>
	<!-- End of Page content -->
	<!-- Scroll to top link -->
	<a href="#" id="totop">^ 顶部</a>
	<c:if test="${current_user_permission['addDicWord.do'] == true}">
	<!-- 新增窗口-->
	<a href="#addwin" class="nyroModal DisNo" id="openAdd"></a>
	<div id='addwin' style='display: none;'>
		<h3>新增词汇</h3>
		<div class="box box-info">
			1） 请填写正确的词汇，词汇间不能包含空格<br/>
			2） 可输入多个词汇，每个词汇一行
		</div>
		<p>
			<textarea id="add_word" class="width400" rows="15"></textarea>
		</p>
		<br/>
		<p>
			<center>
				<input type="button" onclick="addWord();" class="btn btn-blue" value="保存"/>
				<input type="button" onclick="closePopWin();" class="btn btn-blue" value="关闭"/>
			</center>
		</p>
		<br/>
	</div>
	<!-- 新增窗口结束 -->
	</c:if>
	<c:if test="${current_user_permission['modifyDicWord.do'] == true}">
	<!-- 编辑区域窗口-->
	<a href="#modwin" class="nyroModal DisNo" id="openA">openA</a>
	<div id='modwin' style='display: none;'>
		<h3>修改词汇</h3>
		<div class="box box-info">提示：请填写正确的词汇，词汇间不能包含空格</div>
		<p>
			<input type="hidden" id="mod_id"/>
			<label class="required textLeft">词汇:</label>
			<input type="text" id="mod_word" class="width200" maxlength="100"/>
			<input type="button" onclick="modifyWord();" class="btn btn-blue" value="保存"/>
			<input type="button" onclick="closePopWin();" class="btn btn-blue" value="关闭"/>
		</p>
	</div>
	<!-- 编辑区域窗口结束 -->
	</c:if>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/fn.js"></script>
	<script id="wordTmpl" type="text/x-fn-tmpl">
		<#
			for(var i = 0,l = data.length; i < l; i++){
				var word = data[i];
		#>
		<tr id="tr_<#=word.id#>">
			<td class="textLeft"><#=word.id#></td>
			<td class="textLeft" id="word_<#=word.id#>"><#=toTxt(word.word)#></td>
			<td class="textLeft"><#=word.updateTime.split(".")[0]#></td>
			<td class="textLeft">
				<c:if test="${current_user_permission['modifyDicWord.do']}">
					<a href="javascript:openModWin(<#=word.id#>,'<#=parseTxt(word.word)#>');">编辑</a>  
				</c:if>
				<c:if test="${current_user_permission['deleteDicWord.do']}">
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
		var _trLoading = '<tr><td align="center" colspan="4"><img src="${pageContext.request.contextPath}/img/loading1.gif"/></td></tr>';
		var _fileTime = -1;

		// 搜索框搜索
		function search() {
			var keyword = $("#keyword").val().trim();
			_CURRENT_PAGE = 1;
			_pageDis = false;
			searchWord();
		}
		
		// 搜索词群
		function searchWord() {
			var keyword = $("#keyword").val().trim();
			var dicFileModTime = 0;
			if (keyword == "") {
				dicFileModTime = _fileTime/1000;	
			}
			$("#ifAdd").html(dicFileModTime != 0 ? "未同步的" : "");
			
			var wordList = $("#wordList");
			wordList.empty();
			wordList.html(_trLoading);
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getDicWord.do?t=" + new Date().getTime(),
				  data: {keyword: keyword, dicFileModTime: dicFileModTime},
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}

					data = $.parseJSON(data);
					var html = "";
					if (data.length == 0){
						html = "<tr><td colspan='4' class='fontRed'>没有可显示的词汇</td></tr>";
					}else{
						html = fn.template($('#wordTmpl').html())(data);
					}

					wordList.html(html);
					$("#totalCount").html(data.length);
				  },
				  error: function(){
					  alert("服务端出错，搜索词汇出错");
				  }
			});
		}

		// 加载字典库词数
		function loadDicWords() {
			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getDicWordsCount.do?t=" + new Date().getTime(),
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}
					data = $.parseJSON(data);
					_fileTime = data.modifyTime;
					$("#dicCount").html(formatNumToMoney(data.wordsCount));
					$("#tableCount").html(formatNumToMoney(data.dicBaseCount));
					checkUpdate();
					searchWord();
				  },
				  error: function(){
					  alert("服务端出错，查询字典库词数出错");
				  }
			});
		}
		
		loadDicWords();

		window.setInterval(function(){
			checkUpdate();
		}, 5000);
		
		/**
		 * 检查字符库是否有更新
		 */
		function checkUpdate() {
			var dicInfo = $("#dicInfo");
			var dicCount = formatMoneyToNum($("#dicCount").html());
			var tableCount = formatMoneyToNum($("#tableCount").html());
			var updateHtml = "词库有更新，请适时更新字典文件";
			if (!isNaN(dicCount) && !isNaN(tableCount)) {
				if (dicCount != tableCount) {
					dicInfo.html(updateHtml);
					dicInfo.show();
					return;
				}
			}

			if (_fileTime == -1) {
				return;
			}

			$.ajax( {
				  type: "get",
				  url: "${pageContext.request.contextPath}/getDicLastModify.do?t=" + new Date().getTime(),
				  success:function(data){
					if ("error" == data) {
						alert("出错了!");
						return;
					}
					if ((data * 1000) > _fileTime) {
						dicInfo.html(updateHtml);
						dicInfo.show();
					}else{
						dicInfo.hide();
					}
				  },
				  error: function(){
					  // alert("服务端出错，查询字典库最后更新时间出错");
				  }
			});
		}

		<c:if test="${current_user_permission['deleteDicWord.do'] == true}">
			/**
			 * 新增词群
			 */
			function addWord() {
				var word = $("#add_word").val().trim();
				if (word == "") {
					alert("词汇不能为空");
					return;
				}
				
				var wordList = word.split("\n");
				var w = "",ws = "";
				for (var i = 0; i < wordList.length; i++) {
					w = wordList[i];
					if (w.trim().indexOf(" ") != -1) {
						alert("词汇中不能包含空格");
						return;
					}
					
					if (w.trim() != "") {
						ws += w.trim() + ",";
					}
				}
				
				ws = ws.substring(0, ws.length - 1);
	
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/addDicWord.do?t=" + new Date().getTime(),
					  data: {words: ws},
					  success:function(data){
						data = $.parseJSON(data);
						var html = "新增词汇完成，处理结果如下：\n";
						html += "1、新增词汇：" + data.success + "\n";
						html += "2、重复词汇：" + data.duplicate + "\n";
					  	html += "3、出错词汇：" + data.error;
					  	alert(html);
					  	window.location.reload();
					  },
					  error:function(){
						  alert("服务出错，新增词汇出错");
					  }
				});
			}
		</c:if>
		
		<c:if test="${current_user_permission['deleteDicWord.do'] == true}">
			/**
			 * 删除词汇
			 */ 
			function deleteWord(id) {
				if (!window.confirm("您确定要删除吗？")) {
					return;
				}
				
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/deleteDicWord.do?t=" + new Date().getTime(),
					  data: {id: id},
					  success:function(data){
						if ("error" == data) {
							alert("删除词汇出错了!");
						}else{
							alert("删除词汇成功");
							deleteSucSet(id);
							if ($("#wordList tr").length == 1) {
								$("#wordList").html("<tr><td colspan='4' class='fontRed'>没有可显示的词汇</td></tr>");
							}
						}
					  },
					  error:function(){
						  alert("服务出错，删除词汇出错");
					  }
				});
			}
		</c:if>
		
		/**
		 * 删除成功设置 
		 */
		function deleteSucSet(id) {
			$("#tr_" + id).hide();
			
			var tc = $("#tableCount");
			tc.html(formatNumToMoney(formatMoneyToNum(tc.html()) - 1));
			
			var total = $("#totalCount");
			total.html(parseInt(total.html()) - 1);
			
			checkUpdate();
		}
		
		/**
		 * 编辑词群
		 */ 
		function openModWin(id, word) {
			$("#openA").trigger("click");
			$("#mod_id").val(id);
			$("#mod_word").val(word);
		}
		
		<c:if test="${current_user_permission['modifyDicWord.do'] == true}">
			// 修改词群
			function modifyWord() {
				var id = $("#mod_id").val();
				var word = $("#mod_word").val().trim();
				if (word == "") {
					alert("词汇不能为空");
					return;
				}
				
				if (word.trim().indexOf(" ") != -1) {
					alert("词汇中不能包含空格");
					return;
				}
				
				var td_word = $("#word_" + id);
				$.ajax( {
					  type: "post",
					  url: "${pageContext.request.contextPath}/modifyDicWord.do?t=" + new Date().getTime(),
					  data: {id: id, word: word.trim()},
					  success:function(data){
						if ("error" == data) {
							alert("修改词汇出错了!");
						}else{
							alert("修改词汇成功");
							td_word.html(word);
							closePopWin();
						}
					  },
					  error:function(){
						  alert("服务出错，修改词汇出错");
					  }
				});
			}
		</c:if>
		
		// 关闭编辑窗口
		function closePopWin() {
			$("#closeBut").trigger("click");
		}
		
		<c:if test="${current_user_permission['renewDic.do'] == true}">
			// 更新字典文件
			function renewDic() {
				$.ajax( {
					  type: "get",
					  url: "${pageContext.request.contextPath}/renewDic.do?t=" + new Date().getTime(),
					  async: false,
					  success:function(data){
						if ("error" == data) {
							alert("更新字典文件出错了!");
						}else{
							alert("更新字典文件成功");
							window.location.reload();
						}
					  },
					  error: function(){
						  alert("更新字典文件出错了!");
					  }
				});
			}
		</c:if>
		
		/************** 绑定事件 *************/
		$("#addBtn").click(function(){
			$("#openAdd").trigger("click");
			window.setTimeout(function(){ 
				$("#add_word").focus();
			}, 600);
		});
		
		$("#modDicBtn").click(function(){
			renewDic();
		});
	</script>
</body>
</html>