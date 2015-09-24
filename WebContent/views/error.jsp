<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/views/com/commonctrl.inc"%>
<!DOCTYPE html>
<html>
<jsp:include page="/views/com/common.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<title>登录</title>
</head>

<body class="site com_login view-login layout-default task- itemid- ">
<div id="system-message-container" style="display:block;margin:16px;">
	<div class="alert alert-error">
		<p>&nbsp;</p>
		<h2>出错了！</h2>
		<p>&nbsp;</p>
		<p>
			<c:if test="${exception==null}">
				你没有访问此页面的权限
			</c:if>
			<c:if test="${exception!=null}">
			<ul>
				<li><span class="error">Caused by  ${exception}</span></li>
				<c:forEach var="info" items="${exception.stackTrace}">
				<li>&nbsp;<c:out value="${info}" /></li>
				</c:forEach>
			</ul>
			</c:if>
  		</p>
	</div>
</div>
<div style="float:right;margin:auto 32px 0 0;">
	<div class="btn-wrapper" style="display:inline;">
		<button class="btn btn-success"  onclick="javascript:window.location.href='${OTT_ROOT}/loginOut';">重新登录</button>
	</div>
	<div class="btn-wrapper" style="display:inline;">
		<button class="btn btn-success" onclick="javascript:history.back();">返回</button>
	</div>
</div>
</body>
</html>