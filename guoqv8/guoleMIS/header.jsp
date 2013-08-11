<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<!-- Favicons --> 
<link rel="shortcut icon" type="image/png" HREF="${pageContext.request.contextPath}/img/favicons/favicon.png"/>
<link rel="icon" type="image/png" HREF="${pageContext.request.contextPath}/img/favicons/favicon.png"/>
<link rel="apple-touch-icon" HREF="${pageContext.request.contextPath}/img/favicons/apple.png" />
<!-- Main Stylesheet --> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
<!-- jQuery with plugins -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.ui.core.min.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.ui.widget.min.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.ui.tabs.min.js"></script>
<!-- jQuery tooltips -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.tipTip.min.js"></script>
<!-- Superfish navigation -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.superfish.min.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.supersubs.min.js"></script>
<!-- jQuery form validation -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.validate_pack.js"></script>
<!-- jQuery popup box -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.nyroModal.pack.js"></script>
<!-- jQuery data tables -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.dataTables.min.js"></script>
<!-- Admin template javascript load -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/administry.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/util.js"></script>
<!-- jQuery tag input -->
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.tagInput.min.js"></script>
<script type="text/javascript" SRC="${pageContext.request.contextPath}/js/jquery.wysiwyg.min.js"></script>


<!-- Internet Explorer Fixes --> 
<script type="text/javascript">
$(document).ready(function(){
	
	/* setup navigation, content boxes, etc... */
	Administry.setup();
	
	/* progress bar animations - setting initial values */
	Administry.progress("#progress1", 1, 5);
	Administry.progress("#progress2", 2, 5);
	Administry.progress("#progress3", 2, 5);

		/* datatable */
	$('#example').dataTable();
	
	/* expandable rows */
	Administry.expandableRows();
});

function replaceHtml(str) {
	return str.replace(/</ig, "&lt;").replace(/>/ig, "&gt;");
}
</script>