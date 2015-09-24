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
		$('form[class="form-horizontal"]').validate({
			rules:{
				'funno':{required:true,regex:'^[0-9a-zA-Z_]{1,6}$',
	    			remote:{url:'${OTT_ROOT}/sys0006/validateOnly',type:'post',dataType:'json',
	    				data:{
    						id:function(){return $('[name="id"]').val();},
    						funno:function(){return $('[name="funno"]').val();}
	    				}
	    			}},
				'funvalue':{required:true,regex:'^[\u4e00-\u9fa5_0-9a-zA-Z]{1,20}$',
	    			remote:{url:'${OTT_ROOT}/sys0006/validateOnly',type:'post',dataType:'json',
	    				data:{
							id:function(){return $('[name="id"]').val();},
							funvalue:function(){return $('[name="funvalue"]').val();}
	    				}
	    			}}
			},
			messages:{
				'funno':{required:'编号不能为空',regex:'编号必须是1到6位的英文、数字或者下划线',remote:'已有重复编号'},
				'funvalue':{required:'名称不能为空',regex:'名称必须是1到20位的中英文、数字或者下划线',remote:'已有重复名称'}
			},
	  		onkeyup: false,
	  		errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
				$(element).focus();
		  	},
			submitHandler: function(form) {
				$.post('${OTT_ROOT}/sys0006/saveOrUpdate',$(form).serializeObject(),function(data){
					if(data.result!='success'){
						_common.showEditedErrorMsg(data.msg);
					}else{
						history.back();
					}	
				},'json');
			}	
		});
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
									<div class="control-group" <c:if test="${null==fun}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>ID
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="id" readonly="readonly" class="readonly" size="30" value="${fun.id}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>编号
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="funno" size="30" maxlength="6" value="${fun.funno}"<c:if test="${null!=fun}">readonly="readonly" class="readonly"</c:if> />
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>名称
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="funvalue" size="30" maxlength="20" value="${fun.funvalue}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>按钮方法
											</label>
										</div>
										<div class="controls">
											<input type="text" name="funmethod" size="30" maxlength="20" value="${fun.funmethod}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>按钮ID
											</label>
										</div>
										<div class="controls">
											<input type="text" name="funid" size="30" maxlength="20" value="${fun.funid}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>按钮名称
											</label>
										</div>
										<div class="controls">
											<input type="text" name="funname" size="30" maxlength="20" value="${fun.funname}"/>
										</div>
									</div>	
									<div class="control-group">
										<div class="control-label">
											<label>启用状态</label>
										</div>
										<div class="controls">
											<select name="status">
												<c:forEach items="${sessionScope.system_work_key}" var="word">
													<c:if test="${word.typeno == 'W001'}">
														<option value="${word.wordbookno}"<c:if test="${fun.status==word.wordbookno}">selected="selected"</c:if>>${word.contents}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>									
									<div class="control-group" <c:if test="${null==fun}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${fun.createrno==sysUser.userno}">
													<c:set var="creater" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==fun}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建时间</label>
										</div>
										<div class="controls">
											<input type="text" readonly="readonly" class="readonly" size="30" value="${fun.createdate}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==fun}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${fun.modifierno==sysUser.userno}">
													<c:set var="modifier" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==fun}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改时间</label>
										</div>
										<div class="controls">
											<input name="modifiedate" type="text" readonly="readonly" class="readonly" size="30" value="${fun.modifiedate}"/>
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