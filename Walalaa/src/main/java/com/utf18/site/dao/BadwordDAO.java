package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.BadwordVO;
import com.utf18.site.vo.Disc_wordVO;

@Repository
public class BadwordDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ChatFilter.";

	
	public List<BadwordVO> getExceptWord() {
		return mybatis.selectList(ns+"getExceptWord");
	}


	public List<Disc_wordVO> getAddword(String badword) {
		return mybatis.selectList(ns+"getAddword", badword);
	}
	 
}
