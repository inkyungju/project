package kr.co.menupass.common.template;

import kr.co.menupass.common.model.dto.PageInfo2;

public class Pagination2 {
	
	public static PageInfo2 getPageInfo(int listCount, int currentPage, 
									   int pageLimit, int boardLimit) {
		
		// listCount : 40.0
		// boardLimit : 15.0
		// 40.0 / 15.0  =  2.66666…
		// Math.ceil : 3
		int maxPage = (int)(Math.ceil(((double)listCount/boardLimit)));
		
		// currenPage = 39
		// pageLimit = 10
		// (currentPage-1) = 15
		// (currentPage-1) / pageLimit
		//       39        /    10      =  3
		// (currentPage-1) / pageLimit * pageLimit + 1
		//       39            10           10        =  1x30+1
		// 11, 21,  31
		int startPage = (currentPage-1) / pageLimit * pageLimit + 1;
		
		//               11    +    10   -1  : 20
		//               41    +    10   -1  : 50
		int endPage = startPage+pageLimit-1;
		
		if(endPage>maxPage) {
			endPage = maxPage;
		} 
		
		return new PageInfo2(listCount, currentPage, pageLimit, boardLimit,
							maxPage, startPage, endPage);
		
	}
}








