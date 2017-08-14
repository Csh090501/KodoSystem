package com.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.LoginMapper;
import com.test.po.User;

@Service
public class LoginService implements LoginServiceInf{
	private LoginMapper loginMapper;
	public LoginMapper getLoginMapper() {
		return loginMapper;
	}
	//自动注入
    @Autowired
	public void setLoginMapper(LoginMapper loginMapper) {
		this.loginMapper = loginMapper;
	}
  //登录验证֤
	@Override
	public User checkLogin(User user) {
		return this.loginMapper.checkLogin(user);
	}

}
