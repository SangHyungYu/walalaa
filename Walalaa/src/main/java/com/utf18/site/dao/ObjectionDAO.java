package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.ObjectionVO;

@Repository
public class ObjectionDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "ObjectionDAO.";

	public void insertObj(ObjectionVO vo) {
		mybatis.insert(ns + "insertObj", vo);
	}

	public List<ObjectionVO> getObj(int chatnum) {
		return mybatis.selectList(ns + "getObj", chatnum);
	}

	public List<ObjectionVO> getObjList(int chatnum) {
		return mybatis.selectList(ns + "getObjList", chatnum);
	}

	public void objAccept(int objnum) {
		mybatis.update(ns + "objAccept", objnum);
	}

	public void objReject(int objnum) {
		mybatis.update(ns + "objReject", objnum);
	}

	public String getObjNum(int objnum) {
		return mybatis.selectOne(ns + "getObjNum", objnum);
	}

}
