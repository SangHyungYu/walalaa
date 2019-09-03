package com.utf18.site.vo;

import java.io.Serializable;
import java.util.ArrayList;

/*
CREATE TABLE CHAT(
    NUM NUMBER(20) PRIMARY KEY,
    NAME VARCHAR2(500) NOT NULL,
    PWD VARCHAR2(500),
    TOTALCOUNT NUMBER(3) NOT NULL,
    REMAINCOUNT NUMBER(3) NOT NULL,
    CONTENT VARCHAR2(4000) NOT NULL
);

CREATE SEQUENCE CHAT_SEQ
START WITH 1 INCREMENT BY 1;
 */
public class ChatVO implements Serializable {

	private static final long serialVersionUID = 8087582886569691632L;

	private int num; // 방번호
	private String name; // 방이름
	private String filterword; // 금지어 목록
	private int totalcount; // 접속자제한수
	private int remaincount; // 남은사람수
	private String content; // 내용
	private String owner; // 방 생성하는 사람
	private String thumbnail; // 섬네일 저장위치 url
	private int views; // 조회수
	private String uploadtime; // 방송 시작시간
	private String usersNickname; // 유저 닉네임 조인전용
	private String tag;
	private ArrayList<String> chatlog;
	private String profile; // 섬네일 저장위치 url

	public ChatVO() {
	}

	public ChatVO(int num, String name, String filterword, int totalcount, int remaincount, String content) {
		this.num = num;
		this.name = name;
		this.filterword = filterword;
		this.totalcount = totalcount;
		this.remaincount = remaincount;
		this.content = content;
	}

	public String getUsersNickname() {
		return usersNickname;
	}

	public void setUsersNickname(String usersNickname) {
		this.usersNickname = usersNickname;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFilterword() {
		return filterword;
	}

	public void setFilterword(String filterword) {
		this.filterword = filterword;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public int getRemaincount() {
		return remaincount;
	}

	public void setRemaincount(int remaincount) {
		this.remaincount = remaincount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public ArrayList<String> getChatlog() {
		return chatlog;
	}

	public void setChatlog(ArrayList<String> chatlog) {
		this.chatlog = chatlog;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	@Override
	public String toString() {
		return "ChatVO [num=" + num + ", name=" + name + ", filterword=" + filterword + ", totalcount=" + totalcount
				+ ", remaincount=" + remaincount + ", content=" + content + ", owner=" + owner + ", thumbnail="
				+ thumbnail + ", views=" + views + ", uploadtime=" + uploadtime + ", usersNickname=" + usersNickname
				+ ", tag=" + tag + ", chatlog=" + chatlog + ", profile=" + profile + "]";
	}

}