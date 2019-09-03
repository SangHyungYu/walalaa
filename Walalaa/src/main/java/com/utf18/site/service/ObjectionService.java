package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.ObjectionDAO;
import com.utf18.site.vo.ObjectionVO;

@Service
public class ObjectionService {
	@Autowired
	ObjectionDAO objectionDAO;

	public void insertObj(ObjectionVO vo) {
		objectionDAO.insertObj(vo);
	}

	public List<ObjectionVO> getObj(int chatnum) {
		return objectionDAO.getObj(chatnum);
	}

	public List<ObjectionVO> getObjList(int chatnum) {
		return objectionDAO.getObjList(chatnum);
	}

	public void objAccept(int objnum) {
		objectionDAO.objAccept(objnum);
	}

	public void objReject(int objnum) {
		objectionDAO.objReject(objnum);
	}

	public String getObjNum(int objnum) {
		return objectionDAO.getObjNum(objnum);
	}

}
