package com.psyssp.beans;

/**
 * 系统权限类
 * @author zj
 *
 */
public class SysRolesToPurview extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7222914558234421951L;
	private Integer id;
	private String roleno;
	private String menuno;
	private String funno;

	public SysRolesToPurview() {
	}

	public SysRolesToPurview(Integer id, String roleno, String menuno, String funno) {
		super();
		this.id = id;
		this.roleno = roleno;
		this.menuno = menuno;
		this.funno = funno;
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

	public String getMenuno() {
		return menuno;
	}

	public void setMenuno(String menuno) {
		this.menuno = menuno;
	}

	public String getFunno() {
		return funno;
	}

	public void setFunno(String funno) {
		this.funno = funno;
	}
}
