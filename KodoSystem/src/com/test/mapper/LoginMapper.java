package com.test.mapper;

import org.apache.ibatis.annotations.Select;

import com.test.po.User;

public interface LoginMapper {
	//查询用户名密码是否存在，登录验证
	@Select("select * from user where userName=#{userName} and password=#{password}")
    public User checkLogin(User user);
}