package com.psyssp.tool;

import java.io.Serializable;

public class PageInfo implements Serializable {

	private static final long serialVersionUID = 1L;
	private int showCount = 0; // 每页显示多少条
	private int totalPage; // 总页数
	private int totalResult; // 总记录数
	private int currentPage; // 当前页

	public int getShowCount() {
		return showCount;
	}

	public void setShowCount(int showCount) {
		this.showCount = showCount;
	}

	public int getTotalPage() {
		totalPage = (totalResult + showCount - 1) / showCount;
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalResult() {
		return totalResult;
	}

	public void setTotalResult(int totalResult) {
		this.totalResult = totalResult;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getCurrentResult() {
		// 计算从第几条获取数据
		currentResult = (currentPage - 1) * showCount;
		return currentResult;
	}

	public void setCurrentResult(int currentResult) {
		this.currentResult = currentResult;
	}

	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	private int currentResult;

	private String sortField;
	private String order;
}
