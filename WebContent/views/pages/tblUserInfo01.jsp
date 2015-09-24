<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/views/com/common.jsp"%>
<%@ include file="/views/com/header.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理-编辑</title>
</head>
<body>
	
	<script type="text/javascript">
	$(document).ready(function(){	
		
		$('form[class="form-horizontal"]').validate({
			rules:{
				'variable_name':{required:true},
				'variable_desc':{required:true},
				'variable_index':{regex:'^[1-9]\d*$'},
				'variable_id_1':{required:true,regex:'^1\d{10}$'},
				'variable_id_30':{regex:'^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$'}
			},
			messages:{
				'variable_name':{required:'变量名称不能为空'},
				'variable_desc':{required:'文字描述不能为空'},
				'variable_index':{regex:'请输入正确的排序索引'},
				'variable_id_1':{required:'请输入手机号码！',regex:'手机号码不正确,请重新输入！'},
				'variable_id_30':{regex:'请输入 正确的邮箱地址'}
			},
	  		onkeyup: false,
	  		errorPlacement : function(error, element) {
				_common.showEditedErrorMsg($(error).text());
				$(element).focus();
		  	},
			submitHandler: function(form) {
				
				$.post('${OTT_ROOT}/tblUserInfo/saveOrUpdate',$(form).serializeObject(),function(data){
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
						<input type="hidden" name="user_card" value="${DynamicBean.user_card}"/>
							<fieldset>
									<div class="control-group" <c:if test="${null==DynamicBean}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>卡号
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id_38" readonly="readonly" size="30" value="${DynamicBean.variable_id_38}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>姓名
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id_5" readonly="readonly" value="${DynamicBean.variable_id_5}"/>
										</div>
									</div>
								    <div class="control-group">
										<div class="control-label">
											<label>性别
												<span class="star">&nbsp;*</span>
											</label>
										</div>
										<div class="controls">
											<select name="variable_id_2">
											    <option value="男" ${DynamicBean.variable_id_2 eq "男" ? 'selected="selected"':''}>男</option>
											    <option value="女" ${DynamicBean.variable_id_2 eq "女" ? 'selected="selected"':''}>女</option>
											</select>
										</div>
									</div> 
									<div class="control-group">
										<div class="control-label">
											<label>手机号码
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id_1" size="30" value="${DynamicBean.variable_id_1}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>身高(CM)
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id_39" size="30" value="${DynamicBean.variable_id_39}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>体重(KG)
											</label>
										</div>
										<div class="controls">
											<input type="text" name="variable_id_40" size="30" value="${DynamicBean.variable_id_40}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最高学历
											</label>
										</div>
										<div class="controls">
											<select name="variable_id_3">
											    <option value="本科" ${DynamicBean.variable_id_3 eq "本科" ? 'selected="selected"':''}>本科</option>
											    <option value="大专" ${DynamicBean.variable_id_3 eq "大专" ? 'selected="selected"':''}>大专</option>
											    <option value="硕士" ${DynamicBean.variable_id_3 eq "硕士" ? 'selected="selected"':''}>硕士</option>
											    <option value="博士" ${DynamicBean.variable_id_3 eq "博士" ? 'selected="selected"':''}>博士</option>
											    <option value="高中、职高、中专或技校" ${DynamicBean.variable_id_3 eq "高中、职高、中专或技校" ? 'selected="selected"':''}>高中、职高、中专或技校</option>
											    <option value="初中及以下" ${DynamicBean.variable_id_3 eq "初中及以下" ? 'selected="selected"':''}>初中及以下</option>
											    
											</select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>是否独生子女
											</label>
										</div>
										<div class="controls">
											<%-- <input type="text" name="variable_id_4" size="30" value="${DynamicBean.variable_id_4}"/> --%>
											<select name="variable_id_4">
											    <option value="是" ${DynamicBean.variable_id_4 eq '是' ? 'selected="selected"':''}>是</option>
											    <option value="否" ${DynamicBean.variable_id_4 eq '否' ? 'selected="selected"':''}>否</option>
											</select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>出生日期
											</label>
										</div>
										<div class="controls">
												<input type="text" name="variable_id_8" size="30" class="form_datetime3" value="${DynamicBean.variable_id_8}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>民族
											</label>
										</div>
										<div class="controls">
											<select name="variable_id_9">
											   <option value="汉族" ${DynamicBean.variable_id_9 eq '汉族' ? 'selected="selected"':''}>汉族</option>
											   <option value="少数民族" ${DynamicBean.variable_id_9 eq '少数民族' ? 'selected="selected"':''}>少数民族</option>
											   <option value="外国籍" ${DynamicBean.variable_id_9 eq '外国籍' ? 'selected="selected"':''}>外国籍</option>
											</select>
										</div>
									</div><div class="control-group">
										<div class="control-label">
											<label>婚姻状况
											</label>
										</div>
										<div class="controls">
											<select name="variable_id_10">
											   <option value="未婚" ${DynamicBean.variable_id_10 eq '未婚' ? 'selected="selected"':''}>未婚</option>
											   <option value="已婚" ${DynamicBean.variable_id_10 eq '已婚' ? 'selected="selected"':''}>已婚</option>
											   <option value="离异" ${DynamicBean.variable_id_10 eq '离异' ? 'selected="selected"':''}>离异</option>
											   <option value="丧偶" ${DynamicBean.variable_id_10 eq '丧偶' ? 'selected="selected"':''}>丧偶</option>	
											</select>
										</div>
									</div>
									
									<div class="control-group">
										<div class="control-label">
											<label>子女状况
											</label>
										</div>
										<div class="controls">
											<select name="variable_id_11">
											   <option value="无子女" ${DynamicBean.variable_id_11 eq '无子女' ? 'selected="selected"':''}>无子女</option>
											   <option value="有1个子女" ${DynamicBean.variable_id_11 eq '有1个子女' ? 'selected="selected"':''}>有1个子女</option>
											   <option value="有2个子女" ${DynamicBean.variable_id_11 eq '有2个子女' ? 'selected="selected"':''}>有2个子女</option>
											   <option value="其他" ${DynamicBean.variable_id_11 eq '其他' ? 'selected="selected"':''}>其他</option>	
											</select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>第一个孩子出生时间
											</label>
										</div>
										<div class="controls">
												<input type="text" name="variable_id_31" size="30" class="form_datetime3" value="${DynamicBean.variable_id_31}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>第二个孩子出生时间	
											</label>
										</div>
										<div class="controls">
												<input type="text" name="variable_id_32" size="30" class="form_datetime3" value="${DynamicBean.variable_id_32}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>入司时间
											</label>
										</div>
										<div class="controls">
												<input type="text" name="variable_id_12" size="30" class="form_datetime3" value="${DynamicBean.variable_id_12}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>职等
											</label>
										</div>
										<div class="controls">
												<select name="variable_id_13">
												   <option value="一般员工" ${DynamicBean.variable_id_13 eq '一般员工' ? 'selected="selected"' :''}>一般员工</option>
												   <option value="基层/一线管理者" ${DynamicBean.variable_id_13 eq '基层/一线管理者' ? 'selected="selected"' :''}>基层/一线管理者</option>
												   <option value="中层管理者" ${DynamicBean.variable_id_13 eq '中层管理者' ? 'selected="selected"' :''}>中层管理者</option>
												   <option value="高层管理者" ${DynamicBean.variable_id_13 eq '高层管理者' ? 'selected="selected"' :''}>高层管理者</option>
												</select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>所属分子公司
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_14" value="${DynamicBean.variable_id_14}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>部门
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_15" value="${DynamicBean.variable_id_15}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>岗位
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_16" value="${DynamicBean.variable_id_16}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>条线
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_17" value="${DynamicBean.variable_id_17}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>公司
											</label>
										</div>
										<div class="controls">
                                              <select name="variable_id_18">
                                                  <option value="计算机/互联网/通信/电子" ${DynmaicBean.variable_id_18 eq '计算机/互联网/通信/电子' ? 'selected="selected"' : ''}>计算机/互联网/通信/电子</option>
                                                  <option value="销售/客服/技术支持" ${DynmaicBean.variable_id_18 eq '销售/客服/技术支持' ? 'selected="selected"' : ''}>销售/客服/技术支持</option>
                                                  <option value="会计/金融/银行/保险" ${DynmaicBean.variable_id_18 eq '会计/金融/银行/保险' ? 'selected="selected"' : ''}>会计/金融/银行/保险</option>
                                                  <option value="生产/营运/采购/物流" ${DynmaicBean.variable_id_18 eq '生产/营运/采购/物流' ? 'selected="selected"' : ''}>生产/营运/采购/物流</option>
                                                  <option value="生物/制药/医疗/护理" ${DynmaicBean.variable_id_18 eq '生物/制药/医疗/护理' ? 'selected="selected"' : ''}>生物/制药/医疗/护理</option>
                                                  <option value="广告/市场/媒体/艺术" ${DynmaicBean.variable_id_18 eq '广告/市场/媒体/艺术' ? 'selected="selected"' : ''}>广告/市场/媒体/艺术</option>
                                                  <option value="建筑/房地产" ${DynmaicBean.variable_id_18 eq '建筑/房地产' ? 'selected="selected"' : ''}>建筑/房地产</option>
                                                  <option value="人事/行政/高级管理" ${DynmaicBean.variable_id_18 eq '人事/行政/高级管理' ? 'selected="selected"' : ''}>人事/行政/高级管理</option>
                                                  <option value="咨询/法律/教育/科研" ${DynmaicBean.variable_id_18 eq '咨询/法律/教育/科研' ? 'selected="selected"' : ''}>咨询/法律/教育/科研</option>
                                                  <option value="服务业" ${DynmaicBean.variable_id_18 eq '服务业' ? 'selected="selected"' : ''}>服务业</option>
                                                  <option value="公务员/事业单位" ${DynmaicBean.variable_id_18 eq '公务员/事业单位' ? 'selected="selected"' : ''}>公务员/事业单位</option>
                                                  <option value="其他" ${DynmaicBean.variable_id_18 eq '其他' ? 'selected="selected"' : ''}>其他</option>
                                              </select>										
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>公司
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_19" value="${DynamicBean.variable_id_19}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>工号
											</label>
										</div>
										<div class="controls">
                                              <input type="text" name="variable_id_20" value="${DynamicBean.variable_id_20}"/>												
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>工作性质
											</label>
										</div>
										<div class="controls">
                                              <select name="variable_id_21">
                                                  <option value="党政机关" ${DynmaicBean.variable_id_21 eq '党政机关' ? 'selected="selected"' : ''}>党政机关</option>
                                                  <option value="科研设计单位 高等教育单位 " ${DynmaicBean.variable_id_21 eq '科研设计单位 高等教育单位 ' ? 'selected="selected"' : ''}>科研设计单位 高等教育单位 </option>
                                                  <option value="中等、初等教育单位 艰苦行业事业单位 医疗卫生单位 国有企业 三资企业  " ${DynmaicBean.variable_id_21 eq '中等、初等教育单位 艰苦行业事业单位 医疗卫生单位 国有企业 三资企业  ' ? 'selected="selected"' : ''}>中等、初等教育单位 艰苦行业事业单位 医疗卫生单位 国有企业 三资企业  </option>
                                                  <option value="艰苦行业企业 其他企业  " ${DynmaicBean.variable_id_21 eq '艰苦行业企业 其他企业  ' ? 'selected="selected"' : ''}>艰苦行业企业 其他企业  </option>
                                                  <option value="国家基层项目 地方基层项目 农村建制村 城镇社区" ${DynmaicBean.variable_id_21 eq '国家基层项目 地方基层项目 农村建制村 城镇社区' ? 'selected="selected"' : ''}>国家基层项目 地方基层项目 农村建制村 城镇社区</option>
                                              </select>										
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>聘用类型
											</label>
										</div>
										<div class="controls">
                                              <select name="variable_id_22">
                                                  <option value="合同工" ${DynmaicBean.variable_id_22 eq '合同工' ? 'selected="selected"' : ''}>合同工</option>
                                                  <option value="劳务派遣 " ${DynmaicBean.variable_id_22 eq '劳务派遣 ' ? 'selected="selected"' : ''}>劳务派遣 </option>
                                              </select>										
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>初次工作时间
											</label>
										</div>
										<div class="controls">
                                             <input type="text" name="variable_id_23" class="form_datetime3" value="${DynamicBean.variable_id_23}">									
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>公司性质
											</label>
										</div>
										<div class="controls">
                                            <select name="variable_id_24">
                                                <option value="国企" ${DynamicBean.variable_id_24 eq '国企' ? 'selected="selected"' :'' }>国企</option>
                                                <option value="民营" ${DynamicBean.variable_id_24 eq '民营' ? 'selected="selected"' :'' }>民营</option>
                                                <option value="政府机构" ${DynamicBean.variable_id_24 eq '政府机构' ? 'selected="selected"' :'' }>政府机构</option>
                                                <option value="事业单位" ${DynamicBean.variable_id_24 eq '事业单位' ? 'selected="selected"' :'' }>事业单位</option>
                                                <option value="外资" ${DynamicBean.variable_id_24 eq '外资' ? 'selected="selected"' :'' }>外资</option>
                                                <option value="合资" ${DynamicBean.variable_id_24 eq '合资' ? 'selected="selected"' :'' }>合资</option>
                                                <option value="非盈利机构" ${DynamicBean.variable_id_24 eq '非盈利机构' ? 'selected="selected"' :'' }>非盈利机构</option>
                                                <option value="其他" ${DynamicBean.variable_id_24 eq '其他' ? 'selected="selected"' :'' }>其他</option>
                                            </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>公司规模
											</label>
										</div>
										<div class="controls">
                                            <select name="variable_id_25">
                                                <option value="少于50人" ${DynamicBean.variable_id_25 eq '少于50人' ? 'selected="selected"' :'' }>少于50人</option>
                                                <option value="50-150人" ${DynamicBean.variable_id_25 eq '50-150人' ? 'selected="selected"' :'' }>50-150人</option>
                                                <option value="150-500人" ${DynamicBean.variable_id_25 eq '150-500人' ? 'selected="selected"' :'' }>150-500人</option>
                                                <option value="500-1000人" ${DynamicBean.variable_id_25 eq '500-1000人' ? 'selected="selected"' :'' }>500-1000人</option>
                                                <option value="1000-5000人" ${DynamicBean.variable_id_25 eq '1000-5000人' ? 'selected="selected"' :'' }>1000-5000人</option>
                                                <option value="5000-10000人" ${DynamicBean.variable_id_25 eq '5000-10000人' ? 'selected="selected"' :'' }>5000-10000人</option>
                                                <option value="10000人以上" ${DynamicBean.variable_id_25 eq '10000人以上' ? 'selected="selected"' :'' }>10000人以上</option>
                                            </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>工作地点
											</label>
										</div>
										<div class="controls">
                                          <input type="text" name="variable_id_26" value="${DynamicBean.variable_id_26}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>证件类型
											</label>
										</div>
										<div class="controls">
                                          <select name="variable_id_27">
                                              <option value="身份证" ${DynamicBean.variable_id_27 eq '身份证' ? 'selected="selected"' : '' }>身份证</option>
                                              <option value="驾驶证" ${DynamicBean.variable_id_27 eq '驾驶证' ? 'selected="selected"' : '' }>驾驶证</option>
                                              <option value="军官证" ${DynamicBean.variable_id_27 eq '军官证' ? 'selected="selected"' : '' }>军官证</option>
                                              <option value="学生证" ${DynamicBean.variable_id_27 eq '学生证' ? 'selected="selected"' : '' }>学生证</option>
                                              <option value="退休证" ${DynamicBean.variable_id_27 eq '退休证' ? 'selected="selected"' : '' }>退休证</option>
                                              <option value="其他" ${DynamicBean.variable_id_27 eq '其他' ? 'selected="selected"' : '' }>其他</option>
                                          </select>
										</div>
									</div>
								    <div class="control-group">
										<div class="control-label">
											<label>证件号码
											</label>
										</div>
										<div class="controls">
                                           <input type="text" name="variable_id_28" value="${DynamicBean.variable_id_28}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>职称
											</label>
										</div>
										<div class="controls">
                                          <select name="variable_id_29">
                                              <option value="初级" test="${DynamicBean.variable_id_29 eq '初级' ? 'selected="selected"': '初级'}">初级</option>
                                              <option value="中级" test="${DynamicBean.variable_id_29 eq '中级' ? 'selected="selected"': '中级'}">中级</option>
                                              <option value="高级" test="${DynamicBean.variable_id_29 eq '高级' ? 'selected="selected"': '高级'}">高级</option>
                                          </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>邮箱
											</label>
										</div>
										<div class="controls">
                                           <input type="text" name="variable_id_30" value="${DynamicBean.variable_id_30}"/>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>家庭结构
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_33">
                                              <option value="独居" test="${DynamicBean.variable_id_33 eq '独居' ? 'selected="selected"':'' }">独居</option>
                                              <option value="二人世界" test="${DynamicBean.variable_id_33 eq '二人世界' ? 'selected="selected"':'' }">二人世界</option>
                                              <option value="夫妇二人和孩子" test="${DynamicBean.variable_id_33 eq '夫妇二人和孩子' ? 'selected="selected"':'' }">夫妇二人和孩子</option>
                                              <option value="单亲和孩子" test="${DynamicBean.variable_id_33 eq '单亲和孩子' ? 'selected="selected"':'' }">单亲和孩子</option>
                                              <option value="和老人同住" test="${DynamicBean.variable_id_33 eq '和老人同住' ? 'selected="selected"':'' }">和老人同住</option>
                                              <option value="夫妇二人和老人、孩子" test="${DynamicBean.variable_id_33 eq '夫妇二人和老人、孩子' ? 'selected="selected"':'' }">夫妇二人和老人、孩子</option>
                                              <option value="其它【请注明】" test="${DynamicBean.variable_id_33 eq '其它【请注明】' ? 'selected="selected"':'' }">其它【请注明】</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>家庭年收入
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_34">
                                              <option value="4万元以下" test="${DynamicBean.variable_id_34 eq '4万元以下' ? 'selected="selected"':'' }">4万元以下</option>
                                              <option value="4-6万元(不含6万元)" test="${DynamicBean.variable_id_34 eq '4-6万元(不含6万元)' ? 'selected="selected"':'' }">4-6万元(不含6万元)</option>
                                              <option value="6-8万元(不含8万元)" test="${DynamicBean.variable_id_34 eq '6-8万元(不含8万元)' ? 'selected="selected"':'' }">6-8万元(不含8万元)</option>
                                              <option value="8-15万元(不含12万元)" test="${DynamicBean.variable_id_34 eq '8-15万元(不含12万元)' ? 'selected="selected"':'' }">8-15万元(不含12万元)</option>
                                              <option value="15-25万元(不含24万元)" test="${DynamicBean.variable_id_34 eq '15-25万元(不含24万元)' ? 'selected="selected"':'' }">15-25万元(不含24万元)</option>
                                              <option value="25-50万元(不含50万元)" test="${DynamicBean.variable_id_34 eq '25-50万元(不含50万元)' ? 'selected="selected"':'' }">25-50万元(不含50万元)</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>父母中最高一方的学历
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_35">
                                              <option value="博士" test="${DynamicBean.variable_id_35 eq '博士' ? 'selected="selected"':'' }">博士</option>
                                              <option value="硕士" test="${DynamicBean.variable_id_35 eq '硕士' ? 'selected="selected"':'' }">硕士</option>
                                              <option value="本科" test="${DynamicBean.variable_id_35 eq '本科' ? 'selected="selected"':'' }">本科</option>
                                              <option value="大专" test="${DynamicBean.variable_id_35 eq '大专' ? 'selected="selected"':'' }">大专</option>
                                              <option value="高中、职高、中专或技校" test="${DynamicBean.variable_id_35 eq '高中、职高、中专或技校' ? 'selected="selected"':'' }">高中、职高、中专或技校</option>
                                              <option value="初中及以下" test="${DynamicBean.variable_id_35 eq '初中及以下' ? 'selected="selected"':'' }">初中及以下</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>家庭出身
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_36">
                                              <option value="单亲家庭" test="${DynamicBean.variable_id_36 eq '单亲家庭' ? 'selected="selected"':'' }">单亲家庭</option>
                                              <option value="完整家庭" test="${DynamicBean.variable_id_36 eq '完整家庭' ? 'selected="selected"':'' }">完整家庭</option>
                                              <option value="离异家庭" test="${DynamicBean.variable_id_36 eq '离异家庭' ? 'selected="selected"':'' }">离异家庭</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>请问您平时主要的消遣方式都是什么？
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_37">
                                              <option value="和朋友聊天" test="${DynamicBean.variable_id_37 eq '和朋友聊天' ? 'selected="selected"':'' }">和朋友聊天</option>
                                              <option value="看电影、话剧等" test="${DynamicBean.variable_id_37 eq '看电影、话剧等' ? 'selected="selected"':'' }">看电影、话剧等</option>
                                              <option value="郊游/爬山" test="${DynamicBean.variable_id_37 eq '郊游/爬山' ? 'selected="selected"':'' }">郊游/爬山</option>
                                              <option value="玩电脑、上网" test="${DynamicBean.variable_id_37 eq '玩电脑、上网' ? 'selected="selected"':'' }">玩电脑、上网</option>
                                              <option value="逛商店、购物" test="${DynamicBean.variable_id_37 eq '逛商店、购物' ? 'selected="selected"':'' }">逛商店、购物</option>
                                              <option value="美容、美体或按摩" test="${DynamicBean.variable_id_37 eq '美容、美体或按摩' ? 'selected="selected"':'' }">美容、美体或按摩</option>
                                              <option value="体育健身" test="${DynamicBean.variable_id_37 eq '体育健身' ? 'selected="selected"':'' }">体育健身</option>
                                              <option value="饲养宠物" test="${DynamicBean.variable_id_37 eq '饲养宠物' ? 'selected="selected"':'' }">饲养宠物</option>
                                              <option value="开车兜风" test="${DynamicBean.variable_id_37 eq '开车兜风' ? 'selected="selected"':'' }">开车兜风</option>
                                              <option value="在家看电视" test="${DynamicBean.variable_id_37 eq '在家看电视' ? 'selected="selected"':'' }">在家看电视</option>
                                              <option value="读书或听音乐" test="${DynamicBean.variable_id_37 eq '读书或听音乐' ? 'selected="selected"':'' }">读书或听音乐</option>
                                              <option value="泡茶馆酒吧" test="${DynamicBean.variable_id_37 eq '泡茶馆酒吧' ? 'selected="selected"':'' }">泡茶馆酒吧</option>
                                              <option value="旅游" test="${DynamicBean.variable_id_37 eq '旅游' ? 'selected="selected"':'' }">旅游</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>住所是否稳定
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_41">
                                              <option value="是" test="${DynamicBean.variable_id_41 eq '是' ? 'selected="selected"':'' }">是</option>
                                              <option value="否" test="${DynamicBean.variable_id_41 eq '否' ? 'selected="selected"':'' }">否</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>身体健康状况
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_42">
                                              <option value="良好" test="${DynamicBean.variable_id_42 eq '良好' ? 'selected="selected"':'' }">良好</option>
                                              <option value="一般" test="${DynamicBean.variable_id_42 eq '一般' ? 'selected="selected"':'' }">一般</option>
                                              <option value="较弱" test="${DynamicBean.variable_id_42 eq '较弱' ? 'selected="selected"':'' }">较弱</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>对当前工作的满意度
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_43">
                                              <option value="满意" test="${DynamicBean.variable_id_43 eq '满意' ? 'selected="selected"':'' }">满意</option>
                                              <option value="一般" test="${DynamicBean.variable_id_43 eq '一般' ? 'selected="selected"':'' }">一般</option>
                                              <option value="不满意" test="${DynamicBean.variable_id_43 eq '不满意' ? 'selected="selected"':'' }">不满意</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否岗位调动
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_44">
                                              <option value="有" test="${DynamicBean.variable_id_44 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_44 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否职位变动
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_45">
                                              <option value="升" test="${DynamicBean.variable_id_45 eq '升' ? 'selected="selected"':'' }">升</option>
                                              <option value="降" test="${DynamicBean.variable_id_45 eq '降' ? 'selected="selected"':'' }">降</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否收入发生变化
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_46">
                                              <option value="增多" test="${DynamicBean.variable_id_46 eq '增多' ? 'selected="selected"':'' }">增多</option>
                                              <option value="减少" test="${DynamicBean.variable_id_46 eq '减少' ? 'selected="selected"':'' }">减少</option>
                                              <option value="无变化" test="${DynamicBean.variable_id_46 eq '无变化' ? 'selected="selected"':'' }">无变化</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否有重大的家庭变故
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_47">
                                             <option value="有" test="${DynamicBean.variable_id_47 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_47 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否生病请假
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_48">
                                              <option value="有" test="${DynamicBean.variable_id_48 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_48 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否有影响您的社会生活事件
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_49">
                                              <option value="有" test="${DynamicBean.variable_id_49 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_49 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年企业或单位是否发生重要的人事变动
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_50">
                                              <option value="有" test="${DynamicBean.variable_id_50 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_50 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>		
									<div class="control-group">
										<div class="control-label">
											<label>最近半年企业是否进行重要的改革或改组
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_51">
                                               <option value="有" test="${DynamicBean.variable_id_51 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_51 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否发生过法律纠纷
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_52">
                                               <option value="有" test="${DynamicBean.variable_id_52 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_52 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年有没有出国或旅游过
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_53">
                                                <option value="有" test="${DynamicBean.variable_id_53 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_53 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否有直系亲属生病
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_54">
                                               <option value="有" test="${DynamicBean.variable_id_54 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_54 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>
									<div class="control-group">
										<div class="control-label">
											<label>最近半年是否有直系亲属过世
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_55">
                                               <option value="有" test="${DynamicBean.variable_id_55 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_55 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>		
									<div class="control-group">
										<div class="control-label">
											<label>有没有接受过心理咨询服务
											</label>
										</div>
										<div class="controls">
                                           <select name="variable_id_56">
                                              <option value="有" test="${DynamicBean.variable_id_56 eq '有' ? 'selected="selected"':'' }">有</option>
                                              <option value="无" test="${DynamicBean.variable_id_56 eq '无' ? 'selected="selected"':'' }">无</option>
                                           </select>
										</div>
									</div>				
									<div class="control-group" <c:if test="${null==DynamicBean}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${DynamicBean.creater_userid==sysUser.id}">
													<c:set var="creater" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${creater}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==DynamicBean}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>创建时间</label>
										</div>
										<div class="controls">
											<input type="text" readonly="readonly" class="readonly" size="30" value="${DynamicBean.create_date}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==DynamicBean}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改人</label>
										</div>
										<div class="controls">
											<c:forEach items="${sessionScope.system_user_key}" var="sysUser">
												<c:if test="${DynamicBean.modifier_userid==sysUser.id}">
													<c:set var="modifier" value="${sysUser.username}"></c:set>
												</c:if>
											</c:forEach>
											<input type="text" readonly="readonly" class="readonly" size="30" value="${modifier}"/>
										</div>
									</div>
									<div class="control-group" <c:if test="${null==DynamicBean}">style="display:none;"</c:if>>
										<div class="control-label">
											<label>修改时间</label>
										</div>
										<div class="controls">
											<input name="modifie_date" type="text" readonly="readonly" class="readonly" size="30" value="${DynamicBean.modifie_date}"/>
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