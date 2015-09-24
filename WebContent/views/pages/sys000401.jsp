<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/views/com/common.jsp"%>
	<%@ include file="/views/com/header.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>角色权限设定</title>
</head>


<body>	
	<script type="text/javascript">
		$(document).ready(function(){
			$('form[class="form-horizontal"]').validate({
				
				submitHandler: function(form) {
					form=$(form).serializeObject();
					for ( var i in form) {
						form[i]+='';
					}
					$.post('${OTT_ROOT}/sys0004/saveOrUpdate',form,function(data){	  	
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
							
							
					
	<div id="main" >
		<div id="content" >
			<div class="box"> 
				<div class="data">
				<form method="post" class="form-horizontal">	
						<input type="hidden" id="roleno" name="roleno" value="${roleno}"/>	
						<input type="hidden" name="token" value="${token}">			
						<table class="assignform" >
							<c:forEach items="${menuList}" var="menu0"> 
								<tr>
									<c:if test="${menu0.menutype=='0'}">
										<td width="120px;"><a style="text-decoration:none;cursor:pointer;color: #003366;">
										   <input name="chkFun" value="${menu0.menuno }"  style="vertical-align:middle;margin: 1px;" type="checkbox" 
										   <c:forEach items="${rolesList}" var="rp">
										  	   <c:if test="${menu0.menuno==rp.menuno}">checked="checked"</c:if>
										   </c:forEach>
										   ></input> ${menu0.menuname}</a>
										</td>
										<td>
											<table class="assignform" >
												<c:forEach items="${menuList}" var="menu1">
													<c:if test="${menu1.menutype=='1' && menu1.fathermenuno==menu0.menuno}">
														<tr>
															<td width="200px;"><label>
															<input name="chkSubFun" value="${menu1.menuno }"  style="vertical-align:middle;margin: 4px;" type="checkbox"
															<c:forEach items="${rolesList}" var="rp">
																<c:if test="${menu1.menuno==rp.menuno}">checked="checked"</c:if>
															</c:forEach>
															></input><a style="text-decoration:none;color: #003366;">${menu1.menuname}</a></label></td>
															<td>
																<table>
																	<tr>
																	<c:set value="${menu1.allfunno}" var="str"></c:set>
																	<c:set var="tempStr" value="${fn:split(str,',')}"></c:set>
																		<c:forEach items="${tempStr}" var="funno">
																			<td width="80px;">
																				<c:forEach items="${sessionScope.system_fun_key}" var="fun">
																					<c:if test="${fun.funno==funno}">
																						<label><input name="funs_${menu1.menuno }" value="${fun.funno }"  style="vertical-align:middle;margin: 4px;"  type="checkbox"
																						<c:forEach items="${rolesList}" var="rList">
																							<c:if test="${fn:indexOf(rList['funno'],funno)>=0 && rList.menuno==menu1.menuno}">checked="checked"</c:if>
																						</c:forEach>
																						></input>${fun.funvalue}</label>
																					</c:if>
																				</c:forEach>
																			</td>
																		</c:forEach>
																	</tr>
																</table>
															</td>
														</tr>
														<c:forEach items="${menuList}" var="menu2">
															<c:if test="${menu2.menutype=='2' && menu2.fathermenuno==menu1.menuno}">
																<tr>
																	<td width="100px;"><label><a style="margin-left:20px;text-decoration:none;color: #003366;"><input name="chkSubFun"  value="${menu2.menuno }"  style="vertical-align:middle;margin: 2px;" type="checkbox"
																	<c:forEach items="${rolesList}" var="rp">
																  		<c:if test="${menu2.menuno==rp.menuno}">checked="checked"</c:if>
																    </c:forEach>
																	></input>${menu2.menuname}</a></label></td>
																	<td>
																		<table  >
																			<tr>
																			<c:set value="${menu2.allfunno}" var="str"></c:set>
																			<c:set var="tempStr" value="${fn:split(str,',')}"></c:set>
																				<c:forEach items="${tempStr}" var="funno">
																					<td width="80px;">
																						<c:forEach items="${sessionScope.system_fun_key}" var="fun">
																							<c:if test="${fun.funno==funno}">
																								<label style="vertical-align:middle;"><input name="funs_${menu2.menuno }" value="${fun.funno }"  style="vertical-align:middle;margin: 4px;"  type="checkbox"
																								<c:forEach items="${rolesList}" var="rList">
																									<c:if test="${fn:indexOf(rList['funno'],funno)>=0 && rList.menuno==menu2.menuno}">checked="checked"</c:if>
																								</c:forEach>
																								></input>${fun.funvalue}</label>
																							</c:if>
																						</c:forEach>
																					</td>
																				</c:forEach>
																			</tr>
																		</table>
																	</td>
																</tr>
															</c:if>
														</c:forEach>
													</c:if>
												</c:forEach>
											</table>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>