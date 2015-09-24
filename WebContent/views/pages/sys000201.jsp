<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/views/com/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统菜单管理-编辑</title>
</head>

<body>
	<jsp:include page="/views/com/header.jsp"></jsp:include>	
	
	<script type="text/javascript">	
	$(document).ready(function(){
		$('form[class="form-horizontal"]').validate({
			rules:{ 
				'menuno':{required:true,regex:'^[0-9a-zA-Z_]{1,18}$',
				remote:{url:'validateOnly',type:'post',dataType:'json',
					data:{
						id:function(){return $('[name="id"]').val();},
						menuno:function(){return $('[name="menuno"]').val();}
					}
				}}, 
				'menuname':{required:true,regex:'^[\u4e00-\u9fa5-0-9a-zA-Z]{1,300}$'},
				'menuurl':{regex:'^[0-9a-zA-Z/]{0,3000}$'}
			},
			messages:{
				'menuno':{required:'菜单编号不能为空',regex:'菜单编号必须是1到18位的英文、数字或者下划线',remote:'已有重复菜单编号'},
				'menuname':{required:'菜单名称不能为空',regex:'菜单名称必须是1到300位的中英文、数字或者横线'},
				'menuurl':{regex:'菜单路径必须是0到300位的英文、数字或者斜线'}
			},
	  		onkeyup: false,
		  	errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
			  	$(element).focus();
		  	},
			submitHandler: function(form) {
				form=$(form).serializeObject();
				form.allfunno+='';
				$.post('${OTT_ROOT}/sys0002/saveOrUpdate',form,function(data){	  	
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
							<div class="control-group" <c:if test="${null==menu}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>ID
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="id" readonly="readonly" class="readonly" size="30" value="${menu.id}"/>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>菜单编号
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="menuno" size="30" maxlength="18" value="${menu.menuno}"<c:if test="${null!=menu}">readonly="readonly" class="readonly"</c:if> />
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>菜单名称
										<span class="star">&nbsp;*</span>
									</label>
								</div>
								<div class="controls">
									<input type="text" name="menuname" size="30" maxlength="20" value="${menu.menuname}"/>
								</div>
							</div>

							<div class="control-group">
								<div class="control-label">
									<label>父级菜单</label>
								</div>
								<div class="controls">
									<select name="fathermenuno">
										<option value="">--请选择--</option>
										<c:forEach items="${menuList}" var="sysMenu">
											<option value="${sysMenu.menuno}"<c:if test="${menu.fathermenuno==sysMenu.menuno}">selected="selected"</c:if>>${sysMenu.menuno}&nbsp;&nbsp;--&nbsp;&nbsp;${sysMenu.menuname}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>菜单类型</label>
								</div>
								<div class="controls">
									<select name="menutype">
										<c:forEach items="${sessionScope.system_work_key}" var="word">
											<c:if test="${word.typeno == 'W00003'}">   
												<option value="${word.wordbookno}" <c:if test="${word.wordbookno == menu.menutype}">selected="selected"</c:if> >${word.contents}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<div class="control-label">
									<label>菜单路径 </label>
								</div>
								<div class="controls">
									<input type="text" name="menuurl" size="30" maxlength="100" value="${menu.menuurl}"/>
								</div>
							</div>
							
							<div class="control-group" <c:if test="${null==menu}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${menu.createrno==sysUser.userno}">
											<c:set var="creater" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==menu}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>创建时间</label>
								</div>
								<div class="controls">
									<input name="createdate" type="text" readonly="readonly" class="readonly" size="30" value="${menu.createdate}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==menu}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改人</label>
								</div>
								<div class="controls">
									<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
										<c:if test="${menu.modifierno==sysUser.userno}">
											<c:set var="modifier" value="${sysUser.username}"></c:set>
										</c:if>
									</c:forEach>
									<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
								</div>
							</div>
							<div class="control-group" <c:if test="${null==menu}">style="display:none;"</c:if>>
								<div class="control-label">
									<label>修改时间</label>
								</div>
								<div class="controls">
									<input name="modifiedate" type="text" readonly="readonly" class="readonly" size="30" value="${menu.modifiedate}"/>
								</div>
							</div>
							
							<div class="control-group">
								<div class="control-label">
									<label>功能按钮</label>
								</div>
								<div class="controls">
								<c:set var="funnoArr" value="${fn:split(menu.allfunno,',')}"></c:set>
									<ul>
										<c:forEach items="${sessionScope.system_fun_key}" var="fun">											
											<li style="list-style: none;padding: 2px;margin: 2px;"><label>
												<input type="checkbox" name="allfunno" value="${fun.funno}" style="vertical-align:middle;" 
													<c:forEach items="${funnoArr}" var="funno">
														<c:if test="${fun.funno==funno}">checked="checked"</c:if>
													</c:forEach>
													/>&nbsp;${fun.funvalue}
											</label></li>
										</c:forEach>	
									</ul>							
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