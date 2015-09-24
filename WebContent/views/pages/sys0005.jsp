<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>数据字典管理</title> 
<style>
	.cc{display:inline;}
</style>
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
		url:'${OTT_ROOT}/sys0005/list',//获取数据的地址
		colModel://排列方式
		[													   
		 {display:'ID',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
		 {display:'字典编号',width:'10%',name:'wordbookno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'字符编码',width:'20%',name:'langno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'所属节点',width:'20%',name:'typeno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'字典内容',width:'20%',name:'contents',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'状态 ',width:'20%',name:'status',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:realStatus}
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
						<input name="wordbookno" placeholder="字典编号" maxlength="10" type="text" style="width:90%;" class="hasTooltip" data-original-title="字符编号">
						<hr class="hr-condensed">
						<input name="typeno" placeholder="所属节点" type="text" maxlength="10" style="width:90%;" class="hasTooltip" data-original-title="所属节点">
						<hr class="hr-condensed">
						<input name="contents" placeholder="字典内容" type="text" maxlength="20" style="width:90%;" class="hasTooltip" data-original-title="字典内容">
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