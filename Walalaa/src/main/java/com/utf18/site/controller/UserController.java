package com.utf18.site.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.utf18.site.service.ChatService;
import com.utf18.site.service.UserService;
import com.utf18.site.vo.UserVO;

@Controller
public class UserController {
	// 유저 관련 컨트롤러 ( 로그인 / 회원가입 / 비밀번호 찾기 / 로그아웃)

	@Autowired
	private UserService userService;

	// 회원가입 - 아이디 중복 확인
	@RequestMapping(value = "duplicationIdCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String CheckDuplication(@RequestBody String email) {
		String checkRst;

		int idCnt = userService.CheckDuplication(email.replace("%40", "@"));
		if (idCnt > 0)
			checkRst = "F";
		else
			checkRst = "S";

		return checkRst;
	}

	// 회원가입 - 닉네임 중복 확인
	@RequestMapping(value = "duplicationNicknameCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String CheckNicknameDuplication(@RequestBody String nickname) {
		String checkRst;

		int nicknameCount = userService.CheckNicknameDuplication(nickname);
		if (nicknameCount > 0)
			checkRst = "F";
		else
			checkRst = "S";

		return checkRst;
	}

	// 회원가입 페이지 로딩
	@RequestMapping(value = "joinform.do", method = RequestMethod.GET)
	public String joinForm() {
		return "joinform";
	}

	// 로그인 화면 페이지 로딩
	@RequestMapping(value = "loginform.do", method = RequestMethod.GET)
	public String loginForm() {
		return "loginform";
	}

	// 회원가입 페이지 로딩 - 모바일 버전
	@RequestMapping(value = "joinform_m.do", method = RequestMethod.GET)
	public String joinForm_m() {
		return "joinform_m";
	}

	// 로그인 화면 페이지 로딩 - 모바일 버전
	@RequestMapping(value = "loginform_m.do", method = RequestMethod.GET)
	public String loginForm_m() {
		return "loginform_m";
	}

	// 회원가입 - 사용자 정보 디비에 등록
	@RequestMapping(value = "joininsert.do", method = RequestMethod.POST)
	public String insertUser(@ModelAttribute UserVO vo) {
		userService.insertUser(vo);
		return "loginform";
	}

	// 회원가입 - 사용자 정보 디비에 등록 - 모바일 버전
	@RequestMapping(value = "joininsert_m.do", method = RequestMethod.POST)
	public String insertUser_m(@ModelAttribute UserVO vo) {
		userService.insertUser(vo);
		return "loginform_m";
	}

	// 로그인 - 로그인 시도 시 화면 분개
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(UserVO vo, HttpSession session) {
		if (userService.getUserVO(vo) != null) {
			UserVO vo2 = userService.getUserVO(vo);
			if (vo2.getPassword().equals(vo.getPassword())) {
				session.setAttribute("login", vo2);
				return "main";
			} else {
				session.setAttribute("error", "");
				return "loginform";
			}
		} else {
			session.setAttribute("error", "");
			return "loginform";
		}
	}

	// 로그인 - 로그인 시도 시 화면 분개 - 모바일 버전
	@RequestMapping(value = "login_m.do", method = RequestMethod.POST)
	public String login_m(UserVO vo, HttpSession session) {
		if (userService.getUserVO(vo) != null) {
			UserVO vo2 = userService.getUserVO(vo);
			if (vo2.getPassword().equals(vo.getPassword())) {
				session.setAttribute("login", vo2);
				return "main_m";
			} else {
				session.setAttribute("error", "");
				return "loginform_m";
			}
		} else {
			session.setAttribute("error", "");
			return "loginform_m";
		}
	}

	// 로그인 -> 비밀번호 찾기 화면 로딩
	@RequestMapping("findpasswordform.do")
	public String findPWform() {
		return "findpassword";
	}

	// 비밀번호 찾기 - 비밀번호 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/findpw.do", method = RequestMethod.POST)
	public String findpw(@RequestParam(name = "email", required = true) String email) {
		UserVO vo = new UserVO();
		vo.setEmail(email);
		vo = userService.getUserVO(vo);
		return vo.getPassword();
	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		UserVO vo = new UserVO();
		session.setAttribute("login", vo);
		return "main";
	}

	// 비밀번호 찾기 - 비밀번호 일치하는지 확인
	@RequestMapping(value = "checkPassword.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkPassword(@RequestBody String email) {

		String getPassword = userService.checkPassword(email.replace("%40", "@"));

		return getPassword;
	}

}
