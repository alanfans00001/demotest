package com.psyssp.beans;

public class TblVariable extends TblModel {

	/**
	 * 2015年9月15日 上午10:54:42
	 * 
	 * @auther liuc
	 */
	private static final long serialVersionUID = 263475556451002647L;
	
	
	private Integer variable_id;   //变量标识
	private String variable_name; //变量名称
	private Integer variable_type; //变量类型,1:文本框,2:下拉框,3:多选框,4:日期选择器,5:时间选择器
	private String variable_style;//
	private String variable_desc; //文字描述
	private Integer variable_index; //变量排序索引
	private String variable_txtwatermark; //文本框水印
	private String variable_linkage; //是否联动下级下拉选项,0:联动,1:不联动
	private String variable_linkage_variable_name; //联动下级下拉变量标识
	private Long variable_required; //是否必输项,0:必输,1:不必输
	private String variable_requiredmsg; //必输项提示信息
	private Long variable_vaild; //是否校验格式,0:校验,1:不校验(正则表达式)
	private String variable_vaildstr; //校验正则表达式字符串
	private String variable_vaildmsg; //格式校验提示信息
	public Integer getVariable_id() {
		return variable_id;
	}
	public void setVariable_id(Integer variable_id) {
		this.variable_id = variable_id;
	}
	public String getVariable_name() {
		return variable_name;
	}
	public String getVariable_style() {
		return variable_style;
	}
	public void setVariable_style(String variable_style) {
		this.variable_style = variable_style;
	}
	public void setVariable_name(String variable_name) {
		this.variable_name = variable_name;
	}
	public String getVariable_desc() {
		return variable_desc;
	}
	public void setVariable_desc(String variable_desc) {
		this.variable_desc = variable_desc;
	}
	public Integer getVariable_index() {
		return variable_index;
	}
	public void setVariable_index(Integer variable_index) {
		this.variable_index = variable_index;
	}
	public String getVariable_txtwatermark() {
		return variable_txtwatermark;
	}
	public void setVariable_txtwatermark(String variable_txtwatermark) {
		this.variable_txtwatermark = variable_txtwatermark;
	}
	public String getVariable_linkage_variable_name() {
		return variable_linkage_variable_name;
	}
	public void setVariable_linkage_variable_name(
			String variable_linkage_variable_name) {
		this.variable_linkage_variable_name = variable_linkage_variable_name;
	}
	public String getVariable_requiredmsg() {
		return variable_requiredmsg;
	}
	public void setVariable_requiredmsg(String variable_requiredmsg) {
		this.variable_requiredmsg = variable_requiredmsg;
	}
	public Long getVariable_vaild() {
		return variable_vaild;
	}
	public void setVariable_vaild(Long variable_vaild) {
		this.variable_vaild = variable_vaild;
	}
	public String getVariable_vaildstr() {
		return variable_vaildstr;
	}
	public void setVariable_vaildstr(String variable_vaildstr) {
		this.variable_vaildstr = variable_vaildstr;
	}
	public String getVariable_vaildmsg() {
		return variable_vaildmsg;
	}
	public void setVariable_vaildmsg(String variable_vaildmsg) {
		this.variable_vaildmsg = variable_vaildmsg;
	}
	
	public Integer getVariable_type() {
		return variable_type;
	}
	public void setVariable_type(Integer variable_type) {
		this.variable_type = variable_type;
	}
	public String getVariable_linkage() {
		return variable_linkage;
	}
	public void setVariable_linkage( String variable_linkage) {
		this.variable_linkage = variable_linkage;
	}
	public Long getVariable_required() {
		return variable_required;	
	}
	public void setVariable_required(Long variable_required) {
		this.variable_required = variable_required;
	}
	
	
	public TblVariable(Integer variable_id, String variable_name,
			Integer variable_type, String variable_style, String variable_desc,
			Integer variable_index, String variable_txtwatermark,
			String variable_linkage, String variable_linkage_variable_name,
			Long variable_required, String variable_requiredmsg,
			Long variable_vaild, String variable_vaildstr,
			String variable_vaildmsg) {
		super();
		this.variable_id = variable_id;
		this.variable_name = variable_name;
		this.variable_type = variable_type;
		this.variable_style = variable_style;
		this.variable_desc = variable_desc;
		this.variable_index = variable_index;
		this.variable_txtwatermark = variable_txtwatermark;
		this.variable_linkage = variable_linkage;
		this.variable_linkage_variable_name = variable_linkage_variable_name;
		this.variable_required = variable_required;
		this.variable_requiredmsg = variable_requiredmsg;
		this.variable_vaild = variable_vaild;
		this.variable_vaildstr = variable_vaildstr;
		this.variable_vaildmsg = variable_vaildmsg;
	}
	public TblVariable() {
		super();
		// TODO Auto-generated constructor stub
	}
}
