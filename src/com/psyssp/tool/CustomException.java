package com.psyssp.tool;

public class CustomException extends Exception {
	/**
	 * 自定义异常
	 */
	private static final long serialVersionUID = 1L;
	private int code;
	private String msg;
	public CustomException() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CustomException(int code,String msg){
		this.code=code;
		this.msg=msg;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
