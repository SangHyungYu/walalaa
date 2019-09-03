package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;

@Repository
public class ChatMemberDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ChatMemberDAO.";

	public void addRoomMember(ChatMemberVO mem) throws Exception {
		mybatis.insert(ns + "addRoomMember", mem);
	}

	public ChatMemberVO getRoomMember(ChatMemberVO mem) throws Exception {
		return mybatis.selectOne(ns + "getRoomMember", mem);
	}

	public List<ChatMemberVO> sameRoomList(ChatMemberVO mem) throws Exception {
		return mybatis.selectList(ns + "sameRoomList", mem);
	}

	public void updateRoomMember(ChatMemberVO mem) throws Exception {
		mybatis.update(ns + "updateRoomMember", mem);
	}

	public void Nochat(ChatMemberVO mem) {
		mybatis.update(ns + "Nochat", mem);
	}

	public void deleteRoomMember(ChatMemberVO mem) throws Exception {
		mybatis.delete(ns + "deleteRoomMember", mem);
	}

	public ChatVO checkChatmember(String id) {
		return mybatis.selectOne(ns + "checkChatmember", id);
	}

	public void plusWarningCount(String name) {
		mybatis.update(ns + "plusWarningCount", name);
	}

	public int getWarningCount(String id) {
		return mybatis.selectOne(ns + "getWarningCount", id);
	}

	public void updateChatStatus(String id) {
		mybatis.update(ns + "updateChatStatus", id);
	}

	public String getChatStatus(String id) {
		return mybatis.selectOne(ns + "getChatStatus", id);
	}

	public void minusWarnCnt(String id) {
		mybatis.update(ns + "minusWarnCnt", id);
	}

	public void returnChatStatus(String id) {
		mybatis.update(ns + "returnChatStatus", id);
	}

	public void updateChatStatusNo(String id) {
		mybatis.update(ns + "updateChatStatusNo", id);
	}
}
