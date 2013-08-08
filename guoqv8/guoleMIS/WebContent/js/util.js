/**
 * 显示交易类型
 */
function convertTradeType(num){
	switch(num){
		case 1:return '充值';
		case 2:return '提现';
		case 3:return '线路购买';
		case 4:return '返款';
		case 5:return '佣金';
	}
}

/**
 * 显示交易方式
 * @param num
 * @returns {String}
 */
function convertTradeChannel(num){
	switch(num){
		case 1:return '支付宝';
		case 2:return '线下汇款';
		case 3:return '银行转账';
		case 4:return '平台内';
	}
}

/**
 * 显示收支类型
 * @param num
 * @returns {String}
 */
function convertBillType(num){
	switch(num){
		case 1:return '收入';
		case 2:return '支出';
	}
}

function convertWithdrawingState(state){
	switch(state){
		case 0:return '申请';
		case 1:return '通过';
		case 2:return '拒绝';
	}
}

/**
 * 转换服务端传来的日期
 * @param dateJSON
 * @returns {String}
 */
function convertDate(dateJSON){
	if(null==dateJSON)return;
	var hour = (dateJSON.hours+'').length<2?('0'+dateJSON.hours):dateJSON.hours;
	var min = (dateJSON.minutes+'').length<2?('0'+dateJSON.minutes):dateJSON.minutes;
	var month = dateJSON.month + 1;
	month = (month+'').length<2?('0'+month):month;
	var date = dateJSON.date;
	date = (date+'').length<2?('0'+date):date;
	return (dateJSON.year+1900)+'-'+month+'-'+date+' '+hour+':'+min;
}

function convertDateYMD(dateJSON){
	var month = dateJSON.month + 1;
	month = (month+'').length<2?('0'+month):month;
	var date = dateJSON.date;
	date = (date+'').length<2?('0'+date):date;
	return (dateJSON.year+1900)+'-'+month+'-'+date;
}

/**
 * 
 * 转换时间格式2013-06-09 12:12:00.0
 * 2013-06-09 12:12
 * @returns {String}
 */
function convertTime(time){
	var temp = time.split(":");
	return temp[0]+":"+temp[1];
}
// 获取线路状态
function getLineState(state) {
	state = parseInt(state);
	switch(state) {
		case 1:
			return "过期下架";
		case 2:
			return "违规下架";
		case 3:
			return "手动下架";
		case 4:
			return "在售";
		case 5:
			return "待售";
		case 6:
			return "审核不通过";
	}
}

//是否含有中文（也包含日文和韩文）  
function isChineseChar(str){     
   var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;  
   return reg.test(str);
}

//是否含有全角符号的函数  
function isFullwidthChar(str){  
   var reg = /[\uFF00-\uFFEF]/;  
   return reg.test(str);  
}  

// 关闭页面
function closeWin() {
	window.opener= null; 
	window.open("","_top"); 
	window.top.close(); 
}

//获取招聘状态
function getZhaopinState(state) {
	state = parseInt(state);
	switch(state) {
		case 1:
			return "正常";
		case 2:
			return "关闭";
		case 3:
			return "审核不通过";
	}
}
//获取广告状态
function getAdvertState(state) {
	state = parseInt(state);
	switch(state) {
	case 1:
		return "正常";
	case 2:
		return "下架";
	}
}

//获取礼品卡类型状态
function getGiftCardTypeState(state) {
	state = parseInt(state);
	switch(state) {
	case 1:
		return "正常";
	case 2:
		return "下架";
	}
}
//获取产品类型状态
function getProductTypeState(state) {
	state = parseInt(state);
	switch(state) {
	case 0:
		return "无效";
	case 1:
		return "有效";
	}
}

/**
 * 将数字转换为金额格式（每三位用逗号隔开）
 * @param {Object} value
 * @return {TypeName} 
 */
function formatNumToMoney(value) {
	value += "";
	return value.replace(/(\d{3}(?!,))/g, '$1,').replace(/,$/, '');
}

/**
 * 将金额格式转换为数字
 * @param {Object} value
 * @return {TypeName} 
 */
function formatMoneyToNum(value) {
	value += "";
	return value.replace(/,/g, '');
}

/**
 * 截取字符
 * @param {Object} str 字符串
 * @param {Object} limit 截取长度
 * @return {TypeName} 
 */
function limitWordFromFront(str, limit){
	if (str) {
		if (str.length >= limit) {
			str = "..." + str.substring(str.length - limit, str.length);
		}
	}
	
	return str;
}

//转换html标签
function toTxt(str) {
    var RexStr = /\<|\>|\"|\'|\&/g
    str = str.replace(RexStr, function(MatchStr) {
        switch (MatchStr) {
        case "<":
            return "&lt;";
            break;
        case ">":
            return "&gt;";
            break;
        case "\"":
            return "&quot;";
            break;
        case "'":
            return "&#39;";
            break;
        case "&":
            return "&amp;";
            break;
        default:
            break;
        }
    });
    return str;
}

//转换html标签
function parseTxt(str) {
    var RexStr = /\<|\>|\"|\'|\&/g;
    str = str.replace(RexStr, function(MatchStr) {
    	return '\\' + MatchStr;
    });
    return str;
}