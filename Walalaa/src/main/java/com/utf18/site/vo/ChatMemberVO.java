package com.utf18.site.vo;

import java.io.Serializable;

/*
CREATE TABLE CHATMEMBER(
    NUM NUMBER(20) PRIMARY KEY,
    ID VARCHAR2(500) NOT NULL,
    ROOM VARCHAR2(500) NOT NULL,
    PRIROOM VARCHAR2(500) NOT NULL
);
   
CREATE SEQUENCE CHAT_MEMBER_SEQ
START WITH 1 INCREMENT BY 1;
*/
public class ChatMemberVO implements Serializable {
	private static final long serialVersionUID = 7836583867839190158L;

	private int num;

	private String id;
	private String room;
	private String priroom;
	private int warningCnt;

	public ChatMemberVO() {
	}

	public ChatMemberVO(int num, String id, String room, String priroom, int warningCnt) {
		this.num = num;
		this.id = id;
		this.room = room;
		this.priroom = priroom;
		this.warningCnt = warningCnt;
	}

	public ChatMemberVO(int num, String id, String room, String priroom) {

		this.num = num;
		this.id = id;
		this.room = room;
		this.priroom = priroom;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getPriroom() {
		return priroom;
	}

	public void setPriroom(String priroom) {
		this.priroom = priroom;
	}

	public int getWarningCnt() {
		return warningCnt;
	}

	public void setWarningCnt(int warningCnt) {
		this.warningCnt = warningCnt;
	}

	@Override
	public String toString() {
		return "ChatMemberVO [num=" + num + ", id=" + id + ", room=" + room + ", priroom=" + priroom + ", warningCnt="
				+ warningCnt + "]";
	}
}
