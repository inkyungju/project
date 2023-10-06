package kr.co.menupass.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

@Controller
public class SessionManageController {
	
	public void setSessionMessage(String msg, 
								  String status,
								  HttpSession session) {
	session.setAttribute("msg", msg);
	session.setAttribute("status", status);
}
}