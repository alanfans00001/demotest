<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/views/com/commonctrl.inc"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<link rel="stylesheet" href="${OTT_ROOT}/views/css/chosen.css" type="text/css" />
<link rel="stylesheet" href="${OTT_ROOT}/views/css/template.css" type="text/css" />
<style type="text/css">
html {
	display: none;
}
</style>
<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/jquery-1.7.min.js"></script>
<script type="text/javascript" src="${OTT_ROOT}/views/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${OTT_ROOT}/views/com/common.js"></script>
<script src="${OTT_ROOT}/views/js/mootools-core.js" type="text/javascript"></script>
<script src="${OTT_ROOT}/views/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var _login={
	};
	window.addEvent('domready', function() {
		if (top == self) {
			document.documentElement.style.display = 'block';
		} else {
			top.location = self.location;
		}
	});
	$(document).ready(function() {
		jQuery('.hasTooltip').tooltip({
			"container" : false
		});
		$('[name="userno"]').select();
		$('[name="userno"]').focus();
		$('#btnLogin').click(function(){
			$('#form-login').submit();
		});
		document.onkeydown=function(e){
			var ev = e || event;
			if(ev.keyCode==13){
				$('#btnLogin').click();
			}
		};
		$('#form-login').validate({
			rules:{
				'userno':{required:true},
				'password':{required:true}
			},
			messages:{
				'userno':{required:'账户不能为空'},
				'password':{required:'密码不能为空'}
			},
	  		onkeyup: false,
		  	errorPlacement : function(error, element) {
				$('#system-message-container').children('button').click();
			  	
			  	var div=$('#system-message-container-backup').clone();
				$(div).attr('id','system-message-container');
			  	$(div).css({'display':'block'});	
				$('#system-message-container-backup').after($(div));

			  	$(div).children('div .alert').children('p').html('');
			  	$(error).appendTo($(div).children('div .alert').children('p'));	
		  	},
			submitHandler: function(form) {
				$.post('${OTT_ROOT}/loginIn',$(form).serializeObject(),function(data){
					if(data.result=='success'){
						window.location.href=_common.getWebRootPath()+'/init';
						return;
					}
					$('#system-message-container').children('button').click();
				  	var div=$('#system-message-container-backup').clone();
					$(div).attr('id','system-message-container');
				  	$(div).css({'display':'block'});	
				  	$(div).children('div .alert').children('p').html(data.msg);
					$('#system-message-container-backup').after($(div));
				},'json');
			}	
		});
	});
</script>
<style type="text/css">
@media ( max-width : 480px) {
	.view-login .container {
		margin-top: -170px;
	}
	.btn {
		font-size: 13px;
		padding: 4px 10px 4px;
	}
}
</style>
</head>

<body class="site com_login view-login layout-default task- itemid- ">
	<div class="container">
		<div id="content">
			<div id="element-box" class="login well">
				<img src="${OTT_ROOT}/views/images/logo.png" alt="OttService" />
				<hr />	
				<form method="post" id="form-login" class="form-inline">
					<fieldset class="loginform">
						<div class="control-group">
							<div class="controls">
								<div class="input-prepend input-append">
									<span class="add-on">
										<i class="icon-user hasTooltip" data-placement="left" title="账户"></i> 
										<label for="mod-login-username" class="element-invisible"> 账户 </label>
									</span> 
									<input name="userno" tabindex="1" id="mod-login-username" type="text" class="input-medium" placeholder="账户" size="15" value=""/> 
									<a href="#" class="btn width-auto hasTooltip" data-placement="right" title="Forgot your username?"> 
										<i class="icon-help" title="Forgot your username?"></i> 
									</a>
								</div>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<div class="input-prepend input-append">
									<span class="add-on">
										<i class="icon-lock hasTooltip" data-placement="left" title="密码"></i> 
										<label for="mod-login-password" class="element-invisible"> 密码 </label> 
									</span>
									<input name="password" tabindex="2" id="mod-login-password" type="password" class="input-medium" placeholder="密码" size="15" value=""/> 
									<a href="#" class="btn width-auto hasTooltip" data-placement="right" title="Forgot your password?"> 
										<i class="icon-help" title="Forgot your password?"></i> 
									</a>
								</div>
							</div>
						</div>
						<div class="control-group">
							<div class="controls">
								<div class="btn-group pull-left">
									<div id="btnLogin" tabindex="3" class="btn btn-primary btn-large">
										<i class="icon-lock icon-white"></i>&nbsp;&nbsp;&nbsp;&nbsp;登录
									</div>
								</div>
							</div>
						</div>
					</fieldset>
				</form>	
				<div id="system-message-container-backup" style="display:none;">
					<button type="button" class="close" data-dismiss="alert">×</button>
					<div class="alert">
						<h4 class="alert-heading">警告</h4>
						<p></p>
					</div>
				</div>
			</div>
			<noscript>Warning! JavaScript must be enabled for proper operation of the Administrator backend.</noscript>
		</div>
	</div>
	<div class="navbar navbar-fixed-bottom hidden-phone">
		<p class="pull-right">&copy; OttService</p>
		<a class="login-joomla" href="#" class="hasTooltip" title="OttService">Ottservice;</a>
		<a href="${OTT_ROOT}" class="pull-left">
			<i class="icon-share icon-white"></i> 返回首页
		</a>
	</div>
</body>
</html>