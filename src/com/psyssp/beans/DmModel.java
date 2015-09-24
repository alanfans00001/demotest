package com.psyssp.beans;

/**
 * 基本实体类
 * @author zj
 *
 */
public abstract class DmModel implements java.io.Serializable {

	private static final long serialVersionUID = 4086584063866427495L;

	private String modifiedate;

	private String createdate;

	private String createrno;

	private String modifierno;
	
	private String forbiddendate;
	
	private String forbiddenerno;

	public String getForbiddendate() {
		return forbiddendate;
	}

	public void setForbiddendate(String forbiddendate) {
		this.forbiddendate = forbiddendate;
	}

	public String getForbiddenerno() {
		return forbiddenerno;
	}

	public void setForbiddenerno(String forbiddenerno) {
		this.forbiddenerno = forbiddenerno;
	}

	public String getModifiedate() {
		return modifiedate;
	}

	public String getCreatedate() {
		return createdate;
	}

	public void setModifiedate(String modifiedate) {
		this.modifiedate = modifiedate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

	public String getCreaterno() {
		return createrno;
	}

	public void setCreaterno(String createrno) {
		this.createrno = createrno;
	}

	public String getModifierno() {
		return modifierno;
	}

	public void setModifierno(String modifierno) {
		this.modifierno = modifierno;
	}
}
