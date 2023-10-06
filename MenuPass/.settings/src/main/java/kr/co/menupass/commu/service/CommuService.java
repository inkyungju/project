package kr.co.menupass.commu.service;

import java.util.List;

import kr.co.menupass.common.model.dto.PageInfo2;
import kr.co.menupass.commu.dto.Commu;

public interface CommuService {
	// 전체 게시글 수 구하기
	// 추상 메서드 
	int selectListCount(String searchTxt);
	
	// 목록 불러오기
	List<Commu> selectListAll(PageInfo2 pi, String searchTxt);
	
	// 글쓰기
	int insertBoard(Commu co);
	
	// 게시글 상세보기
	Commu detailBoard(int idx);
	
	// 게시글 조회수 올리기
	int countBoard(Commu co);
	
	// 게시글 수정
	int updateBoard(Commu co);
	
	// 게시글 삭제
	int deleteBoard(Commu co);

	// 수정 -  파일업로드
	int updateUploadFree(Commu co);
}
