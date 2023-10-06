package kr.co.menupass.common.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor    // 기본 생성자 주입
@AllArgsConstructor   // 매개변수 있는 생성자 주입
public class PageInfo2 {
	// 전체 게시글 수
	private int listCount;
	
	// 현재 페이지
	private int currentPage;
	
	// 보여질 페이지 수
	private int pageLimit;
	
	// 보여질 게시글 수
	private int boardLimit;
	
	// 전체 페이지, 시작 페이지, 끝 페이지
	private int maxPage;
	private int startPage;
	private int endPage;
	
}
