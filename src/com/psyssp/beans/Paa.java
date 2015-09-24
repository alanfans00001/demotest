package com.psyssp.beans;

/**
 * P代表存储过程
 * aa代表存储过程名
 * 2015年9月17日 下午1:44:58
 * Paa这个是测试用
 * @auther liuc
 */
public class Paa extends TblModel {
	
	/**
	 * 2015年9月17日 下午1:44:48
	 * 
	 * @auther liuc
	 */
	private static final long serialVersionUID = 3058396750246036514L;
	private String columnA;
	private String B1;
	private String B2;
	private String B3;
	private String B4;
	public String getColumnA() {
		return columnA;
	}
	public void setColumnA(String columnA) {
		this.columnA = columnA;
	}
	public String getB1() {
		return B1;
	}
	public void setB1(String b1) {
		B1 = b1;
	}
	public String getB2() {
		return B2;
	}
	public void setB2(String b2) {
		B2 = b2;
	}
	public String getB3() {
		return B3;
	}
	public void setB3(String b3) {
		B3 = b3;
	}
	public String getB4() {
		return B4;
	}
	public void setB4(String b4) {
		B4 = b4;
	}
	public Paa() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Paa(String columnA, String b1, String b2, String b3, String b4) {
		super();
		this.columnA = columnA;
		B1 = b1;
		B2 = b2;
		B3 = b3;
		B4 = b4;
	}
	
	

}
