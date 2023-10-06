package kr.co.menupass.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class login {
	  @RequestMapping("/")
	    public String member(Model model, HttpSession session) {
	    	String msg = (String) session.getAttribute("msg");
	    	session.removeAttribute("msg");

	    	return "/member/member";
	    }

}
