package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.CustomBadwordVO;

@Repository
public class CustomBadwordDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "CustomBadwordDAO.";

	// 사용자 지정 비속어 단어 추가
	public void addCustomBadword(CustomBadwordVO vo) {
		mybatis.insert(ns + "addCustomBadword", vo);
	}

	// 사용자 지정 비속어 단어 삭제
	public void deleteCustomBadword(CustomBadwordVO vo) {
		mybatis.delete(ns + "deleteCustomBadword", vo);
	}

	// 사용자가 추가한 비속어 단어리스트 가져오기
	public List<CustomBadwordVO> getCustomBadWordList(String email) throws Exception {
		return mybatis.selectList(ns + "getCustomBadWordList", email);
	}
}
