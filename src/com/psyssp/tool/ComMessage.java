package com.psyssp.tool;

import java.util.List;

/**
 * 名称：ComMessage.java<br>
 * 类描述: JSON异步返回数据实体类<br>
 * 
 * 
 */
public class ComMessage implements java.io.Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -8569349072716765899L;

	public static final String RESULT_SUCESS = "success";
	public static final String RESULT_FAIL = "fail";
	
	private List<Object> list = null;
	private String result;

	private String msg; // 提示信息

	private String id; // 消息编号

	private Object obj; // 其他信息

	
	public List<Object> getList() {
		return list;
	}

	public void setList(List<Object> list) {
		this.list = list;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

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

	public ComMessage() {
		result = RESULT_SUCESS;
	}
}
