package com.utf18.site.vo;

public class Disc_wordVO {
	private int disc_num;
	private String add_word;
	private String iswhite;
	private int badword_num;

	public Disc_wordVO() {
	}

	public Disc_wordVO(int disc_num, String add_word, String iswhite, int badword_num) {
		this.disc_num = disc_num;
		this.add_word = add_word;
		this.iswhite = iswhite;
		this.badword_num = badword_num;
	}

	public int getDisc_num() {
		return disc_num;
	}

	public void setDisc_num(int disc_num) {
		this.disc_num = disc_num;
	}

	public String getAdd_word() {
		return add_word;
	}

	public void setAdd_word(String add_word) {
		this.add_word = add_word;
	}

	public String getIswhite() {
		return iswhite;
	}

	public void setIswhite(String iswhite) {
		this.iswhite = iswhite;
	}

	public int getBadword_num() {
		return badword_num;
	}

	public void setBadword_num(int badword_num) {
		this.badword_num = badword_num;
	}

}
