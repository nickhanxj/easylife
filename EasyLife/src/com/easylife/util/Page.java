package com.easylife.util;

import java.util.List;

/**
 * 分页对象
 * @author john
 *
 * @param <T>
 */
public class Page<T> {
	private int currentPage;//当前页
	private int pageSize;//每页条数
	private int totalRow;//查询到的总记录数
	private List<T> rows;//查询到的对象集合
	private boolean isFirstPage;//是否是第一页
	private boolean isLastPage;//是否是最后一夜
	private String customizedHql;//使用者自定义hql 如果使用者不设置，则默认查询所有记录（不带任何条件）
	private int totalPage;//查询到的记录的总页数，根据pagesize和totalRow计算出来

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

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public boolean isFirstPage() {
		return isFirstPage;
	}

	public void setFirstPage(boolean isFirstPage) {
		this.isFirstPage = isFirstPage;
	}

	public boolean isLastPage() {
		return isLastPage;
	}

	public void setLastPage(boolean isLastPage) {
		this.isLastPage = isLastPage;
	}

	public String getCustomizedHql() {
		return customizedHql;
	}

	public void setCustomizedHql(String customizedHql) {
		this.customizedHql = customizedHql;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", pageSize=" + pageSize
				+ ", totalRow=" + totalRow + ", rows=" + rows
				+ ", isFirstPage=" + isFirstPage + ", isLastPage=" + isLastPage
				+ ", customizedHql=" + customizedHql + ", totalPage="
				+ totalPage + "]";
	}

}
