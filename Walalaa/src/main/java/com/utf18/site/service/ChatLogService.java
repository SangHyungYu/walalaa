package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.ChatLogDAO;
import com.utf18.site.vo.ChatLogVO;

@Service
public class ChatLogService {
	@Autowired
	private ChatLogDAO chatLogDAO;

	public void addChatLog(ChatLogVO vo) throws Exception {
		chatLogDAO.addChatLog(vo);
	}

	public List<ChatLogVO> getChatLog(int num) {
		return chatLogDAO.getChatLog(num);
	}

	public List<ChatLogVO> getUploadedDataInfo(int num) {
		return chatLogDAO.getUploadedDataInfo(num);
	}
}
