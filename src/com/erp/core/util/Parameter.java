package com.erp.core.util;

public class Parameter {
	private int position;
	private String alias;
	private String name;
	private boolean defaultShow;

	public Parameter(int position, String name, String alias, boolean defaultShow) {
		super();
		this.position = position;
		this.name = name;
		this.alias = alias;
		this.defaultShow = defaultShow;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isDefaultShow() {
		return defaultShow;
	}

	public void setDefaultShow(boolean defaultShow) {
		this.defaultShow = defaultShow;
	}

}
