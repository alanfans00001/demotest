package com.psyssp.tool;

public class Message  implements java.io.Serializable  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8569349072716765899L;

	private String msg;
	
	private String id;
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
