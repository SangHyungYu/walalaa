package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.ChatLogVO;

@Repository
public class ChatLogDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ChatLogDAO.";

	public void addChatLog(ChatLogVO vo) throws Exception {
		mybatis.insert(ns + "addChatLog", vo);
	}

	public List<ChatLogVO> getChatLog(int num) {
		return mybatis.selectList(ns + "getChatLog", num);
	}

	public List<ChatLogVO> getUploadedDataInfo(int num) {
		return mybatis.selectList(ns + "getUploadedDataInfo", num);
	}
}
