<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理</title> 
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
		url:'${OTT_ROOT}/tblUserInfo/list',//获取数据的地址
		colModel://排列方式
		[													   
		 {display:'ID',name:'user_card',defaultValue:'-',hidden:true,primaryKey:true},
		 {display:'姓名',width:'10%',name:'5',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'手机号码',width:'8%',name:'1',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'性别',width:'10%',name:'2',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'最高学历',width:'10%',name:'3',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'出生日期',width:'13%',name:'8',defaultValue:'-',titleAligin:'center',cellAligin:'center'},
		 {display:'民族',width:'10%',name:'9',defaultValue:'-',titleAligin:'center',cellAligin:'center'}
		/*  {display:'是否校验格式',width:'10%',name:'variable_vaild',defaultValue:'-',titleAligin:'center',cellAligin:'center',realValue:'0:校验,1:不校验'} */
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
						 <input name="user_card" placeholder="卡号" maxlength="10" type="text" style="width:90%;" class="hasTooltip" data-original-title="卡号">
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