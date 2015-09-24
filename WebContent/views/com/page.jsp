<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/views/com/commonctrl.inc"%>

<script>
var _pageElement,_pageFilterForm;
var _pageFilter={};
var _page={
		url:'',//异步查询地址
		//显示数据的格式
		colModel:[{
			display:'',//列标题名称
			name:'',//需要显示的对象属性名
			width:'',//列宽度
			defaultValue:'-',//当单元格内的值为NULL时的显示内容
			link:'',//此属性的存在与否决定是否用a标签表示，link的值即a标签的href属性
			colType:'',//单元格显示类型
			titleAlign:'left',//列头标题对齐方式
			cellAlign:'left',//单元格内容对齐方式
			primaryKey:false,//是否主键,多选判断的依据
			realValue:'',//真实值'a:a1,b:b1'，外部传入形式
			realValues:{},//真实值，内部转化为json对象
			hidden:false,//是否隐藏
			playPath:false,//是否播放路径
			addbtn:'',//自定义的临时加的功能
			button:'',//按钮
			addAndSub:{min:0,max:0,url:'',reload:true},//最小值，最大值，提交表单的地址，提交表单成功后是否重载
			rowCallBack:{}//function(row,value){}//行操作的回调函数，行对象，该行该单元格的对应的值(非html文本)
		}],
		//分页查询的条件
		pageConfig:{
			currentPage:1,//当前页码
			showCount:20,//每页显示的数据量
			total:0,//不分页查询获得的数据总量
			totalPage:1,//不分页查询获得的数据页数
			orderby:'',//排序字段
			order:'asc'//排序方式:asc,desc
		},
		pageFilter:{},//搜索过滤器
		filterForm:{}//传递过滤器参数的表单，传递参数后立刻废除
	};

$.fn.page=function(o){
	/******************** 初始化区域 ********************/
	_pageElement=$(this);
	if(undefined!=o.filterForm){
		_pageFilterForm=o.filterForm;
	}
	//传递过滤器参数的表单，传递参数后立刻废除
	try{
		o.pageFilter=o.filterForm.serializeObject();
		_pageFilter=o.pageFilter;
	}catch(e){
		o.pageFilter=_pageFilter;
	}
	o.filterForm=undefined;
	//异步查询地址
	if(null==o.url || undefined==o.url || o.url==''){
		return;
	}
	//显示数据的格式
	if(null==o.colModel || undefined==o.colModel || o.colModel.length<1){
		return;
	}
	//处理真实值
	for(var i=0;i<o.colModel.length;i++){
		if(o.colModel[i].realValue!=undefined){
			var realValues={};
			var str=o.colModel[i].realValue+'';
			var strs=str.split(',');
			for(var j=0;j<strs.length;j++){
				var s=strs[j].split(':');				
				realValues[s[0]]=s[1];
			}
			o.colModel[i].realValues=realValues;
		}	
	}
	
	
	//分页设置
	try{
		JSON.stringify(o.pageConfig);		
	}catch(e){
		o.pageConfig={showCount:20,currentPage:1,total:0};
	}
	if(null==o.pageConfig || undefined==o.pageConfig){
		o.pageConfig={showCount:20,currentPage:1,total:0};
	}
	if(undefined!=$('#_page_showCount').val() && ''!=$('#_page_showCount').val()){
		o.pageConfig.showCount=$('#_page_showCount').val();
	}
	if(undefined!=$('#_page_currentPage').val() && ''!=$('#_page_currentPage').val()){
		o.pageConfig.currentPage=$('#_page_currentPage').val();
	}
	//全局设置
	_page=o;
	/******************** 初始化区域 ********************/

	/******************** 异步请求区域 ********************/
	$.post(o.url,{page:JSON.stringify(o)},function(data){
		
/* 		common.blockUI($('.j-sidebar-container')); */
		
		var th,tr,td,html;
		
		/******************** 重绘表格头部 ********************/
		var thead=$('#j-main-container').children('table[class="table table-striped"]').children('thead');
		thead.empty();
		tr=$(document.createElement('TR'));
		th=$(document.createElement('TH'));
		th.attr('width','1%');
		th.attr('class','nowrap center');
		//全选框
		var checkbox=$(document.createElement('INPUT'));
		checkbox.attr('type','checkbox');
		checkbox.attr('name','checkall-toggle');
		checkbox.attr('class','hasTooltip');
		checkbox.attr('data-original-title','全选');
		checkbox.appendTo(th);
		th.appendTo(tr);
		//全选框事件
		checkbox.live('change',function(){			
			var tbody=$('#j-main-container').children('table[class="table table-striped"]').children('tbody');
			tbody.find('input[type="checkbox"][name="j-main-container-checkboxes"]').each(function(index,item){
				$(item).prop('checked',checkbox.prop('checked'));
			});
		});
		//用户配置的每一列		
		for(var i=0;i<o.colModel.length;i++){
			th=$(document.createElement('TH'));
			th.attr('width',o.colModel[i].width);
			if(o.colModel[i].titleAligin=='center'){
				th.attr('class','nowrap center');
			}else{
				th.attr('class','left');
			}
			html='  <a name="'+o.colModel[i].name+'" href="#" class="hasTooltip" data-original-title="&lt;strong&gt;'+o.colModel[i].display+'&lt;/strong&gt;&lt;br /&gt;点击排序">'+o.colModel[i].display;
			if(undefined!=data.obj && o.colModel[i].name==data.obj.field){
				if(data.obj.sort=='asc'){
					html+='<i class="icon-arrow-up-3"></i>';
				}else if(data.obj.sort=='desc'){
					html+='<i class="icon-arrow-down-3"></i>';
				}
			}else{
				html+='<i></i>';
			}
			html+='<i></i></a>';
			th.html(html);
			//点击列头排序
			th.live('click',function(){
				//排序方式
				if($(this).find('a i').attr('class')=='icon-arrow-up-3'){
					o.pageConfig.order='desc';
				}else{
					o.pageConfig.order='asc';
				}
				//排序字段
				o.pageConfig.orderby=$(this).children('a').attr('name');
				//排序
				$('#_page_currentPage').change();
			});
			//列隐藏属性
			if(o.colModel[i].hidden==true){
				th.css({'display':'none'});
			}
			th.appendTo(tr);
		}
		tr.appendTo(thead);

		//重绘表格内容
		var tbody=$('#j-main-container').children('table[class="table table-striped"]').children('tbody');
		tbody.empty();
		if(data.result=="success" && data.obj.list.length>0){
			
/* 			common.unblockUI($('.j-sidebar-container')); */
			
			for(var i=0;i<data.obj.list.length;i++){
				tr=$(document.createElement('TR'));
				td=$(document.createElement('TD'));
				td.attr('class','center');
				tr.attr('class','row0');
				td.html('<input type="checkbox" name="j-main-container-checkboxes"/>');
				td.appendTo(tr);
				for(var j=0;j<o.colModel.length;j++){
					td=$(document.createElement('TD'));
					td.attr('name',o.colModel[j].name);
					if(o.colModel[j].cellAligin=='center'){
						td.attr('class','center');
					}else{
						td.attr('class','left');
					}
					//空值
					if(data.obj.list[i][o.colModel[j].name]==null || data.obj.list[i][o.colModel[j].name]==undefined){
						td.html(o.colModel[j].defaultValue);					
					}else if(o.colModel[j].link!=undefined){//链接
						var str=o.colModel[j].link+'';
						str=$.trim(str)+'';
						if(str.lastIndexOf('=')==str.length-1){
							for(var k=0;k<o.colModel.length;k++){
								if(o.colModel[k].primaryKey){
									str+=data.obj.list[i][o.colModel[k].name];
								}
							}
						}
						td.html('<a style="color: #00CC48;" href="'+str+'"><strong>'+data.obj.list[i][o.colModel[j].name]+'</strong></a>');
					}else if(o.colModel[j].realValue!=undefined){//真实值
						td.html(o.colModel[j].realValues[data.obj.list[i][o.colModel[j].name]]);					
					}else if(o.colModel[j].addAndSub!=undefined){//加减按钮		
						try{
							JSON.stringify(o.colModel[j].addAndSub);
							var btnAdd=$(document.createElement('input'));
							var btnSub=$(document.createElement('input'));
							btnAdd.attr({'type':'button','value':'+'});
							btnSub.attr({'type':'button','value':'-'});
							btnAdd.css({'width':24,'height':24,'text-aligin':'center'});
							btnSub.css({'width':24,'height':24,'text-aligin':'center'});
							var span=$(document.createElement('span'));
							span.html(data.obj.list[i][o.colModel[j].name]);
							span.css({'padding-left':8,'padding-right':8});
							span.attr({'min':o.colModel[j].addAndSub.min,'max':o.colModel[j].addAndSub.max,'url':o.colModel[j].addAndSub.url,'reload':o.colModel[j].addAndSub.reload});
							td.append(btnSub);
							td.append(span);
							td.append(btnAdd);
							btnAdd.click(function(){
								_pageFunAddAndSub($($(this).parent().children('span')),1);
							});
							btnSub.click(function(){
								_pageFunAddAndSub($($(this).parent().children('span')),-1);
							});
						}catch(e){
							td.html(data.obj.list[i][o.colModel[j].name]);
						}				
					}else if(o.colModel[j].addbtn!=undefined){
						var id = '';
						for(var k=0;k<o.colModel.length;k++){
							if(o.colModel[k].primaryKey){
								id+=data.obj.list[i][o.colModel[k].name];
							}
						}
						td.html('<div onclick="showselect('+id+');"><strong><'+data.obj.list[i][o.colModel[j].name]+'></strong></div>');
					}else if(o.colModel[j].button!=undefined){
						var id = '';
						for(var k=0;k<o.colModel.length;k++){
							if(o.colModel[k].primaryKey){
								id+=data.obj.list[i][o.colModel[k].name];
							}
						}
						td.html('<button type="button"  onclick="tblreservation('+id+')" class="btn btn-warning">操作</button>');
					}else{//一般值
						td.html(data.obj.list[i][o.colModel[j].name]);
					}				
					//主键属性
					if(o.colModel[j].primaryKey==true){
						td.attr('primaryKey','true');						
					}
					//列隐藏属性
					if(o.colModel[j].hidden==true){
						td.css({'display':'none'});
					}
					//播放路径属性
					if(o.colModel[j].playPath==true){
						td.attr({'playPath':'true'});
					}
					td.appendTo(tr);
					//行操作的回调函数
					if(undefined!=o.colModel[j].rowCallBack && typeof(eval(o.colModel[j].rowCallBack))=='function'){
						o.colModel[j].rowCallBack.call({},tr,data.obj.list[i][o.colModel[j].name]);
					}
				}
				tr.appendTo(tbody);
			}
		}else{
			tr=$(document.createElement('TR'));
			td=$(document.createElement('TD'));
			td.attr('colspan',o.colModel.length);
			td.attr('aligin','center');
			td.css({'text-align':'center'});
			td.html('<strong>无数据！</strong>');
			td.appendTo(tr);
			tr.appendTo(tbody);
		}

		//重绘表格底部
		var tfoot=$('#j-main-container').find('table[class="table table-striped"] tfoot');
		tfoot.empty();
		tr=$(document.createElement('TR'));
		td=$(document.createElement('TD'));
		td.attr('colspan',o.colModel.length);
		if(data.result=="success" && data.obj.list.length>0){
			html='<div class="pagination pagination-toolbar">';
			html+='<ul class="pagination-list">';
			html+='  <li><a class="hasTooltip" title="" href="#" data-original-title="首页"><i class="icon-first"></i></a></li>';
			html+='  <li><a class="hasTooltip" title="" href="#" data-original-title="上一页"><i class="icon-previous"></i></a></li>';
			html+='  <li class="active"><a>'+data.obj.currentPage+'/'+data.obj.totalPage+'</a></li>';
			html+='  <li><a class="hasTooltip" title="" href="#" data-original-title="下一页"><i class="icon-next"></i></a></li>';
			html+='  <li><a class="hasTooltip" title="" href="#" data-original-title="尾页"><i class="icon-last"></i></a></li>';
			html+='  <li><div class="filter-search btn-group pull-right"><select id="_page_currentPage" style="width:120px;"></select></select></li>';
			html+='</ul></div>';	
			td.html(html);
			//页面跳转箭头
			var ul=$(td.children('div').children('ul'));
			ul.children('li').each(function(index,item){
				if(data.obj.currentPage<=1 && (index==0 || index==1)){
					$(item).attr('class','disabled');
				}
				if(data.obj.currentPage>=data.obj.totalPage && (index==3 || index==4)){
					$(item).attr('class','disabled');
				}
				$(item).live('click',function(){
					if($(item).attr('class')=='disabled'){
						return;
					}
					var temp=parseInt(ul.find('#_page_currentPage').val());
					switch (index) {
					case 0:
						ul.find('#_page_currentPage').val(1);						
						break;
					case 1:
						if(temp<=1){
							ul.find('#_page_currentPage').val(1);
						}else{
							ul.find('#_page_currentPage').val(temp-1);
						}				
						break;
					case 3:
						if(temp>=data.obj.totalPage){
							ul.find('#_page_currentPage').val(data.obj.totalPage);
						}else{
							ul.find('#_page_currentPage').val(temp+1);
						}
						break;
					case 4:
						ul.find('#_page_currentPage').val(data.obj.totalPage);
						break;
					default:
						return;
					}
					$('#_page_currentPage').change();
				});
			});
			//页码选择器
			var select=ul.find('#_page_currentPage');
			for(var i=1;i<=data.obj.totalPage;i++){
				if(i==data.obj.currentPage){
					select.append('<option selected="selected" value="'+i+'">'+i+'</option>');
				}else{
					select.append('<option value="'+i+'">'+i+'</option>');
				}
			}
		}else{
			td.html('<div class="pagination pagination-toolbar"><input type="hidden" name="limitstart" value="0"/></div>');
		}
		td.appendTo(tr);
		tr.appendTo(tfoot);
	},'json');
	/******************** 异步请求区域 ********************/
};

/**
 * 
 */
function _pageFunAddAndSub(span,addValue){
	var v=parseInt(span.html());
	var min=parseInt(span.attr('min'));
	var max=parseInt(span.attr('max'));
	if(addValue>0){
		if(v<max){
			v+=addValue;
			span.html(v);
			if(undefined!=span.attr('url')){
				$.post(span.attr('url'),{'updateValue':v,'id':span.parent().parent().find('[primaryKey="true"]').html},function(data){
					if(data.result=='success' && span.attr('reload')!=false){
						$('#_page_currentPage').change();
					}
				},'json');
			}
		}
		return;
	}
	if(addValue<0){
		if(v>min){
			v+=addValue;
			span.html(v);
			if(undefined!=span.attr('url')){
				$.post(span.attr('url'),{'updateValue':v},function(data){
					if(data.result=='success' && span.attr('reload')!=false){
						$('#_page_currentPage').change();
					}
				},'json');
			}
		}
		return;
	}
}

function test(){
	//删除和修改时可知被选行
	/*$('table[class="table table-striped"] tbody tr[class="row0"] td input:checked').each(function(index,item){
		
	});*/
}

$(document).ready(function(){
	$('#_page_currentPage').live('change',function(){
		_pageElement.page(_page);
	});
	$('#_page_btnSearch').live('click',function(){
		$('#_page_currentPage').val(1)
		_page.filterForm=_pageFilterForm;
		//点击搜索按钮，不再按指定页面的字段排序
		_page.pageConfig.orderby=undefined;
		_page.pageConfig.order=undefined;
		_pageElement.page(_page);
	});
	$('#_page_btnReset').live('click',function(){
		_pageFilterForm.find('[class^="chzn-container chzn-container-single chzn-container-single-nosearch"]').each(function(index,item){
			$(item).remove();
		});
		_pageFilterForm.find('select').each(function(index,item){
			$(item).css({'display':'none'});
			$(item).removeClass('chzn-done');
		});
		_pageFilterForm.find('[class*="chzn-container"]').remove();
		_pageFilterForm.children('input[type="reset"]').click();
		_pageFilterForm.find('select').chosen({
			disable_search_threshold : 10,
			allow_single_deselect : true
		});
	});
});
</script>

<div id="j-main-container" class="span10" style="width:80%;">
	<div id="system-message-container-backup" style="display:none;">
		<button type="button" class="close" data-dismiss="alert">×</button>
		<div class="alert">
			<h4 class="alert-heading">警告</h4>
			<p></p>
		</div>
	</div>
	<div id="filter-bar" class="btn-toolbar">
		<div class="filter-search btn-group pull-left">
			<select id="_page_showCount">
				<option value="10">每页数据10条</option>
				<option value="20">每页数据20条</option>
				<option value="30">每页数据30条</option>
				<option value="50">每页数据50条</option>
				<option value="100">每页数据100条</option>
			</select>
		</div>
		<div class="btn-group pull-left">
			<div id="_page_btnSearch" class="btn hasTooltip" title="" data-original-title="搜索">
				<i class="icon-search"></i>
			</div>
			<div id="_page_btnReset" class="btn hasTooltip" title="" data-original-title="重置过滤器" onclick="javascript:test();">
				<i class="icon-remove"></i>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<table class="table table-striped" >
		<thead>
		</thead>
		<tfoot>
		</tfoot>
		<tbody>
		</tbody>
	</table>
</div>