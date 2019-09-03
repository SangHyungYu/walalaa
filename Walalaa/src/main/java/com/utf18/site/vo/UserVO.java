package com.utf18.site.vo;

public class UserVO {

	private String email;
	private String password;
	private String nickname;
	private int manage_warncount;
	private int apply;
	private String blacklist;
	private String operlist;
	private String subscribe;
	private String profile;
	private String bgimg;
	private String channelInfo;

	public String getChannelInfo() {
		return channelInfo;
	}

	public void setChannelInfo(String channelInfo) {
		this.channelInfo = channelInfo;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getBgimg() {
		return bgimg;
	}

	public void setBgimg(String bgimg) {
		this.bgimg = bgimg;
	}

	public int getApply() {
		return apply;
	}

	public void setApply(int apply) {
		this.apply = apply;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getManage_warncount() {
		return manage_warncount;
	}

	public void setManage_warncount(int manage_warncount) {
		this.manage_warncount = manage_warncount;
	}

	public String getBlacklist() {
		return blacklist;
	}

	public void setBlacklist(String blacklist) {
		this.blacklist = blacklist;
	}

	public String getOperlist() {
		return operlist;
	}

	public void setOperlist(String operlist) {
		this.operlist = operlist;
	}

	public String getSubscribe() {
		return subscribe;
	}

	public void setSubscribe(String subscribe) {
		this.subscribe = subscribe;
	}

	@Override
	public String toString() {
		return "UserVO [email=" + email + ", password=" + password + ", nickname=" + nickname + "]";
	}
}