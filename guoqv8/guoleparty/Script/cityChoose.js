var contains =  function(a, b, itself){
         // 第一个节点是否包含第二个节点
         //contains 方法支持情况：chrome+ firefox9+ ie5+, opera9.64+(估计从9.0+),safari5.1.7+
         if(itself && a == b){
             return true
         }
         if(a.contains){
             if(a.nodeType === 9 )
                 return true;
             return a.contains(b);
         }else if(a.compareDocumentPosition){
             return !!(a.compareDocumentPosition(b) & 16);
         }
         while ((b = b.parentNode))
             if (a === b) return true;
         return false;
     }

var cityChoose = {
	hotCitys: [
		"北京","上海","天津","青岛,山东","南京,江苏","杭州,浙江","厦门,福建","成都,四川","深圳,广东","广州,广东","沈阳,辽宁","武汉,湖北","香港","台北,台湾","西安,陕西"
	],
	citys: {
		"B": ["北京", "包头,内蒙古自治区"],
		"C": ["重庆", "成都,四川", "长春,吉林", "长沙,湖南", "常州,江苏"],
		"D": ["大连,辽宁", "东莞,广东"],
		"F": ["佛山,广东", "福州,福建"],
		"G": ["广州,广东", "贵阳,贵州"],
		"H": ["哈尔滨,黑龙江", "杭州,浙江", "海口,海南", "呼和浩特,内蒙古", "合肥,安徽"],
		"J": ["济南,山东", "江门,广东"],
		"K": ["昆明,云南", "喀什市,新疆维吾尔自治区"],
		"L": ["拉萨,西藏自治区", "兰州,甘肃"],
		"M": ["绵阳,四川"],
		"N": ["南京,江苏", "宁波,浙江", "南昌,江西", "南宁,广西壮族自治区"],
		"Q": ["青岛,山东", "泉州,福建"],
		"S": ["上海", "苏州,江苏", "深圳,广东", "三亚,海南", "石家庄,河北", "汕头,广东", "沈阳,辽宁"],
		"T": ["天津", "太原,山西", "台州,浙江"],
		"W": ["无锡,江苏", "乌鲁木齐,新疆维吾尔自治区", "武汉,湖北", "威海,山东", "温州,浙江"],
		"X": ["西安,陕西", "厦门,福建", "西宁,青海", "西昌,四川", "徐州,江苏"],
		"Y": ["银川,宁夏回族自治区", "运城,山西", "延吉,吉林", "榆林,陕西", "烟台,山东", "义乌,浙江"],
		"Z": ["珠海,广东", "中山,广东", "郑州,河南"]
	},
	country: {
		"日本": ["东京", "北海道","大阪","冲绳"],
		"韩国": ["首尔", "济州岛", "釜山", "江原道"],
		"泰国": ["曼谷", "普吉", "清迈", "芭提雅", "苏梅"],
		"美国": ["夏威夷", "洛杉矶", "西雅图", "纽约"],
		"东南亚": ["马尔代夫", "巴厘岛", "新加坡", "马来西亚", "塞班岛", "长滩岛"],
		"美洲": ["加拿大", "墨西哥", "古巴", "巴西", "阿根廷"],
		"中东非洲": ["埃及", "迪拜", "土耳其", "肯尼亚", "毛里求斯"],
		"欧洲": ["希腊", "法国", "英国", "意大利", "德国", "瑞士", "西班牙", "俄罗斯", "冰岛"]
	},
	show: function(opts, country){
		var id = opts.id;
		var renderTo = opts.renderTo;
		var callbackFn = opts.callbackFn;
		var _this = $("#" + renderTo);
		var left = _this.offset().left;
		var top = _this.offset().top;
		var height = _this.height();
		top += height + 3;

		var panel = $("#" + id);
		if (panel.attr("id")) {
			if (!panel.is(":visible")){ 
				panel.css({
					left: left,
					top: top
				}).show();
			}
			return;
		}

		var body = $("body");
		var rsHtml = "";
		var html = '<iframe  style="position:absolute;z-index:9;width:expression(this.nextSibling.offsetWidth);height:expression(this.nextSibling.offsetHeight);top:expression(this.nextSibling.offsetTop);left:expression(this.nextSibling.offsetLeft);" frameborder="0" ></iframe>';
		html += '<div id="'+ id +'" class="CC_CityPanel">\
						<div class="CC_Header">\
							<span class="CC_HotCityTitle">热门城市</span> <span title="关闭" onclick="cityChoose.hide(\''+ id +'\');" class="CC_Close FR">X</span>\
							<div class="CC_HotCity">#hotCitys</div>\
						</div>\
						<div class="CC_Citys">#citys</div>\
						<div class="CC_Citys" style="display:none">#country</div>\
				   </div>';

	    var hCitys = "";
	    for (var i = 0; i < this.hotCitys.length; i++) {
	    	var cy = this.hotCitys[i].split(',')[0];
	    	hCitys += '<a href="javascript:'+ callbackFn +'(\''+ cy + "','" +this.hotCitys[i] +',中国\');">'+ cy +'</a>'
	    }
	    
	    var citys = "", cs;
	    for (var type in this.citys) {
	    	cs = this.citys[type];
	 		
	    	citys += '<div class="CC_item"><span>'+ type +'</span>';
	    	for (var x = 0; x < cs.length; x++) {
	    		var cy = cs[x].split(',')[0];
	    		citys += ' <a href="javascript:'+ callbackFn +'(\''+ cy + "','"+ cs[x] +',中国\');">'+ cy +'</a>';
			}
	    	citys += '</div>';
	    }
		
	    rsHtml = html.replace(/#hotCitys/ig, hCitys).replace(/#citys/ig, citys);
	    
	    //country
	    if(country){
		    var country = "", cs;
		    for (var type in this.country) {
		    	cs = this.country[type];
		 		
		    	country += '<div class="CC_item"><span class="FL" style="width:50px">'+ type +'</span><div class="country">';
		    	for (var x = 0; x < cs.length; x++) {
		    		country += ' <a href="javascript:'+ callbackFn +'(\''+ cs[x] +'\');">'+ cs[x] +'</a>';
				}
		    	country += '</div><div class="Cle"></div></div>';
		    }
			
		    rsHtml = rsHtml.replace(/#country/ig, country).replace('style="display:none"','');
	    }
		body.append(rsHtml);

		$("#" + id).css({
			left: left,
			top: top
		});

		this.autoClose(id, renderTo);
	},
	hide: function(id) {
		$("#" + id).hide();
	},
	autoClose: function(id, renderTo) {
		$("body").click(function(){
			var cityPanel = $("#" + id);
			var _this = event.target || event.srcElement;
			var c = document.getElementById(id);

			if (cityPanel.attr("id") && cityPanel.is(":visible")) {
				var clickTag = $(_this);
				var clsName = clickTag.attr("class");
				var pClsName = clickTag.parent().attr("class");

				if (contains(c, _this, true) || _this.id == renderTo) {
					return;
				}

				if (contains(document.getElementById(renderTo), _this, true)) {
					return;
				}

				cityChoose.hide(id);
			}
		});
	}
}