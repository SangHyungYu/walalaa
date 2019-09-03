package com.utf18.site.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.utf18.site.service.ChatLogService;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.UserService;
import com.utf18.site.service.VideoCommentService;
import com.utf18.site.vo.ChatLogVO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.UserVO;
import com.utf18.site.vo.VideoCommentVO;

@Controller
public class UploadedController {
	// 인기 업로드 관련 컨트롤러

	@Autowired
	private VideoCommentService commentService;
	@Autowired
	private ChatService chatService;
	@Autowired
	private ChatLogService chatLogService;
	@Autowired
	private UserService userService;
	// 댓글 - 입력
	@ResponseBody
	@RequestMapping(value = "/addComment.do", method = RequestMethod.POST)
	public void addComment(@RequestParam(name = "comment", required = true) String content,
			@RequestParam(name = "room", required = true) String roomName,
			@RequestParam(name = "email", required = true) String email) throws Exception {
		ChatVO chat = chatService.getRoomInfo(roomName);
		VideoCommentVO vo = new VideoCommentVO(0, chat.getNum(), email, content, "");
		commentService.addComment(vo);
	}

	// 댓글 - 댓글 가져오기
	@ResponseBody
	@RequestMapping(value = "/showComment.do", method = RequestMethod.POST)
	public List<VideoCommentVO> showComment(@RequestParam(name = "room", required = true) String roomName) throws Exception {
		ChatVO chat = chatService.getRoomInfo(roomName);
		List<VideoCommentVO> vo = commentService.getCommentList(chat.getNum());

		return vo;
	}

	// 댓글 - 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteComment.do", method = RequestMethod.POST)
	public String deleteComment(@RequestParam(name = "num", required = true) int num,
			@RequestParam(name = "room", required = true) String roomName,
			@RequestParam(name = "email", required = true) String email) throws Exception {
		ChatVO chat = chatService.getRoomInfo(roomName);
		if (chat.getOwner().equals(email)) {
			VideoCommentVO vo = new VideoCommentVO();
			vo.setCom_num(num);
			commentService.deleteComment(vo);
			return "del";
		} else {
			return "notdel";
		}
	}

	// 인기 업로드 - 선택된 영상 정보 가져오기 / 내 채널 - 선택된 영상 정보 가져오기 ( 2번 사용)
	@RequestMapping(value = "playUploaded.do", method = RequestMethod.POST)
	public String uploaded(Model model, String roomName) throws Exception {
		ChatVO vo = chatService.getRoomInfo(roomName);
		// 방의 조회수 증가
		chatService.incViews(roomName);
		// 방이동 처리
		String date = "게시일 : "+vo.getUploadtime().substring(0, 4)+"."+vo.getUploadtime().substring(5, 7)+"."+vo.getUploadtime().substring(8, 10);
		String time = vo.getUploadtime().substring(11, 13) + vo.getUploadtime().substring(14, 16)
				+ vo.getUploadtime().substring(17, 19);
		// 방송시작시간
		model.addAttribute("showtime", time);
		model.addAttribute("upload_date", date);
		model.addAttribute("room", roomName);
		model.addAttribute("roomName", roomName);
		model.addAttribute("roomNum", vo.getNum());
		return "uploaded_video";
	}

	// 인기 업로드 - 업로드된 영상의 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/getuploaded_data.do", method = RequestMethod.POST)
	public ChatVO getuploaded_data(Model model, @RequestParam(name = "room", required = true) String roomName) throws Exception {
		ChatVO vo = chatService.getRoomInfo(roomName);

		return vo;
	}

	// 인기 업로드 - 해당 영상의 채팅 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "/getuploaded_Chatdata.do", method = RequestMethod.POST)
	public List<ChatLogVO> getuploaded_Chatdata(@RequestParam(name = "room", required = true) String roomName) throws Exception {
		ChatVO vo = chatService.getRoomInfo(roomName);

		List<ChatLogVO> chatlist = chatLogService.getUploadedDataInfo(vo.getNum());
		return chatlist;
	}
	@ResponseBody
	@RequestMapping(value = "/getowner_info.do", method = RequestMethod.POST)
	public UserVO getowner_info(@RequestParam(name = "email", required = true) String email) throws Exception {
		UserVO vo = new UserVO();
		vo.setEmail(email);
		vo = userService.getUserVO(vo);
		
		return vo;
	}
	
	
}