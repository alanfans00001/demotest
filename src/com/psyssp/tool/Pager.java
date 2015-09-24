package com.psyssp.tool;

import java.util.List;

@SuppressWarnings("unchecked")
public class Pager  implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int allRow; // 总的记录数
	private int totalPage; // 总的页数
	private int currentPage; // 当前页
	private int pageSize; // 一页有几个
	private String field;// 排序字段
	private String sort;// 怎样排序

	private List list;//

	/******* GET & SET *********/
	public int getAllRow() {
		return allRow;
	}

	public void setAllRow(int allRow) {
		this.allRow = allRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}
