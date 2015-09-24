package com.psyssp.beans;

/**
 * 系统用户类
 * @author zj
 *
 */
public class SysUser extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8624711268262747341L;
	private Integer id;
	private String userno;
	private String username;
	private String password;
	private String email;
	private String roleno;
	private String status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRoleno() {
		return roleno;
	}

	public void setRoleno(String roleno) {
		this.roleno = roleno;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public SysUser() {
	}

	public SysUser(Integer id) {
		this.id = id;
	}
}
