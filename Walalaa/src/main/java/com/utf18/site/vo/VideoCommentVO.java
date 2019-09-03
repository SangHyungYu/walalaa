package com.utf18.site.vo;

public class VideoCommentVO {
	private int com_num;
	private int chatnum;
	private String email;
	private String content;
	private String time;

	// 조인문에 필요한 아이
	private String nickname;
	private String profile;

	public VideoCommentVO() {
	}

	public VideoCommentVO(int com_num, int chatnum, String email, String content, String time) {
		super();
		this.com_num = com_num;
		this.chatnum = chatnum;
		this.email = email;
		this.content = content;
		this.time = time;
	}

	public int getCom_num() {
		return com_num;
	}

	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}

	public int getChatnum() {
		return chatnum;
	}

	public void setChatnum(int chatnum) {
		this.chatnum = chatnum;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	@Override
	public String toString() {
		return "VideoCommentVO [com_num=" + com_num + ", chatnum=" + chatnum + ", email=" + email + ", content="
				+ content + ", time=" + time + "]";
	}

}