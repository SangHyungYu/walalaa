package com.utf18.site.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.utf18.site.service.ChatService;
import com.utf18.site.service.UserService;
import com.utf18.site.vo.ChatVO;
import com.utf18.site.vo.UserVO;

@Controller
public class MyChannelContoller {
	// 내 채널 관련 컨트롤러

	@Autowired
	private UserService userService;

	@Autowired
	private ChatService chatService;

	// 프로필 사진 설정
	@ResponseBody
	@RequestMapping(value = "profileuplaod.do", method = { RequestMethod.POST })
	public void proflieupload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String encoding = "UTF-8";
		String url = "C:\\Users\\SangHyungYu\\Desktop\\BIT\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Walalaa\\assets\\profilefolder\\";
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		MultipartRequest multi = new MultipartRequest(request, url, 5 * 1024 * 1024, encoding,
				new DefaultFileRenamePolicy());

		login.setProfile("/assets/profilefolder/" + multi.getFilesystemName("profile"));
		// 해당 정보로 방을 DB에 생성( 이미 방이 존재한다면 생성하지 않는다 )

		userService.uploadprofile(login);

	}

	// 채널 배경사진 설정
	@ResponseBody
	@RequestMapping(value = "backgrounduplaod.do", method = { RequestMethod.POST })
	public void bgupload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String encoding = "UTF-8";
		String url = "C:\\Users\\SangHyungYu\\Desktop\\BIT\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Walalaa\\assets\\bgimgfolder\\";
		UserVO login = (UserVO) request.getSession().getAttribute("login");
		MultipartRequest multi = new MultipartRequest(request, url, 5 * 1024 * 1024, encoding,
				new DefaultFileRenamePolicy());

		login.setBgimg("/assets/bgimgfolder/" + multi.getFilesystemName("bgimg"));
		// 해당 정보로 방을 DB에 생성( 이미 방이 존재한다면 생성하지 않는다 )

		userService.uploadbgimg(login);

	}

	// 채널 정보 입력(변경)
	@RequestMapping(value = "changeChannelInfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public void changeChannelInfo(String email, String channelInfo) {

		UserVO vo = new UserVO();

		vo.setEmail(email);
		vo.setChannelInfo(channelInfo);

		userService.changeChannelInfo(vo);
	}

	// 내 채널 내 영상 리스트
	@ResponseBody
	@RequestMapping(value = "/getMyUploadList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public List<ChatVO> getMyUploadList(String email) throws Exception {
		List<ChatVO> myUploadList = chatService.getMyUploadList(email.replace("%40", "@"));
		return myUploadList;
	}

}
