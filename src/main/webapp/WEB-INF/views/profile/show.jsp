<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/12
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../includes/taglibs.jsp" %>
<script>
    function openAviatorDialog(){
        $('#aviatorModal').modal('show');
    }
    function openPasswordDialog(){
        $('#passwordModal').modal('show');
    }
    $('#aviatorForm').form({
        url:'${ctx}/workspace/changeAviator',
        success: function(data){
            var data = eval('(' + data + ')');
            if(data.result){
                $("#aviator1").attr("src",data.src);
                $("#aviator2").attr("src",data.src);
                $("#aviator3").attr("src",data.src);
                $('#aviatorModal').modal('hide');
                noty({text:data.message, layout: 'topRight', type: 'success', timeout: 2000});
            }else{
                $('#aviatorModal').modal('hide');
                noty({text:data.message, layout: 'topRight', type: 'error', timeout: 2000});
            }
        }
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
    $("#passwordForm").validate({
        rules: {
            password:{required:true},
            repassword: {required:true,comparePassword: true}
        },
        submitHandler: function () {
            resetPass();
        }
    });
    function resetPass(){
        $.post("${ctx}/workspace/resetPass",{"id":$("#uid").val(),"password":$("#password").val()},function(data){
            if(data.result){
                $('#passwordModal').modal('hide');
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        },"json");
    }
    $("#userForm").validate({
        rules: {
            email:{required:true,isEmail:true},
            phone: {required:true,isPhone: true}
        },
        submitHandler: function () {
            updateUser();
        }
    });
    function updateUser(){
        $.post("${ctx}/workspace/updateUser",{"id":$("#uid").val(),"email":$("#email").val(),"phone":$("#phone").val()},function(data){
            if(data.result){
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        },"json");
    }
</script>
<ul class="breadcrumb">
    <li class="active">个人中心</li>
    <li class="active">我的信息</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <form id="userForm" class="form-horizontal">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="text-center" id="user_image">
                                <img id="aviator3" src="${ctx}/aviator/${user.aviator==null?'default.jpg':user.aviator}" class="img-thumbnail" style="width: 100px;"/>
                            </div>
                        </div>

                        <div class="panel-body form-group-separated">
                            <input type="hidden" id="uid" value="${user.id}"/>
                            <div class="form-group">
                                <div class="col-md-3"></div>
                                <div class="col-md-6 col-xs-12" style="border-left: none;">
                                    <a href="#" class="btn btn-primary btn-block btn-rounded" data-toggle="modal" data-target="#modal_change_photo" onclick="openAviatorDialog();">更换头像</a>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-3"></div>
                                <div class="col-md-6 col-xs-12"  style="border-left: none;">
                                    <a href="#" class="btn btn-danger btn-block btn-rounded" data-toggle="modal" data-target="#modal_change_password" onclick="openPasswordDialog();">修改密码</a>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 col-xs-5 control-label">用户名</label>
                                <div class="col-md-9 col-xs-7">
                                    <input type="text" class="form-control" disabled value="${user.username}" style="background-color: #F9F9F9;color: #555;"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 col-xs-5 control-label">Email</label>
                                <div class="col-md-9 col-xs-7">
                                    <input type="text" id="email" value="${user.email}" name="email" class="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 col-xs-5 control-label">联系电话</label>
                                <div class="col-md-9 col-xs-7">
                                    <input type="text" id="phone" value="${user.phone}" name="phone" class="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-3 col-xs-5 control-label">注册时间</label>
                                <div class="col-md-9 col-xs-7">
                                    <input type="text" class="form-control" disabled value="<fmt:formatDate value='${user.createtime}' pattern='yyyy-MM-dd'/>" style="background-color: #F9F9F9;color: #555;"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-3"></div>
                                <div class="col-md-6 col-xs-12"  style="border-left: none;">
                                    <button type="submit" class="btn btn-info btn-block btn-rounded" data-toggle="modal">保存</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--更换头像--%>
<div class="modal" id="aviatorModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="aviatorForm" enctype="multipart/form-data" method="post" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">
                        更换头像
                    </h4>
                </div>
                <div class="modal-body" style="text-align: center;">
                    <input type="file" class="fileinput btn-success" name="aviator" required accept="image/png,image/gif,image/jpeg"  title="请选择头像图片"/>
                    <br>文件支持jpg、png、gif格式
                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="更换"/>
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="取消" />
                </div>
            </div>
        </div>
    </form>
</div>
<%--修改密码--%>
<div class="modal" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="passwordForm" enctype="multipart/form-data" method="post" class="form-horizontal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">
                        修改密码
                    </h4>
                </div>
                <div class="modal-body" style="text-align: center;">
                    <div class="panel-body form-group-separated">
                        <div class="form-group">
                            <label class="col-md-2 col-xs-12 control-label">新密码</label>
                            <div class="col-md-10">
                                <input type="password" id="password" class="form-control" required name="password"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 col-xs-12 control-label">确认密码</label>
                            <div class="col-md-10">
                                <input type="password" class="form-control" required name="repassword"/>
                            </div>
                        </div>
                        <div class="form-group"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="确认"/>
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="取消" />
                </div>
            </div>
        </div>
    </form>
</div>