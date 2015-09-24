<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>	
<html>
<head>
<meta charset="UTF-8">
<title>系统权限管理</title>
</head>

<body>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#divPage').page({
				url:'${OTT_ROOT}/sys0003/list',//获取数据的地址
				colModel://排列方式
				[
				 {display:'ID',width:'10%',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
				 {display:'编号',width:'10%',name:'roleno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
				 {display:'昵称',width:'20%',name:'rolename',defaultValue:'-',titleAligin:'center',cellAligin:'center'}
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
						<input name="roleno" placeholder="编号" type="text" style="width:90%;" size="30" maxlength="6" class="hasTooltip" data-original-title="编号">
						<hr class="hr-condensed">
						<input name="rolename" placeholder="昵称" type="text" style="width:90%;" maxlength="20" class="hasTooltip" data-original-title="昵称">
						<hr class="hr-condensed">
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