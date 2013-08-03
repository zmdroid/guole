for(var i = 0; i < 10; i++) { var scriptId = 'u' + i; window[scriptId] = document.getElementById(scriptId); }

$axure.eventManager.pageLoad(
function (e) {

});
gv_vAlignTable['u4'] = 'top';
u5.style.cursor = 'pointer';
$axure.eventManager.click('u5', function(e) {

if (true) {

	self.location.href=$axure.globalVariableProvider.getLinkUrl('登录.html');

}
});
gv_vAlignTable['u6'] = 'top';gv_vAlignTable['u7'] = 'top';gv_vAlignTable['u9'] = 'center';gv_vAlignTable['u1'] = 'center';gv_vAlignTable['u2'] = 'top';
u3.style.cursor = 'pointer';
$axure.eventManager.click('u3', function(e) {

if (true) {

	self.location.href=$axure.globalVariableProvider.getLinkUrl('首页.html');

}
});
