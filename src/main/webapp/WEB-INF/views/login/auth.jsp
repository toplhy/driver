<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/3
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../includes/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en" class="body-full-height">
<head>
    <title>驾考练习平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="${ctx}/static/img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="${ctx}/static/css/theme-default.css"/>
</head>
<body>
<div class="login-container lightmode">
    <div class="login-box animated fadeInDown">
        <div class="login-logo"></div>
        <div class="login-body">
            <div class="login-title">用户登录</div>
            <div><font color="red">${message}</font></div>
            <form action="${ctx}/j_spring_security_check" class="form-horizontal" method="post">
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" class="form-control" name="j_username" placeholder="用户名"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="password" class="form-control" name='j_password' placeholder="密码"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input class="btn btn-info btn-block" style="height: 40px;" type="submit" value="登录" />
                    </div>
                </div>
                <div class="login-subtitle">
                    没有账号? <a href="${ctx}/register">点此注册</a>
                </div>
            </form>
        </div>
        <div class="login-footer">
            <div class="pull-left">
                &copy; 2017 驾考练习平台
            </div>
            <div class="pull-right">
                <a href="#">关于我们</a> |
                <a href="#">联系我们</a>
            </div>
        </div>
    </div>

</div>
</body>
</html>






