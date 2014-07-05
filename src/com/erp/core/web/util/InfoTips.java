package com.erp.core.web.util;


import javax.persistence.Entity;

@Entity
public class InfoTips {
	private String tipsInfo;

	/**
	 * @return 返回 tipsInfo。
	 */
	public String getTipsInfo() {
		return tipsInfo;
	}
	/**
	 * @param tipsInfo 要设置的 tipsInfo。
	 */
	public void setTipsInfo(String tipsInfo) {
		this.tipsInfo = tipsInfo;
	}
}
