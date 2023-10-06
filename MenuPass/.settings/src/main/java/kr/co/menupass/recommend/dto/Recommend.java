package kr.co.menupass.recommend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Recommend {

// Ctrl + Shift + O    ==> 자동 import
	private int board_No;
	private int memberNo;
	private String category_Food;
	private String memberName;
	private String recommend_Title;
	private String recommend_Content;
	private String recommend_Grade;
	private String recommend_comment;
	private String createDate;
	private int views;
	
	private String uploadPath;
	private String uploadName;
	private String uploadOriginName;
	
	private String recommend_delete;
	
	private String restaurant_Name;
	private String restaurant_Addr;
	
		
}

	




