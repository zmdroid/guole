String.prototype.trim = function(){
	return this.replace(/^\s+|\s+$/mg,'');
};
String.prototype.format = function() {
	return this.replace(/[\r]{0,1}\n/g,'');
};
Array.prototype.indexOf = Array.prototype.indexOf||function(e){
	 for(var i=this.length;i--;){
		if(this[i]===e){
			return i;
		}
	}
	return -1;
};
var A="Active",
	Bro = $.browser.msie && $.browser.version == "6.0",
	EOC="easeOutCubic",
	EIC="easeInCirc",
	EOE="easeOutExpo",
	EIE="easeInExpo",
	EOQ="easeOutQuad",
	EIQ="easeInQuint",
	EIOB="easeInOutBack",
	EIOQ="easeInOutQuart",
	EIOE="easeInOutExpo",
	OPEN = OPEN || {
		Layer:8E3,
		Poplayer:"Poplayer",
		AnimTime:500,
		TransBox:function(Layer,ID){$("#"+ID).before('<div class="PF '+OPEN.Poplayer+'" style="z-index:'+Layer+'"></div>');
			$("."+OPEN.Poplayer).ColorGradual("0.7",OPEN.AnimTime,EOC);
		},
		/**弹出框
		* @param {String} ID:需要弹出框的ID
		*/
		Modal:function(ID){
			var $Th=$("#"+ID),_Width=$Th.width(),_Height=$Th.height();
			OPEN.TransBox(OPEN.Layer,ID);
			$Th.show().css({"z-index":++OPEN.Layer}).WinCon("In");
			$Th.find("select").removeClass("DisNo");
			if(Bro){$(".SelectIE").hide();};
			$(window).on("keydown",function(event){
				if(event.keyCode == 27){
					$Th.removeAttr("style").hide().BlankBox(1,_Width,_Height).prev("."+OPEN.Poplayer).animate({opacity:"0.1"},230,EOC,function(){
						$(this).remove();
					});
					$(window).off("keydown resize");
				};
			});
			return this;
		},
		/**页面位置及窗口大小
		* @return {Array} 页面宽度PageW:_PageW,页面高度PageH:_PageH,窗口宽度WinW:_WinW,窗口高度WinH:_WinH
		*/
		GetPageSize:function(){
			var _ScrW="",_ScrH="";
			if(window.innerHeight && window.scrollMaxY){
				_ScrW = window.innerWidth + window.scrollMaxX;_ScrH = window.innerHeight + window.scrollMaxY;//Mozilla
			}else if(document.body.scrollHeight>document.body.offsetHeight){
				_ScrW = document.body.scrollWidth;_ScrH = document.body.scrollHeight;//all but IE Mac
			}else if(document.body){
				_ScrW = document.body.offsetWidth;_ScrH = document.body.offsetHeight;//IE Mac
			}
			var _WinW="",_WinH="";
			if(window.innerHeight){
				_WinW = window.innerWidth;_WinH = window.innerHeight;// all except IE
			}else if (document.documentElement && document.documentElement.clientHeight){
				_WinW = document.documentElement.clientWidth;_WinH = document.documentElement.clientHeight;// IE 6 Strict Mode
			}else if (document.body){
				_WinW = document.body.clientWidth;_WinH = document.body.clientHeight;//other
			}// for small pages with total size less then the viewport
			var _PageW = (_ScrW<_WinW) ? _WinW : _ScrW;
			var _PageH = (_ScrH<_WinH) ? _WinH : _ScrH;
			return {PageW:_PageW,PageH:_PageH,WinW:_WinW,WinH:_WinH};
		},
		/**滚动条位置
		* @return {Array} 滚动条X:x,滚动条Y:y
		*/
		GetPageScroll:function (){
			var x="",y="";
			if(window.pageYOffset){
				y = window.pageYOffset;x = window.pageXOffset;// all except IE
			}else if(document.documentElement && document.documentElement.scrollTop){
				y = document.documentElement.scrollTop;x = document.documentElement.scrollLeft;//IE 6 Strict
			}else if(document.body){
				y = document.body.scrollTop;x = document.body.scrollLeft;// all other IE
			}
			return {X:x,Y:y};
		},
		/**鼠标坐标
		* @return {Array} X轴坐标.x,Y轴坐标.y
		*/
		mousePosition:function (Event){
			if(Event.pageX || Event.pageY){
				return {x:Event.pageX, y:Event.pageY};
			}
			return {
				x:Event.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:Event.clientY + document.body.scrollTop - document.body.clientTop
			};
		},
		/**图片头数据加载就绪事件 - 更快获取图片尺寸
		* @param {String} 图片路径
		* @param {function}	尺寸就绪
		* @param {function}	加载完毕 (可选)
		* @param {function}	加载错误 (可选)
		* @example ImgReady('http://www.google.com.hk/intl/zh-CN/images/logo_cn.png', function () {
				alert('size ready: width=' + this.width + '; height=' + this.height);
			});
		*/
		ImgReady:(function(){
			var _list = [], intervalId = null,		
			// 用来执行队列
			FnTick = function () {
				var i = 0;
				for (; i < _list.length; i++) {
					_list[i].end ? _list.splice(i--, 1) : _list[i]();
				};
				!_list.length && FnStop();
			},		
			// 停止所有定时器队列
			FnStop = function () {
				clearInterval(intervalId);
				intervalId = null;
			};		
			return function (url, ready, load, error) {
				var FnOnready, _Width, _Height, _NewWidth, _NewHeight,
					_Image = new Image();				
				_Image.src = url;		
				// 如果图片被缓存，则直接返回缓存数据
				if (_Image.complete) {
					ready.call(_Image);
					load && load.call(_Image);
					return;
				};				
				_Width = _Image.width;
				_Height = _Image.height;				
				// 加载错误后的事件
				_Image.onerror = function () {
					error && error.call(_Image);
					FnOnready.end = true;
					_Image = _Image.onload = _Image.onerror = null;
				};				
				// 图片尺寸就绪
				FnOnready = function () {
					_NewWidth = _Image.width;
					_NewHeight = _Image.height;
					if (_NewWidth !== _Width || _NewHeight !== _Height ||
						// 如果图片已经在其他地方加载可使用面积检测
						_NewWidth * _NewHeight > 1024
					) {
						ready.call(_Image);
						FnOnready.end = true;
					};
				};
				FnOnready();				
				// 完全加载完毕的事件
				_Image.onload = function () {
					// onload在定时器时间差范围内可能比FnOnready快
					// 这里进行检查并保证FnOnready优先执行
					!FnOnready.end && FnOnready();				
					load && load.call(_Image);					
					// IE gif动画会循环执行onload，置空onload即可
					_Image = _Image.onload = _Image.onerror = null;
				};		
				// 加入队列中定期执行
				if (!FnOnready.end) {
					_list.push(FnOnready);
					// 无论何时只允许出现一个定时器，减少浏览器性能损耗
					if (intervalId === null) intervalId = setInterval(FnTick, 40);
				};
			};
		})()
	},
	MoveLoad={
		css:function(path){
			if(!path||path.length===0){throw new Error(ErrorTxt);};
			var head=document.getElementsByTagName('head')[0],link=document.createElement('link');
			link.href=path;
			link.rel='stylesheet';
			link.type='text/css';
			head.appendChild(link);
		},
		js: function(path){
			if(!path||path.length===0){throw new Error(ErrorTxt);};
			var head=document.getElementsByTagName('head')[0],script=document.createElement('script');
			script.src=path;
			script.type='text/javascript';
			head.appendChild(script);
		}
	};
(function($,window,document){
'use strict';
var $Win=$(window);
jQuery.fn.extend({
	/**锚点*/
	Anchor:function(options){
		var $Th = $(this),
			_Defaults = {target:0, _Time:1E3},
			_Options = $.extend(_Defaults,options);
		$Th.each(function(event){
			$($Th[event]).click(function(){
				var _Rel = $(this).attr("href").substr(1);
				switch(_Options.target){
					case 1:
						var _Top = $(document.getElementById(_Rel)).offset().top-50;
						$(this).parent().addClass(A).siblings().removeClass(A);
						$("html,body").stop(!0,!1).animate({scrollTop:_Top},_Options._Time,EIOE);
						break;
					case 2:
						var _Left = $(document.getElementById(_Rel)).offset().left;
						$("html,body").stop(!0,!1).animate({scrollLeft:_Left},_Options._Time,EIOE);
						break;
				}
				return false;
			});
		});
	},
	/**多选*/
	AreaBox:function(){
		return this.each(function(){
			var $Th=$(this),				
				_AreaList=$(".AreaList",$Th);
			_AreaList.find("dd").on("click",function(){
				if($(this).hasClass(A)){
					$(this).removeClass(A);
				}else{
					$(this).addClass(A);
				}
			})
		});
	},
	/**弹出框效果
	* @param {Integer} Mode:调用方式 (0:载入框,1:弹出框)
	* @param {Integer} Width:弹框宽度
	* @param {Integer} Height:弹框高度
	* @param {Integer} Scale:弹框缩放比
	*/
	BlankBox:function(Mode,Width,Height,Scale){
		return this.each(function(){
			var $Th = $(this),
				FnTi="",
				_WinSize=OPEN.GetPageSize();
			$Th.after('<div class="BlankBox"/>');
			var _Blank=$(".BlankBox");
			var	FnIn = function (){
					var _Width=Width*Scale,_Height=Height*Scale;
					_Blank.css({
						width:_Width,
						height:_Height,
						left:(_WinSize.WinW-_Width)/2,
						top:(_WinSize.WinH-_Height)/2}
					).animate({
						width:Width,
						height:Height,
						left:(_WinSize.WinW-Width)/2,
						top:(_WinSize.WinH-Height)/2
					},200,EOE,function(){
						_Blank.remove();
					});
				};
			var	FnOut = function (){
					var _Width=_WinSize.WinW,_Height=0;
					_Blank.css({
						width:Width,
						height:Height,
						left:(_WinSize.WinW-Width)/2,
						top:(_WinSize.WinH-Height)/2
					}).animate({
						width:_Width,
						height:_Height,
						left:(_WinSize.WinW-_Width)/2,
						top:(_WinSize.WinH-_Height)/2
					},200,EOE,function(){
						_Blank.remove();
					});
				};
			if(Mode==0){
				FnTi = window.setTimeout(FnIn,0);
			};
			if(Mode==1){
				clearTimeout(FnTi);
				FnTi = window.setTimeout(FnOut,0);
			};
		});
	},
	/**输入框提示*/
	BoxTip:function(){
		var _Label="label",_Input="input",_IPrompt="IPrompt",_Time=3E2;
		$(this).each(function(){
			var $Th=$(this);
			$Th.find(_Label).css("line-height",$Th.find(_Input).outerHeight()+"px");
			if($Th.find(_Input).val()){$Th.find(_Label).hide();};
		})
		.click(function(){$(this).find("."+_IPrompt).fadeIn().end().find(_Label).stop(!0,!1).fadeOut(_Time).end().find(_Input).focus();})
		.find(_Input).focus(function(){$(this).next(_Label).stop(!0,!1).fadeOut(_Time).end().parent().find("."+_IPrompt).fadeIn();})
		.blur(function(){
			if($(this).val()==''){
				$(this).next(_Label).fadeIn(_Time).next("."+_IPrompt).fadeOut();
			}else{
				$(this).next(_Label).stop(!0,!1).fadeOut(_Time).next("."+_IPrompt).fadeOut();
			}
		});
	},
	/**动画渐变
	* @param {Integer} Degree:渐变程度
	* @param {Integer} Time:渐变时间
	* @param {String} Mode:渐变方式
	*/
	ColorGradual:function(Degree,Time,Mode){
		return this.animate({opacity:Degree},Time,Mode);
	},
	/**图片自动缩放居中
	* @param {Boolean} scaling:参数设置 true/false
	* @param {Integer} MaxWidth:图片最大宽度
	* @param {Integer} MaxHeight:图片最大高度
	*/
	ImgSize:function(scaling,MaxWidth,MaxHeight){
		return this.each(function(){
			var $Th=$(this),
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
			$(this).attr("src","about:blank");
			$Th.hide();
			$(_Image).load(function(){
				FnAutoScaling();
				$Th.attr("src",this.src).show();
			});
		});
	},
	/**商品焦点图展示*/
	ImageTurn:function(id){
		var $Th=$(this),
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
		$(document).off("keyup").on("keyup",function(event){
			var _Evevt = event.target||event.srcElement;
			if(_Evevt.tagName.toLocaleUpperCase()=="INPUT"||_Evevt.tagName.toLocaleUpperCase()=="TEXTAREA"||(_Evevt.tagName.toLocaleUpperCase()=="DIV" && _Evevt.contentEditable=='true'))return;
			if(event.keyCode == 39){//右
				_Next.click();
			}else if (event.keyCode == 37){//左
				_Prev.click();
			};
		});
	},
	/**文本框提示*/
	InBox:function(){
		return this.each(function(){
			var $Th=$(this),
				_Time=3E2,
				_InExPlain=".InExplain",
				_InEnter=".InEnter",
				$InEnter=$Th.find(_InEnter),
				_InTip=$Th.find(".InTip"),
				_InTextBoxSpan=$Th.find(".InTextBox span"),
				_InenterVal=$InEnter.val(),
				_InNumber=$Th.find(".InNumber"),
				_Sum=_InNumber.find("em").eq(1).text(),
				_Length=_InenterVal.length;
			$Th.find(_InExPlain).css("line-height",$InEnter.innerHeight()+"px");
			$Th.find(_InNumber).css("line-height",$InEnter.innerHeight()+"px");
			if($InEnter.is("textarea")){
				$Th.find(_InExPlain).css("line-height","24px");
				if(Bro){$InEnter.width($InEnter.width());};
			};
			if($InEnter.val()){
				$Th.find(_InExPlain).hide();
			};
			var FnCount=function(Temp,Value){
				if (Temp <= -1) {//字数超出
					_InNumber.find("em").eq(0).html("<span class='CRed FB'>"+Value+"</span>");
				} else {
					_InNumber.find("em").eq(0).html(Value);
				};
			};
			//初始化文本框字数显示
			var _Result = _Sum - _Length;
			_InNumber.find("em").eq(0).html(_Length);
			FnCount(_Result,_Length);
			_InTip.live("keyup click mousedown",function(){
				$(this).find(_InExPlain).stop(!0,!1).fadeOut(_Time).end().find(_InEnter).focus();
				_InTextBoxSpan.stop(!0,!0).fadeIn();
			}).find(_InEnter).focus(function(){
				$(this).next(_InExPlain).stop(!0,!1).fadeOut(_Time);
			}).blur(function(){
				$(this).val()==''?$(this).next(_InExPlain).stop(!0,!0).fadeIn(_Time):$(this).next(_InExPlain).stop(true,false).fadeOut(_Time);
			});
			$InEnter.live("keyup keydown click mousedown keypress",function(){
				FnPress();
			});
			var FnPress=function() {
				var _Val = $InEnter.val().format();
				var _ValLength = _Val.length;
				var _Temp = _Sum - _ValLength;
				FnCount(_Temp,_ValLength);
			};
		});
	},
	/**Loading加载
	* @param {Integer} Mode:加载方式 (0:满屏,1:相对父元素)
	* @param {String} Color:加载颜色 ('W':白色,'B':黑色)
	* @param {Integer} Time:加载时间
	* @param {function} fn:加载后回调
	*/
	Loading:function(Mode,Color,Time,fn){
		var _Color=Color,
			_Loading="Loading";
			Time = !Time && 8E2;
		!_Color ? _Color="":_Color="Load"+Color;
		if($("."+_Loading).length==0){
			if(Mode=="0" || Mode==null){Body.addClass("BodyLoad").prepend('<div class="'+_Loading+' '+_Color+'" style="position:fixed"/>');};
			if(Mode=="1"){
				if(Bro){
					$(this).addClass("PR").prepend('<div class="'+_Loading+' '+_Color+'" style="width:'+$(this).innerWidth()+'px;height:'+$(this).innerHeight()+'px" />');
				}else{
					$(this).addClass("PR").prepend('<div class="'+_Loading+' '+_Color+'"/>');
				};		
			};
		};
		var FnLoadingCall=function(){
			if($.browser.msie && $.browser.version < parseInt("9.0")){
				fn();
			}else{
				$("."+_Loading).animate({opacity:0.1},0).animate({opacity:1},Time,EIOQ,fn);
			};
		};
		if(fn){FnLoadingCall();};
		return this;
	},
	/**卸载加载
	* @param {Integer} Time:卸载时间
	* @param {function} fn:卸载后回调
	*/
	unLoading:function(Time,fn){
		//if(Bro){return false;};
		var $Th = $(this),_Loading="Loading";
		Body.removeClass("BodyLoad");
		$Th.removeClass("PR").children("."+_Loading).animate({opacity:0},Time,EIOQ,fn).TimeOut(function(){$Th.children("."+_Loading).remove();},Time+1);
		return this;
	},
	/**关闭弹出框*/
	ModalClose:function(){
		var $Th=$(this).parents(".ModalBG"),_Width=$Th.width(),_Height=$Th.height();
		Body.removeClass("BodyLoad");
		$Win.unbind("keydown");
		$Th.removeAttr("style").BlankBox(1,_Width,_Height).prev("."+OPEN.Poplayer).animate({opacity:"0.1"},230,EOC,function(){
			$(this).remove();
		});
		if(Bro){$Th.find("select").addClass("DisNo");$(".SelectIE").show();};
	},
	/**提示框
	* @param {type} Type:提示类型 ('Success':成功 'Failure':提醒 'Failing':错误)
	* @param {type} Text:提示文本
	* @param {Number} inTime:进入时间
	* @param {Number} outTime:退出时间
	*/
	Point:function(Type,Text,inTime,outTime){
		if($(".Point").length<1){
			inTime=!inTime && OPEN.AnimTime;
			outTime=!outTime && OPEN.AnimTime;
			var _WinSize = OPEN.GetPageSize();
			$(document.body).append('<div class="Point '+Type+'"><div class="PointI"/><div class="PointT">'+Text+'</div></div>');
			$("."+Type).css({
				left:(_WinSize.WinW-220)/2,
				top:(_WinSize.WinH-200)/2
			}).animate({
				"margin-top":'45'
			},inTime).delay(3E3).animate({
				"margin-top":'-45',
				opacity:0
			},outTime,'',function(){
				$(".Point").remove();
			});
			if(Bro){
				$("."+Type).removeAttr("style").css({left:(_WinSize.WinW-220)/2});
			};
		}
	},
	/**居中到父元素*/
	ParCen:function(){
		return this.each(function(){
			var $Th = $(this),$Parent=$Th.parent();
			$Parent.addClass("PosRel");
			var _ParentWidth=$Parent.width(),
				_ParentHeight=$Parent.height(),
				_Width=$Th.width(),
				_Height=$Th.height();
			$Th.css({
				left:(_ParentWidth-_Width)/2,
				top:(_ParentHeight-_Height)/2
			});
		});
	},
	/**输入框字数*/
	Restrict:function(){
		return this.each(function(){
			var $Th=$(this),
				_Value=null,
				_ComNumber=".ComNumber",
				_Disable="Disable",
				_EmElement=$("em"),
				_Publish=".Publish",
				_Sum=$Th.next().find(_EmElement).eq(1).text();
			if($Th.is("div")){
				_Value = $Th.text();
			};
			if($Th.is("textarea")){
				_Value = $Th.val();
				if(Bro){$Th.width($Th.width());};
			};
			var FnCount=function(Temp,Len,Value){
				var _Pub=$Th.parent().next().find(_Publish);
				if (Temp < 0) {//字数超出
					_Pub.addClass(_Disable).bind("click",FnResAni);
					$Th.next(_ComNumber).find(_EmElement).eq(0).html("<span class='CRed FB'>"+Len+"</span>");
				} else {
					_Pub.removeClass(_Disable);
					$Th.next(_ComNumber).find(_EmElement).eq(0).html(Len);
				};
				if(Temp >= _Sum){
					//$Th.parent().next().find(".Publish").addClass("Disable")
				};
				if(!Value){
					_Pub.bind("click",FnResAni);
				}else if(Len<=_Sum){
					_Pub.unbind("click",FnResAni);
				};
			};
			function FnResAni(){
				$Doc.Glint($Th);
			};
			//初始化文本框字数显示
			var _Length = _Value.length,
				_Result = _Sum - _Length;			
			$Th.next(_ComNumber).find(_EmElement).eq(0).html(_Length);
			FnCount(_Result,_Length,_Value);
			//事件
			$(document).on("keyup keydown click mousedown keypress",$Th,function(){
				FnPress();
			});
			var FnPress=function() {
				var _Val="",_Len="";
				if($Th.is("div")){
					_Val = $Th.text().format();
					_Len = _Val.length;
				};
				if($Th.is("textarea")){
					_Val = $Th.val().format();
					_Len = _Val.length;
				};
				var _Temp = _Sum - _Len;
				FnCount(_Temp,_Len,_Val);
			};
		});
	},
	/**下拉框*/
	Selects:function(){
		return this.each(function(){
			var $Th=$(this),
				_Selecteds=$(".Selecteds",$Th),
				_SelectTxt=$(".SelectTxt",$Th),
				_Options=$(".Options",$Th);
			_Selecteds.on("click",function(){
				$(this).toggleClass(A);
				_Options.toggleClass("DisNo");
				if(Bro){$(".SelectIE").hide();};
				if(!$(this).hasClass(A) && Bro){$(".SelectIE").show();};
			});
			_Options.find("a").on("click",function(){
				_Selecteds.removeClass(A);
				_SelectTxt.html($(this).html());
				_Options.addClass("DisNo");
				if(Bro){$(".SelectIE").show();};
			});
		});		
	},
	/**弹框初始居中
	* @param {String} Mode:弹框初始居中方式 ("In"/"Out")
	* @param {function} fn:弹框初始居中后回调，可选
	*/
	WinCen:function(Mode,fn){
		return this.each(function(){
			var $Th = $(this),
				_WinSize=OPEN.GetPageSize(),
				_Width=$Th.width(),
				_Height=$Th.height();
			if(Mode=="Out"){
				$Th.css({left:(_WinSize.WinW-_Width)/2,top:(_WinSize.WinH-_Height)/2}).show(function(){
					if(fn){fn();};
				});
				if(Bro){
					var _ScrollTop = document.body.scrollTop + document.documentElement.scrollTop;
					var _Top = _ScrollTop + ((document.documentElement.clientHeight-_Height)/2);
					$Th.removeAttr("style").css({left:(_WinSize.WinW-_Width)/2,top:_Top,"z-index":OPEN.Layer++});
				}
				return true;
			};
			if(!Mode || Mode=="In"){
				$Th.BlankBox(0,_Width,_Height,1.5).css({left:(_WinSize.WinW-_Width)/2,top:(_WinSize.WinH-_Height)/2});
				if(Bro){
					$Th.removeAttr("style").BlankBox(0,_Width,_Height,1.5).css({left:(_WinSize.WinW-_Width)/2,"z-index":OPEN.Layer}).show();
				};
				return true;
			};
		});
	},
	/**保持居中
	* @param {String} Mode:居中方式 ("In"/"Out")
	* @param {function} fn:居中后回调，可选
	*/
	WinCon:function(Mode,fn){
		return this.each(function(){
			var $Th = $(this);
			$Th.WinCen(Mode,fn);
			$Win.on("resize",function(){
				var _WinSize=OPEN.GetPageSize(),_Width=$Th.width(),_Height=$Th.height();
				$Th.stop(!0,!1).animate({left:(_WinSize.WinW-_Width)/2,top:(_WinSize.WinH-_Height)/2},6E2,EIOB,function(){
					if(fn){fn();};
				});
			});
		});
	}
});})(jQuery,window,document);
$(document).ready(function(){
	self.Body=$("body");
	self.Doc=document;
	self.$Doc=$(document);
	self.Win=$(window);
	//表单
	$("input:text,textarea,input:password").focus(function(){$(this).addClass("focus");}).blur(function(){$(this).removeClass("focus");});
	$(".IBoxTip,.TBoxTip,.NavSearchBox").BoxTip();
	$(".InBox").InBox();
	$(":checkbox,:radio").addClass("BNo");
	//弹出框
	$(".Modal").live("click",function(event){
		//event.preventDefault();
		var _This=$(this);
		OPEN.Modal(_This.attr("rel"));
		try{modalCallBackFn(event);}catch(err){};
	});
	$(".ModalClose").click(function(){$(this).ModalClose();return false;});
	//Header导航
	$(".UserNav > dd").hover(function(){
		$(this).find("ul").length>0?$(this).find("ul").show():'';
	},function(){
		$(this).find("ul").hide();
	});
	//鼠标经过事件
	$(".Falls dd").live("mouseenter",function() {
        $(this).addClass(A);
    }).live("mouseleave",function(){
		$(this).removeClass(A);
	});
	//Tabs
	$(".Tabs li:first-child").addClass(A);
	$(".Tabs li").live("click",function(){
		if($(this).attr('invalid')){
			return;
		}
		var _index = $(this).index();
		$(this).addClass(A).siblings().removeClass(A);
		$(this).parent(".Tabs").next(".TabsCon").find(">div").eq(_index).stop(!0,!1).fadeIn().siblings().hide();
	});
	$(".Selects").Selects();
	$(document).on("mouseenter","#Ensure",function(){
		$(this).find(".Ensure").show();	
	}).on("mouseleave","#Ensure",function(){
		$(this).find(".Ensure").hide();	
	});
	$(document).on("mouseenter",".DView",function(){
		$(this).find(".DViewMenu").show();	
	}).on("mouseleave",".DView",function(){
		$(this).find(".DViewMenu").hide();	
	});
	$(".AreaBox").AreaBox();



	//end
});
















