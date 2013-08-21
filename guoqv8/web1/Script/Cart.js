var cart = {
		num_inp : $(".numInp"),	//数量输入框
		plus : $(".num_jia"),	//加
		minus : $(".num_jian"),//减
		
		_tm : $('#total'),
		_dm : $('#totalmoney'),
		_yh : $('span.youhui'),
		up_url : '',//更新数量的url
		del_url : '',
		
		init : function(){
			
			cart.num_inp.keydown('event',cart.num_inp_func).focus(function(){this.style.imeMode='disabled';});
			cart.num_inp.change(cart.inp_blur_func);
			cart.plus.click({'type':true},cart.plus_minus_func);
			cart.minus.click({'type':false},cart.plus_minus_func);
		},
		//数量输入框，限制非法字符的输入
		num_inp_func : function(event){
			var myevent = event || windows.event;
			var keyCode = myevent.keyCode;
			var val = $(this).val();
			if(val.length < 4){
				if((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) || keyCode == 8 || keyCode == 9 || keyCode == 13 || keyCode == 46 || keyCode == 39 || keyCode == 37){
					return true;
				}
			}else{
				if(keyCode == 8 || keyCode == 9 || keyCode == 13 || keyCode == 46 || keyCode == 39 || keyCode == 37){
					return true;
				}
			}
			return false;
		},
		//数量加减方法
		plus_minus_func : function(event){
			
			var _this = $(this).parents('tr.proshow');
			var inp = _this.find(cart.num_inp);
			
			var id = _this.prop('id');
			var _num = parseFloat(inp.val());
			
			num = event.data.type ? _num+1 : _num-1;
			if(num<1){return false;}
			if(cart.change_num_func(id,num)){
				cart.change_page(_this,_num,num);
				inp.val(num);
			}
		},
		//返回float数据
		ma : function(num){
			num = parseFloat(num);
			//var reg = /^\d+\.\d+$/;
			//if(reg.test(num)){
			//	num = num.toFixed(2);
			//}else{
				num = Math.round(num*100)/100;
			//}
			return num;
		},
		//数量改变页面的联动
		change_page : function(_this,_num,num){
			var danjia = cart.ma(_this.find('span.danjia').html());
			var discount = cart.ma(_this.find('input.discount').val());

			var totalmoney = cart.ma(cart._tm.html());
			var dismoney = cart.ma(cart._dm.html());
			
			var _price = _this.find('span.price');
			_jifen = parseInt(_price.html());
			
			_price.html(cart.ma(num*danjia));
			_this.find('span.vipprice').html(cart.ma(num*danjia*discount));
			
			var n = Math.abs(_num-num);
			
			jf = _num<num ? parseInt(_jifen+danjia*n) : parseInt(_jifen-danjia*n)
			tm = _num<num ? cart.ma(totalmoney+danjia*n) : cart.ma(totalmoney-danjia*n);
			dm = _num<num ? cart.ma(dismoney+danjia*discount*n) : cart.ma(dismoney-danjia*discount*n);
			
			cart.isvip ? _this.find('span.jifen').html(jf) : '';
			cart._tm.html(tm);
			cart._dm.html(dm);
			cart._yh.html(cart.ma(tm-dm));
		},
		//输入框onblur事件
		inp_blur_func : function(){
				var _this = $(this).parents('tr.proshow');
				var num = parseInt($(this).val());
				var id = $(this).parents('tr.proshow').prop('id');
				if(num<1){alert('请输入正确的商品数量！');return false;}
				
		},
		
		
		//发送请求更新数据库数据
		change_num_func : function(id,num){
			var flog = true;
			if(isNaN(num) || isNaN(id)){
				alert('请输入正确的商品数量！');
				return false;
			}
			return flog;
		},
		
}

cart.init();