package com.utf18.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.BadwordDAO;
import com.utf18.site.dao.Disc_wordDAO;
import com.utf18.site.vo.BadwordVO;
import com.utf18.site.vo.Disc_wordVO;

@Service
public class ChatFilterService {
	@Autowired
	private BadwordDAO badwordDAO;
	@Autowired
	private Disc_wordDAO disc_wordDAO;

	public String checkexcept(String string) {

		List<BadwordVO> ExceptWord = badwordDAO.getExceptWord();
		String check = "";

		for (BadwordVO vo : ExceptWord) {
			if (string.contains(vo.getBadword())) {
				check =vo.getBadword();
			}
		}

		return check;
	}


	public List<Disc_wordVO> getAddWord(String exceptWord) {
		return badwordDAO.getAddword(exceptWord);
	}

}
