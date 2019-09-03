package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.VideoCommentDAO;
import com.utf18.site.vo.VideoCommentVO;

@Service
public class VideoCommentService {
	@Autowired
	VideoCommentDAO commentDAO;

	public void addComment(VideoCommentVO vo) {
		commentDAO.addComment(vo);

	}

	public List<VideoCommentVO> getCommentList(int num) {
		return commentDAO.getCommentlist(num);
	}

	public void deleteComment(VideoCommentVO vo) {
		commentDAO.delteComment(vo);
	}

}