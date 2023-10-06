package kr.co.menupass.recommend.controller;

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
import kr.co.menupass.common.controller.UploadFileController;
import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.common.template.Pagination;
import kr.co.menupass.recommend.dto.Recommend;
import kr.co.menupass.recommend.service.RecommendServiceImpl;

@Controller
@RequestMapping("/recommend") // http://localhost/commu/commu.do
public class RecommendController {
    public static final String uploadpath = "C:\\prj\\spring\\FinalProject\\src\\main\\webapp\\resources\\upload\\";

    @Autowired
    private RecommendServiceImpl recommendService;

    @Autowired
    private DataValidationController dataValidation;

    @Autowired
    private SessionManageController sessionManage;

    @Autowired
    private UploadFileController uploadFile;

    @GetMapping("/recommend.do")
    public String recommendList(@RequestParam(value = "searchTxt", defaultValue = "") String searchTxt,
    							@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
    							Model model,
    							HttpSession session) {

        // 전체 게시글 수 구하기
        int listCount = recommendService.selectListCount(searchTxt);

        // 페이지당 아이템 개수
        int itemsPerPage = 6;
        
		// 시작 인덱스 계산
        int start = (currentPage - 1) * itemsPerPage;
        
        
        // 페이징 처리
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage);       

        // 목록 불러오기
     	List<Recommend> list = recommendService.selectListAll(pi, searchTxt);
        
        // 날짜 포맷 변경 (년-월-일 형식으로)
        for (Recommend item : list) {
            item.setCreateDate(item.getCreateDate().substring(0, 10));
        }
        
     // 별점 데이터를 숫자로 변환
        for (Recommend item : list) {
            int numStars = Integer.parseInt(item.getRecommend_Grade());
            String stars = "";
            for (int i = 0; i < numStars; i++) {
                stars += "&#9733;";
            }
            item.setRecommend_Grade(stars); // 숫자로 변환된 별점 데이터를 setUser_Grade에 설정
        }
        
        model.addAttribute("list", list); // 객체 바인딩
        model.addAttribute("pi", pi);
        model.addAttribute("searchTxt", searchTxt);
        model.addAttribute("currentPage", currentPage); // 현재 페이지
        model.addAttribute("user", session.getAttribute("memberNo"));
        model.addAttribute("msg", (String) session.getAttribute("msg"));
    	model.addAttribute("status", (String) session.getAttribute("status"));
    	session.removeAttribute("msg");
    	session.removeAttribute("status");

        return "recommend/recommend";
    }
	
    @GetMapping("enroll.do")
    public String enroll(Recommend re,
    					 Model model, 
    					 HttpSession session, 
    					 HttpServletRequest request) {
    	
    	re.setMemberNo((int) session.getAttribute("memberNo"));
    	
    	model.addAttribute("msg", (String) session.getAttribute("msg"));
    	model.addAttribute("status", (String) session.getAttribute("status"));
    	session.removeAttribute("msg");
    	session.removeAttribute("status");
    	
    	return "recommend/enroll";
    }
	@RequestMapping("insert.do")
	public String insert(Recommend re, 
						 HttpSession session,
						 MultipartFile upload) throws IllegalStateException, IOException {
//		// 파일 업로드, 파일 덮어쓰기
		re = uploadFile.uploadFile(upload, re);
		boolean titleNullCheck = dataValidation.nullCheck(re.getRecommend_Title());
		boolean titleLength = dataValidation.LanguageCheck(re.getRecommend_Title());
		boolean contentLength = dataValidation.nullCheck(re.getRecommend_Content());
		// result = 1 이 반환 되면 성공
		// result = 0 이 반환 되면 실패
		
		re.setMemberNo((int) session.getAttribute("memberNo"));

    	session.removeAttribute("msg");
    	session.removeAttribute("status");
    	
		if(titleLength && contentLength && titleNullCheck) {
			int result = recommendService.insertRecommend(re);

			 if (result > 0) {
		            session.setAttribute("msg", "글이 등록 되었습니다");
		            session.setAttribute("status", "success");
		            return "redirect:/recommend/recommend.do";
		        } else {
		            session.setAttribute("msg", "글 올리기를 실패했습니다");
		            session.setAttribute("status", "error");
		            return "redirect:/recommend/recommend.do";
		        }
			
		} else if(!titleLength){
			sessionManage.setSessionMessage("제목이 너무 깁니다", "error", session);
			return "redirect:/recommend/enroll.do";
		
		} else if(!contentLength){
			session.setAttribute("msg", "게시글이 너무 깁니다.");
			session.setAttribute("status", "error");
			// add
			return "redirect:/recommend/enroll.do";
		
		} else if(!titleNullCheck){
			session.setAttribute("msg", "제목을 입력해 주세요.");
			session.setAttribute("status", "error");
			// add
			return "redirect:/recommend/enroll.do";
		}else {
			return "common/errorPage";
		}
		
		
	}
	
	
	//view count 추가
	@GetMapping("detail.do")
	public String detailrecommend(@RequestParam(value="board_No")
							  int board_No,
							  Model model,
							  HttpSession session) {
		Recommend result = recommendService.detailRecommend(board_No);
		
		if(!Objects.isNull(result)) {
			int count = result.getViews()+1;
			result.setViews(count);
			result.setBoard_No(board_No);
			
			
			recommendService.countRecommend(result);

			model.addAttribute("detail", result);
			model.addAttribute("user", session.getAttribute("memberNo"));
			
			return "recommend/edit";
		} else {
			return "recommend/edit";
		}
  
        }
		
	@PostMapping("update.do")
	public String updaterecommend(@RequestParam(value = "recommend_content", defaultValue = "") String Recommend_Content, 
	                            MultipartFile upload,
	                            Recommend re,
	                            Model model,
	                            HttpSession session,
	                            @RequestParam(value = "board_No") int board_No) {
	    re.setMemberName((String) session.getAttribute("memberName"));
	    re.setBoard_No(board_No);
	    re.setRecommend_Content(Recommend_Content);
	    
	    // 사용자가 파일 업로드 했을때 : 새로운 정보 업데이트
	    if (!upload.isEmpty()) {
	        try {
	            uploadFile.deleteFile(upload, re);

	            re = uploadFile.uploadFile(upload, re);
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        int result = recommendService.updateUploadRecommend(re);
	       
	        if (result > 0) {
	            session.setAttribute("msg", "수정 되었습니다");
	            session.setAttribute("status", "success");
	            return "redirect:/recommend/recommend.do";
	        } else {
	            session.setAttribute("msg", "수정에 실패했습니다");
	            session.setAttribute("status", "error");
	            return "redirect:/recommend/recommend.do";
	        }
	        // 업로드 안했을때 : 기존 업로드 정보 유지
	    } else if (upload.isEmpty()) {
	    	
	        int result = recommendService.updateRecommend(re);

	        if (result > 0) {
	            session.setAttribute("msg", "수정 되었습니다");
	            session.setAttribute("status", "success");
	            return "redirect:/recommend/recommend.do";
	        } else {
	            session.setAttribute("msg", "수정에 실패했습니다");
	            session.setAttribute("status", "error");
	            return "redirect:/recommend/recommend.do";
	        }
	    } else {
	        session.setAttribute("msg", "잘못된 접근 입니다.");
	        session.setAttribute("status", "error");
	        return "redirect:/recommend/recommend.do";
	    }

	}
		
		@PostMapping("delete.do")
		public String deleterecommend(Recommend re, HttpSession session,
								  MultipartFile upload) {
			int result = recommendService.deleteRecommend(re);
			
			// 삭제 버튼 눌렀을때 파일 삭제
			uploadFile.deleteFile(upload, re);
					
			if(result >0) {
				session.setAttribute("msg", "삭제 되었습니다");
				session.setAttribute("status", "success");
				return "redirect:/recommend/recommend.do";
			} else {
				session.setAttribute("msg", "삭제에 실패했습니다");
				session.setAttribute("status", "error");
				return "redirect:/recommend/recommend.do";
			}
		}
	 
	    
	}
		
