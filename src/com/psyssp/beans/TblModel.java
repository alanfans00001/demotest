package com.psyssp.beans;

public class TblModel implements java.io.Serializable{

	/**
	 * 2015年9月15日 上午10:48:39
	 * 
	 * @auther liuc
	 */
	private static final long serialVersionUID = -2934962669021810811L;

	//记录状态,0:有效,1:无效
	private String record_status;
	
    //数据创建者
	private Integer creater_userid;
	
	//数据修改者
	private Integer modifier_userid;
	
	//数据创建时间
	private String create_date;
	
	//数据修改时间
	private String modifie_date;
	

	public String getRecord_status() {
		return record_status;
	}

	public void setRecord_status(String record_status) {
		this.record_status = record_status;
	}

	public Integer getCreater_userid() {
		return creater_userid;
	}

	public void setCreater_userid(Integer creater_userid) {
		this.creater_userid = creater_userid;
	}

	public Integer getModifier_userid() {
		return modifier_userid;
	}

	public void setModifier_userid(Integer modifier_userid) {
		this.modifier_userid = modifier_userid;
	}

	public String getCreate_date() {
		return create_date;
	}

	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}

	public String getModifie_date() {
		return modifie_date;
	}

	public void setModifie_date(String modifie_date) {
		this.modifie_date = modifie_date;
	}

}
