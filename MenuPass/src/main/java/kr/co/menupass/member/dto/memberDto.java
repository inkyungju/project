package kr.co.menupass.member.dto;

import java.util.Date;

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
public class memberDto {
    private int memberNo;
    private String memberName;
    private String memberPw;
    private String memberEmail;

	private String passwordChk;

	}
    
