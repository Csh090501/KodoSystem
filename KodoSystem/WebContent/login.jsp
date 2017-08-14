<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%> 
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <title>科多</title>
  <link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css'>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="wrapper" style="height: 20%; width: 100%;"></div>
    <div class="wrapper">
    <form class="form-signin" method="post" action="user/login.do" >       
      <h2 class="form-signin-heading">科多</h2>
      <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入用户名" />
      <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" />      
      <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>   
       <font color="red" style="margin-top: 5px;">${error }</font>
    </form>
  </div>
  <div class="wrapper" style="height: 20%; width: 100%;"></div>
</body>
</html>
