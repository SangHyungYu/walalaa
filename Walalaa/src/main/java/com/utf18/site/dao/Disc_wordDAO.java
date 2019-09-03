package com.utf18.site.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Disc_wordDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ChatFilter.";
	
}
