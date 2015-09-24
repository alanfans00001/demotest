package com.psyssp.beans;

/**
 * 系统字典类
 * @author zj
 *
 */
public class SysWordbook extends DmModel implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 405010316716870057L;
	private Integer id;
	private String wordbookno;      //字典编号
	private String langno;			//字符编码类型
	private String typeno;			//字典类型
	private String contents;		//字典内容
	private String status; 			//字典状态
	

	public SysWordbook() {
	}
 
	public SysWordbook(Integer id, String wordbookno, String langno,
			String typeno, String contents, String status) {
		
		super();
		this.id = id;
		this.wordbookno = wordbookno;
		this.langno = langno;
		this.typeno = typeno;
		this.contents = contents;
		this.status = status;
		 
	}



	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWordbookno() {
		return wordbookno;
	}

	public void setWordbookno(String wordbookno) {
		this.wordbookno = wordbookno;
	}

	public String getLangno() {
		return langno;
	}

	public void setLangno(String langno) {
		this.langno = langno;
	}

	public String getTypeno() {
		return typeno;
	}

	public void setTypeno(String typeno) {
		this.typeno = typeno;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}