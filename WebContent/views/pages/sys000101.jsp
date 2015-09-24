<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/views/com/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统用户管理</title> 
	
<script type="text/javascript"><!--
$(document).ready(function(){	
	$('form[class="form-horizontal"]').validate({
		rules:{
			'userno':{required:true,regex:'^[0-9a-zA-Z_]{5,20}$',
    			remote:{url:'${OTT_ROOT}/sys0001/validateOnly',type:'post',dataType:'json',
    				data:{
   						id:function(){return $('[name="id"]').val();},
    					userno:function(){return $('[name="userno"]').val();}
    				}
    			}},
			'username':{required:true,regex:'^[\u4e00-\u9fa5_0-9a-zA-Z]{1,20}$',
    			remote:{url:'${OTT_ROOT}/sys0001/validateOnly',type:'post',dataType:'json',
    				data:{
						id:function(){return $('[name="id"]').val();},
    					username:function(){return $('[name="username"]').val();}
    				}
    			}},
			'password1':{equalTo:'#password'},
			'email':{email:true}
		},
		messages:{
			'userno':{required:'账户不能为空',regex:'账户必须是5到20位的英文、数字或者下划线',remote:'已有重复账号'},
			'username':{required:'昵称不能为空',regex:'昵称必须是5到20位的中英文、数字或者下划线',remote:'已有重复昵称'},
			'password1':{equalTo:'密码和重复密码不一致'},
			'email':{email:'邮件格式不正确'}
		},
  		onkeyup: false,
	  	errorPlacement : function(error, element) {
			_common.showEditedErrorMsg($(error).text());
		  	if($(element).attr('name')!='password1'){
			  	$(element).focus();
		  	}
	  	},
		submitHandler: function(form) {
			//新增用户时，密码不能为空
			if('${user.id}'=='' && !/^[0-9a-zA-Z]{5,50}$/.test($('#password').val())){
			  	_common.showEditedErrorMsg('密码必须是5到50位大小写的英文或者数字');
			  	$('#password').focus();
			  	return;
			}
			//修改用户时,密码不为空则进行校验
			if('${user.id}' != '' && $('#password').val() != '' && !/^[0-9a-zA-Z]{5,50}$/.test($('#password').val())){
				_common.showEditedErrorMsg('密码必须是5到50位大小写的英文或者数字');
			  	$('#password').focus();
			  	return;
			}
			$.post('${OTT_ROOT}/sys0001/saveOrUpdate',$(form).serializeObject(),function(data){			  	
				if(data.result!='success'){
					_common.showEditedErrorMsg(data.msg);
				}else{
					history.back();
					//location.href="${OTT_ROOT}/sys0001/init";
				}					
			},'json');
		}	
	});
});
</script>
</head>

<body>
	<jsp:include page="/views/com/header.jsp"></jsp:include>

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
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>ID
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="id" readonly="readonly" class="readonly" size="30" value="${user.id}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>账户
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="userno" size="30" maxlength="20" value="${user.userno}"<c:if test="${null!=user}">readonly="readonly" class="readonly"</c:if> />
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>昵称
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="username" size="30" maxlength="20" value="${user.username}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>密码<c:if test="${null==user}"><span class="star">&nbsp;*</span></c:if></label>
								</div>
								<div class="controls">
									<input type="password" id="password" name="password" size="30" maxlength="20"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>重复密码<c:if test="${null==user}"><span class="star">&nbsp;*</span></c:if></label>
								</div>
								<div class="controls">
									<input type="password" name="password1" size="30" maxlength="20"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>邮件</label>
								</div>
								<div class="controls">
									<input type="text" name="email" size="30" maxlength="30" value="${user.email}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>角色</label>
								</div>
								<div class="controls">
									<select name="roleno">
										<c:forEach items="${roleList}" var="role">											
											<option value="${role.roleno}"<c:if test="${user.roleno==role.roleno}">selected="selected"</c:if>>${role.rolename}</option>
										</c:forEach>
									</select>
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
												<option value="${word.wordbookno}"<c:if test="${user.status==word.wordbookno}">selected="selected"</c:if>>${word.contents}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${user.createrno==sysUser.userno}">
											<c:set var="creater" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建时间</label>
								</div>
								<div class="controls">
									<input name="createdate" type="text" readonly="readonly" class="readonly" size="30" value="${user.createdate}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${user.modifierno==sysUser.userno}">
											<c:set var="modifier" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改时间</label>
								</div>
								<div class="controls">
									<input name="modifiedate" type="text" readonly="readonly" class="readonly" size="30" value="${user.modifiedate}"/>
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