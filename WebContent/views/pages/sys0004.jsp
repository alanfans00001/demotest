<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/views/com/common.jsp"%>
	<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统用户管理</title>
</head>

<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#divPage').page({
				url:'${OTT_ROOT}/sys0004/list',//获取数据的地址
				colModel://排列方式
				[
				 {display:'ID',width:'10%',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
				 {display:'角色编号',width:'10%',name:'roleno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
				 {display:'菜单编号',width:'20%',name:'menuno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
				 {display:'按钮内容',width:'20%',name:'funno',defaultValue:'-',titleAligin:'center',cellAligin:'center'}
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
						<input name="roleno" placeholder="角色编号" type="text" style="width:90%;" class="hasTooltip" data-original-title="角色编号">
						<hr class="hr-condensed">
						<input name="menuno" placeholder="菜单编号" type="text" style="width:90%;" class="hasTooltip" data-original-title="菜单编号">
						<hr class="hr-condensed">
						<input name="funno" placeholder="按钮内容" type="text" style="width:90%;" class="hasTooltip" data-original-title="按钮内容">
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