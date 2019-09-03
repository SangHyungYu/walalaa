package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.ChatMemberDAO;
import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;

@Service
public class ChatMemberService {

	@Autowired
	ChatMemberDAO chatMemberDAO;

	public ChatVO checkChatmember(String email) throws Exception {
		return chatMemberDAO.checkChatmember(email.replace("=", ""));
	}

	public void addRoomMember(ChatMemberVO mem) throws Exception {
		chatMemberDAO.addRoomMember(mem);
	}

	public ChatMemberVO getRoomMember(ChatMemberVO mem) throws Exception {
		return chatMemberDAO.getRoomMember(mem);
	}

	public List<ChatMemberVO> sameRoomList(ChatMemberVO mem) throws Exception {
		return chatMemberDAO.sameRoomList(mem);
	}

	public void updateRoomMember(ChatMemberVO mem) throws Exception {
		chatMemberDAO.updateRoomMember(mem);
	}

	public void deleteRoomMember(ChatMemberVO mem) throws Exception {
		chatMemberDAO.deleteRoomMember(mem);
	}

	public void plusWarningCount(String name) {
		chatMemberDAO.plusWarningCount(name);
	}

	public int getWarningCount(String id) {
		return chatMemberDAO.getWarningCount(id);
	}

	public void updateChatStatus(String id) {
		chatMemberDAO.updateChatStatus(id);
	}

	public String getChatStatus(String id) {
		return chatMemberDAO.getChatStatus(id);
	}

	public void minusWarnCnt(String id) {
		chatMemberDAO.minusWarnCnt(id.replace("=", ""));
	}

	public void returnChatStatus(String id) {
		chatMemberDAO.returnChatStatus(id);
	}

	public void Nochat(ChatMemberVO mem) {
		chatMemberDAO.Nochat(mem);
	}

	public void updateChatStatusNo(String id) {
		chatMemberDAO.updateChatStatusNo(id);
	}
}
