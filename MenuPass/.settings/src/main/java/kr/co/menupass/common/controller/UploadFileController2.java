package kr.co.menupass.common.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.co.menupass.commu.dto.Commu;
import kr.co.menupass.commu.service.CommuServiceImpl;
import kr.co.menupass.recommend.dto.Recommend;
import kr.co.menupass.recommend.service.RecommendServiceImpl;


@Controller
public class UploadFileController2 {
		public static final String uploadPath = "C:\\prj\\spring\\FinalProject\\src\\main\\webapp\\resources\\upload\\";

		@Autowired
		private CommuServiceImpl commuService;
		
		public boolean deleteFile(MultipartFile upload, Commu co) {
			co = commuService.detailBoard(co.getC_board_No());
			if(!Objects.isNull(co)) {
				File deleteFile = new File(co.getUploadPath()+co.getUploadName());
				deleteFile.delete();
				return true;
				} else {
					return true;
				}
		}
		
		public Commu uploadFile(MultipartFile upload,  
					   Commu co) throws IllegalStateException, IOException {
		if(!upload.isEmpty()) {
			// 원본 파일명
			String originalName = upload.getOriginalFilename();
			
			// 확장자
			// 제목없음.png -> extension에 담기는건 .png
			String extension = originalName.substring(originalName.lastIndexOf("."));
			
			// 2023-07-06: 10:32:15
			LocalDateTime now = LocalDateTime.now();
			
			// 23 07 06 10 32 15
			// 년  월  일  시  분  초
			DateTimeFormatter fomatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
			String output = now.format(fomatter);
			
			// 랜덤문자열 생성
			int length = 8; // 문자열 길이 
			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
			
			Random random = new Random();
			String randomString = random.ints(length, 0, characters.length())
						.mapToObj(characters::charAt)
						.map(Object::toString)
						.collect(Collectors.joining());		
			
			//					날짜	   	 -		랜덤문자열	   +	 확장자
			String fileName = (output + "_" + randomString + extension);
			
			// 경로 + 변경된 파일명
			String filePathName = uploadPath + fileName;
			
			// 서버에 파일 저장
			// no.file.Path 임포트
			Path filePath = Paths.get(filePathName);
			upload.transferTo(filePath);
			
			co.setUploadPath(uploadPath);
			co.setUploadOriginName(originalName);
			co.setUploadName(fileName);
		}	
		return co;
	}
}
