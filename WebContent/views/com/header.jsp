<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/views/com/commonctrl.inc"%>

<script type="text/javascript">
	//获取列表内选中的id
	function _headerMutipleCommandIds(){
		//警告信息
		$('#system-message-container').remove();
		var checkboxes=$('table[class="table table-striped"] tbody tr[class="row0"] td input:checked');
		if(checkboxes.length<=0){
			var div=$($('#system-message-container-backup').clone());
			div.attr('id','system-message-container');
		  	div.css({'display':'block'});
		  	div.find('p').html('请选择至少一项！');
			$('#system-message-container-backup').after($(div));
			return undefined;
		}
		//获取id
		var ids='';
		$(checkboxes).each(function(index,item){
			var tr=$($(item).parent().parent());
			ids+=$(tr.children('td[primaryKey="true"]')).html()+',';
		});
		ids=ids.substring(0,ids.length-1);
		return ids;
	}
	//获取列表内选中索引
	function _headerMutipleCommandIndexes(){
		//警告信息
		$('#system-message-container').remove();
		var checkboxes=$('table[class="table table-striped"] tbody tr[class="row0"] td input:checked');
		if(checkboxes.length<=0){
			var div=$($('#system-message-container-backup').clone());
			div.attr('id','system-message-container');
		  	div.css({'display':'block'});
		  	div.find('p').html('请选择至少一项！');
			$('#system-message-container-backup').after($(div));
			return undefined;
		}
		//获取index
		var indexes='';
		$('table[class="table table-striped"] tbody tr[class="row0"] td input').each(function(index,item){
			if($(item).prop('checked')==true){
				indexes+=index+',';
			}
		});
		indexes=indexes.substring(0,indexes.length-1);
		return indexes;
	}
	function _headerShowUpdatedUi(ids){
	  	//提交请求
		$('#_header_sysBtnForm').attr('action',window.location.href);
		$('#_header_sysBtnForm').find('[name="ids"]').val(ids);
		$('#_header_sysBtnForm').submit();
	}
	window.addEvent('domready', function() {
		if (top == self) {
			document.documentElement.style.display = 'block';
		} else {
			top.location = self.location;
		}
	});


	$(document).ready(function() {
		jQuery('.hasTooltip').tooltip( {
			"container" : false
		});
		jQuery('select').chosen({
			disable_search_threshold : 10,
			allow_single_deselect : true
		});
		//系统功能按钮：新增
		$('#sysBtnAdd').click(function(){
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'editInit';
			window.location.href=url;
		});
		
		//系统功能按钮：启用
		$('#sysBtnStartUse').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			var b= window.confirm('确定启用该项？');
			if(!b){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'startUse';
			$.post(url,{ids:ids},function(data){
				if(data.result='success'){
					$('#_page_currentPage').change();
				}
			},'json');
		});
		//系统功能按钮：禁用
		$('#sysBtnForbidden').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			var b= window.confirm('确定禁用该项？');
			if(!b){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'forbidden';
			$.post(url,{ids:ids},function(data){
				if(data.result='success'){
					$('#_page_currentPage').change();
				}
			},'json');
		});
		//系统功能按钮：编辑
		$('#sysBtnEdit').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			//只能选一个
			if(ids.contains(',')){
				 _common.showEditedErrorMsg("只能编辑 一个");
				 return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'editInit';
			$('#_header_sysBtnForm').attr('action',url);
			$('#_header_sysBtnForm').find('[name="ids"]').val(ids);
			$('#_header_sysBtnForm').submit();
		});

		//系统功能按钮：查看
		$('#sysBtnlook').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'look';
			$('#_header_sysBtnForm').attr('action',url);
			$('#_header_sysBtnForm').find('[name="ids"]').val(ids);
			$('#_header_sysBtnForm').submit();
		});

		//系统功能按钮：审核
		$('#sysBtnshenke').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'shenhe';
			$('#_header_sysBtnForm').attr('action',url);
			$('#_header_sysBtnForm').find('[name="ids"]').val(ids);
			$('#_header_sysBtnForm').submit();
			
		});
		
		

		//系统功能按钮：提交
		$('#sysBtnSubmit').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'submit';
			$.post(url,{ids:ids},function(data){
				if(data.result!=null && data.result=='fail'){
					alert('只能提交状态为已创建和已驳回的!');
					return false;
				}
				if((data.result!=null) && (data.result=='W02902'|| data.result=='W01802')){
					alert('不能重复提交!');
					return false;
				}
				if(data.result='success'){
					$('#_page_currentPage').change();
				}
			},'json');
		});
		
		
		
		
		//系统功能按钮：删除
		$('#sysBtnDelete').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			} 
			var b= window.confirm('删除后数据将不可恢复。你确定要删除吗？');
			if(!b){
				return;
			}
			//提交请求
			var url=window.location.href+'';
			var index=url.lastIndexOf('/');
			url=url.substring(0,index+1)+'delete';
			$.post(url,{ids:ids},function(data){
				if(data.result='success'){
					$('#_page_currentPage').change();
				}else{
					if("" !=data.msg || null != data.msg){
						alert(data.msg);
					}
				}
				
			},'json');
		});

		
		//系统功能按钮：保存
		$('#sysBtnSaveOrUpdate').click(function(){
			$('form[class="form-horizontal"]').submit();
		});
		//系统功能按钮：返回
		$('#sysBtnBack').click(function(){
			history.back();
		});
		//系统功能按钮：权限分配
		$('#sysBtnAssignPermission').click(function(){
			var ids=_headerMutipleCommandIds();
			if(ids==undefined){
				return;
			}
			//提交请求
			$('#_header_sysBtnForm').attr('action','${OTT_ROOT}/sys0004/assignPermission');
			$('#_header_sysBtnForm').find('[name="ids"]').val(ids);
			$('#_header_sysBtnForm').submit();
		});

	});
var vlcUrl='';


//日期时间处理
function formartDate(dataFormate, time) {
    var date = new Date();
    date.setTime(time);
    return date.pattern(dataFormate);
}
 
//日期时间处理    
Date.prototype.pattern = function(fmt) {
        var o = {
            "M+" : this.getMonth() + 1, //月份     
            "d+" : this.getDate(), //日     
            "h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时     
            "H+" : this.getHours(), //小时     
            "m+" : this.getMinutes(), //分     
            "s+" : this.getSeconds(), //秒     
            "q+" : Math.floor((this.getMonth() + 3) / 3), //季度     
            "S" : this.getMilliseconds()
        //毫秒     
        };
        var week = {
            "0" : "日",
            "1" : "一",
            "2" : "二",
            "3" : "三",
            "4" : "四",
            "5" : "五",
            "6" : "六"
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
                    .substr(4 - RegExp.$1.length));
        }
        if (/(E+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1,
                    ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "星期" : "周")
                            : "")
                            + week[this.getDay() + ""]);
        }
        if (/(e+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1,
                    ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "星期" : "周")
                            : "")
                            + this.getDay());
        }
        for ( var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
                        : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    }
    
    
    
    function getProvinces(elem){
    	//加载省
    	 $.ajax({
   	         type: "GET",
   	         url: "${OTT_ROOT}/views/citys/provinces.json",
   	         data: "",
   	         dataType: "json",
   	         success: function(data){
   	        	if(data != null){
   	        			var Provinces =  data.RECORDS;
   	        			var option=" ";
   	        			$.each(Provinces,function(k, p){
   	        				option += "<option value='" + p.province + "' provinceid='"+p.provinceid+"'>" + p.province + "</option>";
   	        			});
   	        			$(elem).html(option);
   	        			$(elem).show();
   	        		//	$("#consultor_province_chzn").remove();
   	        			$(elem+"_chzn").remove();
   	        	}
   	         }
            });
    }
    
    
    function getCitys(elem,data_provinceid){
    	$(elem).html("");
    	//加载省
    	 $.ajax({
   	         type: "GET",
   	         url: "${OTT_ROOT}/views/citys/cities.json",
   	         data: "",
   	         dataType: "json",
   	         success: function(data){
   	        	if(data != null){
   	        			var citys =  data.RECORDS;
   	        			var option=" ";
   	        			$.each(citys,function(k, p){
                             if(data_provinceid == p.provinceid){
                            	 option += "<option value='" + p.city + "'>" + p.city + "</option>";
                             }
   	        			});
   	        			$(elem).html(option);
   	        			$(elem).show();
   	        			$(elem+"_chzn").remove();
   	        	}
   	         }
            })
    }
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

<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
			</a> 
			<a class="brand" href="${OTT_ROOT}/init" title="首页">首页 
				<i class="icon-out-2 small"></i>
			</a>
			<div class="nav-collapse">
				<ul id="menu" class="nav">
					<c:forEach items="${sessionScope.account_menu_key}" var="menu">
						<c:if test="${menu.menutype=='0'}">
							<li class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#">${menu.menuname} 
									<span class="caret"></span>
								</a>
								
								<c:set var="tempCounter1" value="0"></c:set>
								<c:set var="tempCounter2" value="0"></c:set>
								<c:forEach items="${sessionScope.account_menu_key}" var="subMenu">
									<c:if test="${subMenu.menutype=='1' && subMenu.fathermenuno==menu.menuno}">
										<c:set var="tempCounter1" value="${tempCounter1+1}"></c:set>
									</c:if>
								</c:forEach>
								
								<c:if test="${tempCounter1>0}">
								<ul class="dropdown-menu">
									<c:forEach items="${sessionScope.account_menu_key}" var="subMenu">
										<c:if test="${subMenu.menutype=='1' && subMenu.fathermenuno==menu.menuno}">
											<c:set var="tempCounter2" value="${tempCounter2+1}"></c:set>
											<li>
												<a class="menu-cpanel" href="${OTT_ROOT}${subMenu.menuurl}">${subMenu.menuname}</a>
											</li>
											<c:if test="${tempCounter1 != tempCounter2}">
												<li class="divider"><span></span></li>
											</c:if>
										</c:if>
									</c:forEach>
								</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
	
				<ul class="nav pull-right">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">${sessionScope.account_session_key.username} 
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li class="">
								<a href="${OTT_ROOT}/sys0001/editInit?ids=${sessionScope.account_session_key.id}">编辑账户</a>
							</li>
							<li class="divider"></li>
							<li class="">
								<a href="${OTT_ROOT}/loginOut">注销</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>


<div class="header">
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2 container-logo">
				<a class="logo" href="${OTT_ROOT}/init"><img src="${OTT_ROOT}/views/images/logo.png"></a>
			</div>
			<div class="span10">
				<c:forEach items="${sessionScope.account_menu_key}" var="menu2">
					<c:if test="${menu2.menuurl==OTT_URL}">
						<c:set var="_head_menu2_name" value="${menu2.menuname}"></c:set>
						<c:if test="${menu2.fathermenuno!=null}">
							<c:forEach items="${sessionScope.account_menu_key}" var="menu1">
								<c:if test="${menu1.menuno==menu2.fathermenuno}">
									<c:set var="_head_menu1_no" value="${menu1.menuno}"></c:set>
									<c:set var="_head_menu1_name" value="${menu1.menuname}"></c:set>
									<c:set var="_head_menu1_url" value="${menu1.menuurl}"></c:set>
									<c:if test="${menu1.fathermenuno!=null}">
										<c:forEach items="${sessionScope.account_menu_key}" var="menu0">
											<c:if test="${menu0.menuno==menu1.fathermenuno}">
												<c:set var="_head_menu0_no" value="${menu0.menuno}"></c:set>
												<c:set var="_head_menu0_name" value="${menu0.menuname}"></c:set>
												<c:set var="_head_menu0_url" value="${menu0.menuurl}"></c:set>
											</c:if>
										</c:forEach>
									</c:if>
								</c:if>
							</c:forEach>
						</c:if>
					</c:if>
				</c:forEach>
				<h1 class="page-title" style="height:8px;line-height:27px;">
					<c:if test="${_head_menu0_no!=null && _head_menu0_no!=''}">
						<c:if test="${_head_menu0_url==null || _head_menu0_url==''}">
							${_head_menu0_name}
						</c:if>
						<c:if test="${_head_menu0_url!=null && _head_menu0_url!=''}">
							<a style="color:#ffffff;" href="${OTT_ROOT}${_head_menu0_url}">${_head_menu0_name}</a>
						</c:if>
						&nbsp;&gt;
					</c:if>
					<c:if test="${_head_menu1_no!=null && _head_menu1_no!=''}">
						<c:if test="${_head_menu1_url==null || _head_menu1_url==''}">
							${_head_menu1_name}
						</c:if>
						<c:if test="${_head_menu1_url!=null && _head_menu1_url!=''}">
							<a style="color:#ffffff;" href="${OTT_ROOT}${_head_menu1_url}">${_head_menu1_name}</a>
						</c:if>
						&nbsp;&gt;
					</c:if>
					${_head_menu2_name}
				</h1>
			</div>
		</div>
	</div>
</div>

<form id="_header_sysBtnForm" method="post" style="display:none;">
	<input name="ids" type="hidden"/>
</form>


<a class="btn btn-subhead" data-toggle="collapse" data-target=".subhead-collapse">Toolbar 
	<i class="icon-wrench"></i>
</a>

<div class="subhead-collapse collapse" style="width:100%">
	<div class="subhead">
		<div class="container-fluid">
			<div id="container-collapse" class="container-collapse"></div>
			<div class="row-fluid">
				<div class="span12">
					<div class="btn-toolbar" id="toolbar">
						<c:set var="counter1" value="0"></c:set>
						<c:set var="counter2" value="0"></c:set>
						<c:forEach items="${sessionScope.account_fun_key}">
							<c:set var="counter1" value="${counter1+1}"></c:set>
						</c:forEach>
						<c:out value="${counter1}"></c:out>
						<c:forEach items="${sessionScope.account_fun_key}" var="fun">
							<div class="btn-wrapper" id="${fun.funid}">
								<button class="btn btn-small <c:if test="${counter2==0}">btn-success</c:if>">
									<c:if test="${fun.funname!=null && fun.funname!=''}">
										<span class="${fun.funname} <c:if test="${counter2==0}">icon-white</c:if>"></span>
									</c:if>
									${fun.funvalue}
								</button>
							</div>
							<c:set var="counter2" value="${counter2+1}"></c:set>
							<c:if test="${counter1!=counter2}">
								<div class="btn-group divider"></div>
							</c:if>
						</c:forEach>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

