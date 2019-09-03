package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.CustomBadwordDAO;
import com.utf18.site.vo.CustomBadwordVO;

@Service
public class CustomBadwordService {
	@Autowired
	private CustomBadwordDAO dao;

	// 사용자 지정 비속어 단어 추가
	public void addCustomBadword(CustomBadwordVO vo) {
		dao.addCustomBadword(vo);
	}

	// 사용자 지정 비속어 단어 삭제
	public void deleteCustomBadword(CustomBadwordVO vo) {
		dao.deleteCustomBadword(vo);
	}

	// 사용자가 추가한 비속어 단어리스트 가져오기
	public List<CustomBadwordVO> getWordList(String email) throws Exception {
		return dao.getCustomBadWordList(email);
	}

}
