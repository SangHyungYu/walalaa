package com.utf18.site.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.utf18.site.service.ChatMemberService;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.CustomBadwordService;
import com.utf18.site.service.UserService;
import com.utf18.site.service.ObjectionService;
import com.utf18.site.util.WebSocket;
import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.CustomBadwordVO;
import com.utf18.site.vo.UserVO;

@Controller
public class ManageController {
	// 방송 관리자 관련 컨트롤러

	@Autowired
	private UserService userService;

	@Autowired
	private ChatService chatService;

	@Autowired
	private ChatMemberService chatMemberService;

	@Autowired
	private CustomBadwordService customBadwordService;

	@Autowired
	private ObjectionService ObjectionService;

	// 방송 관리자 설정 페이지 로딩
	@RequestMapping(value = "manage.do", method = RequestMethod.GET)
	public String manage(Model model, int roomNum) {
		ChatVO vo = chatService.getRoomInfoNumber(roomNum);
		String roomName = vo.getName();

		String StartTime = vo.getUploadtime().substring(11, 18);
		model.addAttribute("broadcastStartTime", StartTime);
		System.out.println(StartTime);

		model.addAttribute("roomNum", roomNum);
		model.addAttribute("roomName", roomName);
		return "manage";
	}

	// 이의제기 신청 목록 - 이의제기 승인 처리
	@ResponseBody
	@RequestMapping(value = "/objAccept.do", method = RequestMethod.POST)
	public void objAccept(@RequestParam(name = "objnum", required = true) int objnum) throws Exception {

		ObjectionService.objAccept(objnum);

		String id = ObjectionService.getObjNum(objnum);
		chatMemberService.minusWarnCnt(id);

		int warnCnt = chatMemberService.getWarningCount(id);

		if (warnCnt < 3) {
			chatMemberService.returnChatStatus(id);
		}
	}

	// 이의제기 신청 목록 - 이의제기 거부 처리
	@ResponseBody
	@RequestMapping(value = "objReject.do", method = RequestMethod.POST)
	public void objReject(@RequestParam(name = "objnum", required = true) int objnum) throws Exception {
		ObjectionService.objReject(objnum);
	}

	// 사용자 관리 - 유저 채팅 다시보기
	@RequestMapping(value = "manage_user_chatting.do", method = RequestMethod.GET)
	public String manage_user_chatting() {
		return "manage_include/manage_user_chatting";
	}

	// 비속어 단어 관리 - 사용자 지정 비속어 단어 삭제
	@RequestMapping(value = "deleteCustomBadword.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void deleteCustomBadword(int num) {

		CustomBadwordVO vo = new CustomBadwordVO();
		vo.setNum(num);

		customBadwordService.deleteCustomBadword(vo);
	}

	// 비속어 단어 관리 - 사용자가 추가한 비속어 단어리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getCustomBadwordList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<CustomBadwordVO> getWordList(@RequestParam(name = "email", required = true) String email)
			throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");
		List<CustomBadwordVO> badWordList = customBadwordService.getWordList(email);
		return badWordList;
	}

	// 비속어 단어 관리 - 사용자 지정 비속어 단어 추가
	@RequestMapping(value = "addCustomBadword.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void addCustomBadword(String email, String content) {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		CustomBadwordVO vo = new CustomBadwordVO();

		vo.setEmail(email);
		vo.setContent(content);

		customBadwordService.addCustomBadword(vo);
	}

	// 사용자 관리 - 현재 접속 중인 사용자 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "/getCnntPPL.do", method = RequestMethod.POST)
	public List<UserVO> getCnntPPL(@RequestParam(name = "num", required = true) int num) throws Exception {
		List<UserVO> userVOs = chatService.getCnnctPPL(num);
		return userVOs;
	}

	// 사용자 관리 (사용자 채팅모아보기) - 사용자 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/getUserInfo.do", method = RequestMethod.POST)
	public UserVO getUserInfo(@RequestParam(name = "id", required = true) String id) throws Exception {
		UserVO userVO = chatService.getUsersInfo(id);
		return userVO;
	}

	// 사용자 관리 - 선택된 블랙리스트 리스트에서 지우기
	@ResponseBody
	@RequestMapping(value = "/delBlackList.do", method = RequestMethod.POST)
	public void delBlackList(@RequestParam(name = "email", required = true) String email,
			@RequestParam(name = "delBList", required = true) String delBList) throws Exception {
		UserVO userVO = chatService.getUsersInfo(email);
		String BList = userVO.getBlacklist();
		String afterDelstr = BList.replaceAll(delBList + "&/&", "");
		userVO.setBlacklist(afterDelstr);
		chatService.updateBlackList(userVO);
	}

	// 사용자 관리 - 선택된 운영자 리스트에서 지우기
	@ResponseBody
	@RequestMapping(value = "/delOperList.do", method = RequestMethod.POST)
	public void delOperList(@RequestParam(name = "email", required = true) String email,
			@RequestParam(name = "delOList", required = true) String delOList) throws Exception {
		UserVO userVO = chatService.getUsersInfo(email);
		String OList = userVO.getOperlist();
		String afterDelstr = OList.replaceAll(delOList + "&/&", "");
		userVO.setOperlist(afterDelstr);
		chatService.updateOperList(userVO);
	}

	// 사용자 관리 - 선택된 유저 블랙리스트/운영자 리스트에 추가 (2번 사용)
	@ResponseBody
	@RequestMapping(value = "/listupdate.do", method = RequestMethod.POST)
	public void listupdate(@RequestParam(name = "email", required = true) String email,
			@RequestParam(name = "value", required = true) String value,
			@RequestParam(name = "num", required = true) int num) throws Exception {
		String addList = email + "&/&";
		ChatVO chatVO = chatService.getRoomInfoNumber(num);
		UserVO userVO = chatService.getUsersInfo(chatVO.getOwner());

		if (value.equals("black")) {
			String BList = userVO.getBlacklist();
			String afterAddstr = BList + addList;
			userVO.setBlacklist(afterAddstr);
			chatService.updateBlackList(userVO);
		}
		if (value.equals("oper")) {
			String OList = userVO.getOperlist();
			String afterAddstr = OList + addList;
			userVO.setOperlist(afterAddstr);
			chatService.updateOperList(userVO);
		}
	}

	// 사용자 관리 (채팅 모아보기) - 강제로 채팅 금지 시키기
	@ResponseBody
	@RequestMapping(value = "/Nochat.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void nochat(@RequestParam(name = "email", required = true) String email) throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(email);

		mem = chatMemberService.getRoomMember(mem);
		ChatVO chatVO = chatService.getRoomInfo(mem.getRoom());
		int limitwarncount = userService.getLimitWarnCount(chatVO.getOwner());
		mem.setWarningCnt(limitwarncount);
		//chatMemberService.Nochat(mem);
		// 강제 채금으로 인해 broadcast창에서 문구 변화를 위함
		chatMemberService.updateChatStatusNo(email);
	}

	// 사용자 관리 - 블랙리스트 유저 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "/getBlackListUser.do", method = RequestMethod.POST)
	public List<UserVO> getBlackListUser(@RequestParam(name = "id", required = true) String id) throws Exception {
		UserVO userVO = chatService.getUsersInfo(id);

		String bnick = "";
		bnick = userVO.getBlacklist();
		bnick = bnick.substring(7);
		List<UserVO> nickblackList = new ArrayList<>();
		String[] blackLists = bnick.split("&/&");
		for (String str : blackLists) {
			UserVO vo = new UserVO();
			vo.setEmail(str);
			vo = userService.getUserVO(vo);

			nickblackList.add(vo);
		}
		return nickblackList;
	}

	// 사용자 관리 - 운영자리스트 유저 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "/getOperListUser.do", method = RequestMethod.POST)
	public List<UserVO> getOperListUser(@RequestParam(name = "id", required = true) String id) throws Exception {
		UserVO userVO = chatService.getUsersInfo(id);

		String bnick = "";
		bnick = userVO.getOperlist();
		bnick = bnick.substring(6);
		List<UserVO> nickblackList = new ArrayList<>();
		String[] blackLists = bnick.split("&/&");
		for (String str : blackLists) {
			UserVO vo = new UserVO();
			vo.setEmail(str);
			vo = userService.getUserVO(vo);

			nickblackList.add(vo);
		}
		return nickblackList;
	}

	// 분석 - 실시간 채팅 사용량 가져오기
	@ResponseBody
	@RequestMapping(value = "/userchat_amount.do", method = RequestMethod.POST)
	public List<String> userchat_amount(@RequestParam(name = "email", required = true) String email, Model model)
			throws Exception {

		WebSocket socket = new WebSocket();
		ChatMemberVO mem = chatMemberService.getRoomMember(new ChatMemberVO(0, email, "", ""));
		ChatVO room = chatService.getRoomInfo(mem.getRoom());
		List<String> userchat = socket.getAllchatlogLive(mem, room);

		return userchat;
	}

	// 사용자 관리(채팅 모아보기) - 선택된 유저의 채팅 가져오기
	@RequestMapping(value = "/userchatlog.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String userchatlog(Model model, String email) throws Exception {

		WebSocket socket = new WebSocket();
		ChatMemberVO mem = chatMemberService.getRoomMember(new ChatMemberVO(0, email, "", ""));
		ChatVO room = chatService.getRoomInfo(mem.getRoom());
		List<String> userchat = socket.getchatlogLive(mem, room);

		model.addAttribute("userchat", userchat);
		return "manage_include/manage_user_chatting";
	}
}
