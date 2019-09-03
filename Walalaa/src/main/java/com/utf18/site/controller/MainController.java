package com.utf18.site.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.utf18.site.service.ChatMemberService;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.UserService;
import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.UserVO;

@Controller
public class MainController {
	// 메인 화면 관련 컨트롤러

	@Autowired
	private UserService userService;

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private ChatMemberService chatMemberService;

	// 메인 화면 로딩 - 웹 버전
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String main() {
		return "main";
	}

	// 메인 화면 로딩 - 모바일 버전
	@RequestMapping(value = "main_m.do", method = RequestMethod.GET)
	public String main_m() {
		return "main_m";
	}

	// 실시간 방송 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getRoomList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ChatVO> getRoomList(Model model) throws Exception {
		List<ChatVO> RoomList = chatService.getRoomList();
		return RoomList;
	}

	// 인기 업로드 방송 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getUploadList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ChatVO> getUploadList(Model model) throws Exception {
		List<ChatVO> uploadList = chatService.getUploadList();
		return uploadList;
	}

	// 내 채널 로딩
	@RequestMapping(value = "mychannel.do", method = RequestMethod.GET)
	public String mychannel(Model model, HttpServletRequest request) {
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		login = userService.getUserVO(login);
		model.addAttribute("user", login);
		return "mychannel";
	}

	// 방 이동 - 웹 버전
	@RequestMapping(value = "MoveChatRoom.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MoveChatRoom(Model model, HttpServletRequest req, String roomName) throws Exception {

		UserVO login = (UserVO) req.getSession().getAttribute("login");

		if (login == null) {
			return "redirect:/loginform.do";
		}

		// DB에 현재 아이디로 세팅하기
		chatMemberService.addRoomMember(new ChatMemberVO(0, login.getEmail(), roomName, ""));

		// 이동하게 될 방 이름으로 수정
		chatMemberService.updateRoomMember(new ChatMemberVO(0, login.getEmail(), roomName, ""));
		ChatVO vo = chatService.getRoomInfo(roomName);
		// 방의 조회수 증가
		chatService.incViews(roomName);
		// 방이동 처리
		model.addAttribute("room", roomName);
		model.addAttribute("roomName", roomName);
		model.addAttribute("roomNum", vo.getNum());
		return "broadcast";
	}

	// 방 이동 - 모바일 버전
	@RequestMapping(value = "MoveChatRoom_m.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MoveChatRoom_m(Model model, HttpServletRequest req, String roomName) throws Exception {

		UserVO login = (UserVO) req.getSession().getAttribute("login");

		if (login == null) {
			return "redirect:/loginform_m.do";
		}

		// DB에 현재 아이디로 세팅하기
		chatMemberService.addRoomMember(new ChatMemberVO(0, login.getEmail(), roomName, ""));

		// 이동하게 될 방 이름으로 수정
		chatMemberService.updateRoomMember(new ChatMemberVO(0, login.getEmail(), roomName, ""));
		ChatVO vo = chatService.getRoomInfo(roomName);
		// 방의 조회수 증가
		chatService.incViews(roomName);
		// 방이동 처리
		model.addAttribute("room", roomName);
		model.addAttribute("roomName", roomName);
		model.addAttribute("roomNum", vo.getNum());
		return "broadcast_m";
	}

	// 검색하면 나오는 화면 - 태그만 받아오기
	@RequestMapping(value = "search_result.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String getUploadList(Model model, String tag) throws Exception { // Model model, @RequestParam(name="search",
		// required=true)

		model.addAttribute("tag", tag);
		return "search_result";
	}

	// 검색하면 나오는 화면 - 리스트 뽑기
	@ResponseBody
	@RequestMapping(value = "/search_result_list.do", method = RequestMethod.POST)
	public List<ChatVO> searchList(String tag) {
		return chatService.getTagList(tag);
	}
}
