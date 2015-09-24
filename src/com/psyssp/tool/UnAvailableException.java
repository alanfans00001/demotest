/*
 * Copyright © 2012 All Rights Reserved.
 */
package com.psyssp.tool;


/**
 * <pre>
 * [概要]
 *  系统简单异常处理。
 * 
 * [处理类容]
 *  
 * </pre>
 * 
 * @author KIWI
 * @version 2012//07/05 新规做成 
 * 
 */
public class UnAvailableException extends RuntimeException  {
	
	public static final long serialVersionUID = 1L;  

	public String info;

	public UnAvailableException(){
    }

    public UnAvailableException(Exception ex){
    	super(ex);
    }
    
    public UnAvailableException(String msg){
    	super(msg);
    	info = msg;
    }
    
    public UnAvailableException(Message msg,Exception ex){
    	super(ex);
    	info = msg.getMsg();
    }

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
}
