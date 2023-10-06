package kr.co.menupass.commu.dto;

import lombok.AllArgsConstructor;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Getter;
// Ctrl + Shift + O    ==> 자동 import
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class Commu {
	private int c_board_No;
	private int memberNo;
	private String category;
	private String memberName;
	private String userTitle;
	private String userContent;
	private String createDate;
	private int views;
	
	private String updateDate;
	private String updateMemberName;	
	private String deleteDate;
	private String u_delete;
	
	private String uploadPath;
	private String uploadName;
	private String uploadOriginName;
	
}
	