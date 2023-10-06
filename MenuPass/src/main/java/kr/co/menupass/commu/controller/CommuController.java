package kr.co.menupass.commu.controller;

import java.io.IOException;

import java.util.List;

import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;

import kr.co.menupass.common.controller.DataValidationController;
import kr.co.menupass.common.controller.SessionManageController;
import kr.co.menupass.common.controller.UploadFileController2;

import kr.co.menupass.common.model.dto.PageInfo2;

import kr.co.menupass.common.template.Pagination2;
import kr.co.menupass.commu.dto.Commu;
import kr.co.menupass.commu.service.CommuServiceImpl;


@Controller
@RequestMapping("/commu")
public class CommuController {
	public static final String UPLOAD_PATH = "C:\\prj\\spring\\Project\\src\\main\\webapp\\resources\\upload\\";
	// GET : URL 정보 보임, 중요도 낮은 정보들(ex. 검색, 페이지이동)
	// POST : URL 정보 X, 네트워크 패킷 body 안에 데이터가 들어감
	//        중요한 정보들 (회원가입, 로그인, 결제)
	
	// RequestMapping  :  GET, POST
	// GetMapping  :  GET
	// PostMapping  :  POST
	
	@Autowired
	private CommuServiceImpl commuService;
	
	@Autowired
	private DataValidationController dataValidation;
	
	@Autowired
	private SessionManageController sessionManage;
	
	@Autowired
	private UploadFileController2 uploadFile;
	
	@GetMapping("/list.do")
	public String boardList(@RequestParam(value="searchTxt", defaultValue="")String searchTxt,
							@RequestParam(value="cpage", defaultValue="1") int currentPage, 
							Model model,
							HttpSession session) {
		


			// 전체 게시글 수 구하기
			int listCount = commuService.selectListCount(searchTxt);                                                             
			
			// 보여질 페이지 수
			int pageLimit = 10;
			
			// 한 페이지에 보여질 게시글 수
			int boardLimit = 15;
			
			// 글 번호 뒤에서부터 출력해주는 변수
			int row = listCount - (currentPage-1) * boardLimit;
			
			// 페이징 로직 처리
			PageInfo2 pi = Pagination2.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			// 목록 불러오기
			List<Commu> list = commuService.selectListAll(pi, searchTxt);
			
			for(Commu item : list) {
				item.setCreateDate(item.getCreateDate().substring(0, 10));
			}

			
			model.addAttribute("list", list); // 객체 바인딩
			model.addAttribute("pi", pi);
			model.addAttribute("row", row);
			
		    model.addAttribute("msg", (String) session.getAttribute("msg"));
		    model.addAttribute("status", (String) session.getAttribute("status"));
			
		    session.removeAttribute("msg");
			session.removeAttribute("status");
			
			return "commu/commuList";

	}
	
	@GetMapping("enrollForm.do")
	   public String enrollForm(Commu co,
			   					Model model, 
			   					HttpSession session, 
			   					HttpServletRequest request) {
	        
	      model.addAttribute("msg", (String) session.getAttribute("msg"));
	      model.addAttribute("status", (String) session.getAttribute("status"));
	     
	      session.removeAttribute("msg");
	      session.removeAttribute("status");
	      
	      
	      return "commu/commuEnroll";
	   }

	public String enrollForm(Model model, HttpSession session) {
		model.addAttribute("msg", (String) session.getAttribute("msg"));
		model.addAttribute("status", (String) session.getAttribute("status"));
		
		session.removeAttribute("msg");
		session.removeAttribute("status");

		return "commu/commuEnroll";
	}

	
	@PostMapping("insert.do")
	public String insert(Commu co, 
						 HttpSession session,
						 MultipartFile upload) throws IllegalStateException, IOException {
		
		//파일 업로드, 파일 덮어쓰기
		co = uploadFile.uploadFile(upload, co);
		boolean titleLength = dataValidation.LanguageCheck(co.getUserTitle());
		boolean contentLength = dataValidation.LanguageCheck(co.getUserContent());
		boolean titleNullCheck = dataValidation.nullCheck(co.getUserTitle());
		// result = 1 이 반환 되면 성공
		// result = 0 이 반환 되면 실패
		
		co.setMemberNo((int) session.getAttribute("memberNo"));
		co.setMemberName((String)session.getAttribute("username"));
		
    	session.removeAttribute("msg");
    	session.removeAttribute("status");
    	
		if(titleLength && contentLength && titleNullCheck) {
			int result = commuService.insertBoard(co);
		
			if (result > 0) {
	            session.setAttribute("msg", "글이 등록 되었습니다");
	            session.setAttribute("status", "success");
	            return "redirect:/commu/list.do";
	        } else {
	            session.setAttribute("msg", "글 올리기를 실패했습니다");
	            session.setAttribute("status", "error");
	            return "redirect:/commu/list.do";
	        }
			
		} else if(!titleLength){
			sessionManage.setSessionMessage("제목이 너무 깁니다", "error", session);
			return "redirect:/commu/enrollForm.do";
		
		} else if(!contentLength){
			session.setAttribute("msg", "내용이 너무 깁니다.");
			session.setAttribute("status", "error");
			// enrollForm
			return "redirect:/commu/enrollForm.do";
		
		} else if(!titleNullCheck){
			session.setAttribute("msg", "제목을 입력해 주세요.");
			session.setAttribute("status", "error");
			// enrollForm
			return "redirect:/commu/enrollForm.do";
		}else {
			return "common/errorPage";
		}
	}

	@GetMapping("detail.do")
	public String detailBoard(@RequestParam(value="c_board_No") int c_board_No,
//							  @RequestParam(value="memberNo") int memberNo,	
							  Model model,
							  Commu co,
							  HttpSession session) {
		co.setMemberNo((int) session.getAttribute("memberNo"));
		Commu result = commuService.detailBoard(c_board_No);
		
		if(!Objects.isNull(result)) {
			int count = result.getViews()+1;
			result.setViews(count);
			result.setC_board_No(c_board_No);

			commuService.countBoard(result);

			model.addAttribute("detail", result);
			model.addAttribute("user", session.getAttribute("memberNo"));
			
			return "commu/commuDetail";
		} else {
			return "";
		}
		}
		@PostMapping("update.do")
		public String updateBoard(MultipartFile upload,
								  Commu co, 
								  HttpSession session,
								  Model model,
								  @RequestParam(value = "c_board_No") int c_board_No ) {
			
			co.setMemberName((String)session.getAttribute("memberName"));
		    co.setC_board_No(c_board_No);
		    
			// 사용자가 파일 업로드 했을때 : 새로운 정보 업데이트
			if(!upload.isEmpty()) {
				try {		
					uploadFile.deleteFile(upload, co);
					
					co = uploadFile.uploadFile(upload, co);
				} catch (IllegalStateException e) {		
					e.printStackTrace();
				} catch (IOException e) {	
					e.printStackTrace();
				}
				int result = commuService.updateUploadFree(co);
				
				if(result >0) {
					session.setAttribute("msg", "수정 되었습니다");
					session.setAttribute("status", "success");
					return "redirect:/commu/list.do";
				} else {
					session.setAttribute("msg", "수정에 실패했습니다");
					session.setAttribute("status", "error");
					return "redirect:/commu/list.do";
				}	
				//업로드 안했을때 : 기존 업로드 정보 유지
			}else if(upload.isEmpty()) {
				
				int result = commuService.updateBoard(co);
				
				if(result >0) {
					session.setAttribute("msg", "수정 되었습니다");
					session.setAttribute("status", "success");
					return "redirect:/commu/list.do";
				} else {
					session.setAttribute("msg", "수정에 실패했습니다");
					session.setAttribute("status", "error");
					return "redirect:/commu/list.do";
				} 
					}else {
					session.setAttribute("msg", "잘못된 접근 입니다.");
					session.setAttribute("status", "error");
					return "redirect:/commu/list.do";
				}
		}

		
		@PostMapping("delete.do")
		public String deleteBoard(Commu co, HttpSession session,
								  MultipartFile upload) {
			int result = commuService.deleteBoard(co);
			
			// 삭제 버튼 눌렀을때 파일 삭제
			uploadFile.deleteFile(upload, co);
					
						
			if(result >0) {
				session.setAttribute("msg", "삭제 되었습니다");
				session.setAttribute("status", "success");
				return "redirect:/commu/list.do";
			} else {
				session.setAttribute("msg", "삭제에 실패했습니다");
				session.setAttribute("status", "error");
				return "redirect:/commu/list.do";
			}
		
		}
		}
