package kr.co.menupass.common.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor    // 기본 생성자 주입
@AllArgsConstructor   // 매개변수 있는 생성자 주입
public class PageInfo {
	// 전체 게시글 수
	private int listCount;
	
	// 현재 페이지
	private int currentPage;
	
	//페이지에 보일 개수, 시작 개수
	private int itemsPerPage;
	private int start;
	
	
}
