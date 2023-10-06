package kr.co.menupass.member.controller;

import java.util.Objects;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.menupass.member.dto.memberDto;
import kr.co.menupass.member.service.memberService;

@Controller
@RequestMapping("/member")
public class memberController {
   @Autowired
   private memberService memberService;
   @Autowired
   private BCryptPasswordEncoder bcryptPasswordEncoder;

   @RequestMapping("/login.do")
   public String login(memberDto au, HttpSession session, Model model) {
      memberDto loginmember = memberService.loginMember(au);
 
  
      if (!Objects.isNull(loginmember)
            && bcryptPasswordEncoder.matches(au.getMemberPw(), loginmember.getMemberPw())) {
         session.setAttribute("username", loginmember.getMemberName());
         session.setAttribute("memberNo", loginmember.getMemberNo());

         session.setAttribute("msg","[" + loginmember.getMemberName()+ "]" + "님 Welcome to MenuPass.");
         session.setAttribute("status", "success");
         return "redirect:/maplist/list.do";
      } else { 
    	  model.addAttribute("msg", "ID / PASSWORD를 확인하세요");
    	  model.addAttribute("status", "error");
         return "/member/member";
      }
   }

// 회원가입

   @PostMapping("/register.do")
   public String signup(memberDto au,
		   				HttpSession session) {
      String password = au.getMemberPw();
      String passwordRegex = "^(?=.*[a-z])(?=.*[!@#$%^&+=])[A-Za-z\\d@$!%*?&#]{6,20}$";
      String email = au.getMemberEmail();
      String passwordCheck = au.getPasswordChk();
      
      String isEmailAvailable = Email(email);
      // 비밀번호가 정규식에 맞고 이메일 중복 체크에도 성공하며 비밀번호와 비밀번호 확인이 일치하는 경우
      if (password.matches(passwordRegex) && isEmailAvailable.equals("success") && password.equals(passwordCheck)) {
         String bcryptPassword = bcryptPasswordEncoder.encode(au.getMemberPw());
         au.setMemberPw(bcryptPassword);
         int result = memberService.signupmember(au);
         

         // 회원 가입에 성공한 경우 메인 페이지로 이동
         if (result > 0) {
        	 session.setAttribute("msg", "회원가입 성공!");
             session.setAttribute("status", "success");
            return "/member/member";
         } else {
            // 회원 가입에 실패한 경우 회원 가입 페이지로 이동
        	 session.setAttribute("msg", "회원가입 실패!");
             session.setAttribute("status", "error");
            return "member/member";
         }
      } else {
         // 비밀번호가 정규식에 맞지 않거나 이메일 중복 체크에 실패하거나 비밀번호와 비밀번호 확인이 일치하지 않는 경우
         // 회원 가입 페이지로 이동
    	  session.setAttribute("msg", "아이디/이메일/비밀번호를 확인하여 주세요!");
          session.setAttribute("status", "error");
         return "redirect:/";
         // localhost/
         // /WEB-INF/views//.jsp
      }
   }

   @GetMapping("/updatein")
   public String updatein(Model model, HttpSession session) {
      int idx = (int) session.getAttribute("memberNo");
      memberDto result = memberService.updatein(idx);
      System.out.println(result);
      model.addAttribute("result", result);
      return "/member/memberUpdate";
   }

   @PostMapping("updateout")
   public String updateMember(memberDto au, HttpSession session) {
      int idx = (int) session.getAttribute("memberNo");
      au.setMemberNo(idx);

      String password = au.getMemberPw();
      String passwordRegex = "^(?=.*[a-z])(?=.*[!@#$%^&+=])[A-Za-z\\d@$!%*?&#]{6,20}$";

      if (!password.matches(passwordRegex)) {
         return "redirect:/"; // 비밀번호 정규식에 맞지 않으면 에러 페이지로 리디렉션
      }
      

      // 비밀번호 암호화
      String bcryptPassword = bcryptPasswordEncoder.encode(password);
      au.setMemberPw(bcryptPassword);

      int result = memberService.updateMemberInfo(au);
      if (result > 0) {
         return "redirect:/maplist/list.do"; // 업데이트 성공 시 메인 페이지로 리디렉션
      } else {
         return "redirect:/"; // 업데이트 실패 시 에러 페이지로 리디렉션
      }
   }

   public String Email(String email) {
      int result = memberService.memberEmail(email);
      if (result > 0) {
         return "failed";
      } else {
         return "success";
      }
   }
   
   @GetMapping("/logout")
   public String logout(HttpSession session,
		   				HttpServletResponse response) {


      session.invalidate(); // 세션 무효화	
      // 로그아웃 후 리다이렉트할 페이지 URL로 리턴
      return "redirect:/"; // 로그아웃 후 메인 페이지로 이동하도록 설정
   }
   
}