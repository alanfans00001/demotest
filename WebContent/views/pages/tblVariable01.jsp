<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>变量管理-编辑</title>
</head>
<body>
	
	<script type="text/javascript">
	$(document).ready(function(){	
		
		$('form[class="form-horizontal"]').validate({
			rules:{
				'variable_name':{required:true},
				'variable_desc':{required:true},
				'variable_index':{regex:'^[1-9]\d*$'}
			},
			messages:{
				'variable_name':{required:'变量名称不能为空'},
				'variable_desc':{required:'文字描述不能为空'},
				'variable_index':{regex:'请输入正确的排序索引'}
			},
	  		onkeyup: false,
	  		errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
				$(element).focus();
		  	},
			submitHandler: function(form) {
				
				if($("select[name='variable_linkage']").val() == '0'){
					if($("#variable_linkage_variable_name").val().trim() == ""){
						_common.showEditedErrorMsg("联动下级下拉变量标识为空!");
						return false;
					}
				}
				
				if($("select[name='variable_required']").val() == '0'){
					if($("#variable_requiredmsg").val().trim() == ""){
						_common.showEditedErrorMsg("必输项提示信息为空!");
						return false;
					}
				}
				
				if($("select[name='variable_vaild']").val() == '0'){
					if($("#variable_vaildstr").val().trim() == ""){
						_common.showEditedErrorMsg("校验正则表达式字符串为空!");
						return false;
					}
					if($("#variable_vaildmsg").val().trim() == ""){
						_common.showEditedErrorMsg("格式校验提示信息为空!");
						return false;
					}
				}
				
				$.post('${OTT_ROOT}/tblVariable/saveOrUpdate',$(form).serializeObject(),function(data){
					if(data.result!='success'){
						_common.showEditedErrorMsg(data.msg);
					}else{
						history.back();
					}	
				},'json');
			}	
		});
		
		//下拉联动
		$("select").on("change",function(){
			var name = $(this).attr("name");
			if(name != 'variable_type' || name !='variable_style'){
				if($(this).val() == '1'){
					$("#"+name).hide("show");
				}else{
					$("#"+name).show("show");
				}
			}
			})
			
	   //不联动，不必输，不验证，初始化时隐藏文本框
	   $.each($("select"),function(i,v){
		   var name = $(v).attr("name");
		   if(name != 'variable_type' || name !='variable_style'){
			   if($(v).val() == '1'){
				   $("#"+name).hide("show");
			   }
		   }
	   })
	   
	});
	</script>
	
	<div class="container-fluid container-main">
		<section id="content"> 
			<div class="row-fluid">
				<div class="span12">

					<div id="system-message-container-backup" style="display:none;">
						<button type="button" class="close" data-dismiss="alert">×</button>
						<div class="alert">
							<h4 class="alert-heading"></h4>
							<p></p>
						</div>
					</div>
					
						<form method="post"class="form-horizontal">
							<fieldset>
									<div class="control-group" <c:if test="${null==tblVariable}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>ID
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id" readonly="readonly" class="readonly" size="30" value="${tblVariable.variable_id}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>变量名称
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_name" size="30" value="${tblVariable.variable_name}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>变量类别
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
										<!--变量类别,1:个人,2:家庭,3:工作,4:兴趣,5:其他  -->
											<select name="variable_style">
											  <option value="1">个人</option>
											  <option value="2">家庭</option>
											  <option value="3">工作</option>
											  <option value="4">兴趣</option>
											  <option value="5">系统</option>
											  <option value="6">其他</option>
											</select>
										</div>
									</div>
									 <div class="control-group">
										<div class="control-label">
											<label>变量类型
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
										<!-- 变量类型,1:文本框,2:下拉框,3:多选框,4:日期选择器,5:时间选择器 -->
											<select name="variable_type">
											  <option value="1" ${tblVariable.variable_type eq "1" ? 'selected="selected"':'' }>文本框</option>
											  <option value="2" ${tblVariable.variable_type eq "2" ? 'selected="selected"':'' }>下拉框</option>
											  <option value="3" ${tblVariable.variable_type eq "3" ? 'selected="selected"':'' }>多选框</option>
											  <option value="4" ${tblVariable.variable_type eq "4" ? 'selected="selected"':'' }>日期选择器</option>
											  <option value="5" ${tblVariable.variable_type eq "5" ? 'selected="selected"':'' }>时间选择器</option>
											</select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>文字描述
											</label>
										</div>
										<div class="controls">
											<textarea rows="5" cols="50" name="variable_desc">${tblVariable.variable_desc}</textarea>
										</div>
									</div>
									 <div class="control-group">
										<div class="control-label">
											<label>变量排序索引
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_index" size="30" value="${tblVariable.variable_index}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>文本框水印
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_txtwatermark" size="30" value="${tblVariable.variable_txtwatermark}"/>
										</div>
									</div>	
									<div class="control-group">
										<div class="control-label">
											<label>是否联动下级下拉选项
											</label>
										</div>
										<div class="controls">
										<!-- 是否联动下级下拉选项,0:联动,1:不联动 -->
											<select name="variable_linkage">
											  <option value="0" ${tblVariable.variable_linkage eq "0" ? 'selected="selected"':'' }>联动</option>
											  <option value="1" ${tblVariable.variable_linkage eq "1" ? 'selected="selected"':'' }>不联动</option>
											</select>
										</div>
									</div>	
									<div class="control-group" id="variable_linkage">
										<div class="control-label">
											<label>联动下级下拉变量标识
											</label>
										</div>
										<div class="controls">
							              <input type="text" name="variable_linkage_variable_name" id="variable_linkage_variable_name" size="30" value="${tblVariable.variable_linkage_variable_name}"/>
										</div>
									</div>	
									
									<div class="control-group">
										<div class="control-label">
											<label>是否必输项
											</label>
										</div>
										<div class="controls">
										<!-- 是否必输项,0:必输,1:不必输 -->
											<select name="variable_required">
											  <option value="0" ${tblVariable.variable_required eq "0" ? 'selected="selected"':'' }>必输</option>
											  <option value="1" ${tblVariable.variable_required eq "1" ? 'selected="selected"':'' }>不必输</option>
											</select>
										</div>
									</div>	
									<div class="control-group" id="variable_required">
										<div class="control-label">
											<label>必输项提示信息
											</label>
										</div>
										<div class="controls">
							              <input type="text" name="variable_requiredmsg" id="variable_requiredmsg" size="30" value="${tblVariable.variable_requiredmsg}"/>
										</div>
									</div>	
									
									<div class="control-group">
										<div class="control-label">
											<label>是否校验格式
											</label>
										</div>
										<div class="controls">
										<!-- 是否校验格式,0:校验,1:不校验(正则表达式)-->
											<select name="variable_vaild">
											  <option value="0" ${tblVariable.variable_vaild eq "0" ? 'selected="selected"':'' }>校验(正则表达式)</option>
											  <option value="1" ${tblVariable.variable_vaild eq "1" ? 'selected="selected"':'' }>不校验</option>
											</select>
										</div>
									</div>	
									<div class="control-group" id="variable_vaild">
										<div class="control-label">
											<label>校验正则表达式字符串
											</label>
										</div>
										<div class="controls">
										  <input type="text" name="variable_vaildstr" id="variable_vaildstr" size="30" value="${tblVariable.variable_vaildstr }"/>
										</div>
										<div class="control-label">
											<label>格式校验提示信息
											</label>
										</div>
										<div class="controls">
							              <input type="text" name="variable_vaildmsg" id="variable_vaildmsg" size="30" value="${tblVariable.variable_vaildmsg}"/>
										</div>
									</div>
									
									<%-- <div class="control-group">
										<div class="control-label">
											<label>启用状态</label>
										</div>
										<div class="controls">
											<select name="record_status">
												<c:forEach items="${sessionScope.system_work_key}" var="word">
													<c:if test="${word.typeno == 'W001'}">
														<option value="${word.wordbookno}"<c:if test="${tblVariable.record_status==word.wordbookno}">selected="selected"</c:if>>${word.contents}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>	 --%>								
									<div class="control-group" <c:if test="${null==tblVariable}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${tblVariable.creater_userid==sysUser.id}">
													<c:set var="creater" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==tblVariable}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建时间</label>
										</div>
										<div class="controls">
											<input type="text" readonly="readonly" class="readonly" size="30" value="${tblVariable.create_date}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==tblVariable}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${tblVariable.modifier_userid==sysUser.id}">
													<c:set var="modifier" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==tblVariable}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改时间</label>
										</div>
										<div class="controls">
											<input name="modifie_date" type="text" readonly="readonly" class="readonly" size="30" value="${tblVariable.modifie_date}"/>
										</div>
									</div>
								</fieldset>
						</form>
				</div>
			</div>
		</section>
	</div>
</body>
</html>