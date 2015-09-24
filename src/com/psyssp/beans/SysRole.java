package com.psyssp.beans;

/**
 * 系统角色类
 * @author zj
 *
 */
public class SysRole extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4966749486524890505L;
	private Integer id;
	private String roleno;
	private String rolename;

	public SysRole() {
	}

	public SysRole(String roleno, String rolename) {
		this.roleno = roleno;
		this.rolename = rolename;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleno() {
		return roleno;
	}

	public void setRoleno(String roleno) {
		this.roleno = roleno;
	}

	public String getRolename() {
		return rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

}
