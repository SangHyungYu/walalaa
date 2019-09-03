package com.utf18.site.vo;

public class BadwordVO {
	private int badword_num;
	private String badword;
	private String isgray;
	private int category_num;

	public BadwordVO() {
	}

	public BadwordVO(int badword_num, String badword, String isgray, int category_num) {
		this.badword_num = badword_num;
		this.badword = badword;
		this.isgray = isgray;
		this.category_num = category_num;
	}

	public int getBadword_num() {
		return badword_num;
	}

	public void setBadword_num(int badword_num) {
		this.badword_num = badword_num;
	}

	public String getBadword() {
		return badword;
	}

	public void setBadword(String badword) {
		this.badword = badword;
	}

	public String getIsgray() {
		return isgray;
	}

	public void setIsgray(String isgray) {
		this.isgray = isgray;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	@Override
	public String toString() {
		return "BadwordVO [badword_num=" + badword_num + ", badword=" + badword + ", isgray=" + isgray
				+ ", category_num=" + category_num + "]";
	}

}
