package com.psyssp.beans;

/**
 * 系统菜单类
 * @author zj
 *
 */
public class SysMenu extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2952574295410719564L;
	private Integer id;
	private String menuno;
	private String menuname;
	private String fathermenuno;
	private String menutype;
	private String menuurl;
	private String allfunno;

	public SysMenu() {
	}

	public SysMenu(String menuno, String menuname, String fathermenuno, String menutype, String menuurl, String allfunno) {
		this.menuno = menuno;
		this.menuname = menuname;
		this.fathermenuno = fathermenuno;
		this.menutype = menutype;
		this.menuurl = menuurl;
		this.allfunno = allfunno;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMenuno() {
		return menuno;
	}

	public void setMenuno(String menuno) {
		this.menuno = menuno;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public String getFathermenuno() {
		return fathermenuno;
	}

	public void setFathermenuno(String fathermenuno) {
		this.fathermenuno = fathermenuno;
	}

	public String getMenutype() {
		return menutype;
	}

	public void setMenutype(String menutype) {
		this.menutype = menutype;
	}

	public String getMenuurl() {
		return menuurl;
	}

	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}

	public String getAllfunno() {
		return allfunno;
	}

	public void setAllfunno(String allfunno) {
		this.allfunno = allfunno;
	}

}
