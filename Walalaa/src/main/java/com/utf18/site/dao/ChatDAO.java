package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.dao.ChatDAO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.UserVO;

@Repository
public class ChatDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ChatDAO.";

	public ChatVO checkRoom(String name) throws Exception {
		return mybatis.selectOne(ns + "getRoom", name);
	}

	public ChatVO getChatOwner(String email) throws Exception {
		return mybatis.selectOne(ns + "getChatOwner", email);
	}

	public void createChatRoom(ChatVO vo) throws Exception {
		mybatis.insert(ns + "createChatRoom", vo);
	}

	public List<ChatVO> getRoomList() throws Exception {
		return mybatis.selectList(ns + "getRoomList");
	}

	public void updateChatCountInc(ChatVO vo) throws Exception {
		mybatis.update(ns + "updateChatCountInc", vo);
	}

	public void updateChatCountDec(ChatVO vo) throws Exception {
		mybatis.update(ns + "updateChatCountDec", vo);
	}

	public void deleteChat() throws Exception {
		mybatis.delete(ns + "deleteChat");
	}

	public List<ChatVO> searchRoomList(String name) throws Exception {
		return mybatis.selectList(ns + "searchRoomList", name);
	}

	public ChatVO getRoomInfo(String name) {
		return mybatis.selectOne(ns + "getRoomInfo", name);
	}

	public String getFilterword(String name) {
		return mybatis.selectOne(ns + "getFilterword", name);
	}

	public void updateBadwordStatus(String id) {
		mybatis.update(ns + "updateBadwordStatus", id);
	}

	public String getTime() {
		return mybatis.selectOne(ns + "getTime");
	}

	public void uploadChat(ChatVO vo) {
		mybatis.update(ns + "uploadChat", vo);
	}

	public ChatVO getRoomInfoNumber(int roomNum) {
		return mybatis.selectOne(ns + "getRoomInfoNumber", roomNum);
	}

	public List<ChatVO> getUploadList() {
		return mybatis.selectList(ns + "getUploadList");
	}

	public String getRoomOwner(String name) {
		return mybatis.selectOne(ns + "getRoomOwner", name);
	}

	public List<UserVO> getCnnctPPL(int num) {
		return mybatis.selectList(ns + "getCnnctPPL", num);
	}

	public UserVO getUsersInfo(String email) {
		return mybatis.selectOne(ns + "getUsersInfo", email);
	}

	public void updateBlackList(UserVO vo) {
		mybatis.update(ns + "updateBlackList", vo);
	}

	public void updateOperList(UserVO vo) {
		mybatis.update(ns + "updateOperList", vo);
	}

	public void incViews(String name) {
		mybatis.update(ns + "incViews", name);
	}

	public List<ChatVO> getTagList(String tag) {
		return mybatis.selectList(ns + "getTagList", tag);
	}

	public List<ChatVO> getMyUploadList(String email) {
		return mybatis.selectList(ns + "getMyUploadList", email);
	}

}