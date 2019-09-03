package com.utf18.site.util;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.utf18.site.service.ChatFilterService;
import com.utf18.site.service.ChatLogService;
import com.utf18.site.service.ChatMemberService;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.CustomBadwordService;
import com.utf18.site.service.UserService;
import com.utf18.site.vo.ChatLogVO;
import com.utf18.site.vo.ChatMemberVO;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.CustomBadwordVO;
import com.utf18.site.vo.Disc_wordVO;
import com.utf18.site.vo.UserVO;

public class WebSocket extends TextWebSocketHandler {
	// Service접근 (db 처리를 하기위해 )
	@Autowired
	private ChatService chatService;
	@Autowired
	private UserService userService;
	@Autowired
	private ChatLogService chatLogService;
	@Autowired
	private ChatMemberService chatMemberService;
	@Autowired
	private CustomBadwordService customBadwordService;
	@Autowired
	private ChatFilterService chatfilterService;

	// 서버에 연결된 사용자들을 저장하기위해 선언
	private List<WebSocketSession> sessionList = new ArrayList<>(); // 메세지를 날려주기위한 웹소켓전용 세션
	private Map<WebSocketSession, String> mapList = new HashMap<>(); // 실제session의 아이디정보, web소켓정보
	private Map<WebSocketSession, String> roomList = new HashMap<>(); // 실제 session의 아이디정보, room정보
	private Map<WebSocketSession, ArrayList<String>> badwordList = new HashMap<>(); // 실제 session의 아이디정보, room의 금지어 목록
	private Map<WebSocketSession, ArrayList<String>> ilmeList = new HashMap<>(); // 일베,메갈,워마드,성인 단어
	static private Map<Integer, ArrayList<String>> chatLog = new HashMap<>(); // 방번호 , 채팅정보
	ChatUtil chatutil = new ChatUtil();

	// 연결되었을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// 1. 들어온 사람의 실제 로그인 아이디 정보를 가져온다.
		Map<String, Object> map = session.getAttributes();
		UserVO mem = (UserVO) map.get("login");
		String userId = mem.getEmail();
		String nickname = mem.getNickname();
		// 2. 들어온 아이디로 어느 방에 있는 지 확인한다.
		ChatMemberVO userRoom = chatMemberService.getRoomMember(new ChatMemberVO(0, userId, "", ""));
		// 3. 들어온 아이디로 찾은 방이름을 웹소켓 세션에 추가
		roomList.put(session, userRoom.getRoom());

		// 해당 방의 금지어를 웹소켓 세션에 추가
		String filterword = chatService.getFilterword(userRoom.getRoom());
		
		if (filterword != null) {
			ChatUtil chatUtil = new ChatUtil();
			ArrayList<String> badfilter = new ArrayList<>();
			ArrayList<String> totalfilter = new ArrayList<>();
			if (filterword.contains("badword")) {
				badfilter.addAll(chatUtil.FilterwordSave("Badwords.csv"));
			}

			if (filterword.contains("ilbe_megal")) {
				totalfilter.addAll(chatUtil.FilterwordSave("Ilbe.csv"));
				totalfilter.addAll(chatUtil.FilterwordSave("Megal.csv"));
				totalfilter.addAll(chatUtil.FilterwordSave("Womad.csv"));
			}

			if (filterword.contains("adult")) {
				totalfilter.addAll(chatUtil.FilterwordSave("adult.csv"));
			}
			// 해당 session의 금지어 리스트을 등록
			badwordList.put(session, badfilter);
			ilmeList.put(session, totalfilter);
		}
		System.out.println(userId + "님이 " + userRoom.getRoom() + " 방에 들어왔습니다.");

		// 4. mapList(해당세션의 실제아이디 값을 저장하기위해 map으로 저장)
		mapList.put(session, userId); // 세션:key, 유저아이디:value

		// 5. map을 사용하지않아도 될경우를 위해서 session값도 넣도록함
		sessionList.add(session); // 세션의 값 넣기(session : id=0~ , url:/ 주소/ echo.do)

		// 6. 입장 시 해당 방 인원 수를 증가시킨다.
		chatService.updateChatCountInc(new ChatVO(0, userRoom.getRoom(), "", 0, 0, ""));

		// 7. 모든유저들에게 서로다른 메시지를 전달하기위해 전체적으로 for문을 돌리도록한다.
		for (int i = 0; i < sessionList.size(); i++) {

			// 8. 해당 i번째 사람(sessionList.get(i) 의 방이름정보를 가져온다.
			// 웹소켓세션아이디가 저장된 sessionList를 이용해서 방정보를 가져옴
			String roomName = roomList.get(sessionList.get(i));

			// 9. 접속자가 속한 방에만 접속했음을 알린다.
			if (userRoom.getRoom().equals(roomList.get(sessionList.get(i)))) {
				sessionList.get(i).sendMessage(new TextMessage(JsonDataOpen(nickname)));
			}

		}

		// 13. 없는방에대해서 삭제처리를 한다.
//       chatService.deleteChat();
	}

//통신 연결끊었을때실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		// 1. 현재 접속한 사람의 로그인한 id정보를 가져온다.
		Map<String, Object> map = session.getAttributes();
		UserVO mem = (UserVO) map.get("login");
		String userId = mem.getEmail();

		// 2. 접속을끊을 때 해당 아이디로 DB에서 어느 방에 존재하는지 확인한다.
		ChatMemberVO member = chatMemberService.getRoomMember(new ChatMemberVO(0, userId, "", ""));
		ChatVO chatVO = chatService.getRoomInfo(member.getRoom()); // 방이름을 통해 챗방번호 가져오기

		if (userId.equals(chatVO.getOwner())) {
			ChatVO info = chatService.getRoomInfo(member.getRoom());
			if (chatLog.get(info.getNum()) != null) {
				ArrayList<String> log = chatLog.get(info.getNum());
				for (String tmp : log) {
					System.out.println(tmp);
					String msgArr[] = new String[4];
					msgArr = tmp.split("&/%!"); // &/%!로 문자를 잘라서 배열에저장
					System.out.println(msgArr[2]);
					if (msgArr[2].contains("B%A%D")) {
						ChatLogVO vo = new ChatLogVO(msgArr[0], msgArr[1], msgArr[3] + msgArr[2], info.getNum());
						chatLogService.addChatLog(vo);
					} else {
						ChatLogVO vo = new ChatLogVO(msgArr[0], msgArr[1], msgArr[2], info.getNum());
						chatLogService.addChatLog(vo);
					}
				}
			}
		}

		chatService.updateChatCountDec(new ChatVO(0, member.getRoom(), "", 0, 0, ""));
		chatMemberService.deleteRoomMember(member);
		roomList.remove(session);
		mapList.remove(session); // 세션:key, 유저아이디:value
		sessionList.remove(session); // 실제 websocket 세션명

	}

	// 서버가 클라이언트로부터 메시지를 받았을때
	@Override // WebSocketMessage<?>
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		// 1. 회원정보 가져오기
		Map<String, Object> map = session.getAttributes();
		UserVO mem = (UserVO) map.get("login");
		String userId = mem.getEmail();
		String userNick = mem.getNickname();
		if (message.getPayload().contains("!%/")) {

			// 2. 문자열 형태 : 문자 !%/ 대상 !%/ 방이름
			System.out.println(message.getPayload());

			// 3. 배열선언(split을 이용해서 문자열을 자른다)
			String msgArr[] = new String[3];
			msgArr = message.getPayload().split("!%/"); // %!로 문자를 잘라서 배열에저장
			String time = chatService.getTime();
			msgArr[1] = time;
			// 4. [0]: 유저가 보낸 메시지, [1]:귓속말 대상자, [2]:방의 이름
			System.out.println("보낸메시지:" + msgArr[0] + ", 보낸시간:" + msgArr[1] + ", 방의이름:" + msgArr[2]);
			boolean send = true;

			// 알고리즘 여기부터 시작하시면 됩니다

			/*
			 * badword -> 비속어, 표준화된비속어 csv 검사 badword1 -> 표준화 (standardize0) badword2 ->
			 * 글자사이 특수문자, 숫자, 영어, 자음 제거(standardize12)(ex. 개@새끼) badword3 -> 종성 제외시 욕인지
			 * 검사(standardize3)(ex. 씻발) badword4 -> 나머지-(중성 앞에 77-> ㄲ (ex.개새77ㅣ),
			 * r->ㅏ(ex.씨ㅂr) , 1 i I l -> ㅣ(ex.ㅆ1발) , h H -> ㅐ(ex.ㄱhㅅH끼) , 따로쳤을때(ex.ㄱㅐㅅㅐㄲㅣ)
			 * 
			 * 비속어, 표준화된 비속어 csv는 순서대로 모두 검사 일베,메갈,워마드,성인 csv는 badword2와 badword4만 사용(대부분 단어
			 * 그대로 치기 때문에 표준화할 필요x)
			 */
			String afterExceptMsg = msgArr[0];
			String ExceptMsg = msgArr[0];
			ExceptMsg = chatutil.delspace(ExceptMsg);
			String exceptWord = chatfilterService.checkexcept(ExceptMsg);
			if (!exceptWord.equals("")) {
				List<Disc_wordVO> add_word = chatfilterService.getAddWord(exceptWord);
				for (Disc_wordVO vo : add_word) {
					if (vo.getIswhite().equals("0")) {
						if (ExceptMsg.contains(vo.getAdd_word())) {
							session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
							send = false;
							chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
							msgArr[0] += "&/%! B%A%D";
							break;
						}
					} else {
						if(ExceptMsg.contains(vo.getAdd_word())) {
							System.out.println(vo.getAdd_word());
							ExceptMsg = ExceptMsg.replaceAll(vo.getAdd_word(), "");
							afterExceptMsg = afterExceptMsg.replaceAll(vo.getAdd_word(), "");
						}
					}

				}

			}
			System.out.println(ExceptMsg);
			System.out.println(afterExceptMsg);
			if (send) {
				for (String badword : badwordList.get(session)) {
					if (afterExceptMsg.contains(badword)) {
						// 예외상황에 해당하는지
						session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
						send = false;
						chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
						msgArr[0] += "&/%! B%A%D";
						break;

					}
				}
			}
			// 비속어 필터링 알고리즘 시작
			if (send) {

				String firstcheck_msg = chatutil.first_check(afterExceptMsg);
				String secondcheck_msg = chatutil.second_check(firstcheck_msg);
				String third_msg = chatutil.third_check(secondcheck_msg);

				for (String badword : badwordList.get(session)) {
					if (firstcheck_msg.contains(badword)) {
						session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
						send = false;
						chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
						msgArr[0] += "&/%! B%A%D";
						break;
					}
				}

				if (send) {
					for (String badword : badwordList.get(session)) {
						if (secondcheck_msg.contains(badword)) {
							session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
							send = false;
							chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
							msgArr[0] += "&/%! B%A%D";
							break;
						}
					}
				}
				if (send) {
					for (String badword : badwordList.get(session)) {
						if (third_msg.contains(badword)) {
							session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
							send = false;
							chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
							msgArr[0] += "&/%! B%A%D";
							break;
						}
					}
				}

			}
			// 비속어 필터링 알고리즘 끝

			// 일베 메갈
			if (send) {
				for (String badword : ilmeList.get(session)) {
					if (afterExceptMsg.contains(badword)) {
						session.sendMessage(new TextMessage(JsonDataBad(userNick, msgArr[0])));
						send = false;
						chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
						msgArr[0] += "&/%! B%A%D";
						break;
					}
				}
			}

			// 사용자 설정 비속어 확인
			if (send) {
				// 사용자 설정 비속어 확인
				String owner = chatService.getRoomOwner(msgArr[2]);
				String apply = userService.getApply(owner);
				if (apply.equals("1")) {
					for (CustomBadwordVO vo : customBadwordService.getWordList(owner)) {
						if (msgArr[0].contains(vo.getContent())) {
							session.sendMessage(new TextMessage(JsonDataUserBad(userNick, msgArr[0])));
							send = false;
							chatMemberService.plusWarningCount(userId); // 비속어 사용 시, 경고 횟수 증가
							msgArr[0] += "&/%! B%A%D";
							break;
						}
					}
				}
			}

			if (send) {
				for (WebSocketSession webSocketSession : sessionList) {
					// 같은방일때만 보냄
					if (msgArr[2].equals(roomList.get(webSocketSession))) {
						webSocketSession.sendMessage(new TextMessage(JsonData(userNick, msgArr[0])));
					}
				}
			}

			ChatVO roomNum = chatService.getRoomInfo(msgArr[2]);
//         채팅 내역을 chatlog list 에 저장하는 과정
			if (chatLog.get(roomNum.getNum()) == null) {
				// 없으면 해당 방 넘버에 list생성
				chatLog.put(roomNum.getNum(), new ArrayList<String>());
				// 생성한 리스트 가져오기
				ArrayList<String> list = chatLog.get(roomNum.getNum());
				// 리스트에 값추가
				list.add(userId + "&/%!" + msgArr[0] + "&/%!" + msgArr[1]);
				// 리스트를 해당 방넘버에 등록
				chatLog.put(roomNum.getNum(), list);
			} else {
				// 방넘버에 리스트가 있어, 해당 리스트를 가져온다
				ArrayList<String> list = chatLog.get(roomNum.getNum());
				// 리스트에 바로 추가해
				list.add(userId + "&/%!" + msgArr[0] + "&/%!" + msgArr[1]);
				// 추가한 리스트를 다시 방넘버에 등록
				chatLog.put(roomNum.getNum(), list);
			}
			// 구독신청 메세지
		} else if (message.getPayload().contains("%!#Sub")) {
			String msgArr[] = new String[2];
			msgArr = message.getPayload().split("%!#");
			ChatVO room = chatService.getRoomInfo(msgArr[0]);
			String roomName = room.getName();
			for (WebSocketSession webSocketSession : sessionList) {
				// 같은방일때만 보냄
				if (roomName.equals(roomList.get(webSocketSession))) {
					webSocketSession.sendMessage(new TextMessage(JsonDataSub(userNick, "do%!#Sub")));
				}
			}
		} else {
			// 이의제기 신청 메세지
			String roomName = message.getPayload();
			ChatVO roomNum = chatService.getRoomInfo(roomName);
			if (chatLog.get(roomNum.getNum()) == null) {
				session.sendMessage(new TextMessage(JsonData(userId, "쳇로그없음")));
			} else {
				// 방넘버에 쳇로그리스트가 있어, 해당 리스트를 가져온다
				ArrayList<String> list = chatLog.get(roomNum.getNum());
				String objlist = "";
				for (String log : list) {
					if (log.contains(userId))
						if (log.contains("B%A%D")) {
							objlist += log + "/";
						}
				}
				session.sendMessage(new TextMessage(JsonObjData(objlist)));
			}
		}
	}

	// json형태로 메세지 변환2(이의제기했을때)
	public String JsonObjData(String msg) {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", msg).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// json형태로 메세지 변환(이의제기했을때)
	public String JsonDataEnd() {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", "broadcast&end").build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// json형태로 메세지 변환2( 채팅 쳤을때)
	public String JsonData(String id, Object msg) {
		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message", "<b style='color: gray;'>[" + id + "]</b> &nbsp;: " + msg).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// json형태로 메세지 변환2( 구독했을때)
	public String JsonDataSub(String id, String msg) {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", id + msg).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// json형태로 메세지 변환2( 접속했음을 알릴때)
	public String JsonDataOpen(String id) {
		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message", "<b style='color:blue'>[" + id + "] 님이 접속하셨습니다.</b>").build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// json형태로 메세지 변환3( 나갔음을 알릴때)
	public String JsonDataClose(String id) {
		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message", "<b>[" + id + "]</b> 님이 <b style='color:red'>퇴장</b>하셨습니다.").build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	// 욕설시
	public String JsonDataBad(String id, Object msg) {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", "#^$bad" + "<b>[" + id + "]</b> : " + msg)
				.build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();
	}

	// 사용자 금지어
	public String JsonDataUserBad(String id, Object msg) {
		JsonObject jsonObject = Json.createObjectBuilder().add("message", "#^$userbad" + "<b>[" + id + "]</b> : " + msg)
				.build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();
	}

	// json형태로 유저 정보 날리기
	public String JsonUser(String id) {
		JsonObject jsonObject = Json.createObjectBuilder().add("list", id).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}
		;
		return write.toString();
	}

	public List<String> getchatlogLive(ChatMemberVO mem, ChatVO room) throws Exception {
		System.out.println("websocket 함수 ");
		List<String> userlog = new ArrayList<>();
		System.out.println(mem.toString());
		System.out.println(room.toString());
		ArrayList<String> roomlog = chatLog.get(room.getNum());
		for (String chat : roomlog) {
			if (chat.contains(mem.getId())) {
				userlog.add(chat);
			}
		}
		return userlog;
	}

	// [분석탭] 시간 별 채팅량 가져오기
	public List<String> getAllchatlogLive(ChatMemberVO mem, ChatVO room) throws Exception {
		System.out.println("websocket getAllchatlogLive 함수 ");
		System.out.println(mem.toString());
		System.out.println(room.toString());
		ArrayList<String> roomlog = chatLog.get(room.getNum());

		return roomlog;
	}

}