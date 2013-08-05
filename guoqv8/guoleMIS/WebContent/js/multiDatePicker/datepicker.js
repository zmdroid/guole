/**
 * 数组扩展
 * @class $Kit.Array
 * @requires kit.js
 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/array.js">Source code</a>
 */
$Kit.Array = function(config) {
	//
}
$Kit.Array.prototype =
/**
 * lends $Kit.Array.prototype
 */
{
	/**
	 * 从小到大排序
	 * @param {Number}
	 * @param {Number}
	 * @return {Array}
	 * @private
	 */
	SORT_ASC : function(left, right) {
		return left - right;
	},
	/**
	 * 从大到小排序
	 * @param {Number}
	 * @param {Number}
	 * @return {Array}
	 * @private
	 */
	SORT_DESC : function(left, right) {
		return right - left;
	},
	/**
	 * 判断是否存在
	 * @param {Array}
	 * @param {Object}
	 * @param {Object} config
	 * @param {Boolean} config.ignoreCase 判断是否相等时候，是否忽略大小写
	 * @return {Boolean}
	 */
	hs : function(ary, check, setting) {
		var me = this;
		if(!$kit.isAry(ary)) {
			return;
		}
		var defaultSetting = {
			ignoreCase : false
		}
		var setting = $kit.merge(defaultSetting, setting);
		for(var i = 0; i < ary.length; i++) {
			var o = ary[i];
			if(o == check//
			|| (setting.ignoreCase && o.toString().toLowerCase() == check.toString().toLowerCase())) {
				return true;
			}
		}
		return false;
	},
	/**
	 * 向数组中添加元素
	 * @param {Array}
	 * @param {Object|Array}
	 * @param {Object} config
	 * @param {Boolean} config.ifExisted 为true时候，则进行存在判断，存在则不加，为false，直接第一个数组冗余相加
	 * @param {Boolean} config.ignoreCase 判断是否相等时候，是否忽略大小写
	 */
	ad : function(ary, add, setting) {
		var me = this;
		if(!$kit.isAry(ary)) {
			return;
		}
		var defaultSetting = {
			ifExisted : false,
			ignoreCase : false
		}
		var setting = $kit.merge(defaultSetting, setting);
		if($kit.isAry(add)) {
			for(var i = 0; i < add.length; i++) {
				me.ad(ary, add[i], setting);
			}
		} else {
			if(setting.ifExisted && ary.length > 0) {
				for(var i = 0; i < ary.length; i++) {
					var o = ary[i];
					if(o == add//
					|| (setting.ignoreCase && o.toString().toLowerCase() == add.toString().toLowerCase())) {
						break;
					} else if(i == ary.length - 1) {
						ary.push(add);
					}
				}
			} else {
				ary.push(add);
			}
		}
	},
	/**
	 * 数组删除元素
	 * @param {Array}
	 * @param {Object|Array}
	 * @param {Object} config
	 * @param {Boolean} config.ignoreCase 判断是否相等时候，是否忽略大小写
	 * @param {Boolean} config.isGlobal 是否全局检查，不仅仅删除第一个发现的
	 */
	rm : function(ary, del, setting) {
		var me = this;
		if(!$kit.isAry(ary)) {
			return;
		}
		var defaultSetting = {
			ignoreCase : false,
			isGlobal : true
		}
		var setting = $kit.merge(defaultSetting, setting);
		if($kit.isAry(del)) {
			for(var i = 0; i < del.length; i++) {
				me.rm(ary, del[i], setting);
			}
		} else {
			for(var i = 0; i < ary.length; i++) {
				var o = ary[i];
				if(o == del//
				|| (setting.ignoreCase && o.toString().toLowerCase() == del.toString().toLowerCase())) {
					ary.splice(i, 1);
					if(setting.isGlobal) {
						continue;
					} else {
						break;
					}
				}
			}
		}
	},
	/**
	 * 排序
	 * @param {Array}
	 * @param {String} param 排序类型，目前支持ASC从小到大,DESC从大到小两种类型
	 * @rettun {Array} 返回被排序的数组
	 */
	sort : function(ary, param) {
		var me = this;
		if($kit.isEmpty(ary) || $kit.isEmpty(param)) {
			return;
		}
		if($kit.isFn(param)) {
			return ary.sort(param);
		} else {
			switch (param) {
				case "ASC" :
					return ary.sort(me.SORT_ASC);
				case "DESC" :
					return ary.sort(me.SORT_DESC);
			}
		}
	},
	/**
	 * 通过比较方法取得值
	 * @param {Array}
	 * @param {Function} validateFn 遍历数组，执行该方法，等方法返回true时候，获得数组中对应值。方法传入三个参数，当前元素，当前元素索引，数组
	 * @param {Object} [scope] 执行方法时候的this指针
	 * @return {Object}
	 */
	get : function(ary, validateFn, scope) {
		var scope = scope || window;
		for(var i = 0; i < ary.length; i++) {
			if(validateFn.call(scope, ary[i], i, ary) == true) {
				return ary[i];
			}
		}
	},
	/**
	 * 遍历数组，获得数组中元素以xxx文字开头的
	 * @param {Array}
	 * @param {String}
	 * @return {Object}
	 */
	getTextBeginWith : function(ary, beginWithText) {
		var me = this;
		return me.get(ary, function(o) {
			if(o.indexOf(beginWithText) == 0) {
				return true;
			}
		});
	},
	/**
	 * 把字符串按照分隔符转换成数组
	 * @param {String}
	 * @param {String} [separate] 默认值为','
	 * @return {Array}
	 */
	parse : function(str, separate) {
		var separate = ',' || separate;
		return (str && str.split(separate)) || [str]
	},
	/**
	 * 过滤满足条件的数组元素
	 * @param {Array}
	 * @param {Function} 方法传入三个参数，当前元素，当前元素索引，数组
	 * @return {Array}
	 */
	filter : function(ary, compare) {
		var re = [];
		$kit.each(ary, function(o, i, ary) {
			if(compare(o, i, ary)) {
				re.push(o);
			}
		});
		return re;
	},
	/**
	 * 返回指定元素在数组的第几个，从0开始
	 * @param {Array}
	 * @param {Object}
	 * @return {Number}
	 */
	indexOf : function(ary, obj) {
		var index = -1;
		if(obj != null) {
			$kit.each(ary, function(o, idx) {
				if(obj == o) {
					index = idx;
					return false;
				}
			});
		}
		return index;
	},
	/**
	 * 克隆一个新的数组
	 * @param {Array}
	 * @param {Array}
	 */
	clone : function(ary) {
		var re = [];
		$kit.each(ary, function(o) {
			re.push(o);
		});
		return re;
	},
	/**
	 * 删除数组中空的元素
	 * @param {Array}
	 * @return {Array}
	 */
	delEmpty : function(ary) {
		for(var i = 0; i < ary.length; ) {
			if(ary[i] == '' || ary[i] == null) {
				ary.splice(i, 1);
			} else {
				i++;
			}
		}
		return ary;
	},
	/**
	 * 删除重复元素，不保证顺序
	 * @param {Array}
	 * @return {Array}
	 */
	rmRepeat : function(ary) {
		var tmp = {}, re = [];
		$kit.each(ary, function(o) {
			tmp[o] = 1;
		});
		for(var o in tmp) {
			re.push(o);
		}
		return re;
	}
};
/**
 * $Kit.Array实例，直接通过这个实例访问$Kit.Array所有方法
 * @global
 * @type $Kit.Array
 * @name $kit.array
 * @alias $kit.ary
 */
$kit.ary = $kit.array = new $Kit.Array();
/**
 * 日期时间扩展
 * @class $Kit.Date
 * @requires kit.js
 * @requires math.js
 * @requires array.js
 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/date.js">Source code</a>
 */
$Kit.Date = function() {
	//
}
$kit.merge($Kit.Date.prototype,
/**
 * @lends $Kit.Date.prototype
 */
{
	/**
	 * 返回时间，单位秒 dd:dd:dd 时:分:秒
	 * @param {String}
	 * @return {Date}
	 */
	parseTime : function(timeStr) {
		if($kit.isEmpty(timeStr)) {
			return undefined;
		}
		var me = this;
		var a = timeStr.split(":");
		var hours, minutes, seconds;
		if(a.length == 3) {
			hours = parseFloat(a[0]);
			minutes = parseFloat(a[1]);
			seconds = parseFloat(a[2]);
		} else if(a.length == 2) {
			hours = 0;
			minutes = parseFloat(a[0]);
			seconds = parseFloat(a[1]);
		} else {
			hours = 0;
			minutes = 0;
			seconds = parseFloat(a[0]);
		}
		var time = hours * 60 * 60 + minutes * 60 + seconds;
		time = Math.round(time);
		return time;
	},
	/**
	 * 返回时间字符串 dd:dd:dd，参数time，单位秒
	 * @param {String}
	 * @return {String}
	 */
	formatTime : function(time) {
		time = parseFloat(time);
		var me = this;
		var minutes = Math.floor(time / 60);
		var hours = Math.floor(minutes / 60);
		minutes = minutes % 60;
		var seconds = (time % 60).toFixed(0);
		return $kit.math.padZero(hours, 2) + ":" + $kit.math.padZero(minutes, 2) + ":" + $kit.math.padZero(seconds, 2);
	},
	/**
	 * 是否闰年
	 * @param {Date}
	 * @return {Boolean}
	 */
	isLeapYear : function(year) {
		return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0))
	},
	/**
	 * 一个月有多少天
	 * @param {Date}
	 * @param {String}
	 * @return {Number}
	 */
	getDaysInMonth : function(year, month) {
		return [31, (this.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month]
	},
	//格式
	validParts : /E{1}|D{1}|F{1}|a{1}|hh{1}|HH{1}|SS{1}|ss{1}|dd{1}|mm{1}|MM{1}|yy(?:yy){1}/g,
	dateSplitRegExp : /(E{1}|D{1}|F{1}|a{1}|hh{1}|HH{1}|SS{1}|ss{1}|dd{1}|mm{1}|MM{1}|yy(?:yy){1})/g,
	nonpunctuation : /[^ -\/:-@\[-`{-~\t\n\r\D]+/g,
	/**
	 * 解析时间格式
	 * @param {String} format 如"yyyy年MM月dd日"
	 */
	parseFormat : function(format) {
		// IE treats \0 as a string end in inputs (truncating the value),
		// so it's a bad format delimiter, anyway
		var separators = $kit.array.delEmpty(format.replace(this.validParts, '\0').split('\0')), //
		parts = $kit.array.delEmpty((format.match(this.validParts))), //
		date = $kit.array.delEmpty(format.split(this.dateSplitRegExp));
		if(!separators || !separators.length || !parts || parts.length == 0) {
			throw new Error("Invalid date format.");
		}
		return {
			separators : separators,
			parts : parts,
			date : date
		};
	},
	/**
	 * 日期语言包
	 * @member
	 * @enum
	 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/date.js">查看代码</a>
	 */
	languagePack : {
		/**
		 * 英文月份语言包
		 */
		en : {
			days : ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
			daysShort : ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
			daysMin : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"],
			months : ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
			monthsShort : ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			weekStart : 0
		},
		/**
		 * 中文月份语言包
		 */
		cn : {
			days : ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
			daysShort : ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
			daysMin : ["七", "一", "二", "三", "四", "五", "六", "七"],
			months : ["一月份", "二月份", "三月份", "四月份", "五月份", "六月份", "七月份", "八月份", "九月份", "十月份", "十一月", "十二月"],
			monthsShort : ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
			weekStart : 1
		}
	},
	/**
	 * 解析日期
	 * @param {Date}
	 * @param {DateFormat} format 需要$kit.date.parseFormat('yyyy年MM月dd日')
	 * @param {String} [language] 语言包，默认中文
	 * @return {Date}
	 */
	parseDate : function(date, format, language) {
		var me = this;
		if( date instanceof Date) {
			return date;
		}
		language = language || 'en';
		if(/^[-+]\d+[dmwy]([\s,]+[-+]\d+[dmwy])*$/.test(date)) {
			var part_re = /([-+]\d+)([dmwy])/, parts = date.match(/([-+]\d+)([dmwy])/g), part, dir;
			date = new Date();
			for(var i = 0; i < parts.length; i++) {
				part = part_re.exec(parts[i]);
				dir = parseInt(part[1]);
				switch(part[2]) {
					case 'd':
						date.setDate(date.getDate() + dir);
						break;
					case 'm':
						this.moveMonth.call(date, dir);
						break;
					case 'w':
						date.setDate(date.getDate() + dir * 7);
						break;
					case 'y':
						this.moveYear(date, dir);
						break;
				}
			}
			return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
		}
		var parts = date ? date.match(this.nonpunctuation) : [], date = new Date(), val, filtered;
		date = new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
		if(parts.length == format.parts.length) {
			for(var i = 0, cnt = format.parts.length; i < cnt; i++) {
				val = parseInt(parts[i], 10) || 1;
				switch(format.parts[i]) {
					case 'MM':
						filtered = $kit.array.filter(this.languagePack[language].months, function(o, index, ary) {
							var m = ary.slice(0, parts[i].length), p = parts[i].slice(0, m.length);
							return m == p;
						});
						if(filtered && filtered.length) {
							val = $kit.array.indexOf(this.languagePack[language].months, filtered[0]) + 1;
						}
						break;
					case 'M':
						filtered = $kit.array.filter(this.languagePack[language].monthsShort, function(o, index, ary) {
							var m = ary.slice(0, parts[i].length), p = parts[i].slice(0, m.length);
							return m == p;
						});
						if(filtered && filtered.length) {
							val = $kit.array.indexOf(this.languagePack[language].monthsShort, filtered[0]) + 1;
						}
						break;
				}
				switch(format.parts[i]) {
					case 'dd':
					case 'd':
						date.setDate(val);
						break;
					case 'mm':
					case 'm':
					case 'MM':
					case 'M':
						date.setMonth(val - 1);
						break;
					case 'yy':
						date.setFullYear(2000 + val);
						break;
					case 'yyyy':
						date.setFullYear(val);
						break;
				}
			}
		}
		return date;
	},
	/**
	 * 改变月份
	 * @param {Date}
	 * @param {Number} dir 月份增量
	 * @return {Date}
	 */
	addMonths : function(date, months) {
		return this.moveMonth(date, months)
	},
	/**
	 * 改变月份
	 * @param {Date}
	 * @param {Number} dir 月份增量
	 * @return {Date}
	 * @private
	 */
	moveMonth : function(date, dir) {
		if(!dir)
			return date;
		var new_date = new Date(date.valueOf()), day = new_date.getDate(), month = new_date.getMonth(), mag = Math.abs(dir), new_month, test;
		dir = dir > 0 ? 1 : -1;
		if(mag == 1) {
			test = dir == -1
			// If going back one month, make sure month is not current month
			// (eg, Mar 31 -> Feb 31 == Feb 28, not Mar 02)
			? function() {
				return new_date.getMonth() == month;
			}
			// If going forward one month, make sure month is as expected
			// (eg, Jan 31 -> Feb 31 == Feb 28, not Mar 02)
			: function() {
				return new_date.getMonth() != new_month;
			};
			new_month = month + dir;
			new_date.setMonth(new_month);
			// Dec -> Jan (12) or Jan -> Dec (-1) -- limit expected date to 0-11
			if(new_month < 0 || new_month > 11)
				new_month = (new_month + 12) % 12;
		} else {
			// For magnitudes >1, move one month at a time...
			for(var i = 0; i < mag; i++)
			// ...which might decrease the day (eg, Jan 31 to Feb 28, etc)...
			new_date = this.moveMonth(new_date, dir);
			// ...then reset the day, keeping it in the new month
			new_month = new_date.getMonth();
			new_date.setDate(day);
			test = function() {
				return new_month != new_date.getMonth();
			};
		}
		// Common date-resetting loop -- if date is beyond end of month, make it
		// end of month
		while(test()) {
			new_date.setDate(--day);
			new_date.setMonth(new_month);
		}
		return new_date;
	},
	/**
	 * 改变年份
	 * @param {Date}
	 * @param {Number} dir 年份增量
	 * @return {Date}
	 */
	addYears : function(date, years) {
		return this.moveYear(date, years)
	},
	/**
	 * 改变年份
	 * @param {Date}
	 * @param {Number} dir 年份增量
	 * @return {Date}
	 * @private
	 */
	moveYear : function(date, dir) {
		return this.moveMonth(date, dir * 12);
	},
	/**
	 * 按照format格式（如yyyy年MM月dd日）格式化日期
	 * @param {Date}
	 * @param {DateFormat} format 需要$kit.date.parseFormat('yyyy年MM月dd日')
	 * @param {String} [language] 语言
	 * @return {String}
	 */
	formatDate : function(date, format, language) {
		var me = this;
		var val = {
			d : date.getDate(),
			m : date.getMonth() + 1,
			M : me.languagePack[language].monthsShort[date.getMonth()],
			MM : me.languagePack[language].months[date.getMonth()],
			yy : date.getFullYear().toString().substring(2),
			yyyy : date.getFullYear()
		};
		val.dd = (val.d < 10 ? '0' : '') + val.d;
		val.mm = (val.m < 10 ? '0' : '') + val.m;
		var date = [];
		$kit.each(format.date, function(o) {
			if(val[o]) {
				date.push(val[o]);
			} else {
				date.push(o);
			}
		});
		return date.join('');
	},
	/**
	 * 返回当前日期，时分秒为00
	 * @return {Date}
	 */
	dateNow : function() {
		var d = new Date();
		d.setMinutes(0);
		d.setSeconds(0);
		d.setHours(0);
		d.setMilliseconds(0);
		return d;
	},
	/**
	 * 增加天数
	 * @param {Date}
	 * @param {Number}
	 * @return {Date}
	 */
	addDays : function(date, days) {
		date.setDate(date.getDate() + days);
	}
});
/**
 * $Kit.Date的实例，直接通过这个实例访问$Kit.Date所有方法
 * @global
 * @type $Kit.Date
 */
$kit.date = new $Kit.Date();
/**
 * Dom扩展
 * @class $Kit.Dom
 * @requires kit.js
 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/dom.js">Source code</a>
 */
$Kit.Dom = function() {
	//
}
$kit.merge($Kit.Dom.prototype,
/**
 * @lends $Kit.Dom.prototype
 */
{
	/**
	 * 根据tagName查找父元素
	 * @param {Element}
	 * @param {String}
	 * @param {Element} [topEl] 到topEl停止查找
	 * @return {Element|Null}
	 */
	parentEl8tag : function(el, tagName, topEl) {
		var topEl = topEl || document.body;
		return $kit.parentEl(el, function(p) {
			if(p.tagName && p.tagName.toLowerCase() == tagName.toLowerCase()) {
				return true;
			}
			if(p == topEl) {
				return false;
			}
		}, topEl);
	},
	/**
	 * 根据className查找父元素
	 * @param {Element}
	 * @param {String}
	 * @param {Element} [topEl] 到topEl停止查找
	 * @return {Element|Null}
	 */
	parentEl8cls : function(el, cls, topEl) {
		var topEl = topEl || document.body;
		return $kit.parentEl(el, function(p) {
			if($kit.hsCls(p, cls)) {
				return true;
			}
			if(p == topEl) {
				return false;
			}
		}, topEl);
	},
	/**
	 * 注入script块
	 * @param {Object} config
	 * @param {String} config.id 注入script的id，自定义，只要与现有dom里面的元素id不相同即可
	 * @param {String} [config.url] 注入script的加载url
	 * @param {String} [config.text] 注入script的script内容
	 * @param {String} [config.then] 注入script的加载完毕的回调方法
	 * @param {String} [config.scope] 注入script的回调方法的this指针
	 * @return {Element} script
	 */
	injectJs : function() {
		if(arguments.length == 1) {
			var config = arguments[0];
			if(config.id && $kit.el8id(config.id)) {
				return;
			}
			config.id = config.id || $kit.onlyId();
			var where = config.where || window.document.body;
			var script = document.createElement('script');
			$kit.attr(script, 'type', 'text/javascript');
			if(config.id) {
				$kit.attr(script, 'id', config.id);
			}
			if(!$kit.isEmpty(config.url)) {
				script.src = config.url;
				if(!$kit.isEmpty(config.then)) {
					var scope = config.scope || window;
					script.onload = function() {
						config.then.call(scope, script);
					}
				}
			} else if(!$kit.isEmpty(config.text)) {
				script.innerHTML = config.text;
				if(!$kit.isEmpty(config.then)) {
					setTimeout(function() {
						config.then.call(scope, script);
					}, 0);
				}
			}
			where.appendChild(script);
			return script;
		}
	},
	/**
	 * 注入css
	 * @param {Object} config
	 * @param {String} config.id 注入css的id，自定义，只要与现有dom里面的元素id不相同即可
	 * @param {String} [config.url] 注入css的url
	 * @param {String} [config.text] 如果没有url的话，写入style的文本
	 * @return {Element} css
	 */
	injectCss : function() {
		if(arguments.length == 1) {
			var config = arguments[0];
			if(config.id && $kit.el8id(config.id)) {
				return;
			}
			// Takes a string of css, inserts it into a `<style>`, then injects it in at the very top of the `<head>`. This ensures any user-defined styles will take precedence.
			var where = config.where || document.getElementsByTagName('head')[document.getElementsByTagName('head').length - 1];
			var css;
			if(!$kit.isEmpty(config.url)) {
				css = document.createElement('link');
				config.id && $kit.attr(css, 'id', config.id);
				$kit.attr(css, {
					rel : 'stylesheet',
					href : config.url
				});
			} else if(!$kit.isEmpty(config.text)) {
				css = document.createElement('style');
				config.id && $kit.attr(css, 'id', config.id);
				$kit.attr(css, 'type', 'text/css');
				css.innerHTML = config.text;
			}
			if(css) {
				$kit.insEl({
					pos : 'last',
					what : css,
					where : where
				});
			}
			return css;
		}
	},
	/**
	 * 删除所有样式
	 * @param {String}
	 * @param {Element}
	 */
	rmClsAll : function(cls, top) {
		var a = $kit.el8cls(cls, top);
		while(a) {
			$kit.rmCls(a, cls);
			a = $kit.el8cls(cls, top);
		}
	},
	/**
	 * 通过className前缀取className
	 * @param {Element}
	 * @param {String}
	 * @return {NodeList||Null}
	 */
	getClassNameByPrefix : function(el, prefixCls) {
		var clsAry = el.className.split(/\s+/);
		var re = null;
		if(clsAry && clsAry.length) {
			$kit.each(clsAry, function(o) {
				if(o.indexOf(prefixCls) == 0) {
					re = o;
					return false;
				}
			});
		}
		return re;
	},
	/**
	 * innerText
	 * @param {Element}
	 * @param {String} [text]
	 * @return {String|Null}
	 */
	text : function(el, text) {
		if(el != null && 'innerText' in el) {
			if(text) {
				el.innerText = text;
			} else {
				return el.innerText;
			}
		} else {
			if(text) {
				el.textContent = text;
			} else {
				return el.textContent;
			}
		}
	},
	/**
	 * innerHTML
	 * @param {Element}
	 * @param {String} [html]
	 * @return {String|Null}
	 */
	html : function(el, html) {
		if(html) {
			if(el != null && 'innerHTML' in el) {
				el.innerHTML = html;
			}
		} else {
			return el.innerHTML;
		}
	},
	/**
	 * clone a node
	 * @param {Element}
	 * @return {Element}
	 */
	clone : function(node) {
		if(document.createElement("nav").cloneNode(true).outerHTML !== "<:nav></:nav>") {
			return node.cloneNode(true);
		} else {
			var fragment = document.createDocumentFragment(), //
			doc = fragment.createElement ? fragment : document;
			doc.createElement(node.tagName);
			var div = doc.createElement('div');
			fragment.appendChild(div);
			div.innerHTML = node.outerHTML;
			return div.firstChild;
		}
	},
	/**
	 * height
	 * @param {Element}
	 * @param {Number} [value]
	 * @return {Number|Null}
	 */
	height : function(node, value) {
		var me = this;
		if(node != null) {
			if(value == null) {
				return $kit.offset(node).height;
			}
			if(document.compatMode == "BackCompat") {
				node.style.height = value;
			} else {
				node.style.height = value//
				- ($kit.css(node, 'border-top-width') || 0)//
				- ($kit.css(node, 'border-bottom-width') || 0)//
				- ($kit.css(node, 'padding-top-width') || 0)//
				- ($kit.css(node, 'padding-bottom-width') || 0)//
				;
			}
		}
		return $kit.viewport().clientHeight;
	},
	/**
	 * width
	 * @param {Element}
	 * @param {Number} [value]
	 * @return {Number|Null}
	 */
	width : function(node, value) {
		var me = this;
		if(node != null) {
			if(value == null) {
				return $kit.offset(node).width;
			}
			if(document.compatMode == "BackCompat") {
				node.style.width = value;
			} else {
				node.style.width = value//
				- ($kit.css(node, 'border-left-width') || 0)//
				- ($kit.css(node, 'border-right-width') || 0)//
				- ($kit.css(node, 'padding-left-width') || 0)//
				- ($kit.css(node, 'padding-right-width') || 0)//
				;
			}
		}
		return $kit.viewport().clientHeight;
	},
	/**
	 * height + padding
	 * @param {Element}
	 * @return {Number}
	 */
	innerHeight : function(node) {
		var me = this;
		if(document.compatMode == "BackCompat") {
			return $kit.css(node, 'height') - ($kit.css(node, 'border-top-width') || 0) - ($kit.css(node, 'border-bottom-width') || 0);
		}
		return $kit.css(node, 'height') + ($kit.css(node, 'padding-top-width') || 0) - ($kit.css(node, 'padding-bottom-width') || 0);
	},
	/**
	 * width + padding
	 * @param {Element}
	 * @return {Number}
	 */
	innerWidth : function(node) {
		var me = this;
		if(document.compatMode == "BackCompat") {
			return $kit.css(node, 'width') - ($kit.css(node, 'border-left-width') || 0) - ($kit.css(node, 'border-right-width') || 0);
		}
		return $kit.css(node, 'width') + ($kit.css(node, 'padding-left-width') || 0) - ($kit.css(node, 'padding-right-width') || 0);
	},
	/**
	 * height + padding + border
	 * @param {Element}
	 * @return {Number}
	 */
	outerHeight : function(node) {
		var me = this;
		if(document.compatMode == "BackCompat") {
			return $kit.css(node, 'height');
		}
		return $kit.css(node, 'height') + ($kit.css(node, 'padding-top-width') || 0) - ($kit.css(node, 'padding-bottom-width') || 0)//
		+ ($kit.css(node, 'border-top-width') || 0) + ($kit.css(node, 'border-bottom-width') || 0);
	},
	/**
	 * width + padding + border
	 * @param {Element}
	 * @return {Number}
	 */
	outerWidth : function(node) {
		var me = this;
		if(document.compatMode == "BackCompat") {
			return $kit.css(node, 'width');
		}
		return $kit.css(node, 'width') + ($kit.css(node, 'padding-left-width') || 0) - ($kit.css(node, 'padding-right-width') || 0)//
		+ ($kit.css(node, 'border-left-width') || 0) + ($kit.css(node, 'border-right-width') || 0);
	},
	/**
	 * 包围一个html
	 * @param {Element}
	 * @param {String}
	 */
	wrap : function(node, html) {
		if($kit.isNode(html)) {
			//
		} else if($kit.isStr(html)) {
			html = $kit.newHTML(html).childNodes[0];
		} else {
			return;
		}
		$kit.insEl({
			where : node,
			what : html,
			pos : 'before'
		});
		html.appendChild(node);
		return html;
	},
	/**
	 * 序列化form元素
	 * @param {Element}
	 * @param {String}
	 * @return {String}
	 */
	serialize : function(form) {
		if($kit.isNode(form)) {
			if(form.tagName.toLowerCase() == 'form') {
				var formEls = {};
				$kit.each($kit.el('input', form), function(o) {
					if(o.type && o.type.toString.toLowerCase() == 'text') {
						formEls[o.name] = o.value;
					} else if(o.type && o.type.toString().toLowerCase() == 'radio') {
						if(o.checked) {
							formEls[o.name] = o.value;
						}
					} else if(o.type && o.type.toString().toLowerCase() == 'checkbox') {
						if(o.checked) {
							if(!$kit.isAry(formEls[o.name])) {
								formEls[o.name] = [formEls[o.name]];
							}
							formEls[o.name].push(o.value);
						}
					}
				});
				$kit.each($kit.el('textarea', form), function(o) {
					formEls[o.name] = o.value;
				});
				$kit.each($kit.el('select', form), function(o) {
					formEls[o.name] = o.options[o.selectedIndex].value;
				});
				var re = [];
				for(var key in formEls) {
					if($kit.isAry(formEls[key])) {
						re.push(key + '=' + encodeURIComponent(formEls[key].join(',')));
					} else {
						re.push(key + '=' + encodeURIComponent(formEls[key]));
					}
				}
				return re.join('');
			}
			return form.name + '=' + encodeURIComponent($kit.val(form));
		}
	},
	/**
	 * 计算元素相对于他的offsetParent的偏移
	 * @param {Element}
	 * @return {Number} top 距离顶部
	 * @return {Number} left 距离左边
	 * @return {Number} height 高度
	 * @return {Number} width 宽度
	 * @return {Number} bottom 底部距离顶部
	 * @return {Number} right 右边距离最左边
	 * @return {Number} middleTop 中间距离顶部
	 * @return {Number} middleLeft 中间距离最左边
	 */
	position : function(el) {
		var me = this;
		if($kit.isEmpty(el)) {
			return;
		}
		var top = el.offsetTop, //
		left = el.offsetLeft, //
		width = el.offsetWidth, //
		height = el.offsetHeight;
		return {
			top : top,
			left : left,
			width : width,
			height : height,
			bottom : top + height,
			right : left + width,
			middleTop : top + height / 2,
			middleLeft : left + width / 2
		}
	},
	/**
	 * 计算元素相对于他的可视区的偏移
	 * @param {Element}
	 * @return {Number} top 距离顶部
	 * @return {Number} left 距离左边
	 * @return {Number} height 高度
	 * @return {Number} width 宽度
	 * @return {Number} bottom 底部距离顶部
	 * @return {Number} right 右边距离最左边
	 * @return {Number} middleTop 中间距离顶部
	 * @return {Number} middleLeft 中间距离最左边
	 */
	clientOffset : function(el) {
		var me = this;
		if($kit.isEmpty(el)) {
			return;
		}
		var offset = $kit.offset(el);
		var viewport = $kit.viewport();
		return {
			top : offset.top - viewport.scrollTop,
			left : offset.left - viewport.scrollLeft,
			width : offset.width,
			height : offset.height,
			bottom : offset.bottom - viewport.scrollTop,
			right : offset.right - viewport.scrollLeft,
			middleTop : offset.top - viewport.scrollTop + offset.height / 2,
			middleLeft : offset.left - viewport.scrollLeft + offset.width / 2
		}
	},
	/**
	 * 获取当一个元素居中的时候，他相对于doc绝对值的top,bottom,left,right等等
	 * @param {Element}
	 * @return {Number} top 距离顶部
	 * @return {Number} left 距离左边
	 * @return {Number} height 高度
	 * @return {Number} width 宽度
	 * @return {Number} bottom 底部距离顶部
	 * @return {Number} right 右边距离最左边
	 * @return {Number} middleTop 中间距离顶部
	 * @return {Number} middleLeft 中间距离最左边
	 */
	offsetCenter : function(el) {
		var me = this;
		var viewport = $kit.viewport();
		var offset = $kit.offset(el);
		return {
			top : viewport.clientHeight / 2 + viewport.scrollTop - offset.height / 2,
			left : viewport.clientWidth / 2 + viewport.scrollLeft - offset.width / 2,
			right : viewport.clientWidth / 2 + viewport.scrollLeft + offset.width / 2,
			bottom : viewport.clientHeight / 2 + viewport.scrollTop + offset.height / 2,
			middleTop : viewport.clientHeight / 2 + viewport.scrollTop,
			middleLeft : viewport.clientWidth / 2 + viewport.scrollLeft
		}
	},
	/**
	 * 获取当一个元素居中的时候，他相对于可视区域的top,bottom,left,right等等
	 * @param {Element}
	 * @return {Number} top 距离顶部
	 * @return {Number} left 距离左边
	 * @return {Number} height 高度
	 * @return {Number} width 宽度
	 * @return {Number} bottom 底部距离顶部
	 * @return {Number} right 右边距离最左边
	 * @return {Number} middleTop 中间距离顶部
	 * @return {Number} middleLeft 中间距离最左边
	 */
	clientOffsetCenter : function(el) {
		var me = this;
		var viewport = $kit.viewport();
		var offset = $kit.offset(el);
		return {
			top : (viewport.clientHeight / 2 - offset.height / 2),
			left : (viewport.clientWidth / 2 - offset.width / 2),
			right : (viewport.clientWidth / 2 + offset.width / 2),
			bottom : (viewport.clientHeight / 2 + offset.height / 2),
			middleTop : (viewport.clientHeight / 2),
			middleLeft : (viewport.clientWidth / 2)
		}
	},
	/**
	 * 获取当一个元素居中的时候，他相对于可视区域的top,bottom,left,right等等
	 * @param {Element}
	 * @return {Number} top 距离顶部
	 * @return {Number} left 距离左边
	 * @return {Number} height 高度
	 * @return {Number} width 宽度
	 * @return {Number} bottom 底部距离顶部
	 * @return {Number} right 右边距离最左边
	 * @return {Number} middleTop 中间距离顶部
	 * @return {Number} middleLeft 中间距离最左边
	 */
	clientPos : function(el) {
		var me = this;
		var viewport = $kit.viewport();
		var offset = $kit.offset(el);
		return {
			top : viewport.clientHeight / 2 + viewport.scrollTop - offset.height / 2,
			left : viewport.clientWidth / 2 + viewport.scrollLeft - offset.width / 2,
			right : viewport.clientWidth / 2 + viewport.scrollLeft + offset.width / 2,
			bottom : viewport.clientHeight / 2 + viewport.scrollTop + offset.height / 2,
			middleTop : viewport.clientHeight / 2 + viewport.scrollTop,
			middleLeft : viewport.clientWidth / 2 + viewport.scrollLeft
		}
	},
	/**
	 * 交换两个element的位置
	 */
	switchPos : function(origin, target) {
		var targetPos;
		if(target.previousSibling) {
			targetPos = {
				pos : 'after',
				where : target.previousSibling
			}
		} else {
			targetPos = {
				pos : 'first',
				where : target.parentNode
			}
		}
		$kit.insEl({
			pos : 'after',
			where : origin,
			what : target
		});
		$kit.insEl($kit.merge({
			what : origin
		}, targetPos));
	}
});
/**
 * $Kit.Dom的实例，直接通过这个实例访问$Kit.Dom所有方法
 * @global
 * @name $kit.dom
 * @alias $kit.d
 * @type $Kit.Dom
 */
$kit.dom = $kit.d = new $Kit.Dom();
/*
 * Sizzle CSS Selector Engine
 *  Copyright 2011, The Dojo Foundation
 *  Released under the MIT, BSD, and GPL Licenses.
 *  More information: http://sizzlejs.com/
 *
 * version: 1.5.1-34
 * update 2012/04/26
 */

(function() {
	var chunker = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g, expando = "sizcache" + (Math.random() + '').replace('.', ''), done = 0, toString = Object.prototype.toString, hasDuplicate = false, baseHasDuplicate = true, rBackslash = /\\/g, rNonWord = /\W/;

	// Here we check if the JavaScript engine is using some sort of
	// optimization where it does not always call our comparision
	// function. If that is the case, discard the hasDuplicate value.
	//   Thus far that includes Google Chrome.
	[0, 0].sort(function() {
		baseHasDuplicate = false;
		return 0;
	});
	var Sizzle = function(selector, context, results, seed) {
		results = results || [];
		context = context || document;

		var origContext = context;

		if(context.nodeType !== 1 && context.nodeType !== 9) {
			return [];
		}

		if(!selector || typeof selector !== "string") {
			return results;
		}

		var m, set, checkSet, extra, ret, cur, pop, i, prune = true, contextXML = Sizzle.isXML(context), parts = [], soFar = selector;

		// Reset the position of the chunker regexp (start from head)
		do {
			chunker.exec("");
			m = chunker.exec(soFar);

			if(m) {
				soFar = m[3];

				parts.push(m[1]);

				if(m[2]) {
					extra = m[3];
					break;
				}
			}
		} while ( m );

		if(parts.length > 1 && origPOS.exec(selector)) {

			if(parts.length === 2 && Expr.relative[parts[0]]) {
				set = posProcess(parts[0] + parts[1], context, seed);

			} else {
				set = Expr.relative[parts[0]] ? [context] : Sizzle(parts.shift(), context);

				while(parts.length) {
					selector = parts.shift();

					if(Expr.relative[selector]) {
						selector += parts.shift();
					}
					set = posProcess(selector, set, seed);
				}
			}

		} else {
			// Take a shortcut and set the context if the root selector is an ID
			// (but not if it'll be faster if the inner selector is an ID)
			if(!seed && parts.length > 1 && context.nodeType === 9 && !contextXML && Expr.match.ID.test(parts[0]) && !Expr.match.ID.test(parts[parts.length - 1])) {
				ret = Sizzle.find(parts.shift(), context, contextXML);
				context = ret.expr ? Sizzle.filter( ret.expr, ret.set )[0] : ret.set[0];
			}

			if(context) {
				ret = seed ? {
					expr : parts.pop(),
					set : makeArray(seed)
				} : Sizzle.find(parts.pop(), parts.length === 1 && (parts[0] === "~" || parts[0] === "+") && context.parentNode ? context.parentNode : context, contextXML);
				set = ret.expr ? Sizzle.filter(ret.expr, ret.set) : ret.set;

				if(parts.length > 0) {
					checkSet = makeArray(set);

				} else {
					prune = false;
				}

				while(parts.length) {
					cur = parts.pop();
					pop = cur;

					if(!Expr.relative[cur]) {
						cur = "";
					} else {
						pop = parts.pop();
					}

					if(pop == null) {
						pop = context;
					}

					Expr.relative[ cur ](checkSet, pop, contextXML);
				}

			} else {
				checkSet = parts = [];
			}
		}

		if(!checkSet) {
			checkSet = set;
		}

		if(!checkSet) {
			Sizzle.error(cur || selector);
		}

		if(toString.call(checkSet) === "[object Array]") {
			if(!prune) {
				results.push.apply(results, checkSet);

			} else if(context && context.nodeType === 1) {
				for( i = 0; checkSet[i] != null; i++) {
					if(checkSet[i] && (checkSet[i] === true || checkSet[i].nodeType === 1 && Sizzle.contains(context, checkSet[i]))) {
						results.push(set[i]);
					}
				}

			} else {
				for( i = 0; checkSet[i] != null; i++) {
					if(checkSet[i] && checkSet[i].nodeType === 1) {
						results.push(set[i]);
					}
				}
			}

		} else {
			makeArray(checkSet, results);
		}

		if(extra) {
			Sizzle(extra, origContext, results, seed);
			Sizzle.uniqueSort(results);
		}

		return results;
	};

	Sizzle.uniqueSort = function(results) {
		if(sortOrder) {
			hasDuplicate = baseHasDuplicate;
			results.sort(sortOrder);

			if(hasDuplicate) {
				for(var i = 1; i < results.length; i++) {
					if(results[i] === results[i - 1]) {
						results.splice(i--, 1);
					}
				}
			}
		}

		return results;
	};

	Sizzle.matches = function(expr, set) {
		return Sizzle(expr, null, null, set);
	};

	Sizzle.matchesSelector = function(node, expr) {
		return Sizzle(expr, null, null, [node]).length > 0;
	};

	Sizzle.find = function(expr, context, isXML) {
		var set, i, len, match, type, left;

		if(!expr) {
			return [];
		}

		for( i = 0, len = Expr.order.length; i < len; i++) {
			type = Expr.order[i];

			if(( match = Expr.leftMatch[type].exec(expr))) {
				left = match[1];
				match.splice(1, 1);

				if(left.substr(left.length - 1) !== "\\") {
					match[1] = (match[1] || "").replace(rBackslash, "");
					set = Expr.find[ type ](match, context, isXML);

					if(set != null) {
						expr = expr.replace(Expr.match[type], "");
						break;
					}
				}
			}
		}

		if(!set) {
			set = typeof context.getElementsByTagName !== "undefined" ? context.getElementsByTagName("*") : [];
		}

		return {
			set : set,
			expr : expr
		};
	};

	Sizzle.filter = function(expr, set, inplace, not) {
		var match, anyFound, type, found, item, filter, left, i, pass, old = expr, result = [], curLoop = set, isXMLFilter = set && set[0] && Sizzle.isXML(set[0]);

		while(expr && set.length) {
			for(type in Expr.filter ) {
				if(( match = Expr.leftMatch[type].exec(expr)) != null && match[2]) {
					filter = Expr.filter[type];
					left = match[1];
					anyFound = false;

					match.splice(1, 1);

					if(left.substr(left.length - 1) === "\\") {
						continue;
					}

					if(curLoop === result) {
						result = [];
					}

					if(Expr.preFilter[type]) {
						match = Expr.preFilter[ type ](match, curLoop, inplace, result, not, isXMLFilter);

						if(!match) {
							anyFound = found = true;

						} else if(match === true) {
							continue;
						}
					}

					if(match) {
						for( i = 0; ( item = curLoop[i]) != null; i++) {
							if(item) {
								found = filter(item, match, i, curLoop);
								pass = not ^ found;

								if(inplace && found != null) {
									if(pass) {
										anyFound = true;

									} else {
										curLoop[i] = false;
									}

								} else if(pass) {
									result.push(item);
									anyFound = true;
								}
							}
						}
					}

					if(found !== undefined) {
						if(!inplace) {
							curLoop = result;
						}
						expr = expr.replace(Expr.match[type], "");

						if(!anyFound) {
							return [];
						}

						break;
					}
				}
			}

			// Improper expression
			if(expr === old) {
				if(anyFound == null) {
					Sizzle.error(expr);

				} else {
					break;
				}
			}
			old = expr;
		}

		return curLoop;
	};

	Sizzle.error = function(msg) {
		throw new Error("Syntax error, unrecognized expression: " + msg);
	};
	/**
	 * Utility function for retreiving the text value of an array of DOM nodes
	 * @param {Array|Element} elem
	 */
	var getText = Sizzle.getText = function(elem) {
		var i, node, nodeType = elem.nodeType, ret = "";

		if(nodeType) {
			if(nodeType === 1 || nodeType === 9 || nodeType === 11) {
				// Use textContent for elements
				// innerText usage removed for consistency of new lines (see #11153)
				if( typeof elem.textContent === "string") {
					return elem.textContent;
				} else {
					// Traverse it's children
					for( elem = elem.firstChild; elem; elem = elem.nextSibling) {
						ret += getText(elem);
					}
				}
			} else if(nodeType === 3 || nodeType === 4) {
				return elem.nodeValue;
			}
		} else {

			// If no nodeType, this is expected to be an array
			for( i = 0; ( node = elem[i]); i++) {
				// Do not traverse comment nodes
				if(node.nodeType !== 8) {
					ret += getText(node);
				}
			}
		}
		return ret;
	};
	var Expr = Sizzle.selectors = {
		order : ["ID", "NAME", "TAG"],

		match : {
			ID : /#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,
			CLASS : /\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,
			NAME : /\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/,
			ATTR : /\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/,
			TAG : /^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/,
			CHILD : /:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/,
			POS : /:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/,
			PSEUDO : /:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/
		},

		leftMatch : {},

		attrMap : {
			"class" : "className",
			"for" : "htmlFor"
		},

		attrHandle : {
			href : function(elem) {
				return elem.getAttribute("href");
			},
			type : function(elem) {
				return elem.getAttribute("type");
			}
		},

		relative : {
			"+" : function(checkSet, part) {
				var isPartStr = typeof part === "string", isTag = isPartStr && !rNonWord.test(part), isPartStrNotTag = isPartStr && !isTag;

				if(isTag) {
					part = part.toLowerCase();
				}

				for(var i = 0, l = checkSet.length, elem; i < l; i++) {
					if(( elem = checkSet[i])) {
						while(( elem = elem.previousSibling) && elem.nodeType !== 1) {
						}

						checkSet[i] = isPartStrNotTag || elem && elem.nodeName.toLowerCase() === part ? elem || false : elem === part;
					}
				}

				if(isPartStrNotTag) {
					Sizzle.filter(part, checkSet, true);
				}
			},
			">" : function(checkSet, part) {
				var elem, isPartStr = typeof part === "string", i = 0, l = checkSet.length;

				if(isPartStr && !rNonWord.test(part)) {
					part = part.toLowerCase();

					for(; i < l; i++) {
						elem = checkSet[i];

						if(elem) {
							var parent = elem.parentNode;
							checkSet[i] = parent.nodeName.toLowerCase() === part ? parent : false;
						}
					}

				} else {
					for(; i < l; i++) {
						elem = checkSet[i];

						if(elem) {
							checkSet[i] = isPartStr ? elem.parentNode : elem.parentNode === part;
						}
					}

					if(isPartStr) {
						Sizzle.filter(part, checkSet, true);
					}
				}
			},
			"" : function(checkSet, part, isXML) {
				var nodeCheck, doneName = done++, checkFn = dirCheck;

				if( typeof part === "string" && !rNonWord.test(part)) {
					part = part.toLowerCase();
					nodeCheck = part;
					checkFn = dirNodeCheck;
				}

				checkFn("parentNode", part, doneName, checkSet, nodeCheck, isXML);
			},
			"~" : function(checkSet, part, isXML) {
				var nodeCheck, doneName = done++, checkFn = dirCheck;

				if( typeof part === "string" && !rNonWord.test(part)) {
					part = part.toLowerCase();
					nodeCheck = part;
					checkFn = dirNodeCheck;
				}

				checkFn("previousSibling", part, doneName, checkSet, nodeCheck, isXML);
			}
		},

		find : {
			ID : function(match, context, isXML) {
				if( typeof context.getElementById !== "undefined" && !isXML) {
					var m = context.getElementById(match[1]);
					// Check parentNode to catch when Blackberry 4.6 returns
					// nodes that are no longer in the document #6963
					return m && m.parentNode ? [m] : [];
				}
			},
			NAME : function(match, context) {
				if( typeof context.getElementsByName !== "undefined") {
					var ret = [], results = context.getElementsByName(match[1]);

					for(var i = 0, l = results.length; i < l; i++) {
						if(results[i].getAttribute("name") === match[1]) {
							ret.push(results[i]);
						}
					}

					return ret.length === 0 ? null : ret;
				}
			},
			TAG : function(match, context) {
				if( typeof context.getElementsByTagName !== "undefined") {
					return context.getElementsByTagName(match[1]);
				}
			}
		},
		preFilter : {
			CLASS : function(match, curLoop, inplace, result, not, isXML) {
				match = " " + match[1].replace(rBackslash, "") + " ";

				if(isXML) {
					return match;
				}

				for(var i = 0, elem; ( elem = curLoop[i]) != null; i++) {
					if(elem) {
						if(not ^ (elem.className && (" " + elem.className + " ").replace(/[\t\n\r]/g, " ").indexOf(match) >= 0)) {
							if(!inplace) {
								result.push(elem);
							}

						} else if(inplace) {
							curLoop[i] = false;
						}
					}
				}

				return false;
			},
			ID : function(match) {
				return match[1].replace(rBackslash, "");
			},
			TAG : function(match, curLoop) {
				return match[1].replace(rBackslash, "").toLowerCase();
			},
			CHILD : function(match) {
				if(match[1] === "nth") {
					if(!match[2]) {
						Sizzle.error(match[0]);
					}

					match[2] = match[2].replace(/^\+|\s*/g, '');

					// parse equations like 'even', 'odd', '5', '2n', '3n+2', '4n-1', '-n+6'
					var test = /(-?)(\d*)(?:n([+\-]?\d*))?/.exec(match[2] === "even" && "2n" || match[2] === "odd" && "2n+1" || !/\D/.test(match[2]) && "0n+" + match[2] || match[2]);

					// calculate the numbers (first)n+(last) including if they are negative
					match[2] = (test[1] + (test[2] || 1)) - 0;
					match[3] = test[3] - 0;
				} else if(match[2]) {
					Sizzle.error(match[0]);
				}

				// TODO: Move to normal caching system
				match[0] = done++;

				return match;
			},
			ATTR : function(match, curLoop, inplace, result, not, isXML) {
				var name = match[1] = match[1].replace(rBackslash, "");

				if(!isXML && Expr.attrMap[name]) {
					match[1] = Expr.attrMap[name];
				}

				// Handle if an un-quoted value was used
				match[4] = (match[4] || match[5] || "" ).replace(rBackslash, "");

				if(match[2] === "~=") {
					match[4] = " " + match[4] + " ";
				}

				return match;
			},
			PSEUDO : function(match, curLoop, inplace, result, not) {
				if(match[1] === "not") {
					// If we're dealing with a complex expression, or a simple one
					if((chunker.exec(match[3]) || "" ).length > 1 || /^\w/.test(match[3])) {
						match[3] = Sizzle(match[3], null, null, curLoop);

					} else {
						var ret = Sizzle.filter(match[3], curLoop, inplace, true ^ not);

						if(!inplace) {
							result.push.apply(result, ret);
						}

						return false;
					}

				} else if(Expr.match.POS.test(match[0]) || Expr.match.CHILD.test(match[0])) {
					return true;
				}

				return match;
			},
			POS : function(match) {
				match.unshift(true);

				return match;
			}
		},

		filters : {
			enabled : function(elem) {
				return elem.disabled === false && elem.type !== "hidden";
			},
			disabled : function(elem) {
				return elem.disabled === true;
			},
			checked : function(elem) {
				return elem.checked === true;
			},
			selected : function(elem) {
				// Accessing this property makes selected-by-default
				// options in Safari work properly
				if(elem.parentNode) {
					elem.parentNode.selectedIndex
				}

				return elem.selected === true;
			},
			parent : function(elem) {
				return !!elem.firstChild;
			},
			empty : function(elem) {
				return !elem.firstChild;
			},
			has : function(elem, i, match) {
				return !!Sizzle(match[3], elem).length;
			},
			header : function(elem) {
				return (/h\d/i).test(elem.nodeName);
			},
			text : function(elem) {
				var attr = elem.getAttribute("type"), type = elem.type;
				// IE6 and 7 will map elem.type to 'text' for new HTML5 types (search, etc)
				// use getAttribute instead to test this case
				return elem.nodeName.toLowerCase() === "input" && "text" === type && (attr === type || attr === null );
			},
			radio : function(elem) {
				return elem.nodeName.toLowerCase() === "input" && "radio" === elem.type;
			},
			checkbox : function(elem) {
				return elem.nodeName.toLowerCase() === "input" && "checkbox" === elem.type;
			},
			file : function(elem) {
				return elem.nodeName.toLowerCase() === "input" && "file" === elem.type;
			},
			password : function(elem) {
				return elem.nodeName.toLowerCase() === "input" && "password" === elem.type;
			},
			submit : function(elem) {
				var name = elem.nodeName.toLowerCase();
				return (name === "input" || name === "button") && "submit" === elem.type;
			},
			image : function(elem) {
				return elem.nodeName.toLowerCase() === "input" && "image" === elem.type;
			},
			reset : function(elem) {
				var name = elem.nodeName.toLowerCase();
				return (name === "input" || name === "button") && "reset" === elem.type;
			},
			button : function(elem) {
				var name = elem.nodeName.toLowerCase();
				return name === "input" && "button" === elem.type || name === "button";
			},
			input : function(elem) {
				return (/input|select|textarea|button/i).test(elem.nodeName);
			},
			focus : function(elem) {
				return elem === elem.ownerDocument.activeElement;
			}
		},
		setFilters : {
			first : function(elem, i) {
				return i === 0;
			},
			last : function(elem, i, match, array) {
				return i === array.length - 1;
			},
			even : function(elem, i) {
				return i % 2 === 0;
			},
			odd : function(elem, i) {
				return i % 2 === 1;
			},
			lt : function(elem, i, match) {
				return i < match[3] - 0;
			},
			gt : function(elem, i, match) {
				return i > match[3] - 0;
			},
			nth : function(elem, i, match) {
				return match[3] - 0 === i;
			},
			eq : function(elem, i, match) {
				return match[3] - 0 === i;
			}
		},
		filter : {
			PSEUDO : function(elem, match, i, array) {
				var name = match[1], filter = Expr.filters[name];

				if(filter) {
					return filter(elem, i, match, array);

				} else if(name === "contains") {
					return (elem.textContent || elem.innerText || getText([elem]) || "").indexOf(match[3]) >= 0;

				} else if(name === "not") {
					var not = match[3];

					for(var j = 0, l = not.length; j < l; j++) {
						if(not[j] === elem) {
							return false;
						}
					}

					return true;

				} else {
					Sizzle.error(name);
				}
			},
			CHILD : function(elem, match) {
				var first, last, doneName, parent, cache, count, diff, type = match[1], node = elem;

				switch ( type ) {
					case "only":
					case "first":
						while(( node = node.previousSibling)) {
							if(node.nodeType === 1) {
								return false;
							}
						}

						if(type === "first") {
							return true;
						}
						node = elem;

					/* falls through */
					case "last":
						while(( node = node.nextSibling)) {
							if(node.nodeType === 1) {
								return false;
							}
						}

						return true;

					case "nth":
						first = match[2];
						last = match[3];

						if(first === 1 && last === 0) {
							return true;
						}
						doneName = match[0];
						parent = elem.parentNode;

						if(parent && (parent[expando] !== doneName || !elem.nodeIndex)) {
							count = 0;

							for( node = parent.firstChild; node; node = node.nextSibling) {
								if(node.nodeType === 1) {
									node.nodeIndex = ++count;
								}
							}

							parent[expando] = doneName;
						}
						diff = elem.nodeIndex - last;

						if(first === 0) {
							return diff === 0;

						} else {
							return (diff % first === 0 && diff / first >= 0 );
						}
				}
			},
			ID : function(elem, match) {
				return elem.nodeType === 1 && elem.getAttribute("id") === match;
			},
			TAG : function(elem, match) {
				return (match === "*" && elem.nodeType === 1) || !!elem.nodeName && elem.nodeName.toLowerCase() === match;
			},
			CLASS : function(elem, match) {
				return (" " + (elem.className || elem.getAttribute("class")) + " ").indexOf(match) > -1;
			},
			ATTR : function(elem, match) {
				var name = match[1], result = Sizzle.attr ? Sizzle.attr(elem, name) : Expr.attrHandle[name] ? Expr.attrHandle[ name ](elem) : elem[name] != null ? elem[name] : elem.getAttribute(name), value = result + "", type = match[2], check = match[4];

				return result == null ? type === "!=" : !type && Sizzle.attr ? result != null : type === "=" ? value === check : type === "*=" ? value.indexOf(check) >= 0 : type === "~=" ? (" " + value + " ").indexOf(check) >= 0 : !check ? value && result !== false : type === "!=" ? value !== check : type === "^=" ? value.indexOf(check) === 0 : type === "$=" ? value.substr(value.length - check.length) === check : type === "|=" ? value === check || value.substr(0, check.length + 1) === check + "-" : false;
			},
			POS : function(elem, match, i, array) {
				var name = match[2], filter = Expr.setFilters[name];

				if(filter) {
					return filter(elem, i, match, array);
				}
			}
		}
	};

	var origPOS = Expr.match.POS, fescape = function(all, num) {
		return "\\" + (num - 0 + 1);
	};
	for(var type in Expr.match ) {
		Expr.match[type] = new RegExp(Expr.match[type].source + (/(?![^\[]*\])(?![^\(]*\))/.source));
		Expr.leftMatch[type] = new RegExp(/(^(?:.|\r|\n)*?)/.source + Expr.match[type].source.replace(/\\(\d+)/g, fescape));
	}
	// Expose origPOS
	// "global" as in regardless of relation to brackets/parens
	Expr.match.globalPOS = origPOS;

	var makeArray = function(array, results) {
		array = Array.prototype.slice.call(array, 0);

		if(results) {
			results.push.apply(results, array);
			return results;
		}

		return array;
	};
	// Perform a simple check to determine if the browser is capable of
	// converting a NodeList to an array using builtin methods.
	// Also verifies that the returned array holds DOM nodes
	// (which is not the case in the Blackberry browser)
	try {
		Array.prototype.slice.call( document.documentElement.childNodes, 0 )[0].nodeType
	} catch( e ) {
		makeArray = function(array, results) {
			var i = 0, ret = results || [];

			if(toString.call(array) === "[object Array]") {
				Array.prototype.push.apply(ret, array);

			} else {
				if( typeof array.length === "number") {
					for(var l = array.length; i < l; i++) {
						ret.push(array[i]);
					}

				} else {
					for(; array[i]; i++) {
						ret.push(array[i]);
					}
				}
			}

			return ret;
		};
	}

	var sortOrder, siblingCheck;

	if(document.documentElement.compareDocumentPosition) {
		sortOrder = function(a, b) {
			if(a === b) {
				hasDuplicate = true;
				return 0;
			}

			if(!a.compareDocumentPosition || !b.compareDocumentPosition) {
				return a.compareDocumentPosition ? -1 : 1;
			}

			return a.compareDocumentPosition(b) & 4 ? -1 : 1;
		};
	} else {
		sortOrder = function(a, b) {
			// The nodes are identical, we can exit early
			if(a === b) {
				hasDuplicate = true;
				return 0;

				// Fallback to using sourceIndex (in IE) if it's available on both nodes
			} else if(a.sourceIndex && b.sourceIndex) {
				return a.sourceIndex - b.sourceIndex;
			}

			var al, bl, ap = [], bp = [], aup = a.parentNode, bup = b.parentNode, cur = aup;

			// If the nodes are siblings (or identical) we can do a quick check
			if(aup === bup) {
				return siblingCheck(a, b);

				// If no parents were found then the nodes are disconnected
			} else if(!aup) {
				return -1;

			} else if(!bup) {
				return 1;
			}

			// Otherwise they're somewhere else in the tree so we need
			// to build up a full list of the parentNodes for comparison
			while(cur) {
				ap.unshift(cur);
				cur = cur.parentNode;
			}
			cur = bup;

			while(cur) {
				bp.unshift(cur);
				cur = cur.parentNode;
			}
			al = ap.length;
			bl = bp.length;

			// Start walking down the tree looking for a discrepancy
			for(var i = 0; i < al && i < bl; i++) {
				if(ap[i] !== bp[i]) {
					return siblingCheck(ap[i], bp[i]);
				}
			}

			// We ended someplace up the tree so do a sibling check
			return i === al ? siblingCheck(a, bp[i], -1) : siblingCheck(ap[i], b, 1);
		};
		siblingCheck = function(a, b, ret) {
			if(a === b) {
				return ret;
			}

			var cur = a.nextSibling;

			while(cur) {
				if(cur === b) {
					return -1;
				}
				cur = cur.nextSibling;
			}

			return 1;
		};
	}

	// Check to see if the browser returns elements by name when
	// querying by getElementById (and provide a workaround)
	(function() {
		// We're going to inject a fake input element with a specified name
		var form = document.createElement("div"), id = "script" + (new Date()).getTime(), root = document.documentElement;

		form.innerHTML = "<a name='" + id + "'/>";

		// Inject it into the root element, check its status, and remove it quickly
		root.insertBefore(form, root.firstChild);

		// The workaround has to do additional checks after a getElementById
		// Which slows things down for other browsers (hence the branching)
		if(document.getElementById(id)) {
			Expr.find.ID = function(match, context, isXML) {
				if( typeof context.getElementById !== "undefined" && !isXML) {
					var m = context.getElementById(match[1]);

					return m ? m.id === match[1] || typeof m.getAttributeNode !== "undefined" && m.getAttributeNode("id").nodeValue === match[1] ? [m] : undefined : [];
				}
			};

			Expr.filter.ID = function(elem, match) {
				var node = typeof elem.getAttributeNode !== "undefined" && elem.getAttributeNode("id");

				return elem.nodeType === 1 && node && node.nodeValue === match;
			};
		}

		root.removeChild(form);

		// release memory in IE
		root = form = null;
	})();
	(function() {
		// Check to see if the browser returns only elements
		// when doing getElementsByTagName("*")

		// Create a fake element
		var div = document.createElement("div");
		div.appendChild(document.createComment(""));

		// Make sure no comments are found
		if(div.getElementsByTagName("*").length > 0) {
			Expr.find.TAG = function(match, context) {
				var results = context.getElementsByTagName(match[1]);

				// Filter out possible comments
				if(match[1] === "*") {
					var tmp = [];

					for(var i = 0; results[i]; i++) {
						if(results[i].nodeType === 1) {
							tmp.push(results[i]);
						}
					}
					results = tmp;
				}

				return results;
			};
		}

		// Check to see if an attribute returns normalized href attributes
		div.innerHTML = "<a href='#'></a>";

		if(div.firstChild && typeof div.firstChild.getAttribute !== "undefined" && div.firstChild.getAttribute("href") !== "#") {

			Expr.attrHandle.href = function(elem) {
				return elem.getAttribute("href", 2);
			};
		}

		// release memory in IE
		div = null;
	})();

	if(document.querySelectorAll) {(function() {
			var oldSizzle = Sizzle, div = document.createElement("div"), id = "__sizzle__";

			div.innerHTML = "<p class='TEST'></p>";

			// Safari can't handle uppercase or unicode characters when
			// in quirks mode.
			if(div.querySelectorAll && div.querySelectorAll(".TEST").length === 0) {
				return;
			}
			Sizzle = function(query, context, extra, seed) {
				context = context || document;

				// Only use querySelectorAll on non-XML documents
				// (ID selectors don't work in non-HTML documents)
				if(!seed && !Sizzle.isXML(context)) {
					// See if we find a selector to speed up
					var match = /^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec(query);

					if(match && (context.nodeType === 1 || context.nodeType === 9)) {
						// Speed-up: Sizzle("TAG")
						if(match[1]) {
							return makeArray(context.getElementsByTagName(query), extra);

							// Speed-up: Sizzle(".CLASS")
						} else if(match[2] && Expr.find.CLASS && context.getElementsByClassName) {
							return makeArray(context.getElementsByClassName(match[2]), extra);
						}
					}

					if(context.nodeType === 9) {
						// Speed-up: Sizzle("body")
						// The body element only exists once, optimize finding it
						if(query === "body" && context.body) {
							return makeArray([context.body], extra);

							// Speed-up: Sizzle("#ID")
						} else if(match && match[3]) {
							var elem = context.getElementById(match[3]);

							// Check parentNode to catch when Blackberry 4.6 returns
							// nodes that are no longer in the document #6963
							if(elem && elem.parentNode) {
								// Handle the case where IE and Opera return items
								// by name instead of ID
								if(elem.id === match[3]) {
									return makeArray([elem], extra);
								}

							} else {
								return makeArray([], extra);
							}
						}

						try {
							return makeArray(context.querySelectorAll(query), extra);
						} catch(qsaError) {
						}

						// qSA works strangely on Element-rooted queries
						// We can work around this by specifying an extra ID on the root
						// and working up from there (Thanks to Andrew Dupont for the technique)
						// IE 8 doesn't work on object elements
					} else if(context.nodeType === 1 && context.nodeName.toLowerCase() !== "object") {
						var oldContext = context, old = context.getAttribute("id"), nid = old || id, hasParent = context.parentNode, relativeHierarchySelector = /^\s*[+~]/.test(query);

						if(!old) {
							context.setAttribute("id", nid);
						} else {
							nid = nid.replace(/'/g, "\\$&");
						}
						if(relativeHierarchySelector && hasParent) {
							context = context.parentNode;
						}

						try {
							if(!relativeHierarchySelector || hasParent) {
								return makeArray(context.querySelectorAll("[id='" + nid + "'] " + query), extra);
							}

						} catch(pseudoError) {
						} finally {
							if(!old) {
								oldContext.removeAttribute("id");
							}
						}
					}
				}

				return oldSizzle(query, context, extra, seed);
			};
			for(var prop in oldSizzle ) {
				Sizzle[prop] = oldSizzle[prop];
			}

			// release memory in IE
			div = null;
		})();
	}(function() {
		var html = document.documentElement, matches = html.matchesSelector || html.mozMatchesSelector || html.webkitMatchesSelector || html.msMatchesSelector;

		if(matches) {
			// Check to see if it's possible to do matchesSelector
			// on a disconnected node (IE 9 fails this)
			var disconnectedMatch = !matches.call(document.createElement("div"), "div"), pseudoWorks = false;

			try {
				// This should fail with an exception
				// Gecko does not error, returns false instead
				matches.call(document.documentElement, "[test!='']:sizzle");

			} catch( pseudoError ) {
				pseudoWorks = true;
			}

			Sizzle.matchesSelector = function(node, expr) {
				// Make sure that attribute selectors are quoted
				expr = expr.replace(/\=\s*([^'"\]]*)\s*\]/g, "='$1']");

				if(!Sizzle.isXML(node)) {
					try {
						if(pseudoWorks || !Expr.match.PSEUDO.test(expr) && !/!=/.test(expr)) {
							var ret = matches.call(node, expr);

							// IE 9's matchesSelector returns false on disconnected nodes
							if(ret || !disconnectedMatch ||
							// As well, disconnected nodes are said to be in a document
							// fragment in IE 9, so check for that
							node.document && node.document.nodeType !== 11) {
								return ret;
							}
						}
					} catch(e) {
					}
				}

				return Sizzle(expr, null, null, [node]).length > 0;
			};
		}
	})();
	(function() {
		var div = document.createElement("div");

		div.innerHTML = "<div class='test e'></div><div class='test'></div>";

		// Opera can't find a second classname (in 9.6)
		// Also, make sure that getElementsByClassName actually exists
		if(!div.getElementsByClassName || div.getElementsByClassName("e").length === 0) {
			return;
		}

		// Safari caches class attributes, doesn't catch changes (in 3.2)
		div.lastChild.className = "e";

		if(div.getElementsByClassName("e").length === 1) {
			return;
		}

		Expr.order.splice(1, 0, "CLASS");
		Expr.find.CLASS = function(match, context, isXML) {
			if( typeof context.getElementsByClassName !== "undefined" && !isXML) {
				return context.getElementsByClassName(match[1]);
			}
		};
		// release memory in IE
		div = null;
	})();

	function dirNodeCheck(dir, cur, doneName, checkSet, nodeCheck, isXML) {
		for(var i = 0, l = checkSet.length; i < l; i++) {
			var elem = checkSet[i];

			if(elem) {
				var match = false;
				elem = elem[dir];

				while(elem) {
					if(elem[expando] === doneName) {
						match = checkSet[elem.sizset];
						break;
					}

					if(elem.nodeType === 1 && !isXML) {
						elem[expando] = doneName;
						elem.sizset = i;
					}

					if(elem.nodeName.toLowerCase() === cur) {
						match = elem;
						break;
					}
					elem = elem[dir];
				}

				checkSet[i] = match;
			}
		}
	}

	function dirCheck(dir, cur, doneName, checkSet, nodeCheck, isXML) {
		for(var i = 0, l = checkSet.length; i < l; i++) {
			var elem = checkSet[i];

			if(elem) {
				var match = false;
				elem = elem[dir];

				while(elem) {
					if(elem[expando] === doneName) {
						match = checkSet[elem.sizset];
						break;
					}

					if(elem.nodeType === 1) {
						if(!isXML) {
							elem[expando] = doneName;
							elem.sizset = i;
						}

						if( typeof cur !== "string") {
							if(elem === cur) {
								match = true;
								break;
							}

						} else if(Sizzle.filter(cur, [elem]).length > 0) {
							match = elem;
							break;
						}
					}
					elem = elem[dir];
				}

				checkSet[i] = match;
			}
		}
	}

	if(document.documentElement.contains) {
		Sizzle.contains = function(a, b) {
			return a !== b && (a.contains ? a.contains(b) : true);
		};
	} else if(document.documentElement.compareDocumentPosition) {
		Sizzle.contains = function(a, b) {
			return !!(a.compareDocumentPosition(b) & 16);
		};
	} else {
		Sizzle.contains = function() {
			return false;
		};
	}

	Sizzle.isXML = function(elem) {
		// documentElement is verified for cases where it doesn't yet exist
		// (such as loading iframes in IE - #4833)
		var documentElement = ( elem ? elem.ownerDocument || elem : 0).documentElement;

		return documentElement ? documentElement.nodeName !== "HTML" : false;
	};
	var posProcess = function(selector, context, seed) {
		var match, tmpSet = [], later = "", root = context.nodeType ? [context] : context;

		// Position selectors must be done after the filter
		// And so must :not(positional) so we move all PSEUDOs to the end
		while(( match = Expr.match.PSEUDO.exec(selector))) {
			later += match[0];
			selector = selector.replace(Expr.match.PSEUDO, "");
		}
		selector = Expr.relative[selector] ? selector + "*" : selector;

		for(var i = 0, l = root.length; i < l; i++) {
			Sizzle(selector, root[i], tmpSet, seed);
		}

		return Sizzle.filter(later, tmpSet);
	};
	// EXPOSE

	window.Sizzle = Sizzle;

	/**
	 * 内嵌Sizzle最新版选择器，单独分离成一个Selector类，方便整合代码
	 * @class $Kit.Selector
	 * @requires kit.js
	 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/selector.js">Source code</a>
	 */
	$Kit.Selector = function() {
		//
	};
	$kit.merge($Kit.Selector.prototype,
	/**
	 * @lends $Kit.Selector.prototype
	 */
	{
		/**
		 * sizzle选择器
		 * @param {Selector}
		 * @param {Element}
		 * @return {[Element]}
		 */
		el : function(selector, root) {
			return Sizzle(selector, root);
		},
		/**
		 * matches
		 * @method
		 * @param {Selector} selector
		 * @param {[Element]} elementsArray
		 * @return {Boolean}
		 */
		matches : Sizzle.matches,
		/**
		 * matchesSelector
		 * @method
		 * @param {Element} element
		 * @param {Selector} selector
		 * @return {Boolean}
		 */
		matchesSelector : Sizzle.matchesSelector,
		/**
		 * filter
		 * @private
		 */
		filter : Sizzle.filter,
		/**
		 * contains
		 * @private
		 */
		contains : Sizzle.contains,
		/**
		 * Utility function for retreiving the text value of an array of DOM nodes
		 * @method
		 * @param {Array|Element} elem
		 * @return {String}
		 */
		getText : Sizzle.getText,
		/**
		 * find
		 * @private
		 */
		find : Sizzle.find
	});
	/**
	 * $Kit.Selector实例，直接通过这个实例访问$Kit.Selector所有方法
	 * @global
	 * @type $Kit.Selector
	 */
	$kit.selector = new $Kit.Selector();
	/**
	 * 加载selector.js之后，可以使用sizzle选择器，使用$kit.$el方法
	 * @global
	 * @function
	 * @param {Selector} selector
	 * @param {Element} [context]
	 * @return {[Element]}
	 */
	$kit.$el = $kit.selector.el;
})();
/**
 * 功能强大的日历（中文，支持多选，划动多选，多语言支持，API操作，自定义事件，界面定制等等）
 * @class $kit.ui.DatePicker
 * @requires kit.js
 * @requires ieFix.js
 * @requires dom.js
 * @requires array.js
 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/widget/DatePicker/datepicker.js">Source code</a>
 * @example
 * <a href="http://xueduany.github.com/KitJs/KitJs/demo/DatePicker/demo.html">Demo</a><br/>
 * <img src="http://xueduany.github.com/KitJs/KitJs/demo/DatePicker/demo.png">
 */
$kit.ui.DatePicker = function(config) {
	var me = this;
	me.config = $kit.join(me.constructor.defaultConfig, config);
}
$kit.merge($kit.ui.DatePicker,
/**
 * @lends $kit.ui.DatePicker
 */
{
	/**
	 * @enum
	 */
	defaultConfig : {
		kitWidgetName : 'kitjs-datepicker',
		/**
		 * 接受和输出的日期格式
		 * @type {String}
		 */
		dateFormat : 'yyyy年mm月dd日', //接受和输出的日期格式
		template : {
			pickerHTML : [//
			'<div class="datepicker">', //
			'<div class="datepicker-days">', //
			'<table class=" table-condensed">', //
			'${headHTML}', //
			'<tbody></tbody>', //
			'</table>', //
			'</div>', //
			'<div class="datepicker-months">', //
			'<table class="table-condensed">', //
			'${headHTML}', //
			'${contHTML}', //
			'</table>', //
			'</div>', //
			'<div class="datepicker-years">', //
			'<table class="table-condensed">', //
			'${headHTML}', //
			'${contHTML}', //
			'</table>', //
			'</div>', //
			'</div>'//
			].join(''),
			headHTML : [//
			'<thead>', //
			'<tr>', //
			'<th class="prev" onselectstart="return false"><i class="icon-arrow-left">&lt;</i></th>', //
			'<th colspan="5" class="switch"></th>', //
			'<th class="next" onselectstart="return false"><i class="icon-arrow-right">&gt;</i></th>', //
			'</tr>', //
			'</thead>'//
			].join(''),
			contHTML : '<tbody><tr><td colspan="7"></td></tr></tbody>',
			dropDownCls : 'dropdown-menu'
		},
		/**
		 * 语言，默认cn
		 * @type {String}
		 */
		language : 'cn',
		/**
		 * 初始显示的view，0为日历,1为月，2为年
		 * @type {Number}
		 */
		startView : 0,
		/**
		 * 初始日期
		 * @type {Date}
		 */
		date : undefined, //$kit.date.dateNow(),
		modes : [{
			clsName : 'days',
			navFnc : 'Month',
			navStep : 1
		}, {
			clsName : 'months',
			navFnc : 'FullYear',
			navStep : 1
		}, {
			clsName : 'years',
			navFnc : 'FullYear',
			navStep : 10
		}],
		/**
		 * 默认从date对象里面的本地化数据取得一周的开始时间
		 * @type {Number}
		 */
		weekStart : undefined,
		weekViewFormat : 'daysMin',
		monthViewFormat : 'monthsShort',
		/*
		 * 默认是否显示
		 * @type {Boolean}
		 */
		show : false,
		/**
		 * 能否多选
		 * @type {Boolean}
		 */
		canMultipleChoose : true,
		/**
		 * 多选时候输出分隔符
		 * @type {String}
		 */
		dateStringSeparator : ',',
		/**
		 * 多选时候输出类型，full为将选中的日期全部输出，short为输出选中日期的开头和结尾
		 * @type {String}
		 */
		shiftSelectOutType : 'full',
		/**
		 * 当输出类型为short时，比如选中了3月1日到3月10日，则输出"3月1日~3月10日",简短输出，只有开头+分隔符+结尾
		 * @type {String}
		 */
		shiftSelectOutTypeShortSeparator : '~'
	}
});
$kit.merge($kit.ui.DatePicker.prototype,
/**
 * @lends $kit.ui.DatePicker.prototype
 */
{
	/**
	 * main()入口
	 */
	init : function() {
		var me = this, config = me.config;
		me.language = config.language;
		me.format = $kit.date.parseFormat(config.dateFormat);
		me.buildHTML();
		//
		me.initEv();
		if(config.date) {
			if($kit.isDate(config.date)) {
				me.date = config.date;
				me.selectedDateAry = [new Date(config.date)];
			} else if($kit.isAry(config.date)) {
				me.date = config.date[0];
				me.selectedDateAry = config.date;
			} else if($kit.isStr(config.date)) {
				if(config.date.indexOf(config.dateStringSeparator) > -1) {
					var dateStrAry = config.date.split(config.dateStringSeparator);
					me.date = $kit.date.parseDate(dateStrAry[0], me.format, me.language);
					me.selectedDateAry = [];
					$kit.each(dateStrAry, function(o) {
						me.selectedDateAry.push($kit.date.parseDate(o, me.format, me.language));
					});
					me.selectedDateAry.sort(function(a, b) {
						return a.valueOf() - b.valueOf();
					});
				} else {
					me.date = $kit.date.parseDate(config.date, me.format, me.language);
					me.selectedDateAry = [me.date];
				}
			}
		} else {
			me.date = $kit.date.dateNow();
		}
		//
		switch(config.startView) {
			case 2:
			case 'decade':
				me.viewMode = me.startViewMode = 2;
				break;
			case 1:
			case 'year':
				me.viewMode = me.startViewMode = 1;
				break;
			case 0:
			case 'month':
			default:
				me.viewMode = me.startViewMode = 0;
				break;
		}
		me.weekStart = config.weekStart || $kit.date.languagePack[me.language].weekStart || 0;
		me.weekEnd = ((me.weekStart + 6) % 7);
		me.startDate = -Infinity;
		me.endDate = Infinity;
		me.setStartDate(config.startDate);
		me.setEndDate(config.endDate);
		me.fillDow();
		me.update();
		me.showMode();
		if(config.show) {
			//
		} else {
			me.hide();
		}
		return me;
	},
	/**
	 * 创建html
	 */
	buildHTML : function() {
		var me = this;
		me.picker = $kit.newHTML($kit.tpl(me.config.template.pickerHTML, me.config.template)).childNodes[0];
		document.body.appendChild(me.picker);
	},
	/**
	 * 注册事件
	 */
	initEv : function() {
		var me = this;
		$kit.ev({
			el : me.picker,
			ev : 'mousedown',
			fn : me.mousedown,
			scope : me
		});
		$kit.ev({
			el : me.picker,
			ev : 'mousemove',
			fn : me.mousemove,
			scope : me
		});
		$kit.ev({
			el : me.picker,
			ev : 'mouseup',
			fn : me.mouseup,
			scope : me
		});
		$kit.ev({
			el : me.picker,
			ev : 'click',
			fn : me.click,
			scope : me
		});
		$kit.ev({
			el : me.picker,
			ev : 'selectstart',
			fn : function(e) {
				e.stopNow();
			},
			scope : me
		});
	},
	/**
	 * 显示日历
	 */
	show : function(e) {
		var me = this;
		if(me.picker.style.display == 'none') {
			me.picker.style.display = '';
		}
		if(me.adhereEl) {
			me.adhere(me.adhereConfig);
		}
	},
	/**
	 * 吸附
	 */
	adhere : function(config) {
		var me = this;
		if($kit.isNode(config)) {
			config = {
				el : config
			}
		}
		if(config) {
			config.el[me.config.kitWidgetName] = me;
			$kit.adCls(me.picker, me.config.template.dropDownCls);
			me.adhereEl = config.el;
			me.adhereConfig = config;
			me.fixPosition(me.adhereConfig);
		}
	},
	/**
	 * 修正日历位置，随着吸附元素调整位置
	 */
	fixPosition : function(adhereConfig) {
		var me = this;
		var offset = $kit.offset(adhereConfig.el);
		$kit.css(me.picker, {
			position : 'absolute',
			top : offset.bottom + (adhereConfig.offsetTop || 0) + 'px',
			left : offset.left + (adhereConfig.left || 0) + 'px'
		});
	},
	/**
	 * 隐藏
	 */
	hide : function(e) {
		var me = this;
		me.picker.style.display = 'none';
	},
	/**
	 * 设值
	 * @private
	 */
	setValue : function(remove) {
		remove = remove;
		var me = this;
		if(remove == false) {
			me.selectedDateAry = [];
			if(me.adhereEl) {
				me.adhereEl.value = '';
			}
		} else {
			var formated = $kit.date.formatDate(me.date, me.format, me.language);
			if(me.adhereEl) {
				me.adhereEl.value = formated;
			}
			me.selectedDateAry = [new Date(me.date)];
			me.update();
		}
		me.newEv({
			ev : 'change'
		});
	},
	/**
	 * 按住shift或者ctrl添加
	 */
	addValue : function(continuous) {
		var me = this;
		continuous = continuous || false;
		me.selectedDateAry = me.selectedDateAry || [];
		var beginDate = me.selectedDateAry[0];
		var endDate = me.selectedDateAry[me.selectedDateAry.length - 1];
		if(continuous == true) {
			if(me.date.valueOf() < beginDate.valueOf()) {
				beginDate = new Date(me.date);
			} else {
				endDate = new Date(me.date);
			}
			var newSelectedDateAry = [];
			while(endDate.valueOf() >= beginDate.valueOf()) {
				newSelectedDateAry.push(new Date(beginDate));
				$kit.date.addDays(beginDate, 1);
			}
			me.selectedDateAry = newSelectedDateAry;
		} else {
			if(!beginDate || (me.date.valueOf() > endDate.valueOf())) {
				me.selectedDateAry.push(new Date(me.date));
			}else if(me.date.valueOf() < beginDate.valueOf()) {
				me.selectedDateAry.splice(0, 0, new Date(me.date));
			} else if(me.date.valueOf() >= beginDate.valueOf() || me.date.valueOf() <= endDate.valueOf()) {
				var canAdd = true;
				for(var i = 0; i < me.selectedDateAry.length; ) {
					if(me.date.valueOf() == me.selectedDateAry[i].valueOf()) {
						me.selectedDateAry.splice(i, 1);
						canAdd = false;
						break;
					} else if(me.date.valueOf() > me.selectedDateAry[i].valueOf() && i < me.selectedDateAry.length - 1 && me.date.valueOf() < me.selectedDateAry[i + 1].valueOf()) {
						me.selectedDateAry.splice(i + 1, 0, new Date(me.date));
						break;
					} else if(i == me.selectedDateAry.length - 1) {
						me.selectedDateAry.splice(i, 0, new Date(me.date));
					}
					i++;
				}
			}
		}
		if(me.adhereEl) {
			me.adhereEl.value = me.getValue();
		}
		me.update();
		me.newEv({
			ev : 'change'
		});
	},
	/**
	 * 获取日历的选中值
	 */
	getValue : function() {
		var me = this;
		if(me.selectedDateAry.length) {
			var dateStrAry = [];
			if(me.config.shiftSelectOutType.toLowerCase() != 'short') {
				$kit.each(me.selectedDateAry, function(o) {
					dateStrAry.push($kit.date.formatDate(o, me.format, me.language))
				});
				return dateStrAry.join(me.config.dateStringSeparator);
			} else {
				dateStrAry.push($kit.date.formatDate(me.selectedDateAry[0], me.format, me.language));
				dateStrAry.push($kit.date.formatDate(me.selectedDateAry[me.selectedDateAry.length - 1], me.format, me.language));
				return dateStrAry.join(me.config.shiftSelectOutTypeShortSeparator);
			}
			return $kit.date.formatDate(me.date, me.format, me.language)
		}
		return '';
	},
	/**
	 * 设置能选择的最早日期
	 */
	setStartDate : function(startDate) {
		var me = this;
		if($kit.isDate(startDate)) {
			me.startDate = startDate;
		} else {
			me.startDate = startDate || -Infinity;
			if(me.startDate !== -Infinity) {
				me.startDate = $kit.date.parseDate(me.startDate, me.format, me.language);
			}
		}
		me.updateNavArrows();
	},
	/**
	 * 设置能选择的最迟日期
	 */
	setEndDate : function(endDate) {
		var me = this;
		if($kit.isDate(endDate)) {
			me.endDate = endDate;
		} else {
			me.endDate = endDate || Infinity;
			if(me.endDate !== Infinity) {
				me.endDate = $kit.date.parseDate(me.endDate, me.format, me.language);
			}
		}
		me.updateNavArrows();
	},
	/**
	 * 刷新日期天数显示
	 */
	update : function() {
		var me = this;
		if(me.date < me.startDate) {
			me.viewDate = new Date(me.startDate);
		} else if(me.date > me.endDate) {
			me.viewDate = new Date(me.endDate);
		} else {
			me.viewDate = new Date(me.date);
		}
		me.fill();
	},
	/**
	 * 星期几
	 */
	fillDow : function() {
		var me = this;
		var dowCnt = me.weekStart;
		var html = '<tr>';
		while(dowCnt < me.weekStart + 7) {
			html += '<th class="dow">' + $kit.date.languagePack[me.language][me.config.weekViewFormat][(dowCnt++) % 7] + '</th>';
		}
		html += '</tr>';
		var thead = $kit.$el('.datepicker-days thead',me.picker)[0];
		if($kit.isIE()) {
			var tr = thead.insertRow(1);
			thead.replaceChild($kit.newHTML('<table><tbody>' + html + '</tbody></table>').firstChild.firstChild.firstChild, tr)
		} else {
			$kit.insEl({
				where : thead,
				what : html,
				pos : 'last'
			});
		}
	},
	/**
	 * 月份选择
	 */
	fillMonths : function() {
		var me = this;
		var html = '';
		var i = 0
		while(i < 12) {
			html += '<span class="month">' + $kit.date.languagePack[me.language][me.config.monthViewFormat][i++] + '</span>';
		}
		$kit.each($kit.$el('.datepicker-months td', me.picker), function(o) {
			o.innerHTML = html;
		});
	},
	/**
	 * 天数面板
	 */
	fill : function() {
		var me = this;
		var d = new Date(me.viewDate), year = d.getFullYear(), month = d.getMonth(), //
		startYear = me.startDate !== -Infinity ? me.startDate.getFullYear() : -Infinity, //
		startMonth = me.startDate !== -Infinity ? me.startDate.getMonth() : -Infinity, //
		endYear = me.endDate !== Infinity ? me.endDate.getFullYear() : Infinity, //
		endMonth = me.endDate !== Infinity ? me.endDate.getMonth() : Infinity;
		//
		if(me.config.language != 'cn') {
			$kit.$el('.datepicker-days th:eq(1)',me.picker)[0].innerHTML = $kit.date.languagePack[me.language].months[month] + ' ' + year;
		} else {
			$kit.$el('.datepicker-days th:eq(1)',me.picker)[0].innerHTML = year + '年' + $kit.date.languagePack[me.language].months[month];
		}
		//
		me.updateNavArrows();
		me.fillMonths();
		var prevMonth = new Date(year, month - 1, 28, 0, 0, 0, 0), day = $kit.date.getDaysInMonth(prevMonth.getFullYear(), prevMonth.getMonth());
		prevMonth.setDate(day);
		prevMonth.setDate(day - (prevMonth.getDay() - me.weekStart + 7) % 7);
		var nextMonth = new Date(prevMonth);
		nextMonth.setDate(nextMonth.getDate() + 42);
		nextMonth = nextMonth.valueOf();
		html = [];
		var clsName;
		var plans = this.config.planData;
		while(prevMonth.valueOf() < nextMonth) {
			if(prevMonth.getDay() == me.weekStart) {
				html.push('<tr>');
			}
			clsName = '';
			if(prevMonth.getFullYear() < year || (prevMonth.getFullYear() == year && prevMonth.getMonth() < month)) {
				clsName += ' old';
			} else if(prevMonth.getFullYear() > year || (prevMonth.getFullYear() == year && prevMonth.getMonth() > month)) {
				clsName += ' new';
			}
			$kit.each(me.selectedDateAry, function(o) {
				if(o.valueOf() == prevMonth.valueOf()) {
					clsName += ' active';
					return false;
				}
			});
			if(prevMonth.valueOf() < me.startDate || prevMonth.valueOf() > me.endDate) {
				clsName += ' disabled';
			}
			
			
			var extraInfo = '';
			if(plans){
				var plan = plans[prevMonth.getFullYear()+"-"+prevMonth.getMonth()+"-"+prevMonth.getDate()];
				if(plan){
					var tagInfo = '';
					if(plan.tag=='特价'){
						tagInfo='<em class="LB PA LBTE LBHA" style="top:0;right:0px">特</em>';
					}
					if(plan.tag=='尾货'){
						tagInfo='<em class="LB PA LBB LBHA" style="top:0;right:0">尾</em>';
					}
					extraInfo = tagInfo+'<p class="CB">￥'+plan.price.split('.')[0]+'</p>';
				}
			}
			html.push('<td  class="VT day' + clsName + '">' + prevMonth.getDate() + extraInfo+'</td>');
			if(prevMonth.getDay() == me.weekEnd) {
				html.push('</tr>');
			}
			prevMonth.setDate(prevMonth.getDate() + 1);
		}
		var tbody = $kit.$el('.datepicker-days tbody', me.picker)[0];
		var _htm = html.join('');
		if($kit.isIE()) {
			while(tbody.rows.length) {
				tbody.deleteRow(0);
			}
			tbody.parentNode.replaceChild($kit.newHTML('<table><tbody>' + _htm + '</tbody></table>').firstChild.firstChild, tbody);
		} else {
			tbody.innerHTML = '';
			$kit.insEl({
				where : tbody,
				what : _htm,
				pos : 'last'
			});
		}
		var currentYear = me.viewDate.getFullYear();
		//
		var monthsEl = $kit.$el('.datepicker-months', me.picker)[0];
		$kit.dom.text($kit.$el('th:eq(1)', monthsEl)[0], year);
		$kit.each($kit.$el('span', monthsEl), function(o) {
			$kit.rmCls(o, 'active');
		});
		if(currentYear == year) {
			$kit.each($kit.$el('span', monthsEl), function(o, i) {
				if(i == me.viewDate.getMonth()) {
					$kit.adCls(o, 'active');
					return false;
				}
			});
		}
		if(year < startYear || year > endYear) {
			$kit.adCls(monthsEl, 'disabled');
		}
		if(year == startYear) {
			$kit.each($kit.$el('span', monthsEl).slice(0, startMonth), function(o) {
				$kit.adCls(o, 'disabled');
			});
		}
		if(year == endYear) {
			$kit.each($kit.$el('span', monthsEl).slice(endMonth + 1), function(o) {
				$kit.adCls(o, 'disabled');
			});
		}
		html = '';
		year = parseInt(year / 10, 10) * 10;
		//
		var yearEl = $kit.$el('.datepicker-years',me.picker)[0];
		$kit.dom.text($kit.$el('th:eq(1)', yearEl)[0], year + '-' + (year + 9));
		var yearCont = $kit.$el('td', yearEl);
		year -= 1;
		for(var i = -1; i < 11; i++) {
			html += '<span class="year' + (i == -1 || i == 10 ? ' old' : '') + (currentYear == year ? ' active' : '') + (year < startYear || year > endYear ? ' disabled' : '') + '">' + year + '</span>';
			year += 1;
		}
		$kit.each(yearCont, function(o) {
			$kit.dom.html(o, html);
		});
	},
	/**
	 * 导航左右翻页
	 */
	updateNavArrows : function() {
		var me = this;
		var d = new Date(me.viewDate), year = d.getFullYear(), month = d.getMonth();
		switch (me.viewMode) {
			case 0:
				if(me.startDate !== -Infinity && year <= me.startDate.getFullYear() && month <= me.startDate.getMonth()) {
					$kit.css($kit.$el('th.prev:first', me.picker)[0], {
						visibility : 'hidden'
					});
				} else {
					$kit.css($kit.$el('th.prev:first', me.picker)[0], {
						visibility : 'visible'
					});
				}
				if(me.endDate !== Infinity && year >= me.endDate.getFullYear() && month >= me.endDate.getMonth()) {
					$kit.css($kit.$el('th.next:last', me.picker)[0], {
						visibility : 'hidden'
					});
				} else {
					$kit.css($kit.$el('th.next:last', me.picker)[0], {
						visibility : 'visible'
					});
				}
				break;
			case 1:
			case 2:
				if(me.startDate !== -Infinity && year <= me.startDate.getFullYear()) {
					$kit.css($kit.$el('th.prev:first', me.picker)[0], {
						visibility : 'hidden'
					});
				} else {
					$kit.css($kit.$el('th.prev:first', me.picker)[0], {
						visibility : 'visible'
					});
				}
				if(me.endDate !== Infinity && year >= me.endDate.getFullYear()) {
					$kit.css($kit.$el('th.next:last', me.picker)[0], {
						visibility : 'hidden'
					});
				} else {
					$kit.css($kit.$el('th.next:last', me.picker)[0], {
						visibility : 'visible'
					});
				}
				break;
		}
	},
	/**
	 * 面板mousedown和mousemove事件，主要用于鼠标滑动选择
	 */
	mousedown : function(e) {
		var me = this, target = e.target;
		if(!me.config.canMultipleChoose) {
			return;
		}
		me.mouseSlideSelect = false;
		if(target.tagName && $kit.array.hs(['td'], target.tagName.toLowerCase())) {
			//
		} else {
			target = $kit.parentEl(target, function(p) {
				if(p.tagName && $kit.array.hs(['td'], p.tagName.toLowerCase())) {
					return true;
				}
				if(p == me.picker) {
					return false;
				}
			});
		}
		if($kit.hsCls(target, 'day')) {
			$kit.adCls(target, 'active');
			me.slideSelectFlag = true;
		}
	},
	/**
	 * 鼠标移动事件
	 * @private
	 */
	mousemove : function(e) {
		var me = this, target = e.target;
		if(!me.config.canMultipleChoose) {
			return;
		}
		if(me.slideSelectFlag != true) {
			return;
		}
		if(target.tagName && $kit.array.hs(['td'], target.tagName.toLowerCase())) {
			//
		} else {
			target = $kit.parentEl(target, function(p) {
				if(p.tagName && $kit.array.hs(['td'], p.tagName.toLowerCase())) {
					return true;
				}
				if(p == me.picker) {
					return false;
				}
			});
		}
		if($kit.hsCls(target, 'day')) {
			var day = parseInt($kit.dom.text(target), 10) || 1;
			var year = me.viewDate.getFullYear(), month = me.viewDate.getMonth();
			if($kit.hsCls(target, 'old') && !$kit.hsCls(target, 'disabled')) {
				if(month == 0) {
					month = 11;
					year -= 1;
				} else {
					month -= 1;
				}
			} else if($kit.hsCls(target, 'new') && !$kit.hsCls(target, 'disabled')) {
				if(month == 11) {
					month = 0;
					year += 1;
				} else {
					month += 1;
				}
			}
			date = new Date(year, month, day, 0, 0, 0, 0);
			$kit.adCls(target, 'active');
			if(me.mouseSlideSelectBeginDate == null) {
				me.mouseSlideSelectBeginDate = new Date(date);
				me.mouseSlideSelectBeginEl = target;
			} else if(me.mouseSlideSelectBeginDate.valueOf() != date.valueOf()//
			&& (//
				me.mouseSlideSelectEndDate == null//
				|| (me.mouseSlideSelectEndDate && me.mouseSlideSelectEndDate.valueOf() != date.valueOf()))//
			) {
				me.mouseSlideSelectEndDate = new Date(date);
				me.mouseSlideSelectEndEl = target;
				if(me.mouseSlideSelectBeginDate && me.mouseSlideSelectEndDate) {
					var first = false, last = false, firstDate, lastDate, firstEl, lastEl;
					if(me.mouseSlideSelectEndDate.valueOf() > me.mouseSlideSelectBeginDate.valueOf()) {
						//firstDate = me.mouseSlideSelectBeginDate;
						firstEl = me.mouseSlideSelectBeginEl;
						//lastDate = me.mouseSlideSelectEndDate;
						lastEl = me.mouseSlideSelectEndEl;
					} else {
						//lastDate = me.mouseSlideSelectBeginDate;
						lastEl = me.mouseSlideSelectBeginEl;
						//firstDate = me.mouseSlideSelectEndDate;
						firstEl = me.mouseSlideSelectEndEl;
					}
					$kit.each($kit.$el('.datepicker-days td.day', me.picker), function(o) {
						if(last) {
							$kit.rmCls(o, 'active');
						}
						if(first && o == lastEl) {
							last = true;
						}
						if(!first && o == firstEl) {
							first = true;
						}
						if(!first) {
							$kit.rmCls(o, 'active');
						}
						if(first && !last) {
							$kit.adCls(o, 'active');
						}

					});
				}
			}
		}
	},
	/**
	 * 选中事件
	 * @private
	 */
	mouseup : function(e) {
		var me = this, target = e.target;
		if(!me.config.canMultipleChoose) {
			return;
		}
		if(me.slideSelectFlag == true) {
			if(me.mouseSlideSelectBeginDate && me.mouseSlideSelectEndDate) {
				me.mouseSlideSelect = true;
				if(me.mouseSlideSelectEndDate.valueOf() > me.mouseSlideSelectBeginDate.valueOf()) {
					beginDate = new Date(me.mouseSlideSelectBeginDate);
					endDate = new Date(me.mouseSlideSelectEndDate);
				} else {
					endDate = new Date(me.mouseSlideSelectBeginDate);
					beginDate = new Date(me.mouseSlideSelectEndDate);
				}
				me.selectedDateAry = [];
				while(endDate.valueOf() >= beginDate.valueOf()) {
					me.selectedDateAry.push(new Date(beginDate));
					$kit.date.addDays(beginDate, 1);
				}
				if(me.adhereEl) {
					me.adhereEl.value = me.getValue();
				}
				//me.update();
				me.newEv({
					ev : 'change'
				});
			}
			me.mouseSlideSelectEndEl = null;
			me.mouseSlideSelectEndDate = null;
			me.mouseSlideSelectBeginEl = null;
			me.mouseSlideSelectBeginDate = null;
		}
		me.slideSelectFlag = false;
	},
	/**
	 * 面板click事件
	 * @private
	 */
	click : function(e) {
		var me = this;
		if(me.mouseSlideSelect == true) {
			me.mouseSlideSelect = false;
			return;
		}
		e.stopNow();
		var target = e.target;
		var cls = target.getAttribute('class')||target.className;
		if(me.disabled && (target.tagName&& $kit.array.hs([ 'td','p'], target.tagName.toLowerCase()) || cls=='switch')){
			return;
		}
		if(target.tagName && $kit.array.hs(['span', 'td', 'th'], target.tagName.toLowerCase())) {
			//
		} else {
			target = $kit.parentEl(target, function(p) {
				if(p.tagName && $kit.array.hs(['span', 'td', 'th'], p.tagName.toLowerCase())) {
					return true;
				}
				if(p == me.picker) {
					return false;
				}
			});
		}
		if(target != null) {
			switch(target.nodeName.toLowerCase()) {
				case 'th':
					switch(target.className) {
						case 'switch':
							me.showMode(1);
							break;
						case 'prev':
						case 'next':
							var dir = me.config.modes[me.viewMode].navStep * (target.className == 'prev' ? -1 : 1);
							switch(me.viewMode) {
								case 0:
									me.viewDate = $kit.date.moveMonth(me.viewDate, dir);
									break;
								case 1:
								case 2:
									me.viewDate = $kit.date.moveYear(me.viewDate, dir);
									break;
							}
							me.fill();
							break;
					}
					break;
				case 'span':
					if(!$kit.hsCls(target, 'disabled')) {
						if($kit.hsCls(target, 'month')) {
							var month = $kit.array.indexOf($kit.$el('span', target.parentNode), target);
							me.viewDate.setMonth(month);
						} else {
							var year = parseInt($kit.dom.text(target), 10) || 0;
							me.viewDate.setFullYear(year);
						}
						me.showMode(-1);
						me.fill();
					}
					break;
				case 'td':
					if($kit.hsCls(target, 'day') && !$kit.hsCls(target, 'disabled')) {
						var day = parseInt($kit.dom.text(target), 10) || 1;
						var year = me.viewDate.getFullYear(), month = me.viewDate.getMonth();
						if($kit.hsCls(target, 'old')) {
							if(month == 0) {
								month = 11;
								year -= 1;
							} else {
								month -= 1;
							}
						} else if($kit.hsCls(target, 'new')) {
							if(month == 11) {
								month = 0;
								year += 1;
							} else {
								month += 1;
							}
						}
						newDate = new Date(year, month, day, 0, 0, 0, 0);
						if(me.date && me.date.valueOf() == newDate.valueOf()) {
							$kit.rmCls(target, 'active');
							me.setValue(false);
							me.date = null;
						} else {
							me.date = newDate;
							me.viewDate = new Date(year, month, day, 0, 0, 0, 0);
							me.fill();
							if(e.shiftKey && me.config.canMultipleChoose && me.selectedDateAry && me.selectedDateAry.length >= 1) {
								//me.addValue(true);
							} else if(e.ctrlKey && me.config.canMultipleChoose && me.selectedDateAry && me.selectedDateAry.length >= 1) {
								//me.addValue();
							} else {
								if(!me.config.canMultipleChoose){
									me.setValue();
									me.hide();
								}else{
									me.addValue();
								}
							}
						}
					}
					break;
			}
		}
	},
	/*
	keydown : function(e) {
	if(me.picker.is(':not(:visible)')) {
	if(e.keyCode == 27)// allow escape to hide and re-show picker
	me.show();
	return;
	}
	var dir, day, month;
	switch(e.keyCode) {
	case 27:
	// escape
	me.hide();
	e.preventDefault();
	break;
	case 37:
	// left
	case 39:
	// right
	dir = e.keyCode == 37 ? -1 : 1;
	if(e.ctrlKey) {
	me.date = me.moveYear(me.date, dir);
	me.viewDate = me.moveYear(me.viewDate, dir);
	} else if(e.shiftKey) {
	me.date = me.moveMonth(me.date, dir);
	me.viewDate = me.moveMonth(me.viewDate, dir);
	} else {
	me.date.setDate(me.date.getDate() + dir);
	me.viewDate.setDate(me.viewDate.getDate() + dir);
	}
	me.setValue();
	me.update();
	e.preventDefault();
	break;
	case 38:
	// up
	case 40:
	// down
	dir = e.keyCode == 38 ? -1 : 1;
	if(e.ctrlKey) {
	me.date = me.moveYear(me.date, dir);
	me.viewDate = me.moveYear(me.viewDate, dir);
	} else if(e.shiftKey) {
	me.date = me.moveMonth(me.date, dir);
	me.viewDate = me.moveMonth(me.viewDate, dir);
	} else {
	me.date.setDate(me.date.getDate() + dir * 7);
	me.viewDate.setDate(me.viewDate.getDate() + dir * 7);
	}
	me.setValue();
	me.update();
	e.preventDefault();
	break;
	case 13:
	// enter
	me.hide();
	e.preventDefault();
	break;
	}
	},
	*/
	/**
	 * 显示天数还是月份还是年
	 */
	showMode : function(dir) {
		var me = this;
		if(dir) {
			me.viewMode = Math.max(0, Math.min(2, me.viewMode + dir));
		}
		var a = $kit.$el('>div', me.picker);
		$kit.each(a, function(o) {
			o.style.display = 'none';
		});
		$kit.array.filter(a, function(o) {
			if($kit.hsCls(o, 'datepicker-' + me.config.modes[me.viewMode].clsName)) {
				o.style.display = 'block';
			}
		})
		me.updateNavArrows();
	},
	/**
	 * 注册自定义事件
	 * @param {Object} config
	 * @param {String} config.ev
	 * @param {Function} config.fn
	 */
	ev : function() {
		if(arguments.length == 1) {
			var evCfg = arguments[0];
			var scope = evCfg.scope || this;
			if($kit.isFn(evCfg.fn) && $kit.isStr(evCfg.ev)) {
				var evCfg = {
					ev : evCfg.ev,
					fn : evCfg.fn,
					scope : this
				};
				this.event = this.event || {};
				this.event[evCfg.ev] = this.event[evCfg.ev] || [];
				this.event[evCfg.ev].push(evCfg);
			}
		}
	},
	/**
	 * 触发自定义事件
	 * @param {Object} config
	 * @param {String} config.ev
	 */
	newEv : function() {
		if(arguments.length == 1 && !$kit.isEmpty(this.event)) {
			var evAry, evCfg, _evCfg = {};
			if($kit.isStr(arguments[0])) {
				var ev = arguments[0];
				evAry = this.event[ev];
			} else if($kit.isObj(arguments[0])) {
				_evCfg = arguments[0];
				evAry = this.event[_evCfg.ev];
			}
			if(!$kit.isEmpty(evAry)) {
				for(var i = 0; evAry != null && i < evAry.length; i++) {
					evCfg = $kit.merge(evAry[i], _evCfg);
					var e = {
						target : this,
						type : evCfg.ev
					}
					evCfg.fn.call(evCfg.scope, e, evCfg);
				}
			}
		}
	}
});

/**
 * 多月日历（支持滑动多选,界面仿Twitter风格，多语言支持，Ctrl/Shift多选支持，日期范围限制支持，自定义事件支持）
 * @class $kit.ui.DatePicker.NMonths
 * @extends $kit.ui.DatePicker
 * @requires kit.js
 * @requires ieFix.js
 * @requires dom.js
 * @requires array.js
 * @see <a href="https://github.com/xueduany/KitJs/blob/master/KitJs/src/js/widget/DatePicker/datepicker-n-months.js">Source code</a>
 * @example
 * <a href="http://xueduany.github.com/KitJs/KitJs/demo/DatePicker/n-months.html">Demo</a><br/>
 * <img src="http://xueduany.github.com/KitJs/KitJs/demo/DatePicker/nmonth.png">
 */
$kit.ui.DatePicker.NMonths = function(config) {
	$kit.inherit({
		child : $kit.ui.DatePicker.NMonths,
		father : $kit.ui.DatePicker
	});
	var me = this;
	me.config = $kit.join(me.constructor.defaultConfig, config);
}
$kit.merge($kit.ui.DatePicker.NMonths,
/**
 * @lends $kit.ui.DatePicker.NMonths
 */
{
	/**
	 * @enum
	 */
	defaultConfig : $kit.join($kit.ui.DatePicker.defaultConfig,
	/**
	 * @lends $kit.ui.DatePicker.NMonths.defaultConfig
	 * @enum
	 */
	{
		template : {
			pickerHTML : [//
			'<div class="datepicker">', //
			'<div class="datepicker-days">', //
			'${pickerDaysHTML}', //
			'</div>', //
			'<div class="datepicker-months">', //
			'<table class="table-condensed">', //
			'${headHTML}', //
			'${contHTML}', //
			'</table>', //
			'</div>', //
			'<div class="datepicker-years">', //
			'<table class="table-condensed">', //
			'${headHTML}', //
			'${contHTML}', //
			'</table>', //
			'</div>', //
			'</div>'//
			].join(''),
			headHTML : [//
			'<thead>', //
			'<tr>', //
			'<th class="prev" onselectstart="return false"><i class="icon-arrow-left">&lt;</i></th>', //
			'<th colspan="5" class="switch"></th>', //
			'<th class="next" onselectstart="return false"><i class="icon-arrow-right">&gt;</i></th>', //
			'</tr>', //
			'</thead>'//
			].join(''),
			contHTML : '<tbody><tr><td colspan="7"></td></tr></tbody>',
			dropDownCls : 'dropdown-menu',
			pickerDaysHTML : [//
			'<table class="table-condensed">', //
			'${headHTML}', //
			'${contHTML}', //
			'</table>' //
			].join('')
		},
		/**
		 * 配置显示多少个月的日历
		 * @type {Number}
		 */
		nMonths : 3 //配置显示多少个月的日历
	})
});
$kit.merge($kit.ui.DatePicker.NMonths.prototype,
/**
 * @lends $kit.ui.DatePicker.NMonths.prototype
 */
{
	buildHTML : function() {
		var me = this;
		var str = $kit.tpl(me.config.template.pickerDaysHTML, me.config.template);
		var pickerDaysHTML = str;
		for(var i = 1; i < me.config.nMonths; i++) {
			pickerDaysHTML += str;
		}
		me.picker = $kit.newHTML($kit.tpl(me.config.template.pickerHTML, $kit.join(me.config.template, {
		pickerDaysHTML : pickerDaysHTML
		}))).childNodes[0];
		document.body.appendChild(me.picker);
	},
	/**
	 * 天数面板
	 */
	fill : function() {
		var me = this;
		me.currentMonthCol = me.currentMonthCol || 0;
		var d = new Date(me.viewDate), year = d.getFullYear(), month = d.getMonth(), //
		startYear = me.startDate !== -Infinity ? me.startDate.getFullYear() : -Infinity, //
		startMonth = me.startDate !== -Infinity ? me.startDate.getMonth() : -Infinity, //
		endYear = me.endDate !== Infinity ? me.endDate.getFullYear() : Infinity, //
		endMonth = me.endDate !== Infinity ? me.endDate.getMonth() : Infinity;
		//month = month + me.currentMonthCol;
		me.updateNavArrows();
		me.fillMonths();
		//
		var _year = year;
		for(var i = 0; i < me.config.nMonths; i++) {
			if(i == 0) {
				$kit.$el('.datepicker-days table:eq('+i+') th.next', me.picker)[0].style.visibility = 'hidden';
			} else if(i == me.config.nMonths - 1) {
				$kit.$el('.datepicker-days table:eq('+i+') th.prev', me.picker)[0].style.visibility = 'hidden';
			} else {
				$kit.$el('.datepicker-days table:eq('+i+') th.next', me.picker)[0].style.visibility = 'hidden';
				$kit.$el('.datepicker-days table:eq('+i+') th.prev', me.picker)[0].style.visibility = 'hidden';
			}
			if(i > 0) {
				month++;
				month = month % 12;
			}
			//
			if(_year == year && me.viewDate.getMonth() + i >= 12) {
				_year += 1;
			}
			var prevMonth = new Date(_year, month - 1, 28, 0, 0, 0, 0);
			var day = $kit.date.getDaysInMonth(prevMonth.getFullYear(), prevMonth.getMonth());
			prevMonth.setDate(day);
			prevMonth.setDate(day - (prevMonth.getDay() - me.weekStart + 7) % 7);
			//
			var nextMonth = new Date(prevMonth);
			nextMonth = new Date(prevMonth);
			nextMonth.setDate(nextMonth.getDate() + 42);
			//
			if(me.config.language != 'cn') {
				$kit.$el('.datepicker-days table:eq('+i+') th:eq(1)',me.picker)[0].innerHTML = $kit.date.languagePack[me.language].months[month] + ' ' + _year;
			} else {
				$kit.$el('.datepicker-days table:eq('+i+') th:eq(1)',me.picker)[0].innerHTML = _year + '年' + $kit.date.languagePack[me.language].months[month];
			}
			// start
			html = [];
			var clsName;
			while(prevMonth.valueOf() < nextMonth.valueOf()) {
				var notShow = false;
				if(prevMonth.getDay() == me.weekStart) {
					html.push('<tr>');
				}
				clsName = '';
				if(prevMonth.getFullYear() < _year || (prevMonth.getFullYear() == _year && prevMonth.getMonth() < month)) {
					notShow = true;
					clsName += ' old';
				} else if(prevMonth.getFullYear() > _year || (prevMonth.getFullYear() == _year && prevMonth.getMonth() > month)) {
					notShow = true;
					clsName += ' new';
				}
				$kit.each(me.selectedDateAry, function(o) {
					if(o.valueOf() == prevMonth.valueOf()) {
						clsName += ' active';
						return false;
					}
				});
				if(prevMonth.valueOf() < me.startDate || prevMonth.valueOf() > me.endDate) {
					clsName += ' disabled';
				}
				if(!notShow) {
					html.push('<td class="day' + clsName + '">' + prevMonth.getDate() + '</td>');
				} else {
					html.push('<td></td>');
				}
				if(prevMonth.getDay() == me.weekEnd) {
					html.push('</tr>');
				}
				prevMonth.setDate(prevMonth.getDate() + 1);
			}
			var tbody = $kit.$el('.datepicker-days tbody:eq('+i+')', me.picker)[0];
			var _htm = html.join('');
			if($kit.isIE()) {
				while(tbody.rows.length) {
					tbody.deleteRow(0);
				}
				tbody.parentNode.replaceChild($kit.newHTML('<table><tbody>' + _htm + '</tbody></table>').firstChild.firstChild, tbody);
			} else {
				tbody.innerHTML = '';
				$kit.insEl({
					where : tbody,
					what : _htm,
					pos : 'last'
				});
			}
		}
		/**
		 * end
		 */
		var currentYear = me.viewDate.getFullYear();
		//
		var monthsEl = $kit.$el('.datepicker-months', me.picker)[0];
		$kit.dom.text($kit.$el('th:eq(1)', monthsEl)[0], year);
		$kit.each($kit.$el('span', monthsEl), function(o) {
			$kit.rmCls(o, 'active');
		});
		//if(currentYear == year) {
		$kit.each($kit.$el('span.month', monthsEl), function(o, i) {
			var _m = me.viewDate.getMonth() + me.currentMonthCol;
			_m = _m % 12;
			if(i == _m) {
				$kit.adCls(o, 'active');
				return false;
			}
		});
		//}
		if(year < startYear || year > endYear) {
			$kit.adCls(monthsEl, 'disabled');
		}
		if(year == startYear) {
			$kit.each($kit.$el('span', monthsEl).slice(0, startMonth), function(o) {
				$kit.adCls(o, 'disabled');
			});
		}
		if(year == endYear) {
			$kit.each($kit.$el('span', monthsEl).slice(endMonth + 1), function(o) {
				$kit.adCls(o, 'disabled');
			});
		}
		html = '';
		year = parseInt(year / 10, 10) * 10;
		//
		var yearEl = $kit.$el('.datepicker-years',me.picker)[0];
		$kit.dom.text($kit.$el('th:eq(1)', yearEl)[0], year + '-' + (year + 9));
		var yearCont = $kit.$el('td', yearEl);
		year -= 1;
		for(var i = -1; i < 11; i++) {
			html += '<span class="year' + (i == -1 || i == 10 ? ' old' : '') + (currentYear == year ? ' active' : '') + (year < startYear || year > endYear ? ' disabled' : '') + '">' + year + '</span>';
			year += 1;
		}
		$kit.each(yearCont, function(o) {
			$kit.dom.html(o, html);
		});
	},
	/**
	 * 面板click事件
	 */
	click : function(e) {
		var me = this;
		if(me.mouseSlideSelect == true) {
			me.mouseSlideSelect = false;
			return;
		}
		e.stopNow();
		var target = e.target;
		//禁止点选
		var cls = target.getAttribute('class')||target.className;
		if(me.disabled && (target.tagName&& $kit.array.hs([ 'td','p'], target.tagName.toLowerCase()) || cls=='switch')){
			return;
		}
		
		//禁止点选年
		if(me.disableNav &&  cls=='switch'){
			return;
		}
		
		if(target.tagName && $kit.array.hs(['span', 'td', 'th'], target.tagName.toLowerCase())) {
			//
		} else {
			target = $kit.parentEl(target, function(p) {
				if(p.tagName && $kit.array.hs(['span', 'td', 'th'], p.tagName.toLowerCase())) {
					return true;
				}
				if(p == me.picker) {
					return false;
				}
			});
		}
		if(target != null) {
			switch(target.nodeName.toLowerCase()) {
				case 'th':
					switch(target.className) {
						case 'switch':
							var n = $kit.array.indexOf($kit.$el('.datepicker-days table', me.picker), $kit.dom.parentEl8tag(target, 'table', me.picker));
							if(n >= 0) {
								me.currentMonthCol = n;
							}
							//
							var monthsEl = $kit.$el('.datepicker-months', me.picker)[0];
							$kit.each($kit.$el('span', monthsEl), function(o) {
								$kit.rmCls(o, 'active');
							});
							$kit.each($kit.$el('span.month', monthsEl), function(o, i) {
								if(i == (me.viewDate.getMonth() + me.currentMonthCol) % 12) {
									$kit.adCls(o, 'active');
									return false;
								}
							});
							//
							if(me.viewDate.getMonth() + me.currentMonthCol >= 12) {
								$kit.dom.text($kit.$el('th:eq(1)', monthsEl)[0], me.viewDate.getFullYear() + 1);
								var yearEl = $kit.$el('.datepicker-years',me.picker)[0];
								$kit.each($kit.$el('span.year', me.picker), function(o) {
									if($kit.hsCls(o, 'active') && $kit.dom.text(o) != me.viewDate.getFullYear() + 1) {
										$kit.rmCls(o, 'active');
									}
									if($kit.dom.text(o) == me.viewDate.getFullYear() + 1) {
										$kit.adCls(o, 'active');
										return false;
									}
								});
							}
							//
							me.showMode(1);
							break;
						case 'prev':
						case 'next':
							var dir = me.config.modes[me.viewMode].navStep * (target.className == 'prev' ? -1 : 1);
							switch(me.viewMode) {
								case 0:
									me.viewDate = $kit.date.moveMonth(me.viewDate, dir);
									break;
								case 1:
								case 2:
									me.viewDate = $kit.date.moveYear(me.viewDate, dir);
									break;
							}
							me.fill();
							break;
					}
					break;
				case 'span':
					if(!$kit.hsCls(target, 'disabled')) {
						if($kit.hsCls(target, 'month')) {
							var month = $kit.array.indexOf($kit.$el('span', target.parentNode), target);
							var year = $kit.dom.text($kit.$el('th.switch',$kit.dom.parentEl8tag(target,'table',me.picker))[0]);
							me.viewDate.setFullYear(year);
							if(me.currentMonthCol) {
								month = month - me.currentMonthCol;
							}
							me.viewDate.setMonth(month);
						} else {
							var monthsEl = $kit.$el('.datepicker-months', me.picker)[0];
							$kit.dom.text($kit.$el('th:eq(1)', monthsEl)[0], me.viewDate.getFullYear());
							var year = parseInt($kit.dom.text(target), 10) || 0;
							me.viewDate.setFullYear(year);
						}
						me.showMode(-1);
						me.fill();
					}
					break;
				case 'td':
					if($kit.hsCls(target, 'day') && !$kit.hsCls(target, 'disabled')) {
						var day = parseInt($kit.dom.text(target), 10) || 1;
						var n = $kit.array.indexOf($kit.$el('.datepicker-days table', me.picker), $kit.dom.parentEl8tag(target, 'table', me.picker));
						me.currentMonthCol = n;
						var year = me.viewDate.getFullYear(), month = me.viewDate.getMonth() + n;
						newDate = new Date(year, month, day, 0, 0, 0, 0);
						if(me.date && me.date.valueOf() == newDate.valueOf()) {
							if(!me.config.canMultipleChoose)return;
							$kit.rmCls(target, 'active');
							me.setValue(false);
							me.date = null;
						} else {
							me.date = newDate;
							//me.viewDate = new Date(year, month, day, 0, 0, 0, 0);
							me.fill();
							if(e.shiftKey && me.config.canMultipleChoose && me.selectedDateAry && me.selectedDateAry.length >= 1) {
								me.addValue(true);
							} else if(e.ctrlKey && me.config.canMultipleChoose && me.selectedDateAry && me.selectedDateAry.length >= 1) {
								me.addValue();
							} else {
								if(me.config.canMultipleChoose)
									me.addValue();
								else{
									me.setValue();
								}
							}
						}
					}
					break;
			}
		}
	},
	/**
	 * 星期几
	 */
	fillDow : function() {
		var me = this;
		var dowCnt = me.weekStart;
		var html = '<tr>';
		while(dowCnt < me.weekStart + 7) {
			html += '<th class="dow">' + $kit.date.languagePack[me.language][me.config.weekViewFormat][(dowCnt++) % 7] + '</th>';
		}
		html += '</tr>';
		$kit.each($kit.$el('.datepicker-days thead', me.picker), function(o) {
			var thead = o;
			if($kit.isIE()) {
				var tr = thead.insertRow(1);
				thead.replaceChild($kit.newHTML('<table><tbody>' + html + '</tbody></table>').firstChild.firstChild.firstChild, tr)
			} else {
				$kit.insEl({
					where : thead,
					what : html,
					pos : 'last'
				});
			}
		});
	},
	mousemove : function(e) {
		var me = this, target = e.target;
		if(!me.config.canMultipleChoose) {
			return;
		}
		if(me.slideSelectFlag != true) {
			return;
		}
		if(target.tagName && $kit.array.hs(['td'], target.tagName.toLowerCase())) {
			//
		} else {
			target = $kit.parentEl(target, function(p) {
				if(p.tagName && $kit.array.hs(['td'], p.tagName.toLowerCase())) {
					return true;
				}
				if(p == me.picker) {
					return false;
				}
			});
		}
		if($kit.hsCls(target, 'day')) {
			var day = parseInt($kit.dom.text(target), 10) || 1;
			var n = $kit.array.indexOf($kit.$el('.datepicker-days table', me.picker), $kit.dom.parentEl8tag(target, 'table', me.picker));
			var year = me.viewDate.getFullYear(), month = me.viewDate.getMonth() + n;
			if($kit.hsCls(target, 'old') && !$kit.hsCls(target, 'disabled')) {
				if(month == 0) {
					month = 11;
					year -= 1;
				} else {
					month -= 1;
				}
			} else if($kit.hsCls(target, 'new') && !$kit.hsCls(target, 'disabled')) {
				if(month == 11) {
					month = 0;
					year += 1;
				} else {
					month += 1;
				}
			}
			date = new Date(year, month, day, 0, 0, 0, 0);
			$kit.adCls(target, 'active');
			if(me.mouseSlideSelectBeginDate == null) {
				me.mouseSlideSelectBeginDate = new Date(date);
				me.mouseSlideSelectBeginEl = target;
			} else if(me.mouseSlideSelectBeginDate.valueOf() != date.valueOf()//
			&& (//
				me.mouseSlideSelectEndDate == null//
				|| (me.mouseSlideSelectEndDate && me.mouseSlideSelectEndDate.valueOf() != date.valueOf()))//
			) {
				me.mouseSlideSelectEndDate = new Date(date);
				me.mouseSlideSelectEndEl = target;
				if(me.mouseSlideSelectBeginDate && me.mouseSlideSelectEndDate) {
					var first = false, last = false, firstDate, lastDate, firstEl, lastEl;
					if(me.mouseSlideSelectEndDate.valueOf() > me.mouseSlideSelectBeginDate.valueOf()) {
						//firstDate = me.mouseSlideSelectBeginDate;
						firstEl = me.mouseSlideSelectBeginEl;
						//lastDate = me.mouseSlideSelectEndDate;
						lastEl = me.mouseSlideSelectEndEl;
					} else {
						//lastDate = me.mouseSlideSelectBeginDate;
						lastEl = me.mouseSlideSelectBeginEl;
						//firstDate = me.mouseSlideSelectEndDate;
						firstEl = me.mouseSlideSelectEndEl;
					}
					$kit.each($kit.$el('.datepicker-days td.day', me.picker), function(o) {
						if(last) {
							$kit.rmCls(o, 'active');
						}
						if(first && o == lastEl) {
							last = true;
						}
						if(!first && o == firstEl) {
							first = true;
						}
						if(!first) {
							$kit.rmCls(o, 'active');
						}
						if(first && !last) {
							$kit.adCls(o, 'active');
						}
					});
				}
			}
		}
	},
	/**
	 * 刷新日期天数显示
	 */
	update : function() {
		var me = this;
		if(me.date < me.startDate) {
			me.viewDate = new Date(me.startDate);
		} else if(me.date > me.endDate) {
			me.viewDate = new Date(me.endDate);
		} else {
			if(me.viewDate == null) {
				me.viewDate = new Date(me.date);
			} else {
				if(me.date && me.viewDate && Math.abs((me.date.getFullYear() - me.viewDate.getFullYear()) * 12 + me.date.getMonth() - me.viewDate.getMonth()) > 3) {
					me.viewDate = new Date(me.date);
				}
			}
		}
		me.fill();
	},
	/**
	 * 按住shift或者ctrl添加
	 */
	addValue : function(continuous) {
		var me = this;
		continuous = continuous || false;
		me.selectedDateAry = me.selectedDateAry || [];
		var beginDate = me.selectedDateAry[0];
		var endDate = me.selectedDateAry[me.selectedDateAry.length - 1];
		if(continuous == true) {
			if(me.date.valueOf() < beginDate.valueOf()) {
				beginDate = new Date(me.date);
			} else {
				endDate = new Date(me.date);
			}
			var newSelectedDateAry = [];
			while(endDate.valueOf() >= beginDate.valueOf()) {
				newSelectedDateAry.push(new Date(beginDate));
				$kit.date.addDays(beginDate, 1);
			}
			me.selectedDateAry = newSelectedDateAry;
		} else {
			if(!beginDate || (me.date.valueOf() > endDate.valueOf())) {
				me.selectedDateAry.push(new Date(me.date));
			}else
			if(me.date.valueOf() < beginDate.valueOf()) {
				me.selectedDateAry.splice(0, 0, new Date(me.date));
			}  else if(me.date.valueOf() >= beginDate.valueOf() || me.date.valueOf() <= endDate.valueOf()) {
				var canAdd = true;
				for(var i = 0; i < me.selectedDateAry.length; ) {
					if(me.date.valueOf() == me.selectedDateAry[i].valueOf()) {
						me.selectedDateAry.splice(i, 1);
						canAdd = false;
						break;
					} else if(me.date.valueOf() > me.selectedDateAry[i].valueOf() && i < me.selectedDateAry.length - 1 && me.date.valueOf() < me.selectedDateAry[i + 1].valueOf()) {
						me.selectedDateAry.splice(i + 1, 0, new Date(me.date));
						break;
					} else if(i == me.selectedDateAry.length - 1) {
						me.selectedDateAry.splice(i, 0, new Date(me.date));
					}
					i++;
				}
			}
		}
		if(me.adhereEl) {
			me.adhereEl.value = me.getValue();
		}
		me.update();
		me.newEv({
			ev : 'change'
		});
	}
});
