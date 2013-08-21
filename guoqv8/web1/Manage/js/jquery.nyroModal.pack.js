/*
 * nyroModal - jQuery Plugin
 * http://nyromodal.nyrodev.com
 *
 * Copyright (c) 2010 Cedric Nirousset (nyrodev.com)
 * Licensed under the MIT license
 *
 * $Date: 2010-02-23 (Tue, 23 Feb 2010) $
 * $version: 1.6.2
 */
jQuery(function($) {
	var userAgent = navigator.userAgent.toLowerCase();
	var browserVersion = (userAgent.match(/.+(?:rv|webkit|khtml|opera|msie)[\/: ]([\d.]+)/) || [0, '0'])[1];
	var isIE6 = (/msie/.test(userAgent) && !/opera/.test(userAgent) && parseInt(browserVersion) < 7 && (!window.XMLHttpRequest || typeof(XMLHttpRequest) === 'function'));
	var body = $('body');
	var currentSettings;
	var callingSettings;
	var shouldResize = false;
	var gallery = {};
	var fixFF = false;
	var contentElt;
	var contentEltLast;
	var modal = {
		started: false,
		ready: false,
		dataReady: false,
		anim: false,
		animContent: false,
		loadingShown: false,
		transition: false,
		resizing: false,
		closing: false,
		error: false,
		blocker: null,
		blockerVars: null,
		full: null,
		bg: null,
		loading: null,
		tmp: null,
		content: null,
		wrapper: null,
		contentWrapper: null,
		scripts: new Array(),
		scriptsShown: new Array()
	};
	var resized = {
		width: false,
		height: false,
		windowResizing: false
	};
	var initSettingsSize = {
		width: null,
		height: null,
		windowResizing: true
	};
	var windowResizeTimeout;
	$.fn.nyroModal = function(settings) {
		if (!this) return false;
		return this.each(function() {
			var me = $(this);
			if (this.nodeName.toLowerCase() == 'form') {
				me.unbind('submit.nyroModal').bind('submit.nyroModal',
				function(e) {
					if (e.isDefaultPrevented()) return false;
					if (me.data('nyroModalprocessing')) return true;
					if (this.enctype == 'multipart/form-data') {
						processModal($.extend(settings, {
							from: this
						}));
						return true
					}
					e.preventDefault();
					processModal($.extend(settings, {
						from: this
					}));
					return false
				})
			} else {
				me.unbind('click.nyroModal').bind('click.nyroModal',
				function(e) {
					if (e.isDefaultPrevented()) return false;
					e.preventDefault();
					processModal($.extend(settings, {
						from: this
					}));
					return false
				})
			}
		})
	};
	$.fn.nyroModalManual = function(settings) {
		if (!this.length) processModal(settings);
		return this.each(function() {
			processModal($.extend(settings, {
				from: this
			}))
		})
	};
	$.nyroModalManual = function(settings) {
		processModal(settings)
	};
	$.nyroModalSettings = function(settings, deep1, deep2) {
		setCurrentSettings(settings, deep1, deep2);
		if (!deep1 && modal.started) {
			if (modal.bg && settings.bgColor) currentSettings.updateBgColor(modal, currentSettings,
			function() {});
			if (modal.contentWrapper && settings.title) setTitle();
			if (!modal.error && (settings.windowResizing || (!modal.resizing && (('width' in settings && settings.width == currentSettings.width) || ('height' in settings && settings.height == currentSettings.height))))) {
				modal.resizing = true;
				if (modal.contentWrapper) calculateSize(true);
				if (modal.contentWrapper && modal.contentWrapper.is(':visible') && !modal.animContent) {
					if (fixFF) modal.content.css({
						position: ''
					});
					currentSettings.resize(modal, currentSettings,
					function() {
						currentSettings.windowResizing = false;
						modal.resizing = false;
						if (fixFF) modal.content.css({
							position: 'fixed'
						});
						if ($.isFunction(currentSettings.endResize)) currentSettings.endResize(modal, currentSettings)
					})
				}
			}
		}
	};
	$.nyroModalRemove = function() {
		removeModal()
	};
	$.nyroModalNext = function() {
		var link = getGalleryLink(1);
		if (link) return link.nyroModalManual(getCurrentSettingsNew());
		return false
	};
	$.nyroModalPrev = function() {
		var link = getGalleryLink( - 1);
		if (link) return link.nyroModalManual(getCurrentSettingsNew());
		return false
	};
	$.fn.nyroModal.settings = {
		debug: false,
		blocker: false,
		windowResize: true,
		modal: false,
		type: '',
		forceType: null,
		from: '',
		hash: '',
		processHandler: null,
		selIndicator: 'nyroModalSel',
		formIndicator: 'nyroModal',
		content: null,
		bgColor: '#000000',
		ajax: {},
		swf: {
			wmode: 'transparent'
		},
		width: null,
		height: null,
		minWidth: 400,
		minHeight: 300,
		resizable: true,
		autoSizable: true,
		padding: 25,
		regexImg: '[^\.]\.(jpg|jpeg|png|tiff|gif|bmp)\s*$',
		addImageDivTitle: false,
		defaultImgAlt: 'Image',
		setWidthImgTitle: true,
		ltr: true,
		gallery: null,
		galleryLinks: '<a href="#" class="nyroModalPrev">Prev</a><a href="#"  class="nyroModalNext">Next</a>',
		galleryCounts: galleryCounts,
		galleryLoop: false,
		zIndexStart: 100,
		cssOpt: {
			bg: {
				position: 'absolute',
				overflow: 'hidden',
				top: 0,
				left: 0,
				height: '100%',
				width: '100%'
			},
			wrapper: {
				position: 'absolute',
				top: '50%',
				left: '50%'
			},
			wrapper2: {},
			content: {},
			loading: {
				position: 'absolute',
				top: '50%',
				left: '50%',
				marginTop: '-50px',
				marginLeft: '-50px'
			}
		},
		wrap: {
			div: '<div class="wrapper"></div>',
			ajax: '<div class="wrapper"></div>',
			form: '<div class="wrapper"></div>',
			formData: '<div class="wrapper"></div>',
			image: '<div class="wrapperImg"></div>',
			swf: '<div class="wrapperSwf"></div>',
			iframe: '<div class="wrapperIframe"></div>',
			iframeForm: '<div class="wrapperIframe"></div>',
			manual: '<div class="wrapper"></div>'
		},
		closeButton: '<a href="#" class="nyroModalClose" id="closeBut" title="close">Close</a>',
		title: null,
		titleFromIframe: true,
		openSelector: '.nyroModal',
		closeSelector: '.nyroModalClose',
		contentLoading: '<a href="#" class="nyroModalClose">Cancel</a>',
		errorClass: 'error',
		contentError: 'The requested content cannot be loaded.<br />Please try again later.<br /><a href="#" class="nyroModalClose">Close</a>',
		handleError: null,
		showBackground: showBackground,
		hideBackground: hideBackground,
		endFillContent: null,
		showContent: showContent,
		endShowContent: null,
		beforeHideContent: null,
		hideContent: hideContent,
		showTransition: showTransition,
		hideTransition: hideTransition,
		showLoading: showLoading,
		hideLoading: hideLoading,
		resize: resize,
		endResize: null,
		updateBgColor: updateBgColor,
		endRemove: null
	};
	function processModal(settings) {
		if (modal.loadingShown || modal.transition || modal.anim) return;
		debug('processModal');
		modal.started = true;
		callingSettings = $.extend(true, settings);
		setDefaultCurrentSettings(settings);
		if (!modal.full) modal.blockerVars = modal.blocker = null;
		modal.error = false;
		modal.closing = false;
		modal.dataReady = false;
		modal.scripts = new Array();
		modal.scriptsShown = new Array();
		currentSettings.type = fileType();
		if (currentSettings.forceType) {
			if (!currentSettings.content) currentSettings.from = true;
			currentSettings.type = currentSettings.forceType;
			currentSettings.forceType = null
		}
		if ($.isFunction(currentSettings.processHandler)) currentSettings.processHandler(currentSettings);
		var from = currentSettings.from;
		var url = currentSettings.url;
		initSettingsSize.width = currentSettings.width;
		initSettingsSize.height = currentSettings.height;
		if (currentSettings.type == 'swf') {
			setCurrentSettings({
				overflow: 'visible'
			},
			'cssOpt', 'content');
			currentSettings.content = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="' + currentSettings.width + '" height="' + currentSettings.height + '"><param name="movie" value="' + url + '"></param>';
			var tmp = '';
			$.each(currentSettings.swf,
			function(name, val) {
				currentSettings.content += '<param name="' + name + '" value="' + val + '"></param>';
				tmp += ' ' + name + '="' + val + '"'
			});
			currentSettings.content += '<embed src="' + url + '" type="application/x-shockwave-flash" width="' + currentSettings.width + '" height="' + currentSettings.height + '"' + tmp + '></embed></object>'
		}
		if (from) {
			var jFrom = $(from).blur();
			if (currentSettings.type == 'form') {
				var data = $(from).serializeArray();
				data.push({
					name: currentSettings.formIndicator,
					value: 1
				});
				if (currentSettings.selector) data.push({
					name: currentSettings.selIndicator,
					value: currentSettings.selector.substring(1)
				});
				showModal();
				$.ajax($.extend({},
				currentSettings.ajax, {
					url: url,
					data: data,
					type: jFrom.attr('method') ? jFrom.attr('method') : 'get',
					success: ajaxLoaded,
					error: loadingError
				}));
				debug('Form Ajax Load: ' + jFrom.attr('action'))
			} else if (currentSettings.type == 'formData') {
				initModal();
				jFrom.attr('target', 'nyroModalIframe');
				jFrom.attr('action', url);
				jFrom.prepend('<input type="hidden" name="' + currentSettings.formIndicator + '" value="1" />');
				if (currentSettings.selector) jFrom.prepend('<input type="hidden" name="' + currentSettings.selIndicator + '" value="' + currentSettings.selector.substring(1) + '" />');
				modal.tmp.html('<iframe frameborder="0" hspace="0" name="nyroModalIframe" src="javascript:\'\';"></iframe>');
				$('iframe', modal.tmp).css({
					width: currentSettings.width,
					height: currentSettings.height
				}).error(loadingError).load(formDataLoaded);
				debug('Form Data Load: ' + jFrom.attr('action'));
				showModal();
				showContentOrLoading()
			} else if (currentSettings.type == 'image') {
				debug('Image Load: ' + url);
				var title = jFrom.attr('title') || currentSettings.defaultImgAlt;
				initModal();
				modal.tmp.html('<img id="nyroModalImg" />').find('img').attr('alt', title);
				modal.tmp.css({
					lineHeight: 0
				});
				$('img', modal.tmp).error(loadingError).load(function() {
					debug('Image Loaded: ' + this.src);
					$(this).unbind('load');
					var w = modal.tmp.width();
					var h = modal.tmp.height();
					modal.tmp.css({
						lineHeight: ''
					});
					resized.width = w;
					resized.height = h;
					setCurrentSettings({
						width: w,
						height: h,
						imgWidth: w,
						imgHeight: h
					});
					initSettingsSize.width = w;
					initSettingsSize.height = h;
					setCurrentSettings({
						overflow: 'visible'
					},
					'cssOpt', 'content');
					modal.dataReady = true;
					if (modal.loadingShown || modal.transition) showContentOrLoading()
				}).attr('src', url);
				showModal()
			} else if (currentSettings.type == 'iframeForm') {
				initModal();
				modal.tmp.html('<iframe frameborder="0" hspace="0" src="javascript:\'\';" name="nyroModalIframe" id="nyroModalIframe"></iframe>');
				debug('Iframe Form Load: ' + url);
				$('iframe', modal.tmp).eq(0).css({
					width: '100%',
					height: $.support.boxModel ? '99%': '100%'
				}).load(iframeLoaded);
				modal.dataReady = true;
				showModal()
			} else if (currentSettings.type == 'iframe') {
				initModal();
				modal.tmp.html('<iframe frameborder="0" hspace="0" src="javascript:\'\';" name="nyroModalIframe" id="nyroModalIframe"></iframe>');
				debug('Iframe Load: ' + url);
				$('iframe', modal.tmp).eq(0).css({
					width: '100%',
					height: $.support.boxModel ? '99%': '100%'
				}).load(iframeLoaded);
				modal.dataReady = true;
				showModal()
			} else if (currentSettings.type) {
				debug('Content: ' + currentSettings.type);
				initModal();
				modal.tmp.html(currentSettings.content);
				var w = modal.tmp.width();
				var h = modal.tmp.height();
				var div = $(currentSettings.type);
				if (div.length) {
					setCurrentSettings({
						type: 'div'
					});
					w = div.width();
					h = div.height();
					if (contentElt) contentEltLast = contentElt;
					contentElt = div;
					modal.tmp.append(div.contents())
				}
				initSettingsSize.width = w;
				initSettingsSize.height = h;
				setCurrentSettings({
					width: w,
					height: h
				});
				if (modal.tmp.html()) modal.dataReady = true;
				else loadingError();
				if (!modal.ready) showModal();
				else endHideContent()
			} else {
				debug('Ajax Load: ' + url);
				setCurrentSettings({
					type: 'ajax'
				});
				var data = currentSettings.ajax.data || {};
				if (currentSettings.selector) {
					if (typeof data == "string") {
						data += '&' + currentSettings.selIndicator + '=' + currentSettings.selector.substring(1)
					} else {
						data[currentSettings.selIndicator] = currentSettings.selector.substring(1)
					}
				}
				showModal();
				$.ajax($.extend(true, currentSettings.ajax, {
					url: url,
					success: ajaxLoaded,
					error: loadingError,
					data: data
				}))
			}
		} else if (currentSettings.content) {
			debug('Content: ' + currentSettings.type);
			setCurrentSettings({
				type: 'manual'
			});
			initModal();
			modal.tmp.html($('<div/>').html(currentSettings.content).contents());
			if (modal.tmp.html()) modal.dataReady = true;
			else loadingError();
			showModal()
		} else {}
	}
	function setDefaultCurrentSettings(settings) {
		debug('setDefaultCurrentSettings');
		currentSettings = $.extend(true, {},
		$.fn.nyroModal.settings, settings);
		setMargin()
	}
	function setCurrentSettings(settings, deep1, deep2) {
		if (modal.started) {
			if (deep1 && deep2) {
				$.extend(true, currentSettings[deep1][deep2], settings)
			} else if (deep1) {
				$.extend(true, currentSettings[deep1], settings)
			} else {
				if (modal.animContent) {
					if ('width' in settings) {
						if (!modal.resizing) {
							settings.setWidth = settings.width;
							shouldResize = true
						}
						delete settings['width']
					}
					if ('height' in settings) {
						if (!modal.resizing) {
							settings.setHeight = settings.height;
							shouldResize = true
						}
						delete settings['height']
					}
				}
				$.extend(true, currentSettings, settings)
			}
		} else {
			if (deep1 && deep2) {
				$.extend(true, $.fn.nyroModal.settings[deep1][deep2], settings)
			} else if (deep1) {
				$.extend(true, $.fn.nyroModal.settings[deep1], settings)
			} else {
				$.extend(true, $.fn.nyroModal.settings, settings)
			}
		}
	}
	function setMarginScroll() {
		if (isIE6 && !modal.blocker) {
			if (document.documentElement) {
				currentSettings.marginScrollLeft = document.documentElement.scrollLeft;
				currentSettings.marginScrollTop = document.documentElement.scrollTop
			} else {
				currentSettings.marginScrollLeft = document.body.scrollLeft;
				currentSettings.marginScrollTop = document.body.scrollTop
			}
		} else {
			currentSettings.marginScrollLeft = 0;
			currentSettings.marginScrollTop = 0
		}
	}
	function setMargin() {
		setMarginScroll();
		currentSettings.marginLeft = -(currentSettings.width + currentSettings.borderW) / 2;
		currentSettings.marginTop = -(currentSettings.height + currentSettings.borderH) / 2;
		if (!modal.blocker) {
			currentSettings.marginLeft += currentSettings.marginScrollLeft;
			currentSettings.marginTop += currentSettings.marginScrollTop
		}
	}
	function setMarginLoading() {
		setMarginScroll();
		var outer = getOuter(modal.loading);
		currentSettings.marginTopLoading = -(modal.loading.height() + outer.h.border + outer.h.padding) / 2;
		currentSettings.marginLeftLoading = -(modal.loading.width() + outer.w.border + outer.w.padding) / 2;
		if (!modal.blocker) {
			currentSettings.marginLeftLoading += currentSettings.marginScrollLeft;
			currentSettings.marginTopLoading += currentSettings.marginScrollTop
		}
	}
	function setTitle() {
		var title = $('h1#nyroModalTitle', modal.contentWrapper);
		if (title.length) title.text(currentSettings.title);
		else modal.contentWrapper.prepend('<h1 id="nyroModalTitle">' + currentSettings.title + '</h1>')
	}
	function initModal() {
		debug('initModal');
		if (!modal.full) {
			if (currentSettings.debug) setCurrentSettings({
				color: 'white'
			},
			'cssOpt', 'bg');
			var full = {
				zIndex: currentSettings.zIndexStart,
				position: 'fixed',
				top: 0,
				left: 0,
				width: '100%',
				height: '100%'
			};
			var contain = body;
			var iframeHideIE = '';
			if (currentSettings.blocker) {
				modal.blocker = contain = $(currentSettings.blocker);
				var pos = modal.blocker.offset();
				var w = modal.blocker.outerWidth();
				var h = modal.blocker.outerHeight();
				if (isIE6) {
					setCurrentSettings({
						height: '100%',
						width: '100%',
						top: 0,
						left: 0
					},
					'cssOpt', 'bg')
				}
				modal.blockerVars = {
					top: pos.top,
					left: pos.left,
					width: w,
					height: h
				};
				var plusTop = (/msie/.test(userAgent) ? 0: getCurCSS(body.get(0), 'borderTopWidth'));
				var plusLeft = (/msie/.test(userAgent) ? 0: getCurCSS(body.get(0), 'borderLeftWidth'));
				full = {
					position: 'absolute',
					top: pos.top + plusTop,
					left: pos.left + plusLeft,
					width: w,
					height: h
				}
			} else if (isIE6) {
				body.css({
					marginLeft: 0,
					marginRight: 0
				});
				var w = body.width();
				var h = $(window).height() + 'px';
				if ($(window).height() >= body.outerHeight()) {
					h = body.outerHeight() + 'px'
				} else w += 20;
				w += 'px';
				body.css({
					width: w,
					height: h,
					position: 'static',
					overflow: 'hidden'
				});
				$('html').css({
					overflow: 'hidden'
				});
				setCurrentSettings({
					cssOpt: {
						bg: {
							position: 'absolute',
							zIndex: currentSettings.zIndexStart + 1,
							height: '110%',
							width: '110%',
							top: currentSettings.marginScrollTop + 'px',
							left: currentSettings.marginScrollLeft + 'px'
						},
						wrapper: {
							zIndex: currentSettings.zIndexStart + 2
						},
						loading: {
							zIndex: currentSettings.zIndexStart + 3
						}
					}
				});
				iframeHideIE = $('<iframe id="nyroModalIframeHideIe" src="javascript:\'\';"></iframe>').css($.extend({},
				currentSettings.cssOpt.bg, {
					opacity: 0,
					zIndex: 50,
					border: 'none'
				}))
			}
			contain.append($('<div id="nyroModalFull"><div id="nyroModalBg"></div><div id="nyroModalWrapper"><div id="nyroModalContent"></div></div><div id="nyrModalTmp"></div><div id="nyroModalLoading"></div></div>').hide());
			modal.full = $('#nyroModalFull').css(full).show();
			modal.bg = $('#nyroModalBg').css($.extend({
				backgroundColor: currentSettings.bgColor
			},
			currentSettings.cssOpt.bg)).before(iframeHideIE);
			modal.bg.bind('click.nyroModal', clickBg);
			modal.loading = $('#nyroModalLoading').css(currentSettings.cssOpt.loading).hide();
			modal.contentWrapper = $('#nyroModalWrapper').css(currentSettings.cssOpt.wrapper).hide();
			modal.content = $('#nyroModalContent');
			modal.tmp = $('#nyrModalTmp').hide();
			if ($.isFunction($.fn.mousewheel)) {
				modal.content.mousewheel(function(e, d) {
					var elt = modal.content.get(0);
					if ((d > 0 && elt.scrollTop == 0) || (d < 0 && elt.scrollHeight - elt.scrollTop == elt.clientHeight)) {
						e.preventDefault();
						e.stopPropagation()
					}
				})
			}
			$(document).bind('keydown.nyroModal', keyHandler);
			modal.content.css({
				width: 'auto',
				height: 'auto'
			});
			modal.contentWrapper.css({
				width: 'auto',
				height: 'auto'
			});
			if (!currentSettings.blocker && currentSettings.windowResize) {
				$(window).bind('resize.nyroModal',
				function() {
					window.clearTimeout(windowResizeTimeout);
					windowResizeTimeout = window.setTimeout(windowResizeHandler, 200)
				})
			}
		}
	}
	function windowResizeHandler() {
		$.nyroModalSettings(initSettingsSize)
	}
	function showModal() {
		debug('showModal');
		if (!modal.ready) {
			initModal();
			modal.anim = true;
			currentSettings.showBackground(modal, currentSettings, endBackground)
		} else {
			modal.anim = true;
			modal.transition = true;
			currentSettings.showTransition(modal, currentSettings,
			function() {
				endHideContent();
				modal.anim = false;
				showContentOrLoading()
			})
		}
	}
	function clickBg(e) {
		if (!currentSettings.modal) removeModal()
	}
	function keyHandler(e) {
		if (e.keyCode == 27) {
			if (!currentSettings.modal) removeModal()
		} else if (currentSettings.gallery && modal.ready && modal.dataReady && !modal.anim && !modal.transition) {
			if (e.keyCode == 39 || e.keyCode == 40) {
				e.preventDefault();
				$.nyroModalNext();
				return false
			} else if (e.keyCode == 37 || e.keyCode == 38) {
				e.preventDefault();
				$.nyroModalPrev();
				return false
			}
		}
	}
	function fileType() {
		var from = currentSettings.from;
		var url;
		if (from && from.nodeName) {
			var jFrom = $(from);
			url = jFrom.attr(from.nodeName.toLowerCase() == 'form' ? 'action': 'href');
			if (!url) url = location.href.substring(window.location.host.length + 7);
			currentSettings.url = url;
			if (jFrom.attr('rev') == 'modal') currentSettings.modal = true;
			currentSettings.title = jFrom.attr('title');
			if (from && from.rel && from.rel.toLowerCase() != 'nofollow') {
				var indexSpace = from.rel.indexOf(' ');
				currentSettings.gallery = indexSpace > 0 ? from.rel.substr(0, indexSpace) : from.rel
			}
			var imgType = imageType(url, from);
			if (imgType) return imgType;
			if (isSwf(url)) return 'swf';
			var iframe = false;
			if (from.target && from.target.toLowerCase() == '_blank' || (from.hostname && from.hostname.replace(/:\d*$/, '') != window.location.hostname.replace(/:\d*$/, ''))) {
				iframe = true
			}
			if (from.nodeName.toLowerCase() == 'form') {
				if (iframe) return 'iframeForm';
				setCurrentSettings(extractUrlSel(url));
				if (jFrom.attr('enctype') == 'multipart/form-data') return 'formData';
				return 'form'
			}
			if (iframe) return 'iframe'
		} else {
			url = currentSettings.url;
			if (!currentSettings.content) currentSettings.from = true;
			if (!url) return null;
			if (isSwf(url)) return 'swf';
			var reg1 = new RegExp("^http://|https://", "g");
			if (url.match(reg1)) return 'iframe'
		}
		var imgType = imageType(url, from);
		if (imgType) return imgType;
		var tmp = extractUrlSel(url);
		setCurrentSettings(tmp);
		if (!tmp.url) return tmp.selector
	}
	function imageType(url, from) {
		var image = new RegExp(currentSettings.regexImg, 'i');
		if (image.test(url)) {
			return 'image'
		}
	}
	function isSwf(url) {
		var swf = new RegExp('[^\.]\.(swf)\s*$', 'i');
		return swf.test(url)
	}
	function extractUrlSel(url) {
		var ret = {
			url: null,
			selector: null
		};
		if (url) {
			var hash = getHash(url);
			var hashLoc = getHash(window.location.href);
			var curLoc = window.location.href.substring(0, window.location.href.length - hashLoc.length);
			var req = url.substring(0, url.length - hash.length);
			if (req == curLoc || req == $('base').attr('href')) {
				ret.selector = hash
			} else {
				ret.url = req;
				ret.selector = hash
			}
		}
		return ret
	}
	function loadingError() {
		debug('loadingError');
		modal.error = true;
		if (!modal.ready) return;
		if ($.isFunction(currentSettings.handleError)) currentSettings.handleError(modal, currentSettings);
		modal.loading.addClass(currentSettings.errorClass).html(currentSettings.contentError);
		$(currentSettings.closeSelector, modal.loading).unbind('click.nyroModal').bind('click.nyroModal', removeModal);
		setMarginLoading();
		modal.loading.css({
			marginTop: currentSettings.marginTopLoading + 'px',
			marginLeft: currentSettings.marginLeftLoading + 'px'
		})
	}
	function fillContent() {
		debug('fillContent');
		if (!modal.tmp.html()) return;
		modal.content.html(modal.tmp.contents());
		modal.tmp.empty();
		wrapContent();
		if (currentSettings.type == 'iframeForm') {
			$(currentSettings.from).attr('target', 'nyroModalIframe').data('nyroModalprocessing', 1).submit().attr('target', '_blank').removeData('nyroModalprocessing')
		}
		if (!currentSettings.modal) modal.wrapper.prepend(currentSettings.closeButton);
		if ($.isFunction(currentSettings.endFillContent)) currentSettings.endFillContent(modal, currentSettings);
		modal.content.append(modal.scripts);
		$(currentSettings.closeSelector, modal.contentWrapper).unbind('click.nyroModal').bind('click.nyroModal', removeModal);
		$(currentSettings.openSelector, modal.contentWrapper).nyroModal(getCurrentSettingsNew())
	}
	function getCurrentSettingsNew() {
		return callingSettings;
		var currentSettingsNew = $.extend(true, {},
		currentSettings);
		if (resized.width) currentSettingsNew.width = null;
		else currentSettingsNew.width = initSettingsSize.width;
		if (resized.height) currentSettingsNew.height = null;
		else currentSettingsNew.height = initSettingsSize.height;
		currentSettingsNew.cssOpt.content.overflow = 'auto';
		return currentSettingsNew
	}
	function wrapContent() {
		debug('wrapContent');
		var wrap = $(currentSettings.wrap[currentSettings.type]);
		modal.content.append(wrap.children().remove());
		modal.contentWrapper.wrapInner(wrap);
		if (currentSettings.gallery) {
			modal.content.append(currentSettings.galleryLinks);
			gallery.links = $('[rel="' + currentSettings.gallery + '"], [rel^="' + currentSettings.gallery + ' "]');
			gallery.index = gallery.links.index(currentSettings.from);
			if (currentSettings.galleryCounts && $.isFunction(currentSettings.galleryCounts)) currentSettings.galleryCounts(gallery.index + 1, gallery.links.length, modal, currentSettings);
			var currentSettingsNew = getCurrentSettingsNew();
			var linkPrev = getGalleryLink( - 1);
			if (linkPrev) {
				var prev = $('.nyroModalPrev', modal.contentWrapper).attr('href', linkPrev.attr('href')).click(function(e) {
					e.preventDefault();
					$.nyroModalPrev();
					return false
				});
				if (isIE6 && currentSettings.type == 'swf') {
					prev.before($('<iframe id="nyroModalIframeHideIeGalleryPrev" src="javascript:\'\';"></iframe>').css({
						position: prev.css('position'),
						top: prev.css('top'),
						left: prev.css('left'),
						width: prev.width(),
						height: prev.height(),
						opacity: 0,
						border: 'none'
					}))
				}
			} else {
				$('.nyroModalPrev', modal.contentWrapper).remove()
			}
			var linkNext = getGalleryLink(1);
			if (linkNext) {
				var next = $('.nyroModalNext', modal.contentWrapper).attr('href', linkNext.attr('href')).click(function(e) {
					e.preventDefault();
					$.nyroModalNext();
					return false
				});
				if (isIE6 && currentSettings.type == 'swf') {
					next.before($('<iframe id="nyroModalIframeHideIeGalleryNext" src="javascript:\'\';"></iframe>').css($.extend({},
					{
						position: next.css('position'),
						top: next.css('top'),
						left: next.css('left'),
						width: next.width(),
						height: next.height(),
						opacity: 0,
						border: 'none'
					})))
				}
			} else {
				$('.nyroModalNext', modal.contentWrapper).remove()
			}
		}
		calculateSize()
	}
	function getGalleryLink(dir) {
		if (currentSettings.gallery) {
			if (!currentSettings.ltr) dir *= -1;
			var index = gallery.index + dir;
			if (index >= 0 && index < gallery.links.length) return gallery.links.eq(index);
			else if (currentSettings.galleryLoop) {
				if (index < 0) return gallery.links.eq(gallery.links.length - 1);
				else return gallery.links.eq(0)
			}
		}
		return false
	}
	function calculateSize(resizing) {
		debug('calculateSize');
		modal.wrapper = modal.contentWrapper.children('div:first');
		resized.width = false;
		resized.height = false;
		if (false && !currentSettings.windowResizing) {
			initSettingsSize.width = currentSettings.width;
			initSettingsSize.height = currentSettings.height
		}
		if (currentSettings.autoSizable && (!currentSettings.width || !currentSettings.height)) {
			modal.contentWrapper.css({
				opacity: 0,
				width: 'auto',
				height: 'auto'
			}).show();
			var tmp = {
				width: 'auto',
				height: 'auto'
			};
			if (currentSettings.width) {
				tmp.width = currentSettings.width
			} else if (currentSettings.type == 'iframe') {
				tmp.width = currentSettings.minWidth
			}
			if (currentSettings.height) {
				tmp.height = currentSettings.height
			} else if (currentSettings.type == 'iframe') {
				tmp.height = currentSettings.minHeight
			}
			modal.content.css(tmp);
			if (!currentSettings.width) {
				currentSettings.width = modal.content.outerWidth(true);
				resized.width = true
			}
			if (!currentSettings.height) {
				currentSettings.height = modal.content.outerHeight(true);
				resized.height = true
			}
			modal.contentWrapper.css({
				opacity: 1
			});
			if (!resizing) modal.contentWrapper.hide()
		}
		if (currentSettings.type != 'image' && currentSettings.type != 'swf') {
			currentSettings.width = Math.max(currentSettings.width, currentSettings.minWidth);
			currentSettings.height = Math.max(currentSettings.height, currentSettings.minHeight)
		}
		var outerWrapper = getOuter(modal.contentWrapper);
		var outerWrapper2 = getOuter(modal.wrapper);
		var outerContent = getOuter(modal.content);
		var tmp = {
			content: {
				width: currentSettings.width,
				height: currentSettings.height
			},
			wrapper2: {
				width: currentSettings.width + outerContent.w.total,
				height: currentSettings.height + outerContent.h.total
			},
			wrapper: {
				width: currentSettings.width + outerContent.w.total + outerWrapper2.w.total,
				height: currentSettings.height + outerContent.h.total + outerWrapper2.h.total
			}
		};
		if (currentSettings.resizable) {
			var maxHeight = modal.blockerVars ? modal.blockerVars.height: $(window).height() - outerWrapper.h.border - (tmp.wrapper.height - currentSettings.height);
			var maxWidth = modal.blockerVars ? modal.blockerVars.width: $(window).width() - outerWrapper.w.border - (tmp.wrapper.width - currentSettings.width);
			maxHeight -= currentSettings.padding * 2;
			maxWidth -= currentSettings.padding * 2;
			if (tmp.content.height > maxHeight || tmp.content.width > maxWidth) {
				if (currentSettings.type == 'image' || currentSettings.type == 'swf') {
					var useW = currentSettings.imgWidth ? currentSettings.imgWidth: currentSettings.width;
					var useH = currentSettings.imgHeight ? currentSettings.imgHeight: currentSettings.height;
					var diffW = tmp.content.width - useW;
					var diffH = tmp.content.height - useH;
					if (diffH < 0) diffH = 0;
					if (diffW < 0) diffW = 0;
					var calcH = maxHeight - diffH;
					var calcW = maxWidth - diffW;
					var ratio = Math.min(calcH / useH, calcW / useW);
					calcW = Math.floor(useW * ratio);
					calcH = Math.floor(useH * ratio);
					tmp.content.height = calcH + diffH;
					tmp.content.width = calcW + diffW
				} else {
					tmp.content.height = Math.min(tmp.content.height, maxHeight);
					tmp.content.width = Math.min(tmp.content.width, maxWidth)
				}
				tmp.wrapper2 = {
					width: tmp.content.width + outerContent.w.total,
					height: tmp.content.height + outerContent.h.total
				};
				tmp.wrapper = {
					width: tmp.content.width + outerContent.w.total + outerWrapper2.w.total,
					height: tmp.content.height + outerContent.h.total + outerWrapper2.h.total
				}
			}
		}
		if (currentSettings.type == 'swf') {
			$('object, embed', modal.content).attr('width', tmp.content.width).attr('height', tmp.content.height)
		} else if (currentSettings.type == 'image') {
			$('img', modal.content).css({
				width: tmp.content.width,
				height: tmp.content.height
			})
		}
		modal.content.css($.extend({},
		tmp.content, currentSettings.cssOpt.content));
		modal.wrapper.css($.extend({},
		tmp.wrapper2, currentSettings.cssOpt.wrapper2));
		if (!resizing) modal.contentWrapper.css($.extend({},
		tmp.wrapper, currentSettings.cssOpt.wrapper));
		if (currentSettings.type == 'image' && currentSettings.addImageDivTitle) {
			$('img', modal.content).removeAttr('alt');
			var divTitle = $('div', modal.content);
			if (currentSettings.title != currentSettings.defaultImgAlt && currentSettings.title) {
				if (divTitle.length == 0) {
					divTitle = $('<div>' + currentSettings.title + '</div>');
					modal.content.append(divTitle)
				}
				if (currentSettings.setWidthImgTitle) {
					var outerDivTitle = getOuter(divTitle);
					divTitle.css({
						width: (tmp.content.width + outerContent.w.padding - outerDivTitle.w.total) + 'px'
					})
				}
			} else if (divTitle.length = 0) {
				divTitle.remove()
			}
		}
		if (currentSettings.title) setTitle();
		tmp.wrapper.borderW = outerWrapper.w.border;
		tmp.wrapper.borderH = outerWrapper.h.border;
		setCurrentSettings(tmp.wrapper);
		setMargin()
	}
	function removeModal(e) {
		debug('removeModal');
		if (e) e.preventDefault();
		if (modal.full && modal.ready) {
			$(document).unbind('keydown.nyroModal');
			if (!currentSettings.blocker) $(window).unbind('resize.nyroModal');
			modal.ready = false;
			modal.anim = true;
			modal.closing = true;
			if (modal.loadingShown || modal.transition) {
				currentSettings.hideLoading(modal, currentSettings,
				function() {
					modal.loading.hide();
					modal.loadingShown = false;
					modal.transition = false;
					currentSettings.hideBackground(modal, currentSettings, endRemove)
				})
			} else {
				if (fixFF) modal.content.css({
					position: ''
				});
				modal.wrapper.css({
					overflow: 'hidden'
				});
				modal.content.css({
					overflow: 'hidden'
				});
				$('iframe', modal.content).hide();
				if ($.isFunction(currentSettings.beforeHideContent)) {
					currentSettings.beforeHideContent(modal, currentSettings,
					function() {
						currentSettings.hideContent(modal, currentSettings,
						function() {
							endHideContent();
							currentSettings.hideBackground(modal, currentSettings, endRemove)
						})
					})
				} else {
					currentSettings.hideContent(modal, currentSettings,
					function() {
						endHideContent();
						currentSettings.hideBackground(modal, currentSettings, endRemove)
					})
				}
			}
		}
		if (e) return false
	}
	function showContentOrLoading() {
		debug('showContentOrLoading');
		if (modal.ready && !modal.anim) {
			if (modal.dataReady) {
				if (modal.tmp.html()) {
					modal.anim = true;
					if (modal.transition) {
						fillContent();
						modal.animContent = true;
						currentSettings.hideTransition(modal, currentSettings,
						function() {
							modal.loading.hide();
							modal.transition = false;
							modal.loadingShown = false;
							endShowContent()
						})
					} else {
						currentSettings.hideLoading(modal, currentSettings,
						function() {
							modal.loading.hide();
							modal.loadingShown = false;
							fillContent();
							setMarginLoading();
							setMargin();
							modal.animContent = true;
							currentSettings.showContent(modal, currentSettings, endShowContent)
						})
					}
				}
			} else if (!modal.loadingShown && !modal.transition) {
				modal.anim = true;
				modal.loadingShown = true;
				if (modal.error) loadingError();
				else modal.loading.html(currentSettings.contentLoading);
				$(currentSettings.closeSelector, modal.loading).unbind('click.nyroModal').bind('click.nyroModal', removeModal);
				setMarginLoading();
				currentSettings.showLoading(modal, currentSettings,
				function() {
					modal.anim = false;
					showContentOrLoading()
				})
			}
		}
	}
	function ajaxLoaded(data) {
		debug('AjaxLoaded: ' + this.url);
		if (currentSettings.selector) {
			var tmp = {};
			var i = 0;
			data = data.replace(/\r\n/gi, 'nyroModalLN').replace(/<script(.|\s)*?\/script>/gi,
			function(x) {
				tmp[i] = x;
				return '<pre style="display: none" class=nyroModalScript rel="' + (i++) + '"></pre>'
			});
			data = $('<div>' + data + '</div>').find(currentSettings.selector).html().replace(/<pre style="display: none;?" class="?nyroModalScript"? rel="(.?)"><\/pre>/gi,
			function(x, y, z) {
				return tmp[y]
			}).replace(/nyroModalLN/gi, "\r\n")
		}
		modal.tmp.html(filterScripts(data));
		if (modal.tmp.html()) {
			modal.dataReady = true;
			showContentOrLoading()
		} else loadingError()
	}
	function formDataLoaded() {
		debug('formDataLoaded');
		var jFrom = $(currentSettings.from);
		jFrom.attr('action', jFrom.attr('action') + currentSettings.selector);
		jFrom.attr('target', '');
		$('input[name=' + currentSettings.formIndicator + ']', currentSettings.from).remove();
		var iframe = modal.tmp.children('iframe');
		var iframeContent = iframe.unbind('load').contents().find(currentSettings.selector || 'body').not('script[src]');
		iframe.attr('src', 'about:blank');
		modal.tmp.html(iframeContent.html());
		if (modal.tmp.html()) {
			modal.dataReady = true;
			showContentOrLoading()
		} else loadingError()
	}
	function iframeLoaded() {
		if ((window.location.hostname && currentSettings.url.indexOf(window.location.hostname) > -1) || currentSettings.url.indexOf('http://')) {
			var iframe = $('iframe', modal.full).contents();
			var tmp = {};
			if (currentSettings.titleFromIframe) {
				tmp.title = iframe.find('title').text();
				if (!tmp.title) {
					try {
						tmp.title = iframe.find('title').html()
					} catch(err) {}
				}
			}
			var body = iframe.find('body');
			if (!currentSettings.height && body.height()) tmp.height = body.height();
			if (!currentSettings.width && body.width()) tmp.width = body.width();
			$.extend(initSettingsSize, tmp);
			$.nyroModalSettings(tmp)
		}
	}
	function galleryCounts(nb, total, elts, settings) {
		if (total > 1) settings.title += (settings.title ? ' - ': '') + nb + '/' + total
	}
	function endHideContent() {
		debug('endHideContent');
		modal.anim = false;
		if (contentEltLast) {
			contentEltLast.append(modal.content.contents());
			contentEltLast = null
		} else if (contentElt) {
			contentElt.append(modal.content.contents());
			contentElt = null
		}
		modal.content.empty();
		gallery = {};
		modal.contentWrapper.hide().children().remove().empty().attr('style', '').hide();
		if (modal.closing || modal.transition) modal.contentWrapper.hide();
		modal.contentWrapper.css(currentSettings.cssOpt.wrapper).append(modal.content);
		showContentOrLoading()
	}
	function endRemove() {
		debug('endRemove');
		$(document).unbind('keydown', keyHandler);
		modal.anim = false;
		modal.full.remove();
		modal.full = null;
		if (isIE6) {
			body.css({
				height: '',
				width: '',
				position: '',
				overflow: '',
				marginLeft: '',
				marginRight: ''
			});
			$('html').css({
				overflow: ''
			})
		}
		if ($.isFunction(currentSettings.endRemove)) currentSettings.endRemove(modal, currentSettings)
	}
	function endBackground() {
		debug('endBackground');
		modal.ready = true;
		modal.anim = false;
		showContentOrLoading()
	}
	function endShowContent() {
		debug('endShowContent');
		modal.anim = false;
		modal.animContent = false;
		modal.contentWrapper.css({
			opacity: ''
		});
		fixFF = /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent) && parseFloat(browserVersion) < 1.9 && currentSettings.type != 'image';
		if (fixFF) modal.content.css({
			position: 'fixed'
		});
		modal.content.append(modal.scriptsShown);
		if (currentSettings.type == 'iframe') modal.content.find('iframe').attr('src', currentSettings.url);
		if ($.isFunction(currentSettings.endShowContent)) currentSettings.endShowContent(modal, currentSettings);
		if (shouldResize) {
			shouldResize = false;
			$.nyroModalSettings({
				width: currentSettings.setWidth,
				height: currentSettings.setHeight
			});
			delete currentSettings['setWidth'];
			delete currentSettings['setHeight']
		}
		if (resized.width) setCurrentSettings({
			width: null
		});
		if (resized.height) setCurrentSettings({
			height: null
		})
	}
	function getHash(url) {
		if (typeof url == 'string') {
			var hashPos = url.indexOf('#');
			if (hashPos > -1) return url.substring(hashPos)
		}
		return ''
	}
	function filterScripts(data) {
		if (typeof data == 'string') data = data.replace(/<\/?(html|head|body)([^>]*)>/gi, '');
		var tmp = new Array();
		$.each($.clean({
			0: data
		},
		this.ownerDocument),
		function() {
			if ($.nodeName(this, "script")) {
				if (!this.src || $(this).attr('rel') == 'forceLoad') {
					if ($(this).attr('rev') == 'shown') modal.scriptsShown.push(this);
					else modal.scripts.push(this)
				}
			} else tmp.push(this)
		});
		return tmp
	}
	function getOuter(elm) {
		elm = elm.get(0);
		var ret = {
			h: {
				margin: getCurCSS(elm, 'marginTop') + getCurCSS(elm, 'marginBottom'),
				border: getCurCSS(elm, 'borderTopWidth') + getCurCSS(elm, 'borderBottomWidth'),
				padding: getCurCSS(elm, 'paddingTop') + getCurCSS(elm, 'paddingBottom')
			},
			w: {
				margin: getCurCSS(elm, 'marginLeft') + getCurCSS(elm, 'marginRight'),
				border: getCurCSS(elm, 'borderLeftWidth') + getCurCSS(elm, 'borderRightWidth'),
				padding: getCurCSS(elm, 'paddingLeft') + getCurCSS(elm, 'paddingRight')
			}
		};
		ret.h.outer = ret.h.margin + ret.h.border;
		ret.w.outer = ret.w.margin + ret.w.border;
		ret.h.inner = ret.h.padding + ret.h.border;
		ret.w.inner = ret.w.padding + ret.w.border;
		ret.h.total = ret.h.outer + ret.h.padding;
		ret.w.total = ret.w.outer + ret.w.padding;
		return ret
	}
	function getCurCSS(elm, name) {
		var ret = parseInt($.curCSS(elm, name, true));
		if (isNaN(ret)) ret = 0;
		return ret
	}
	function debug(msg) {
		if ($.fn.nyroModal.settings.debug || currentSettings && currentSettings.debug) nyroModalDebug(msg, modal, currentSettings || {})
	}
	function showBackground(elts, settings, callback) {
		elts.bg.css({
			opacity: 0
		}).fadeTo(500, 0.75, callback)
	}
	function hideBackground(elts, settings, callback) {
		elts.bg.fadeOut(300, callback)
	}
	function showLoading(elts, settings, callback) {
		elts.loading.css({
			marginTop: settings.marginTopLoading + 'px',
			marginLeft: settings.marginLeftLoading + 'px',
			opacity: 0
		}).show().animate({
			opacity: 1
		},
		{
			complete: callback,
			duration: 400
		})
	}
	function hideLoading(elts, settings, callback) {
		callback()
	}
	function showContent(elts, settings, callback) {
		elts.loading.css({
			marginTop: settings.marginTopLoading + 'px',
			marginLeft: settings.marginLeftLoading + 'px'
		}).show(0).animate({
			width: settings.width + 'px',
			height: settings.height + 'px',
			marginTop: settings.marginTop + 'px',
			marginLeft: settings.marginLeft + 'px'
		},
		{
			duration: 0,
			complete: function() {
				elts.contentWrapper.css({
					width: settings.width + 'px',
					height: settings.height + 'px',
					marginTop: settings.marginTop + 'px',
					marginLeft: settings.marginLeft + 'px'
				}).show(0);
				elts.loading.fadeOut(50, callback)
			}
		})
	}
	function hideContent(elts, settings, callback) {
		elts.contentWrapper.animate({
			height: '50px',
			width: '50px',
			marginTop: ( - (25 + settings.borderH) / 2 + settings.marginScrollTop) + 'px',
			marginLeft: ( - (25 + settings.borderW) / 2 + settings.marginScrollLeft) + 'px'
		},
		{
			duration: 50,
			complete: function() {
				elts.contentWrapper.hide();
				callback()
			}
		})
	}
	function showTransition(elts, settings, callback) {
		elts.loading.css({
			marginTop: elts.contentWrapper.css('marginTop'),
			marginLeft: elts.contentWrapper.css('marginLeft'),
			height: elts.contentWrapper.css('height'),
			width: elts.contentWrapper.css('width'),
			opacity: 0
		}).show().fadeTo(400, 1,
		function() {
			elts.contentWrapper.hide();
			callback()
		})
	}
	function hideTransition(elts, settings, callback) {
		elts.contentWrapper.hide().css({
			width: settings.width + 'px',
			height: settings.height + 'px',
			marginLeft: settings.marginLeft + 'px',
			marginTop: settings.marginTop + 'px',
			opacity: 1
		});
		elts.loading.animate({
			width: settings.width + 'px',
			height: settings.height + 'px',
			marginLeft: settings.marginLeft + 'px',
			marginTop: settings.marginTop + 'px'
		},
		{
			complete: function() {
				elts.contentWrapper.show();
				elts.loading.fadeOut(400,
				function() {
					elts.loading.hide();
					callback()
				})
			},
			duration: 350
		})
	}
	function resize(elts, settings, callback) {
		elts.contentWrapper.animate({
			width: settings.width + 'px',
			height: settings.height + 'px',
			marginLeft: settings.marginLeft + 'px',
			marginTop: settings.marginTop + 'px'
		},
		{
			complete: callback,
			duration: 400
		})
	}
	function updateBgColor(elts, settings, callback) {
		if (!$.fx.step.backgroundColor) {
			elts.bg.css({
				backgroundColor: settings.bgColor
			});
			callback()
		} else elts.bg.animate({
			backgroundColor: settings.bgColor
		},
		{
			complete: callback,
			duration: 400
		})
	}
	$($.fn.nyroModal.settings.openSelector).nyroModal()
});
var tmpDebug = '';
function nyroModalDebug(msg, elts, settings) {
	if (elts.full && elts.bg) {
		elts.bg.prepend(msg + '<br />' + tmpDebug);
		tmpDebug = ''
	} else tmpDebug += msg + '<br />'
}