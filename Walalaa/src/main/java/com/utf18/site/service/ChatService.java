package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.ChatDAO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.UserVO;

@Service
public class ChatService {
	@Autowired
	ChatDAO chatDAO;

	public ChatVO checkRoom(String name) throws Exception {
		return chatDAO.checkRoom(name);
	}

	public ChatVO getChatOwner(String email) throws Exception {
		return chatDAO.getChatOwner(email.replace("=", ""));
	}

	public void createChatRoom(ChatVO vo) throws Exception {
		chatDAO.createChatRoom(vo);
	}

	public List<ChatVO> getRoomList() throws Exception {
		return chatDAO.getRoomList();
	}

	public void updateChatCountInc(ChatVO vo) throws Exception {
		chatDAO.updateChatCountInc(vo);
	}

	public void updateChatCountDec(ChatVO vo) throws Exception {
		chatDAO.updateChatCountDec(vo);
	}

	public void deleteChat() throws Exception {
		chatDAO.deleteChat();
	}

	public List<ChatVO> searchRoomList(String name) throws Exception {
		return chatDAO.searchRoomList(name);
	}

	public ChatVO getRoomInfo(String name) throws Exception {
		return chatDAO.getRoomInfo(name);
	}

	public String getFilterword(String name) {
		return chatDAO.getFilterword(name);
	}

	public void updateBadwordStatus(String id) {
		chatDAO.updateBadwordStatus(id);
	}

	public String getTime() {
		return chatDAO.getTime();
	}

	public String replaceLast(String string, String toReplace, String replacement) {
		int pos = string.lastIndexOf(toReplace);
		if (pos > -1) {
			return string.substring(0, pos) + replacement + string.substring(pos + toReplace.length(), string.length());
		} else {
			return string;
		}
	}

	public void uploadChat(ChatVO vo) {
		chatDAO.uploadChat(vo);
	}

	public ChatVO getRoomInfoNumber(int roomNum) {
		return chatDAO.getRoomInfoNumber(roomNum);
	}

	public List<ChatVO> getUploadList() {
		return chatDAO.getUploadList();
	}

	public String getRoomOwner(String name) {
		return chatDAO.getRoomOwner(name);
	}

	public List<UserVO> getCnnctPPL(int num) {
		return chatDAO.getCnnctPPL(num);
	}

	public UserVO getUsersInfo(String email) {
		return chatDAO.getUsersInfo(email);
	}

	public void updateBlackList(UserVO vo) {
		chatDAO.updateBlackList(vo);
	}

	public void updateOperList(UserVO vo) {
		chatDAO.updateOperList(vo);
	}

	public void incViews(String roomName) {
		chatDAO.incViews(roomName);
	}

	// 검색 기능
	public List<ChatVO> getTagList(String tag) {
		return chatDAO.getTagList(tag);
	}

	public List<ChatVO> getMyUploadList(String email) {
		return chatDAO.getMyUploadList(email);
	}

}