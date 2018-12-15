<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/11
  Time: 22:39
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
    <script type="text/javascript" src="${ctx}/static/js/plugins/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src='${ctx}/static/js/plugins/jquery-validation/jquery.validate.js'></script>
    <!-- noty插件 start -->
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/jquery.noty.js'></script>
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/layouts/topRight.js'></script>
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/themes/default.js'></script>
    <style>.login-container .login-box{padding-top: 50px;}</style>
    <script>
        $(function(){
            $("#registerForm").validate({
                rules: {
                    repassword: {
                        comparePassword: true
                    },
                    phone: {
                        isPhone: true
                    },
                    email:{
                        isEmail: true
                    }
                },
                submitHandler: function () {
                    registerUser();
                }
            });
        });
        $.extend(jQuery.validator.messages, {required: '必填字段'});
        //密码校验
        $.validator.addMethod("comparePassword", function (value) {
            var password = $("input[name='password']").val();
            if (value != password) {
                return false;
            }
            return true;
        }, "密码不一致！");
        //手机号码效验
        $.validator.addMethod("isPhone", function (value, element) {
            var reg = /^1[34578]\d{9}$/;
            return this.optional(element) || reg.test(value);
        }, "手机号码格式不正确");
        //电子邮箱校验
        $.validator.addMethod("isEmail",function(value,element){
            var isEmail =  /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)+(\.\w{2,3})+$/;
            return this.optional(element) ||isEmail.test(value);
        },"电子邮箱格式不正确");
        function registerUser(){
            $("#registerForm").form('submit', {
                url: "${ctx}/register/registerUser",
                success: function (data) {
                    var data = eval('(' + data + ')');
                    if (data.result) {
                        noty({
                            text: data.message,
                            layout: 'topRight',
                            buttons: [
                                {addClass: 'btn btn-success btn-clean', text: '去登录', onClick: function($noty) {
                                    $noty.close();
                                    window.location.href="${ctx}/auth";
                                }
                            }]
                        });
                    } else {
                        noty({text: data.message, layout: 'topRight', type: 'error', timeout: 5000});
                    }
                    $("#registerForm").form("clear");
                }
            });
        }
    </script>
</head>
<body>
<div class="login-container lightmode">
    <div class="login-box animated fadeInDown">
        <div class="login-logo"></div>
        <div class="login-body">
            <div class="login-title">用户注册</div>
            <form class="form-horizontal" id="registerForm" method="post">
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" class="form-control" required name="username" placeholder="用户名"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="password" class="form-control" required name="password" placeholder="密码"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="password" class="form-control" required name="repassword" placeholder="确认密码"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" class="form-control" required name="email" placeholder="Email"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" class="form-control" required name="phone" placeholder="联系电话"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input class="btn btn-danger btn-block" style="height: 40px;" type="submit" value="注册" />
                    </div>
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






