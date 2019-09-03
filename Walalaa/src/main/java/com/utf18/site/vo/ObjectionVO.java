package com.utf18.site.vo;

public class ObjectionVO {
	private int objnum;
	private int chatnum;
	private String id;
	private String content;
	private String approv_state;
	private String time;

	private String usersNickname;
	private String chatmemChatstatus;
	private int chatmemWarningCount;

	public ObjectionVO() {
	}

	public ObjectionVO(int chatnum, String id, String content) {
		this.chatnum = chatnum;
		this.id = id;
		this.content = content;
	}

	public int getChatnum() {
		return chatnum;
	}

	public void setChatnum(int chatnum) {
		this.chatnum = chatnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getApprov_state() {
		return approv_state;
	}

	public void setApprov_state(String approv_state) {
		this.approv_state = approv_state;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUsersNickname() {
		return usersNickname;
	}

	public void setUsersNickname(String usersNickname) {
		this.usersNickname = usersNickname;
	}

	public String getChatmemChatstatus() {
		return chatmemChatstatus;
	}

	public void setChatmemChatstatus(String chatmemChatstatus) {
		this.chatmemChatstatus = chatmemChatstatus;
	}

	public int getChatmemWarningCount() {
		return chatmemWarningCount;
	}

	public void setChatmemWarningCount(int chatmemWarningCount) {
		this.chatmemWarningCount = chatmemWarningCount;
	}

	public int getObjnum() {
		return objnum;
	}

	public void setObjnum(int objnum) {
		this.objnum = objnum;
	}

	@Override
	public String toString() {
		return "ObjectionVO [objnum=" + objnum + ", chatnum=" + chatnum + ", id=" + id + ", content=" + content
				+ ", approv_state=" + approv_state + ", time=" + time + ", usersNickname=" + usersNickname
				+ ", chatmemChatstatus=" + chatmemChatstatus + ", chatmemWarningCount=" + chatmemWarningCount + "]";
	}

}