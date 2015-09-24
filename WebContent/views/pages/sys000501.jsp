<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>字典信息管理</title>
</head>

<body>
	
	<script type="text/javascript">
	$(document).ready(function(){		
		$('form[class="form-horizontal"]').validate({
			rules:{
				'wordbookno':{required:true,regex:'^[0-9a-zA-Z_]{1,18}$',
	    			remote:{url:'validateOnly',type:'post',dataType:'json',
	    				data:{
    						id:function(){return $('[name="id"]').val();},
	    					wordbookno:function(){return $('[name="wordbookno"]').val();}
	    				}
	    			}},
			 	'langno':{required:true,regex:'^[0-9a-zA-Z_]{1,18}$'},
				'typeno':{required:true,regex:'^[0-9a-zA-Z_]{1,18}$'},
				'contents':{required:true},
				'status':{required:true}
			},
			messages:{
				'wordbookno':{required:'字典编号不能为空',regex:'字典编号必须是1到18位的英文、数字或者下划线',remote:'已有重复编号'},
				'langno':{required:'字符编码不能为空',regex:'字符编码必须是1到18位的英文、数字或者下划线'},
				'typeno':{required:'字典类型不能为空',regex:'字典类型必须是1到18位的英文、数字或者下划线'},
				'contents':{required:'字典内容不能为空'}
			},
	  		onkeyup: false,
		  	errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
				$(element).focus();
		  	},
			submitHandler: function(form) {
				$.post('${OTT_ROOT}/sys0005/saveOrUpdate',$(form).serializeObject(),function(data){			  	
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
							<div class="control-group" <c:if test="${null==user}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>ID
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="id" readonly="readonly" class="readonly" size="30" value="${wordbook.id}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>字典编号:
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="wordbookno" size="30" maxlength="6" value="${wordbook.wordbookno}"<c:if test="${null!=wordbook}">readonly="readonly" class="readonly"</c:if> />
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>字符类型
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="langno" size="30" maxlength="18" value="${wordbook.langno}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>字典类型
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" id="typeno" name="typeno" value="${wordbook.typeno}" size="30" maxlength="18"/>
								</div>
							</div>
							 
							<div class="control-group">
								<div class="control-label">
									<label>字典内容
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<textarea rows="8" maxlength="150">${wordbook.contents}</textarea>
								</div>
							</div>
				 
							<div class="control-group">
								<div class="control-label">
									<label>启用状态</label>
								</div>
								<div class="controls">
									<select name="status">
									<option value="">--状态--</option>
									<c:forEach items="${sessionScope.system_work_key}" var="word">
										<c:if test="${word.typeno == 'W001'}">
											<option value="${word.wordbookno}" ${word.wordbookno==wordbook.status?'selected':'' }>${word.contents}</option>
										</c:if>
									</c:forEach>
								</select>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==wordbook}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${wordbook.createrno==sysUser.userno}">
											<c:set var="creater" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==wordbook}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建时间</label>
								</div>
								<div class="controls">
									<input name="createdate" type="text" readonly="readonly" class="readonly" size="30" value="${wordbook.createdate}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==wordbook}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${wordbook.modifierno==sysUser.userno}">
											<c:set var="modifier" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==wordbook}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改时间</label>
								</div>
								<div class="controls">
									<input name="modifiedate" type="text" readonly="readonly" class="readonly" size="30" value="${wordbook.modifiedate}"/>
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