<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统用户管理</title> 
	
<script type="text/javascript">
$(document).ready(function(){
	var realRoleno='';
	<c:forEach items="${roleList}" var="role">
	realRoleno +="${role.roleno}:${role.rolename},";
	</c:forEach>
	
	var realStatus='';
	<c:forEach items="${sessionScope.system_work_key}" var="word">
	<c:if test="${word.typeno == 'W001'}">
	realStatus +="${word.wordbookno}:${word.contents},";
	</c:if>
	</c:forEach> 
	$('#divPage').page({
		url:'${OTT_ROOT}/sys0001/list',//获取数据的地址
		colModel://排列方式
		[
		 {display:'ID',name:'id',defaultValue:'-',hidden:true,primaryKey:true},
		 //{display:'addAndSubTest',name:'id',defaultValue:'0',titleAligin:'center',cellAligin:'center',addAndSub:{min:0,max:10,url:'${OTT_ROOT}/sys0001/addAndSub'}},
		 {display:'账户',width:'20%',name:'userno',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'昵称',width:'20%',name:'username',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'邮件',name:'email',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'角色',width:'10%',name:'roleno',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:realRoleno},
		 {display:'状态',width:'10%',name:'status',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:realStatus,rowCallBack:function(row,value){
			if(value=='W00101'){
				row.find('td[name="userno"]').html('<a href="${OTT_ROOT}/sys0001/editInit?ids='+row.find('td[name="id"]').html()+'">'+row.find('td[name="userno"]').html()+'</a>');;
			}
		 }}
		],
		filterForm:$('#frmFilter')
	});
});
</script>
</head>

<body> 
	<div id="j-sidebar-container" class="span2">
		<div id="sidebar">
			<div class="sidebar-nav">
				<jsp:include page="/views/com/left.jsp"></jsp:include>
				<hr/>
				<div class="filter-select hidden-phone">
					<form id="frmFilter">
						<h4 class="page-header">过滤器:</h4>
						<input name="userno" placeholder="账户" maxlength="20" type="text" style="width:90%;" class="hasTooltip" data-original-title="账户">
						<hr class="hr-condensed">
						<input name="username" placeholder="昵称" maxlength="20" type="text" style="width:90%;" class="hasTooltip" data-original-title="昵称">
						<hr class="hr-condensed">
						<input name="email" placeholder="邮件地址"  maxlength="30" type="text" style="width:90%;" class="hasTooltip" data-original-title="邮件地址">
						<hr class="hr-condensed">
						<select name="roleno">
							<option value="">-&nbsp;&nbsp;角色&nbsp;&nbsp;-</option>
							<c:forEach items="${roleList}" var="role">
								<option value="${role.roleno}">${role.rolename}</option>
							</c:forEach>
						</select>
						<hr class="hr-condensed">
						<select name="status">
							<option value="">-&nbsp;&nbsp;启用状态&nbsp;&nbsp;-</option>
							<c:forEach items="${sessionScope.system_work_key}" var="word">
								<c:if test="${word.typeno == 'W001'}"> <!-- <c:if test="${word.wordbookno == 'W00101'}">selected="selected"</c:if> -->
									<option value="${word.wordbookno}">${word.contents}</option>
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