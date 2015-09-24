<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>	
<html>
<head>
<meta charset="UTF-8">
<title>系统按钮管理</title>
</head>

<body>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var realStatus='';
			<c:forEach items="${sessionScope.system_work_key}" var="word">
			<c:if test="${word.typeno == 'W001'}">
			realStatus +="${word.wordbookno}:${word.contents},";
			</c:if>
			</c:forEach>
			$('#divPage').page({
				url:'${OTT_ROOT}/sys0006/list',//获取数据的地址
				colModel://排列方式
				[
				 {display:'ID',width:'10%',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
				 {display:'编号',width:'10%',name:'funno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
				 {display:'名称',width:'20%',name:'funvalue',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
				 {display:'状态',width:'10%',name:'status',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:realStatus}
				],
				filterForm:$('#frmFilter')
			});
		});
	</script>
	
	<div id="j-sidebar-container" class="span2">
		<div id="sidebar">
			<div class="sidebar-nav">
				<jsp:include page="/views/com/left.jsp"></jsp:include>
				<hr/>
				<div class="filter-select hidden-phone">
					<form id="frmFilter">
						<h4 class="page-header">过滤器:</h4>
						<input name="funno" placeholder="编号" type="text" style="width:90%;" class="hasTooltip" maxlength="6" data-original-title="编号">
						<hr class="hr-condensed">
						<input name="funvalue" placeholder="名称" type="text" style="width:90%;" class="hasTooltip" maxlength="20" data-original-title="名称">
						<hr class="hr-condensed">
						<select name="status">
							<option value="">-&nbsp;&nbsp;状态&nbsp;&nbsp;-</option>
							<c:forEach items="${sessionScope.system_work_key}" var="word">
								<c:if test="${word.typeno == 'W001'}">
									<option value="${word.wordbookno}" >${word.contents}</option>
								</c:if>
							</c:forEach>
						</select>
						<input type="reset" style="display:none;"/>
					</form>
				</div>
			</div>
		</div>
	</div>		
	
	<div id="divPage">
		<jsp:include page="/views/com/page.jsp"></jsp:include>
	</div>

</body>
</html>