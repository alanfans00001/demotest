<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/views/com/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统菜单管理</title>

</head>

<body>

	<jsp:include page="/views/com/header.jsp"></jsp:include>


	<script type="text/javascript">
	$(document).ready(function(){

		
		$('#divPage').page({
			url:'${OTT_ROOT}/sys0002/list',//获取数据的地址
			colModel://排列方式
			[
			 {display:'ID',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
			
			 {display:'菜单编号',width:'10%',name:'menuno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
			 {display:'菜单名称',width:'20%',name:'menuname',defaultValue:'-',titleAligin:'center',cellAligin:'center',link:'${OTT_ROOT}/sys0002/editInit?ids='},
			 {display:'父级菜单',width:'20%',name:'fathermenuno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
			 {display:'菜单类型',width:'20%',name:'menutype',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'0:父菜单,1:子菜单,2:其他'},
			 {display:'菜单路径',width:'20%',name:'menuurl',defaultValue:'-',titleAligin:'center',cellAligin:'center'}
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
						<input name="menuno" placeholder="菜单编号" type="text" maxlength="18" style="width:90%;" class="hasTooltip" data-original-title="菜单编号">
						<hr class="hr-condensed">
						<input name="menuname" placeholder="菜单名称" type="text" maxlength="100" style="width:90%;" class="hasTooltip" data-original-title="菜单名称">
						<hr class="hr-condensed">
						<input name="menuurl" placeholder="菜单路径" type="text" maxlength="100" style="width:90%;" class="hasTooltip" data-original-title="菜单路径">
						<hr class="hr-condensed">
						<select name="menutype">
							<option value="">-&nbsp;&nbsp;菜单类型&nbsp;&nbsp;-</option>
							<!--
							<option value="0">父菜单</option>
							<option value="1">子菜单</option>
							<option value="2">其他</option>
							-->
							<c:forEach items="${sessionScope.system_work_key}" var="word">
								<c:if test="${word.typeno == 'W00003'}"> <!-- <c:if test="${word.wordbookno == 'W00101'}">selected="selected"</c:if> -->
									<option value="${word.wordbookno}">${word.contents}</option>
								</c:if>
							</c:forEach>
							
						</select>
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