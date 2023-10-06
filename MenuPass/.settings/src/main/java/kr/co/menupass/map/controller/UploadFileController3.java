package kr.co.menupass.map.controller;

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

import kr.co.menupass.map.dto.MapList;
import kr.co.menupass.map.service.MapListServiceImpl;

@Controller
public class UploadFileController3 {
	public static final String UPLOAD_PATH="/Users/choeeungyeong/Documents/workspace-sts-3.9.18.RELEASE/Project/src/main/webapp/resources/upload/";
	
	@Autowired
	private MapListServiceImpl maplistService;
	
	public boolean updateImage(MultipartFile upload, MapList maplist) {
		int result = maplistService.insertReview(maplist);
		
		if(!Objects.isNull(maplist)) {
			
			//"C:Project\\src\\main\\webapp\\resources\\upload\\230706131523_awk@kwNJ.png";
			File deleteFile = new File(maplist.getUploadPath()+maplist.getUploadName());
			
			deleteFile.delete();
			
			return true;
			
		} else {
			
			return false;
		}
	}
		
	
	public static void uploadFile(MultipartFile reviewImage, 
						   MapList maplist) throws IllegalStateException, IOException {
		
		if(!reviewImage.isEmpty()) { // 비어있지 않을 때
			// 원본 파일명
			String originalName = reviewImage.getOriginalFilename();
			
			// 확장자
			// 제목없음.png > .png
			String extension = originalName.substring(originalName.lastIndexOf("."));
			
			// 현재 시간 2023-07-06: 10:32:15
			LocalDateTime now = LocalDateTime.now(); 
			
			// 년 월 일 시 분 초 230706103215
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
			String output = now.format(formatter);
			
			// 랜덤 문자열 생성
			int length = 8; // 문자열 길이
			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
			
			Random random = new Random();
			String randomString = random.ints(length, 0, characters.length())
					.mapToObj(characters::charAt)
					.map(Object::toString)
					.collect(Collectors.joining());
			
			//                   날짜    _    랜덤 문자열      확장자
			//230706104225_akw@%!wn.png
			String fileName = (output+"_"+randomString+extension);
			
			// 경로 + 변경된 파일명
			String filePathName = UPLOAD_PATH + fileName;
						
			// 서버에 파일 저장
			// no.file.Path 임포트 
			Path filePath = Paths.get(filePathName);
			reviewImage.transferTo(filePath);
		
			maplist.setUploadPath(UPLOAD_PATH);
			maplist.setUploadOriginName(originalName);
			maplist.setUploadName(fileName);
		}
	}
}
