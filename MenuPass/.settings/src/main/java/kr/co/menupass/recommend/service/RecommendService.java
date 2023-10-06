package kr.co.menupass.recommend.service;

import java.util.List;

import kr.co.menupass.common.model.dto.PageInfo;
import kr.co.menupass.recommend.dto.Recommend;

// 추상 메서드 
public interface RecommendService {
	
	// 전체 게시글 수 구하기
	int selectListCount(String searchTxt);
	
	// 목록 불러오기
	List<Recommend> selectListAll(PageInfo pi, String searchTxt);
	
	// 글쓰기
	int insertRecommend(Recommend re);
	
	// 게시글 상세보기
	Recommend detailRecommend(int board_No);
	
	// 게시글 조회수 올리기
	int countRecommend(Recommend re);
	
	// 게시글 수정
	int updateRecommend(Recommend re);
	
	// 게시글 삭제
	int deleteRecommend(Recommend re);

	// 수정 -  파일업로드유지
	int updateUploadRecommend(Recommend re);

}
