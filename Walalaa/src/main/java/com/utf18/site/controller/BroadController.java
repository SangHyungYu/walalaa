package com.utf18.site.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.utf18.site.service.ChatLogService;
import com.utf18.site.service.ChatMemberService;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.ObjectionService;
import com.utf18.site.service.UserService;
import com.utf18.site.vo.ChatLogVO;
import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.ObjectionVO;
import com.utf18.site.vo.UserVO;

@Controller
public class BroadController {
	// 방송화면 관련 컨트롤러

	@Autowired
	private UserService userService;
	@Autowired
	private ChatService chatService;
	@Autowired
	private ChatLogService chatLogService;
	@Autowired
	private ChatMemberService chatMemberService;
	@Autowired
	private ObjectionService ObjectionService;

	// 사용자 '경고횟수' 설정
	@RequestMapping(value = "setWarnCount.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void setWarnCount(@RequestParam(name = "input", required = true) int manage_warncount, String email) {
		UserVO vo = new UserVO();
		vo.setManage_warncount(manage_warncount);
		vo.setEmail(email);
		userService.setWarnCount(vo);
	}

	// 이전 방송에서 사용자 지정 단어 사용여부를 해제하지 않으면, 다음 방송 시 사용여부가 사용으로 세팅되어 있음.
	// 방송을 시작 할 때, 사용자 지정 단어 사용여부를 사용안함(0)으로 세팅한다.
	@ResponseBody
	@RequestMapping(value = "settingcustomword.do", method = RequestMethod.POST)
	public void settingcustomword(@RequestBody String email) throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		apply0(email);
	}

	// 적용 0 => 유저가 작성한 비속어 리스트 채팅에 적용안함
	@RequestMapping(value = "apply0.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void apply0(String email) {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		userService.apply0(email);
	}

	// 적용 1 => 유저가 작성한 비속어 리스트 채팅에 적용 함
	@RequestMapping(value = "apply1.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void apply1(String email) {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		userService.apply1(email);
	}

	// 구독 하기
	@ResponseBody
	@RequestMapping(value = "subScribe.do", method = RequestMethod.POST)
	public void subscribe(@RequestBody String email) throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(email);
		mem = chatMemberService.getRoomMember(mem);
		String subscribe = chatService.getRoomOwner(mem.getRoom());

		UserVO vo = new UserVO();
		vo.setEmail(email);
		vo = userService.getUserVO(vo);
		String addList = vo.getSubscribe() + subscribe + "&/&";

		vo.setSubscribe(addList);
		userService.subscribe(vo);
	}

	// 구독 취소
	@ResponseBody
	@RequestMapping(value = "delsubScribe.do", method = RequestMethod.POST)
	public void delsubScribe(@RequestBody String email) throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		// owner 가져오기
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(email);
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		// user가져오기
		UserVO vo = new UserVO();
		vo.setEmail(email);
		vo = userService.getUserVO(vo);
		// subscribe 지우기
		String subscribe = vo.getSubscribe();
		subscribe = subscribe.replaceAll(owner + "&/&", "");
		vo.setSubscribe(subscribe);
		userService.subscribe(vo);

	}

	// 구독상태 체크
	@ResponseBody
	@RequestMapping(value = "/subScribecheck.do", method = RequestMethod.POST)
	public boolean subScribecheck(@RequestBody String email) throws Exception {
		email = email.replace("%40", "@");
		email = email.replace("=", "");

		// owner 가져오기
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(email);
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		// user가져오기
		UserVO vo = new UserVO();
		vo.setEmail(email);
		vo = userService.getUserVO(vo);

		return vo.getSubscribe().contains(owner);
	}

	// 제한(최대) 경고 횟수 가져오기
	@ResponseBody
	@RequestMapping(value = "/getLimitWarnCnt.do", method = { RequestMethod.GET, RequestMethod.POST })
	public int getLimitWarnCnt(@RequestParam(name = "id", required = true) String id) throws Exception {
		System.out.println("getLimit email : " + id);

		id = id.replace("%40", "@");
		id = id.replace("=", "");

		// id - > 방이름 - > 주인 - > limit
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(id);
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		int limitwarncount = userService.getLimitWarnCount(owner);

		return limitwarncount;
	}

	// 채팅 기록 가져오기
	@ResponseBody
	@RequestMapping(value = "getChatLog.do", method = { RequestMethod.POST })
	public List<ChatLogVO> getChatLog(@RequestBody int num) {
		List<ChatLogVO> logList = chatLogService.getChatLog(num);
		return logList;
	}

	// 세션아이디랑 방주인이랑 같은 사람인지 확인
	@ResponseBody
	@RequestMapping(value = "getChatOwner.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String getChatOwner(@RequestBody String email) throws Exception {

		ChatVO vo = chatService.getChatOwner(email.replace("%40", "@"));

		// 0 이면 방송 중 아님, 0이면 방송 중임
		if (vo == null) {
			return "0";
		} else {
			return "1";
		}
	}

	// 방송에 참여중인 사람인지 체크
	@ResponseBody
	@RequestMapping(value = "checkChatmember.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkChatmember(@RequestBody String email) throws Exception {

		ChatVO vo = chatMemberService.checkChatmember(email.replace("%40", "@"));

		// 0 이면 방송 중 아님, 0이면 방송 중임
		if (vo == null) {
			return "0";
		} else {
			return "1";
		}
	}

	// 경고 횟수 가져오기
	@ResponseBody
	@RequestMapping(value = "getWarnCnt.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Integer> getWarnCnt(@RequestBody String id) throws Exception {
		id = id.replace("%40", "@");
		id = id.replace("=", "");
		int warnCnt = chatMemberService.getWarningCount(id);
		// id - > 방이름 - > 주인 - > limit
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(id);
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		int limitCnt = userService.getLimitWarnCount(owner);
		if (warnCnt == limitCnt) {
			chatMemberService.updateChatStatus(id);
		}

		// 강제 채금으로 인해 broadcast창에서 문구 변화를 위함
		String status = chatMemberService.getChatStatus(id);
		int noChatStatus = 0;
		if (status.contains("xxxx")) {
			noChatStatus = 1;
		}

		List<Integer> warnlist = new ArrayList<>();
		warnlist.add(warnCnt);
		warnlist.add(limitCnt);
		warnlist.add(noChatStatus);

		return warnlist;
	}

	// 방송 시청자 수 가져오기
	@ResponseBody
	@RequestMapping(value = "/getremainCnt.do", method = RequestMethod.POST)
	public int getremainCnt(@RequestParam(name = "num", required = true) int num) throws Exception {
		ChatVO vo = chatService.getRoomInfoNumber(num);

		return vo.getRemaincount();
	}

	// 방 주인 체크
	@ResponseBody
	@RequestMapping(value = "/ownerCheck.do", method = RequestMethod.POST)
	public boolean ownerCheck(@RequestBody String id) throws Exception {
		boolean check = false;
		id = id.replace("%40", "@");
		id = id.replace("=", "");
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(id);
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		if (owner.equals(id)) {
			check = true;
		}

		return check;
	}

	// 이의제기 창 로딩
	@RequestMapping(value = "sendobj.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String sendobj(Model model, String msg) throws Exception {

		String objlist[] = msg.split("/");
		ArrayList<String> newobjlist = new ArrayList<>();
		for (int i = 0; i < objlist.length; i++) {
			String msgArr[] = new String[4];
			msgArr = chatService.replaceLast(objlist[i], ":", "").split(":");
			ChatMemberVO memVO = chatMemberService.getRoomMember(new ChatMemberVO(0, msgArr[0], "", "")); // ID를 통해 방이름가져오기

			ChatVO chatVO = chatService.getRoomInfo(memVO.getRoom()); // 방이름을 통해 챗방번호 가져오기
			List<ObjectionVO> getObjs = ObjectionService.getObj(chatVO.getNum());
			if (getObjs.isEmpty()) {
				newobjlist.add(chatService.replaceLast(objlist[i], ":", ""));
			} else {
				boolean save = true;
				for (ObjectionVO vo : getObjs) {
					if ((vo.getId().equals(msgArr[0])) && (vo.getContent().equals(msgArr[1]))) {
						save = false;
					}
				}
				if (save) {
					newobjlist.add(chatService.replaceLast(objlist[i], ":", ""));
				}
			}

		}
		model.addAttribute("objlist", newobjlist);
		return "sendobj";
	}

	// 이의제기 등록하기
	@ResponseBody
	@RequestMapping(value = "insertObj.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void insertObj(String objection) throws Exception {

		String[] msg = objection.split(",");
		for (String obj : msg) {
			String msgArr[] = new String[3];
			msgArr = obj.split(":");
			ChatMemberVO memVO = chatMemberService.getRoomMember(new ChatMemberVO(0, msgArr[0], "", ""));
			ChatVO chatVO = chatService.getRoomInfo(memVO.getRoom());

			ObjectionVO objVO = new ObjectionVO(chatVO.getNum(), msgArr[0], msgArr[1]);

			ObjectionService.insertObj(objVO);
		}
	}

	// 이의제기 신청 목록 - 이의제기 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "getObjList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ObjectionVO> getObjList(@RequestBody String num) throws Exception {
		int roomnum = Integer.parseInt(num);
		List<ObjectionVO> objVO = ObjectionService.getObjList(roomnum);

		for (ObjectionVO vo : objVO) {
			if (vo.getChatmemChatstatus().equals("NOCHAT")) {
				vo.setChatmemChatstatus("채팅금지");
			}
		}
		return objVO;
	}

	// 방 주인인지 확인하기 닉넴을 이용해서
	@ResponseBody
	@RequestMapping(value = "/ownerChecknick.do", method = RequestMethod.POST)
	public boolean ownerChecknick(@RequestParam(name = "usernick", required = true) String nickname) throws Exception {
		boolean check = false;
		UserVO vo = userService.getUserinfo(nickname);
		ChatMemberVO mem = new ChatMemberVO();
		mem.setId(vo.getEmail());
		mem = chatMemberService.getRoomMember(mem);
		String owner = chatService.getRoomOwner(mem.getRoom());
		if (owner.equals(vo.getEmail())) {
			check = true;
		}
		return check;
	}

	// 닉넴으로 프로필가져오기
	@ResponseBody
	@RequestMapping(value = "getprofile.do", method = RequestMethod.POST)
	public String getUserProfile(@RequestParam(name = "usernick", required = true) String nickname) throws Exception {
		return userService.getUserProfile(nickname);
	}
}
