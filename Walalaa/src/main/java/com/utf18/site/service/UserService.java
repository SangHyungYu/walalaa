package com.utf18.site.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.utf18.site.dao.UserDAO;
import com.utf18.site.vo.UserVO;

@Service("userservice")
public class UserService {

	@Autowired
	private UserDAO dao;

	public void insertUser(UserVO vo) {
		dao.insert(vo);
	}

	public UserVO getUserVO(UserVO vo) {
		return dao.getUserVO(vo);
	}

	// 아이디 중복 확인
	public int CheckDuplication(String email) {
		int idCount = dao.idcheck("checkDuplicationId", email.replace("=", ""));
		return idCount;
	}

	// 닉네임 중복확인
	public int CheckNicknameDuplication(String nickname) {
		int nicknameCount = dao.nicknamecheck(nickname.replace("=", ""));
		return nicknameCount;
	}

	// 비번 일치하는지 확인
	public String checkPassword(String email) {
		String db_password = dao.checkPassword(email.replace("=", ""));
		return db_password;
	}

	public String getNickName(String owner) {
		return dao.getNickName(owner);
	}

	// 사용자 '경고횟수' 설정
	public void setWarnCount(UserVO vo) {
		dao.setWarnCount(vo);
	}

	public int getLimitWarnCount(String email) {
		return dao.getLimitWarnCount(email);
	}

	// 적용 0 => 유저가 작성한 비속어 리스트 채팅에 적용안함
	public void apply0(String email) {
		dao.apply0(email);
	}

	// 적용 1 => 유저가 작성한 비속어 리스트 채팅에 적용 함
	public void apply1(String email) {
		dao.apply1(email);
	}

	public String getApply(String email) {
		return dao.getApply(email);
	}

	public void subscribe(UserVO vo) {
		dao.subscribe(vo);
	}

	public void uploadprofile(UserVO login) {
		dao.uploadprofile(login);
	}

	public void uploadbgimg(UserVO login) {
		dao.uploadbgimg(login);
	}

	public void changeChannelInfo(UserVO vo) {
		dao.changeChannelInfo(vo);
	}

	public UserVO getUserinfo(String nickname) {
		return dao.getUserinfo(nickname);
	}

	public String getUserProfile(String nickname) {
		return dao.getUserProfile(nickname);
	}
}
