<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.textarea{width: 500px;height: 100px;max-width: 500px;max-height: 100px;resize: none;}
</style>
<c:set var="OTT_ROOT" value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
<c:set var="OTT_URL" value="${fn:substring(requestScope['javax.servlet.forward.request_uri'],1,-1)}"/>
<c:set var="OTT_URL" value="${fn:substring(OTT_URL,fn:indexOf(OTT_URL,'/'),-1)}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${OTT_ROOT}/views/css/template.css" type="text/css" />
<link rel="stylesheet" href="${OTT_ROOT}/views/css/chosen.css" type="text/css" />
<link rel="stylesheet" href="${OTT_ROOT}/views/js/jquery/colorbox/colorbox.css" type="text/css" />
<link rel="stylesheet" href="${OTT_ROOT}/views/css/bootstrap-datetimepicker.min.css" type="text/css" />
</head>
<body> 
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/jquery-1.7.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/com/common.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/mootools-core.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/core.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/tabs.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/colorbox/jquery.colorbox.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/colorbox/jquery.colorbox-min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/lhgcalendar.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/demo.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="${OTT_ROOT}/views/js/datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){	
		 $(".form_datetime").datetimepicker({
		        autoclose: true,
		        format: "yyyy-mm-dd hh:ii:ss",
		        pickerPosition: ("bottom-left"),
		        language: "zh-CN",
		        startView:2,
		        todayHighlight:true,
		        showMeridian:false,
		        minView:0
			    });
		 
		 ///2015-07-03用
		 $(".form_datetime2").datetimepicker({
		        autoclose: true,
		        format: "yyyy-mm-dd",
		        pickerPosition: ("bottom-left"),
		        language: "zh-CN",
		        todayHighlight:true,
		        startView:2,
		        minView:2,
		        maxView:4
			    });
		///2015-07-03用
		 $(".form_datetime3").datetimepicker({
		        autoclose: true,
		        format: "yyyy年mm月dd日",
		        pickerPosition: ("bottom-left"),
		        language: "zh-CN",
		        todayHighlight:true,
		        startView:2,
		        minView:2,
		        maxView:4
			    });
	});
	</script>
</body>
</html>
