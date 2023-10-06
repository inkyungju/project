package kr.co.menupass.common.template;

import kr.co.menupass.common.model.dto.PageInfo;


public class Pagination {
	
	public static PageInfo getPageInfo(int listCount, int currentPage) {
		
        // 페이지당 아이템 개수
        int itemsPerPage = 6;
        
		// 시작 인덱스 계산
        int start = (currentPage - 1) * itemsPerPage;
        
        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) listCount / itemsPerPage);

        // 현재 페이지 범위 조정
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages) {
            currentPage = totalPages;
        }

		return new PageInfo(listCount, currentPage, itemsPerPage, start);
		
	}
	
}