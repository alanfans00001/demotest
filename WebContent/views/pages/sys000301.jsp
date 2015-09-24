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
				'roleno':{required:true,regex:'^[0-9a-zA-Z_]{1,6}$',
	    			remote:{url:'${OTT_ROOT}/sys0003/validateOnly',type:'post',dataType:'json',
	    				data:{
    						id:function(){return $('[name="id"]').val();},
    						roleno:function(){return $('[name="roleno"]').val();}
	    				}
	    			}},
				'rolename':{required:true,regex:'^[\u4e00-\u9fa5_0-9a-zA-Z]{5,20}$',
	    			remote:{url:'${OTT_ROOT}/sys0003/validateOnly',type:'post',dataType:'json',
	    				data:{
							id:function(){return $('[name="id"]').val();},
							rolename:function(){return $('[name="rolename"]').val();}
	    				}
	    			}}
			},
			messages:{
				'roleno':{required:'编号不能为空',regex:'编号必须是1到6位的英文、数字或者下划线',remote:'已有重复编号'},
				'rolename':{required:'昵称不能为空',regex:'昵称必须是5到20位的中英文、数字或者下划线',remote:'已有重复昵称'}
			},
	  		onkeyup: false,
		  	errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
				$(element).focus();
		  	},
			submitHandler: function(form) {
				$.post('${OTT_ROOT}/sys0003/saveOrUpdate',$(form).serializeObject(),function(data){				  	
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
									<div class="control-group" <c:if test="${null==role}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>ID
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="id" readonly="readonly" class="readonly" size="30" value="${role.id}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>编号
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="roleno" size="30" maxlength="6" value="${role.roleno}"<c:if test="${null!=role}">readonly="readonly" class="readonly"</c:if> />
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>昵称
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="rolename" size="30" maxlength="20" value="${role.rolename}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==role}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${role.createrno==sysUser.userno}">
													<c:set var="creater" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==role}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建时间</label>
										</div>
										<div class="controls">
											<input type="text" readonly="readonly" class="readonly" size="30" value="${role.createdate}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==role}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${role.modifierno==sysUser.userno}">
													<c:set var="modifier" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==role}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改时间</label>
										</div>
										<div class="controls">
											<input name="modifiedate" type="text" readonly="readonly" class="readonly" size="30" value="${role.modifiedate}"/>
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