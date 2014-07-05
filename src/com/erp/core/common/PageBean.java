package com.erp.core.common;

import java.util.List;

public class PageBean {
	private int pageNo = 1;//当前页
	private int pageCount = 0;//分页数
	private int count = 10;//每页条数
	private String url;
	private List<?> list;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}

	public PageBean() {
	}

	public PageBean(int pageNo, int pageCount, int count, String url,
			List<?> list) {
		this.pageNo = pageNo;
		this.pageCount = pageCount;
		this.count = count;
		this.url = url;
		this.list = list;
	}

}
