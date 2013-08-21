	var chk = {
			sq_1 : jQuery('#sq_1 li'),//商圈选择
			sq_2 : jQuery('div.sq_2 ul li'),//具体地址选择
			sq_3 : jQuery('#sq_3'),//地址输入框
			
			paytype : jQuery('#paytype'),//支付方式
			paytype_edit : jQuery('#paytype_edit'),
			paytype_p : jQuery('#paytype_edit p'),
			all_copy : jQuery('#all_copy'),
			copy_inp : jQuery('#copy_inp'),
			copy_li  : jQuery('#all_copy ul li'),
			copy_pass_sub : jQuery('#copy_pass_sub'),
			daytype : jQuery('#daytype p'),//配送方式
			copy_pwd : jQuery('#copy_pwd'),
			msg_pwd : jQuery('#msg_pwd'),
			sendtype : jQuery('#sendtype'),
			send_edit : jQuery('#daytype .send_edit'),
			
			addr_div : jQuery('#addr_div'),//显示地址div 
			addr_inp : jQuery('#addr_div input.addr_inp'),//地址同步显示框
			addr_btn : jQuery('#addr_div input.addr_btn'),//显示地址的按钮
			
			mem_list_btn : jQuery('.mem_list_btn'),//地址信息切换按钮
			mem_edit_btn : jQuery('.mem_edit_btn'),//地址信息切换按钮,有多个
			pay_list_btn : jQuery('.pay_list_btn'),
			
			mem_list_span : jQuery('#mem_list span.mem_info'),//选择地址高亮
			mem_list_p : jQuery('#mem_list p'),
			
			mem_dete_div : jQuery('#mem_dete'),
			mem_edit_div : jQuery('#mem_edit'),
			mem_info_div : jQuery('#mem_info'),
			
			addr_sub_btn : jQuery('#mem_edit input.addr_sub_btn'),
			pay_sub_btn : jQuery('#paytype_edit input.pay_sub_btn'),
			
			form_sub : jQuery('#form_sub'),
			
			daysend : 0,
			addr_sq_2 : '',
			copy_entname : '',
			iscopy : false,
			search_val : '',
			heilight : -1,
			discount : 1,
			copy_id : 0,
			totalmoney : 0,
			update_addr : 0,
			ent_pay : false,
			_sendtype : '次日达',
			_sendday : '',
			flog : true,
			set_time : '',
			ent_flog : true,
			ent_money : 0,
			
			init : function(){
				chk.daysend = chk.mem_list_p.find('span.daysend').html();
				chk.sq_1.click(chk.sq_1_func);
				chk.sq_2.click(chk.sq_2_func);
				chk.sq_3.focus(chk.sq_3_func);
				//chk.paytype.click(chk.paytype_func);
				chk.addr_btn.click(chk.addr_btn_func);
				chk.mem_list_btn.click(chk.mem_list_btn_func);
				chk.mem_edit_btn.click(chk.mem_edit_btn_func);
				chk.mem_list_span.click(chk.mem_list_span_func);
				chk.addr_sub_btn.click(chk.addr_sub_btn_func);
				chk.daytype.click(chk.daytype_func);
				chk.pay_list_btn.click(chk.pay_list_btn_func);
				chk.paytype_p.click(chk.paytype_func);
				chk.copy_li.click(chk.copy_li_func);
				chk.sendtype.click(chk.sendtype_func);
				chk.send_edit.click(chk.send_edit_func);
				chk.pay_sub_btn.click(chk.pay_sub_btn_func);
				chk.copy_pwd.focus(function(){chk.msg_pwd.html('');});
				chk.copy_inp.keyup('event',chk.copy_inp_func);
				chk.copy_inp.blur(chk.copy_inp_blur_func);
				chk.copy_inp.next('input').click(chk.copy_sub_btn);
				chk.copy_pass_sub.click(chk.copy_pass_sub_func);
				//jQuery('#date1').blur(function(){jQery('#date1_msg').html('每天下午六点前下单，次日送达可享双倍积分！');});
				jQuery('#sendh span.sh').click(chk.sendtime_func);
				jQuery('#mem_list input.radio').click(chk.input_radio);
				jQuery('#copy_btn').click(chk.copy_btn_func);
				jQuery('#date1').blur(function(){chk._sendday = jQuery('#date1').val();});
				jQuery('#search_copy').find('span.span_copy').live('mouseover',chk.span_copy_mouseover);
				jQuery('#search_copy').find('span.span_copy').live('click',chk.span_copy_click);
				chk.mem_info_div.find('tr td input').focus(function(){jQuery(this).next('span.msg').html('');});
				chk.form_sub.submit(chk.form_submit);
			},
			//商圈选项卡选择
			sq_1_func : function(){
				var _this_li = jQuery(this);
				//_this_li.css('backgroundColor','#aaa');
				//chk.sq_1.not(_this_li).css('backgroundColor','#ddd');
				var index = _this_li.index();
				var _this_div = jQuery("div.sq_2:eq("+index+")");
				_this_div.show();
				jQuery("div.sq_2").not(_this_div).hide();
			},
			//具体地址选择
			sq_2_func : function(){
				var _this = jQuery(this);
				var addr = _this.html();
				//_this.css({'backgroundColor':'#fd6600','color':'#fff'});
				//chk.sq_2.not(_this).css({'backgroundColor':'#ddd','color':'#000'});
				chk.addr_div.fadeIn(200);
				chk.addr_inp.val(addr);
				chk.addr_sq_2 = addr;
				chk.daysend = 1;
			},
			
			sq_3_func : function(){
				chk.sq_3.keyup(function(){
					var addr_1 = jQuery(this).val();
					var addr = chk.addr_sq_2+addr_1;
					chk.addr_inp.val(addr);
				});
			},

			paytype_func : function(){
				var _this = jQuery(this);
				if(_this.find('input').attr('readonly') == 'readonly'){
					return false;
				}
				_this.find('input').attr('checked','checked');
				_this.css('backgroundColor','#fff4d3');
				chk.paytype_p.not(_this).css('backgroundColor','');
				if(_this.index() == chk.paytype_p.length - 1){
					chk.all_copy.show();
				}else{
					chk.all_copy.hide();
				}
			},
			
			mem_list_btn_func : function(){
				chk.mem_dete_div.hide();
				chk.mem_edit_div.show();
			},
			
			pay_list_btn_func : function(){
				chk.paytype.hide();
				chk.paytype_edit.show();
			},
			
			copy_li_func : function(){
				var _this = jQuery(this);
				chk.copy_entname = _this.html();
				_this.css({'backgroundColor':'#fd6600','color':'#fff'});
				chk.copy_li.not(_this).css({'backgroundColor':'#ddd','color':'#000'});
			},
			//用户多地址选择效果
			mem_list_span_func : function(){
				var _this = jQuery(this);
				var p = _this.parent('p');
				chk.discount = 1;
				if(p.find('input').prop('disabled') == true){
					return false;
				}
				p.find('input').attr('checked','checked');
				p.css('backgroundColor','#fff4d3');
				chk.mem_list_p.not(p).css('backgroundColor','');
				if(p.index() == chk.mem_list_p.length-1){
					chk.daysend = 0;
					chk.mem_info_div.show();
					jQuery('#copy_div').hide();
					chk.edit_addr('');
				}else if(p.index() == chk.mem_list_p.length-2){
					jQuery('#copy_div').show();
					jQuery('#mem_info').hide();
				}else{
					chk.daysend = _this.next('span.daysend').html();
					var text = p.find('span:eq(0)').html();
					chk.edit_addr(text);
					jQuery('#copy_div').hide();
					chk.mem_info_div.hide();
				}
			},
			input_radio : function(){
				var _this = jQuery(this);
				var p = _this.parent('p');
				
				p.find('input').attr('checked','checked');
				p.css('backgroundColor','#fff4d3');
				chk.mem_list_p.not(p).css('backgroundColor','');
				if(p.index() == chk.mem_list_p.length-1){
					chk.daysend = 0;
					chk.mem_info_div.show();
					chk.edit_addr('');
				}else{
					chk.daysend = _this.next('span.daysend').html();
					var text = p.find('span:eq(0)').html();
					chk.edit_addr(text);
					chk.mem_info_div.hide();
				}
			},
			//当日达的选择
			daysend_func : function(type,obj){
				if(type == 0){
					//obj.html();
				}
			},
			//获取用户已有地址并显示在编辑框中
			edit_addr :function(text){
				var info = text;
				var info_arr = info.split(',');
				chk.mem_info_div.find('#receivename').val(info_arr[0]);
				chk.mem_info_div.find('#receivemobile').val(info_arr[1]);
				chk.mem_info_div.find('#sq_3').val(info_arr[2]);
			},
			//确认地址按钮方法
			mem_edit_btn_func : function(){
				var _this = jQuery(this);
				var p = _this.parent('p');

				if(p.find('input.radio').prop('disabled') == true){
					return false;
				}
				chk.update_addr = 1;
					
				var text = p.find('span:eq(0)').html();
				chk.edit_addr(text);
				
				p.find('input').attr('checked','checked');
				p.css('backgroundColor','#fff4d3');
				chk.mem_list_p.not(p).css('backgroundColor','');
				jQuery('#copy_div').hide();
				chk.mem_info_div.show();
			},
			
			addr_sub_btn_func : function(){
				var name = chk.mem_info_div.find('#receivename');
				var mobile = chk.mem_info_div.find('#receivemobile');
				var address = chk.mem_info_div.find('#sq_3');
				
				var p = chk.mem_list_p.find("input:checked").parents('p');
				if(p.index() == chk.mem_list_p.length-2){
					if(jQuery('#copy_mem').val() == '' || jQuery('#copy_mem').val() == '请输入您的姓名'){
						jQuery('#copy_mem').next('span.msg').html('请填写正确的联系人');
						return false;
					}
					if(jQuery('#copy_tel').val() == '' || !jQuery('#copy_tel').val().match(/^1[3|4|5|8][0-9]\d{4,8}$/)){
						jQuery('#copy_tel').next('span.msg').html('请填写正确的联系号码');
						return false;
					}
					if(!chk.iscopy){
						jQuery('#copy_msg').html("请您填写正确的企业名称或密码！");
						return false;
					}
					chk.update_addr = 1;
					name.val(jQuery('#copy_mem').val());
					mobile.val(jQuery('#copy_tel').val());
					address.val(jQuery('#copy_addr').html()+jQuery('#copy_ess').val());
					jQuery('#copy_id').val(chk.copy_id);
					
					/////////////////////////////////////////////////////////
				}else{
					jQuery('#copy_id').val(0);
				}
				var flog = 0;
				if(name.val() == ''){
					name.next('span.msg').html('请填写正确的收货人！');
					flog++;
				}
				if(mobile.val() == '' || !mobile.val().match(/^1[3|4|5|8][0-9]\d{4,8}$/)){
					mobile.next('span.msg').html('请填写正确的联系方式！');
					flog++;
				}
				if(address.val() == ''){
					address.next('span.msg').html('请填写正确的收货地址！');
					flog++;
				}
				if(flog!=0){
					return false;
				}
				
				var span = name.val()+','+mobile.val()+','+address.val();
				
				if(p.index() != chk.mem_list_p.length-1 && p.index() != chk.mem_list_p.length-2){
						p.find('span:eq(0)').html(span);
				}
				if(chk.discount != 1){
					
					jQuery.ajax({
						url : tot_url+'/'+chk.discount,
						type : 'get',
						async : 'false',
						success : function(msg){
							var sp = ",&nbsp;&nbsp;&nbsp;企业协议价为<span  class='c-ff6600 size-20'>￥"+msg+"</span>元";
							jQuery('#totlemoney').css({'fontSize':'14px','color':'#000'});
							jQuery('#ent_money').html(sp);
						}
					});
					//alert(chk.totalmoney);
				}
				var date = chk.mem_dete_div.find('p:eq(0)');
				date.html('');
				date.append(span);
				jQuery('#copy_div').hide();
				chk.mem_dete_div.show();
				chk.mem_edit_div.hide();
			},
			
			pay_sub_btn_func : function(){
				var p = chk.paytype_edit.find('input:checked').parents('p');
				var copy_text = jQuery('#copy_text');
				chk.totalmoney=0;
				chk.totalmoney = jQuery('#totalmoney').html();
				var money = jQuery('#money').val();
				
				if(p.index() == chk.paytype_p.length-1){
					if(chk.discount != 1){
						copy_text.html("成功享有企业折扣："+chk.discount*10+"折，此折扣不与其它折扣共享！");
						money = money*chk.discount;
						jQuery('#totlemoney').html(Math.round(money*100)/100);
					}
					jQuery('#copy_id').val(chk.copy_id);
					chk.discount = chk.discount;
					jQuery('#copy_id').val(chk.copy_id);
					jQuery('#totlemoney').html(chk.totalmoney);
					var span = p.find('span').clone();
					chk.paytype.find('p:eq(0)').html('');
					chk.paytype.find('p:eq(0)').append(span);
					chk.paytype.show();
					chk.paytype_edit.hide();
							
				}else{
					copy_text.html('');
					jQuery('#copy_id').val(0);
					jQuery('#totlemoney').html(chk.totalmoney);
					var span = p.find('span').clone();
					chk.paytype.find('p:eq(0)').html('');
					chk.paytype.find('p:eq(0)').append(span);
					chk.paytype.show();
					chk.paytype_edit.hide();
				}
			},
			
			daytype_func : function(){
				var _this = jQuery(this);
				if(_this.index() == 0){
					if(chk.daysend == 0){
						_this.find('.msg').html('您选择的地址不支持当日达配送！');
						return false;
					}
					chk._sendtype = '当日达';
					chk._sendday = jQuery('#date0').val();
				}else{
					chk._sendtype = '次日达';
					chk._sendday = jQuery('#date1').val();
				}
				_this.find('input').attr('checked','checked');
				_this.css('backgroundColor','#fff4d3');
				chk.daytype.not(_this).css('backgroundColor','');
			},
			
			addr_btn_func : function(){
				chk.daysend = 0;
				chk.addr_div.attr('disabled','disabled');
				chk.addr_div.fadeOut(200);
			},
			
			sendtype_func : function(){return false;
				jQuery('#send_type').hide();
				jQuery('#daytype').show();
			},
			
			send_edit_func : function(){
				var date = jQuery('#daytype').find('input.delivery:checked').parent('span').next('span').find('input');
				if(date.val() == ''){
					date.parent('span').find('span.msg').html('请选择正确的送货日期！');
					return false;
				}
				jQuery('#send_type').show();
				jQuery('#daytype').hide();
				jQuery('#send_type').find('p').html(chk._sendtype+"&nbsp;&nbsp;&nbsp;&nbsp;你选择的送货日期是&nbsp;"+chk._sendday);
			},
			
			copy_inp_func : function(event){
				var myevent = event || windows.event;
				var keyCode = myevent.keyCode;
				
				/*if((keyCode>=65 && keyCode<=90) || (keyCode>=48 && keyCode<=57) || keyCode == 8 || keyCode == 32){
					var val = jQuery(this).val();
					alert(val);
					//搜索请求
					chk.heilight = -1;
					if(val != ''){
						chk.ajax_search(val);
						clearTimeout(chk.set_time);
						chk.set_time = setTimeout(function(){chk.flog = true;},1000);
					}
				}else */
					if(keyCode == 38 || keyCode == 40){
					chk.key_updown(keyCode);
				}else if(keyCode == 13){
					chk.key_enter();
				}else{
					var val = jQuery(this).val();
					//搜索请求
					chk.heilight = -1;
					if(val != ''){
						
						clearTimeout(chk.set_time);
						chk.set_time = setTimeout(function(){chk.flog = true;chk.ajax_search(val);},800);
					}
				}
			},
			
			ajax_search : function(val){
				//alert(val);
				if(chk.flog){
					jQuery.ajax({
						type : 'post',
						async : false,
						url : sea_url,
						data : {'val':val,'type':0},
						dataType : 'json',
						success : function(msg){
							if(msg.stu == 1){
								jQuery('#search_copy').html('');
								var span = "";
								for(var i=0;i<msg.res.length;i++){
									span += "<span class='span_copy' style='cursor:pointer;display:inline-block;margin:0px;width:100%'>"+msg.res[i].entname+"</span><br/>";
								}
								jQuery('#search_copy').append(span);
								jQuery('#search_copy').show();
							}else{
								jQuery('#search_copy').hide();
							}	
						}
					});
					
				}
					chk.flog = false;
					
			},
			
			key_updown : function(keyCode){
				var len = jQuery('span.span_copy').length;
					if(keyCode == 40){
						chk.heilight = chk.heilight > len-2 ? chk.heilight : chk.heilight += 1;
					}else{
						chk.heilight = chk.heilight < 1 ? chk.heilight : chk.heilight -= 1;
					}
				jQuery('#copy_inp').val(jQuery('#search_copy').find('span:eq('+chk.heilight+')').html());
				chk.heilight_func();
			},
			
			key_enter : function(){
				var len = jQuery('#search_copy').find('span.span_copy').length;
				if(chk.heilight >=0 && chk.heilight<len){
					//var text = jQuery('#search_copy').find('span:eq('+chk.heilight+')').html();
					//jQuery('#copy_inp').val(text);
					jQuery('#search_copy').hide();
				}
			},
			
			heilight_func : function(){
				//var len = jQuery('#search_copy').find('span.span_copy').length;
				//if(chk.heilight>=0 && chk.height<len){
					var hi = jQuery('#search_copy').find('span:eq('+chk.heilight+')');
					var ohi = jQuery('#search_copy').find('span.span_copy').not(hi);
					hi.css({'backgroundColor':'#ddd'});
					ohi.css({'backgroundColor':'#fff'});
				//}
			},
			
			span_copy_mouseover : function(){
				var _this = jQuery(this);
				chk.heilight = _this.index()/2;
				var span = jQuery('#search_copy span.span_copy');
				_this.css({'backgroundColor':'#ddd'});
				span.not(_this).css({'backgroundColor':'#fff'});
				jQuery('#copy_inp').val(jQuery(this).html());
			},
			
			span_copy_click : function(){
				var _this = jQuery(this);
				var text = _this.html();
				jQuery('#copy_inp').val(text);
				jQuery('#search_copy').hide();
			},
			
			copy_sub_btn : function(){
				jQuery('#search_copy').hide();
				if(chk.copy_inp.val() !== '' && chk.copy_inp.val() !== '输入企业名称，查询是否开通企业账户'){
					jQuery.post(ent_url,{'entname':chk.copy_inp.val()},function(msg){
						if(msg != 0){
							jQuery('#copy_tr').slideDown(200);
							chk.copy_inp.next('span.msg').html('');
							chk.iscopy = true;
							chk.sq_3.val(msg);
						}else{
							chk.copy_inp.next('input').next('span.msg').html('您填写的公司没有加入我们的果酷平台');
							chk.iscopy = false;
						}
					});
				}
			},
			
			copy_pass_sub_func : function(){
				jQuery('#search_copy').hide();
				if(!chk.ent_flog || chk.copy_inp.val() == '' || chk.copy_inp.val()=='输入企业名称，查询是否开通企业账户'){
					chk.copy_inp.next('span.msg').html("<img src='http://www.guocool.com/source/tuan/images/fail.gif'/>");
					jQuery('#copy_msg').html('企业名称错误');
					return false;
				}
				var paypwd = jQuery('#paypwd').val();
				if(chk.copy_inp.val() !== '' && chk.copy_inp.val() !== '输入企业名称，查询是否开通企业账户' && paypwd !== '' && paypwd !=='输入支付密码'){
					jQuery.post(ent_url,{'entname':chk.copy_inp.val(),'paypwd':paypwd},function(msg){
						chk.copy_inp.next('span.msg').html("<img src='http://www.guocool.com/source/tuan/images/succ.gif'/>");
						if(msg == 0){
							jQuery('#copy_msg').html('支付密码错误');
							chk.iscopy = false;
							/*jQuery('#copypay').find('input').attr('disabled','disabled');
							jQuery('#copypay').css('color','#aaa');
							chk.sq_3.removeAttr('disabled');
							chk.discount = 1;
							jQuery('#copy_text').html("成功享有企业折扣："+chk.discount*10+"折，此折扣不与其它折扣共享！");
							chk.iscopy = false;
							jQuery('#totlemoney').html(chk.totalmoney);
							chk.copy_id = 0;*/
						}else{
							//jQuery('#copy_addr').prop('disabled','disabled');
							jQuery('#copy_dizhi').show();
							jQuery('#copy_addr').html(msg.address);
							var px = 240 - (msg.address.length*18);
							if(px<82){
								px = 82;
							}
							var index = jQuery('#copy_ess').val().indexOf(msg.address)+msg.address.length;
							var ess = jQuery('#copy_ess').val().substring(index);
							jQuery('#copy_ess').val(ess);
							jQuery('#copy_ess').css('width',px+'px');
							chk.copy_id = msg.id;
							chk.discount = msg.discount;
							chk.iscopy = true;
							jQuery('#copy_msg').html("");
							//alert(msg.address);
							//alert(jQuery('#copy_addr').val());
							/*money = money*chk.discount;
							jQuery('#totlemoney').html(Math.round(money*100)/100);
							jQuery('#totlemoney').html(chk.totalmoney);
							
							jQuery('#copy_tr').slideDown(200);
							chk.copy_inp.next('span.msg').html('');
							jQuery('#copy_msg').css('color','#000');
							jQuery('#copypay').find('input').removeAttr('disabled');
							jQuery('#copypay').css('color','#000');
							chk.sq_3.attr('disabled','disabled');
							chk.iscopy = true;
							chk.copy_id = msg.id;
							chk.discount = msg.discount;
							chk.sq_3.val(msg.address);
							jQuery('#copy_msg').html("成功享有企业折扣："+chk.discount*10+"折，此折扣不与其它折扣共享！");
							jQuery('#copy_text').html("成功享有企业折扣："+chk.discount*10+"折，此折扣不与其它折扣共享！");*/
						}
					},'json');
				}else{
					jQuery('#copy_msg').html("支付密码错误！");
				}
			},
			
			copy_btn_func : function(){
				jQuery('#copy_div').toggle();
			},
			
			sendtime_func : function(){
				var _this = jQuery(this);
				var time = jQuery('#sendh span.time');
				var sendtimeh = jQuery('#sendtimeh');
				if(_this.index() == 0){
					time.html('09:00-12:00');
					sendtimeh.val('上午');
				}else{
					time.html('13:00-18:00');
					sendtimeh.val('下午');
				}
				_this.css('border','1px solid #fd6600');
				jQuery('#sendh span.sh').not(_this).css('border','1px solid #ddd');
			},
			
			form_submit : function(){
				chk.sq_3.removeAttr('disabled');
				jQuery('#copy_id').val(chk.copy_id);
				jQuery('#discount').val(chk.discount);
				jQuery('#update_addr').val(chk.update_addr);
				jQuery('#daytype_inp').val(chk.daysend);
				var mem_div = chk.mem_edit_div.css('display');
				var pay_div = chk.paytype_edit.css('display');
				//var day_div = jQuery('#daytype').css('display');
				/*if(chk.daytype.find('input:checked').val() == 0){
					var daytime = jQuery('#date1').val();
					if(daytime == ''){
						alert('请选择送货时间!');
						return false;
					}else{
						jQuery('#sendtimed').val(daytime);
					}
				}else{
					jQuery('#sendtimed').val(jQuery('#date0').val());
				}*/
				//if(mem_div!='none' || pay_div!='none' || day_div != 'none'){
				if(jQuery('#date1').val() == ''){
					jQuery('#date1_msg').html('请选择正确的送货时间！');
					return false;
				}
				jQuery('#sendtimed').val(jQuery('#date1').val());
				if(mem_div!='none' || pay_div!='none'){
					return false;
				}
				//var today = new Date();
				//var date = jQuery('#date1').val().substr(8,2);
				//if(today.getHours() >= 18 && today.getDate()+1 == date && jQuery('#sendtimeh').val() == '上午'){
					//alert('抱歉，当天下午六点以后下的订单，不能在第二天上午发货，请重新选择发货时间！');
					//return false;
				//}
				return true;
			},
			
			copy_inp_blur_func : function(){
				jQuery('#search_copy').hide();
				var val = jQuery(this).val();
				if(val == '' || val == '输入企业名称，查询是否开通企业账户'){
					return false;
				}
				var vl = jQuery(this).val();
				jQuery.post(sea_url,{'val':val,'type':1},function(msg){

						if(msg.stu == 1 && msg.res.length==1){
							chk.ent_flog = true;
							chk.copy_inp.next('span.msg').html("<img src='http://www.guocool.com/source/tuan/images/succ.gif'/>");
							jQuery('#copy_msg').html("请输入支付密码验证");
						}else{
							chk.ent_flog = false;
							chk.copy_inp.next('span.msg').html("<img src='http://www.guocool.com/source/tuan/images/fail.gif'/>");
							jQuery('#copy_msg').html("<span style='color:#000'>"+vl+"没有开通企业平台，您愿意申请开通企业平台功能么？点击</span><a style='text-decoration:underline;color:red' href='http://www.guocool.com/index.php/platform/post'>申请开通</a>");
						}
				},'json');
			},
		}
	
		chk.init();
	
	