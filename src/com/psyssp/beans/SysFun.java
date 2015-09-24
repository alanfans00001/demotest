package com.psyssp.beans;

/**
 * 系统按钮类
 * @author zj
 *
 */
public class SysFun extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2343401074483023999L;
	private Integer id;
	private String funno;
	private String funvalue;
	private String funmethod;
	private String funid;
	private String funname;
	private String status;

	public SysFun() {
	}

	public SysFun(String funno, String funvalue, String funmethod, String funid, String funname, String status) {
		this.funno = funno;
		this.funvalue = funvalue;
		this.funmethod = funmethod;
		this.funid = funid;
		this.funname = funname;
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFunno() {
		return funno;
	}

	public void setFunno(String funno) {
		this.funno = funno;
	}

	public String getFunvalue() {
		return funvalue;
	}

	public void setFunvalue(String funvalue) {
		this.funvalue = funvalue;
	}

	public String getFunmethod() {
		return funmethod;
	}

	public void setFunmethod(String funmethod) {
		this.funmethod = funmethod;
	}

	public String getFunid() {
		return funid;
	}

	public void setFunid(String funid) {
		this.funid = funid;
	}

	public String getFunname() {
		return funname;
	}

	public void setFunname(String funname) {
		this.funname = funname;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
