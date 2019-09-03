package com.utf18.site.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.VideoCommentVO;

@Repository
public class VideoCommentDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	private String ns = "VideoCommentDAO.";

	public void addComment(VideoCommentVO vo) {
		mybatis.insert(ns + "addComment", vo);
	}

	public List<VideoCommentVO> getCommentlist(int num) {
		return mybatis.selectList(ns + "getCommentlist", num);
	}

	public void delteComment(VideoCommentVO vo) {
		mybatis.delete(ns + "delteCommend", vo);
	}
}