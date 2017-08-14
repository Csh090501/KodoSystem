package com.test.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.test.po.User;
import com.test.service.LoginServiceInf;

@Controller
@RequestMapping("/user")
public class UserController {
	private LoginServiceInf loginService;
	public LoginServiceInf getLoginService() {
		return loginService;
	}
	//自动注入
	@Autowired
	public void setLoginService(LoginServiceInf loginService) {
		this.loginService = loginService;
	}
	
	//通过前台传进来的用户名密码进行登录验֤
	@RequestMapping("/login")
	public ModelAndView login(User user){
		ModelAndView mav = new ModelAndView();
		User currentUser = this.loginService.checkLogin(user);
		System.out.println(currentUser);
		if(currentUser!=null){
			mav.addObject("userName",currentUser.getUserName() );
			mav.setViewName("index");
		}else{
			mav.addObject("error","�û�����������");
			mav.setViewName("login");
		}
		return mav;
	}
}
