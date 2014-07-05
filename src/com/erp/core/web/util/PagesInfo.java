package com.erp.core.web.util;

/*
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */

import javax.persistence.Entity;

/**
 * @author Administrator
 * 翻页信息显示
 */
@Entity
public class PagesInfo {
	private String pageinfo;

	/**
	 * @return 返回 pageinfo。
	 */
	public String getPageinfo() {
		return pageinfo;
	}
	/**
	 * @param pageinfo 要设置的 pageinfo。
	 */
	public void setPageinfo(String pageinfo) {
		this.pageinfo = pageinfo;
	}
}
