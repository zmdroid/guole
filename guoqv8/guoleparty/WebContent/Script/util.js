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
		case 2:return '线下';
		case 3:return '支票';
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

/**
 * 显示充值单状态
 */
function convertWithdrawingState(num){
	switch(num){
		case 0:return '申请中';
		case 1:return '成功';
		case 2:return '拒绝';
	}
}

/**
 * 转换服务端传来的日期
 * @param dateJSON
 * @returns {String}
 */
function convertDate(dateJSON){
	var hour = (dateJSON.hours+'').length<2?('0'+dateJSON.hours):dateJSON.hours;
	var min = (dateJSON.minutes+'').length<2?('0'+dateJSON.minutes):dateJSON.minutes;
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


window.isCtrlKey = function (keyCode, ignore) {
    // 8        - 退格
    // 9        - Tab
    // 13       - 回车
    // 16~18    - Shift, Ctrl, Alt
    // 37~40    - 左上右下
    // 35~36    - End Home
    // 46       - Del
    // 112~123  - F1-F12
	if (("," + ignore.join() + ",").indexOf("," + keyCode + ",") != -1) {
		return false;
	}

    switch (keyCode) {
        case 8: case 9: case 13:
        case 16: case 17: case 18:
        case 37: case 38: case 39: case 40:
        case 35: case 36: case 46:
            return true;
        default:
            if (keyCode >= 112 && keyCode <= 123) {
                return true;
            }
    		return false;
	}
}

/**
 * 截取字符
 * @param {Object} str 字符串
 * @param {Object} limit 截取长度
 * @return {TypeName} 
 */
function limitWord(str, limit){
	if (str) {
		if (str.length > limit) {
			str = str.substring(0, limit) + "...";
		}
	}
	
	return str;
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

// 验证Email格式
function checkEmail(email)
{alert(email);
	var reg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;

	return reg.test(email);
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

/**
 * 用户帐号状态
 * @param {Object} state
 * @return {TypeName} 
 */
function userState(state) {
	switch(state) {
		case "1":
			return "正在审核中...";
		case "2":
			return "";
		case "3":
			return "审核未通过";
		case "4":
			return "已被冻结";
		default:
			return "状态异常";
	}
}

/**
 * 大于零的整数
 */
function isInt(num) {
	if (!num || isNaN(num) || num.indexOf(".") != -1 || num.indexOf("-") != -1) {
		return false;
	}
	
	return true;
}

/**
 * 在传入日期上减去天数，获取新的日期
 * @param {Object} dateStr
 * @param {Object} days
 */
function dateDiff(dateStr, days) {
	var dates = dateStr.split("-");
	var year = parseInt(dates[0]);
	var month = parseInt(dates[1]) - 1;
	var date = parseInt(dates[2]);
	
	var d = new Date(year, month, date);
	d.setTime(d.getTime() - days * 24 * 60 * 60 * 1000);
	month = d.getMonth() + 1;
	month = month < 10 ? ("0" + month) : month;
	date = d.getDate();
	date = date < 10 ? ("0" + date) : date;
	return (1900 + d.getYear()) + "-" + month + "-" + date;
}

/**
 * 字符型日期相差天数
 * @param {Object} dStr1 "2013-02-02"
 * @param {Object} dStr2 "2013-02-02"
 * @return {TypeName} 
 */
function dateDiffDay(dStr1, dStr2) {
	var ds1 = dStr1.split("-");
	var year1 = parseInt(ds1[0]);
	var month1 = parseInt(ds1[1]);
	var date1 = parseInt(ds1[2]);

	var ds2 = dStr2.split("-");
	var year2 = parseInt(ds2[0]);
	var month2 = parseInt(ds2[1]);
	var date2 = parseInt(ds2[2]);

	var d1 = new Date(year1, month1, date1);
	var d2 = new Date(year2, month2, date2);
	var MinMilli = 1000 * 60;
   	var HrMilli = MinMilli * 60;
   	var DyMilli = HrMilli * 24;

	return Math.round(Math.abs((d1.getTime() - d2.getTime()) / DyMilli));
}

function setFocus(obj){
	   if(obj != null){
		   obj.focus();
		   obj.select();
	   }
}