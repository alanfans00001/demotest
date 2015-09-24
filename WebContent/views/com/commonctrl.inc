<c:set var="OTT_ROOT" value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
<c:set var="OTT_URL" value="${fn:substring(requestScope['javax.servlet.forward.request_uri'],1,-1)}"/>
<c:set var="OTT_URL" value="${fn:substring(OTT_URL,fn:indexOf(OTT_URL,'/'),-1)}"/>