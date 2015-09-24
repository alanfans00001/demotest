<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>变量管理</title> 
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
		url:'${OTT_ROOT}/tblVariable/list',//获取数据的地址
		colModel://排列方式
		[													   
		 {display:'ID',name:'variable_id',defaultValue:'-',hidden:true,primaryKey:true},
		 {display:'变量名称',width:'15%',name:'variable_name',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'变量类别',width:'10%',name:'variable_style',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'1:个人,2:家庭,3:工作,4:兴趣,5:系统,6:其他'},
		 {display:'变量类型',width:'13%',name:'variable_type',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'1:文本框,2:下拉框,3:多选框,4:日期选择器,5:时间选择器'},
		 {display:'是否联动下级下拉选项',width:'10%',name:'variable_linkage',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'0:联动,1:不联动'},
		 {display:'是否必输项',width:'10%',name:'variable_required',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'0:必输,1:不必输'},
		 {display:'是否校验格式',width:'10%',name:'variable_vaild',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'0:校验,1:不校验'}
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
						 <input name="variable_name" placeholder="变量名称" maxlength="10" type="text" style="width:90%;" class="hasTooltip" data-original-title="变量名称">
						<%--<hr class="hr-condensed">
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
						<input type="reset" style="display:none;"/> --%>
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