package com.utf18.site.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.utf18.site.vo.UserVO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void insert(UserVO vo) {
		mybatis.insert("UserDAO.insert", vo);
	}

	public UserVO getUserVO(UserVO vo) {
		return mybatis.selectOne("UserDAO.getUserVO", vo);
	}

	// 아이디 중복 확인
	public int idcheck(String string, String replace) {
		return mybatis.selectOne("UserDAO.idcheck", replace);
	}

	// 닉네임 중복 확인
	public int nicknamecheck(String nickname) {
		return mybatis.selectOne("UserDAO.nicknamecheck", nickname);
	}

	// 비번 일치하는지 확인
	public String checkPassword(String email) {
		return mybatis.selectOne("UserDAO.checkPassword", email);
	}

	public String getNickName(String email) {
		return mybatis.selectOne("UserDAO.getNickName", email);
	}

	// 사용자 '경고횟수' 설정
	public void setWarnCount(UserVO vo) {
		mybatis.update("UserDAO.setWarnCount", vo);
	}

	public int getLimitWarnCount(String email) {
		return mybatis.selectOne("UserDAO.limitWarnCount", email);
	}

	// 적용 0 => 유저가 작성한 비속어 리스트 채팅에 적용안함
	public void apply0(String email) {
		mybatis.update("UserDAO.apply0", email);
	}

	// 적용 1 => 유저가 작성한 비속어 리스트 채팅에 적용 함
	public void apply1(String email) {
		mybatis.update("UserDAO.apply1", email);
	}

	public String getApply(String email) {
		return mybatis.selectOne("UserDAO.getApply", email);
	}

	public void subscribe(UserVO vo) {
		mybatis.update("UserDAO.subscribe", vo);
	}

	public void uploadprofile(UserVO login) {
		mybatis.update("UserDAO.uploadprofile", login);
	}

	public void uploadbgimg(UserVO login) {
		mybatis.update("UserDAO.uploadbg", login);
	}

	// 채널 정보 입력(변경)
	public void changeChannelInfo(UserVO vo) {
		mybatis.update("UserDAO.changeChannelInfo", vo);
	}

	public UserVO getUserinfo(String nickname) {
		return mybatis.selectOne("UserDAO.getUserinfo", nickname);
	}

	public String getUserProfile(String nickname) {
		return mybatis.selectOne("UserDAO.getUserProfile", nickname);
	}

}
