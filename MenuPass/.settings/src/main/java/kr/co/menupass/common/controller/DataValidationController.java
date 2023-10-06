package kr.co.menupass.common.controller;

import org.springframework.stereotype.Controller;

@Controller
public class DataValidationController {
	public boolean nullCheck(String data) {
		if(data.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}
		public Boolean LanguageCheck(String data) {
		int byteLength = 0;
							//문자 열이 아니라 문자 ex. 안넝하세요 --> ['안','녕','하','세','요']
		for(char c : data.toCharArray()) {
			// 영어일때
			if(Character.toString(c).matches("[a-zA-Z]")) {
				byteLength +=1; // 영어 1바이트
			}
			// 한글일때
			else if(Character.toString(c).matches("[ㄱ-ㅎㅏ-ㅣ가-힣]")) {
				byteLength +=3; // 한글 3바이트
			}
		}
		// 총 문자열의 크기(바이트)가 FREE 테이블의 컬럼 크기(varchar2(50)) 보다 큰 경우
		if(byteLength > 100) {
			return false;
		} else {
			return true;
		}
	}

}
