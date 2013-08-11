<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.remindCityPanel {
		position: absolute;
		z-index : 100000;
		background-color: #ffffff;
		height: 380px;
		border:2px rgb(255, 193, 59) solid;
	}
	
	.keyInfo {
		height:28px;
		line-height:28px;
		padding-left:10px;
		color: #fff;
		background-color: rgb(103, 161, 226);
	}

	.cityList {
		height:300px;
	}

	.cityList div {
		padding-left:10px;
		height: 28px;
		line-height:28px;
		border-top:1px #ffffff solid;
		border-bottom:1px #ffffff solid;
		cursor: pointer;
		color: rgb(0, 85, 170);
	}
	
	#cityPage {
		text-align: center;
		margin-top: 15px;
	}

	.cityActive {
		background-color: rgb(232, 244, 225);
		borderTop: 1px rgb(127, 157, 185) solid!important;
		borderBottom: 1px rgb(127, 157, 185) solid!important;
	}
	
	#cityPage span {
		display: inline-block!important;
		width:20px!important;
		height:20px!important;
		padding:0px!important;
	}
	
	.province {
		font-size:12px;
	}
</style>
<script type="text/javascript">
	var citySug = {};
	citySug.init = function(opt) {
		cityEL = opt.el;
		cityLimit = opt.cityLimit || cityLimit;
		cityCallback = opt.callback || cityCallback;
		keyUpEventFn = opt.keyUpEventFn || keyUpEventFn;
		sugWidth = opt.sugWidth || sugWidth;

		$("#" + cityEL).focus(function(){
			searchCitys(this);
		});
	
		$("#" + cityEL).keyup(function(){
			if (isCtrlKey(event.keyCode, [8])) {
				return;
			}
			if (null != keyUpEventFn) {
				keyUpEventFn();
			}
			searchCitys(this);
		});
	};

	var cityLimit =  10;
	var curCityList;
	var cityCurrentPage = 1;
	var cityEL = "";
	var cityCallback = "city_callBack";
	var keyUpEventFn = null;
	var sugWidth = null;
	function createCityPanel() {
		$(".remindCityPanel").remove();
		var keyword = $("#" + cityEL);
		var top = keyword.offset().top + keyword.innerHeight() + 2;
		var left = keyword.offset().left - 1;
		var width = (null == sugWidth) ? keyword.innerWidth() : sugWidth;
		var html = '<div class="remindCityPanel" id="remindCityPanel" style="top:'+ top +'px;left:'+ left +'px;width:'+ width +'px;">\
				        <div class="keyInfo" id="keyInfo">#keyInfo</div>\
				        <div class="cityList" id="cityList">#cityList</div>\
				        <div id="cityPage" class="pagination"></div>\
				   </div>';
		var keyHtml = keyword.val() + "，按拼音排序";
		var city, cityHtml = "";
		if (curCityList.length == 0) { 
			keyHtml =  "对不起，找不到：" + limitWordFromFront(keyword.val(), 18);
		}else{
			for (var i = (cityCurrentPage - 1) * cityLimit; i < curCityList.length; i++) {
				if (i == cityLimit * cityCurrentPage) {
					break;
				}
				city = curCityList[i];
				if (city.searchType == "continent") { // 州
					cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.continent +'\', \''+ city.continent +'\');" data="'+ city.continent +'\', \''+ city.continent +'"><label>'+ city.continent +'</label><span class="CA province"> - '+ city.continent +'</span></div>';
				}else if (city.searchType == "country") { // 国
					if (city.country != "中国") {
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.country +'\', \''+ city.continent +'-'+ city.country +'\');" data="'+ city.continent +'-'+ city.country +'"><label>'+ city.country +'</label><span class="CA province"> - '+ city.continent +'</span></div>';	
					}else{
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.country +'\', \''+ city.country +'\');" data="'+ city.country +'"><label>'+ city.country +'</label></div>';
					}
				}else if (city.searchType == "province") { // 省
					if (city.country != "中国") {
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.province +'\', \''+ city.continent +'-'+ city.country +'-'+ city.province +'\');" data="'+ city.continent +'-'+ city.country +'-'+ city.province +'"><label>'+ city.province +'</label><span class="CA province"> - '+ city.country +'</span></div>';	
					}else{
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.province +'\', \''+ city.country +'-'+ city.province +'\');" data="'+ city.country +'-'+ city.province +'"><label>'+ city.province +'</label></div>';	
					}
				}else { // 市
					if (city.country != "中国") {
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.city +'\', \''+ city.continent +'-'+ city.country +'-'+ city.province +'-'+ city.city +'\');" data="'+ city.continent +'-'+ city.country +'-'+ city.province +'-'+ city.city +'"><label>'+ city.city +'</label><span class="CA province"> - '+ city.country +'</span></div>';
					}else{
						cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.city +'\', \''+ city.country +'-'+ city.province +'-'+ city.city +'\');" data="'+ city.country +'-'+ city.province +'-'+ city.city +'"><label>'+ city.city +'</label><span class="CA province"> - '+ city.province +'</span></div>';
					}
				}
			}
		}
		html = html.replace(/#keyInfo/ig, keyHtml);
		html = html.replace(/#cityList/ig, cityHtml);
		$(document.body).append(html);
		var cityPage = $("#cityPage");
		var totalPage = 0;
		if (curCityList.length != 0) {
			totalPage = Math.ceil(curCityList.length/cityLimit);
			if (totalPage <= 1) {
				return;
			}
			
			cityPage.pagination(totalPage, {
					items_per_page:0,
					num_display_entries: 2,
					current_page: (cityCurrentPage - 1),
					num_edge_entries:1,
					link_to:"#",
					prev_text:"<<",
					next_text:">>",
					ellipse_text:"...",
					prev_show_always:true,
					next_show_always:true,
					callback: cityCallBack
				});
		}else{
			cityPage.hide();
		}
	}

	function refreahPageTool() {
		var cityPage = $("#cityPage");
		var totalPage = Math.ceil(curCityList.length/cityLimit);
		cityPage.pagination(totalPage, {
					items_per_page:0,
					num_display_entries: 2,
					current_page: (cityCurrentPage - 1),
					num_edge_entries:1,
					link_to:"#",
					prev_text:"<<",
					next_text:">>",
					ellipse_text:"...",
					prev_show_always:true,
					next_show_always:true,
					callback: cityCallBack
				});
	}

	function cityCallBack(page_index) {
		if (cityCurrentPage == (page_index + 1)){
			return false;
		}

		cityCurrentPage = page_index + 1;
		loadCityData();
		return false;
	}

	function loadCityData() {
		var cityList = $("#cityList");
		var city, cityHtml = "";
		for (var i = (cityCurrentPage - 1) * cityLimit; i < curCityList.length; i++) {
			if (i == cityLimit * cityCurrentPage) {
				break;
			}
			city = curCityList[i];
			if (city.searchType == "continent") { // 州
				cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.continent +'\', \''+ city.continent +'\');" data="'+ city.continent +'\', \''+ city.continent +'"><label>'+ city.continent +'</label><span class="CA province"> - '+ city.continent +'</span></div>';
			}else if (city.searchType == "country") { // 国
				cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.country +'\', \''+ city.continent +'-'+ city.country +'\');" data="'+ city.continent +'-'+ city.country +'"><label>'+ city.country +'</label><span class="CA province"> - '+ city.continent +'</span></div>';	
			}else if (city.searchType == "province") { // 省
				cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.province +'\', \''+ city.continent +'-'+ city.country +'-'+ city.province +'\');" data="'+ city.continent +'-'+ city.country +'-'+ city.province +'"><label>'+ city.province +'</label><span class="CA province"> - '+ city.country +'</span></div>';
			}else { // 市
				if (city.country != "中国") {
					cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.city +'\', \''+ city.continent +'-'+ city.country +'-'+ city.city +'\');" data="'+ city.continent +'-'+ city.country +'-'+ city.city +'"><label>'+ city.city +'</label><span class="CA province"> - '+ city.country +'</span></div>';
				}else{
					cityHtml += '<div onclick="'+ cityCallback +'(\''+ city.city +'\', \''+ city.country +'-'+ city.province +'-'+ city.city +'\');" data="'+ city.country +'-'+ city.province +'-'+ city.city +'"><label>'+ city.city +'</label><span class="CA province"> - '+ city.province +'</span></div>';
				}
			}
		}
		
		cityList.html(cityHtml);
	}
	
	function findCitysByKey() {
		var key = $("#" + cityEL).val();
		if (null == key || key.trim() == "") {
			return;
		}

		$.ajax({
			url: '${pageContext.request.contextPath}/findCitysByKey.do?time=' + new Date().getTime(),
			data: {key: key},
			success: function(data){
				if ("error" != data) {
					curCityList = $.parseJSON(decodeURIComponent(data));
					createCityPanel();
				}
			}
		});		
	}
	
	function joinCityList(lists) {
		var rsList = [];
		var list;
		for (var i = 0; i < lists.length; i ++) {
			list = lists[i];
			for (var j = 0; j < list.length; j++) {
				rsList.push(list[j]);
			}
		}
		
		return rsList;
	}
	
	function closeCityPanel() {
		$(".remindCityPanel").hide();
	}

	function searchCitys() {
		var keyword = $("#" + cityEL); 

		if (keyword.val().trim() == "") {
			closeCityPanel();
		}else{
			cityCurrentPage = 1;
			findCitysByKey();
		}
	}
	
	function city_callBack(value, allValue) {
		$("#" + cityEL).val(value);
		// $("#searchBtn").trigger("click");
	}

	$(".cityList div").live("mouseover", function() {
		$(".cityList div").removeClass("cityActive");
		$(this).addClass("cityActive");
	});
	
	$(document.body).click(function(){
		if (!$("#remindCityPanel").is(":visible")) {
			return;
		}

		var _this = event.target || event.srcElement;
		var id = _this.id;
		if (id == "remindCityPanel" 
				|| id == cityEL || id.indexOf("cityPage") != -1
				|| $(_this).parent().attr("id") == "cityPage") {
			return;
		}

		if (id == "" || $(".remindCityPanel #" + id).length == 0) {
			closeCityPanel();
		}
	});

	function bindKeyEvent() {
		var cityList = $("#cityList");
		var cityDiv = $("#cityList div");
		var cur, cur0, curMax, css = "cityActive";
		if ($("#remindCityPanel").is(":visible")) {
			cur = cityList.find("div[class*='"+ css +"']");
			if (event.keyCode == 38) { // 上
				cur0 = $(cityDiv[0]);
				curMax = $(cityDiv[cityDiv.length - 1]);

				if (cur.length == 0) {
					cur0.addClass(css);
					return;
				}

				if (cur0.hasClass(css)) {
					cur0.removeClass(css);
					curMax.addClass(css);
					return;
				}
				
				cur.removeClass(css);
				cur.prev().addClass(css);

				return false;
			}

			if (event.keyCode == 40) { // 下
				cur.removeClass(css);
				cur.next().addClass(css);
				
				if (cur.length == 0) {
					$(cityDiv[0]).addClass(css);
				}
				
				return false;
			}
			
			if (event.keyCode == 13) { // 回车
				if (cur.html()) {
					eval(cityCallback + "('"+ cur.find("label").html() +"','"+ cur.attr("data") +"')");
					closeCityPanel();
				}
			}
			
			var totalPage = Math.ceil(curCityList.length/cityLimit);
			if (event.keyCode == 37) { // 向左
				if (totalPage <= 1 || cityCurrentPage == 1) {
					return;
				}

				cityCurrentPage = cityCurrentPage - 1;
				loadCityData();
				refreahPageTool();
			}
			
			if (event.keyCode == 39) { // 向右
				if (totalPage ==  cityCurrentPage) {
					return;
				}

				cityCurrentPage = cityCurrentPage + 1;
				loadCityData();
				refreahPageTool();
			}
		}
	}
	
	document.onkeydown = bindKeyEvent;
</script>