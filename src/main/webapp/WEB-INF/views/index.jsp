<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/3
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="includes/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>驾考练习平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="${ctx}/static/img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" id="theme" href="${ctx}/static/css/theme-default.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/bootstrap-table/bootstrap-table.css">

    <script type="text/javascript" src="${ctx}/static/js/plugins/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jstree.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src='${ctx}/static/js/plugins/jquery-validation/jquery.validate.js'></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/bootstrap/bootstrap-file-input.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/bootstrap/bootstrap-select.js"></script>

    <!-- noty插件 start -->
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/jquery.noty.js'></script>
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/layouts/topRight.js'></script>
    <script type='text/javascript' src='${ctx}/static/js/plugins/noty/themes/default.js'></script>
    <%--富文本编辑器插件--%>
    <script type="text/javascript" src="${ctx}/static/js/plugins/summernote/summernote.js"></script>
    <%--tour插件--%>
    <script type="text/javascript" src="${ctx}/static/js/plugins/tour/intro.min.js"></script>
    <%--tagsinput插件--%>
    <script type="text/javascript" src="${ctx}/static/js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
    <%--Donut Chart插件--%>
    <script type="text/javascript" src="${ctx}/static/js/plugins/morris/raphael-min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugins/morris/morris.min.js"></script>
    <%--tocity插件--%>
    <script type="text/javascript" src="${ctx}/static/js/plugins/tocify/jquery.tocify.min.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/plugins.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/actions.js"></script>

    <style>.modal-dialog{margin: 50px auto;}</style>
    <script>
        $(function(){
            $.ajaxSetup({
                cache:false,
                complete:function(XMLHttpRequest, textStatus){
                    if(this.type=='POST' && this.dataType == 'html'){
                        pageLoadingFrame("hide");
                    }
                },
                beforeSend:function(xhr){
                    xhr.setRequestHeader('Content-Session', $("#currentSessionId").val());
                    if(this.type=='POST' && this.dataType == 'html'){
                        pageLoadingFrame("show");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown){
                    if (jqXHR.status==401){

                    }else if (jqXHR.status==403){

                    }else if(jqXHR.status==500){

                    }
                },
                traditional : true
            });
            <sec:authorize ifAnyGranted="ROLE_USER">
                initUserMenu("小车");
            </sec:authorize>
        });
        function centerLoad(url,obj) {
            $.post(url,obj, function(data, status) {
                $("#mainTab").html('');
                $("#mainTab").html(data);
                $('.select').selectpicker();
                $(".tagsinput").tagsInput({width: '100%',height:'auto',defaultText: "添加关键字"});
            }, "html");
        }
        function setItemBank(name){
            $.post("${ctx}/welcome", function(data, status) {
                $("#mainTab").html('');
                $("#mainTab").html(data);
                $("#itemName").html(name);
                initUserMenu(name);
            }, "html");
        }
        function initUserMenu(name){
            $.post("${ctx}/user/getMenuList",{"name":name}, function(data, status) {
                var html = "";
                for(var i=0; i<data.length; i++){
                    html += "<li><a href='#' onclick='centerLoad(\"${ctx}/user/practice/main\",{\"ibid\":"+data[i].id+"})'><span class='xn-text'>"+ data[i].name +"</span></a></li>";
                }
                $("#userMenu").html(html);
            }, "json");
        }
    </script>
</head>
<body>
<div class="page-container page-navigation-top-fixed">

    <!--左侧导航-->
    <div class="page-sidebar page-sidebar-fixed scroll">
        <ul class="x-navigation">
            <li class="xn-logo">
                <a href="index.html">驾考练习平台</a>
            </li>
            <%--人物简介--%>
            <%@include file="includes/profile.jsp"%>
            <%--菜单--%>
            <%@include file="includes/menu.jsp"%>
        </ul>
        <!-- END X-NAVIGATION -->
    </div>

    <div class="page-content">

        <!-- 顶部导航 -->
        <ul class="x-navigation x-navigation-horizontal x-navigation-panel">
            <!--首页-->
            <li class="xn-icon-button pull-left">
                <a href="${ctx}/index"><span class="fa fa-home"></span></a>
            </li>
            <sec:authorize ifAnyGranted="ROLE_USER">
                <%--题库--%>
                <li class="xn-icon-button pull-left">
                    <a href="javascript:void(0);" id="itemName" style="width: 70px;">${items[0].name}</a>
                    <ul class="xn-drop-right xn-drop-white animated zoomIn" style="width: 150px;">
                        <c:forEach items="${items}" var="item">
                            <li><a href="javascript:void(0);" onclick="setItemBank('${item.name}')"><span class="flag flag-gb"></span>${item.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </sec:authorize>
            <!--退出-->
            <li class="xn-icon-button pull-right">
                <a href="#" class="mb-control" data-box="#mb-signout"><span class="fa fa-sign-out"></span></a>
            </li>
            <%--个人信息--%>
            <li class="xn-icon-button pull-right">
                <a href="javascript:void(0);" onclick="centerLoad('${ctx}/workspace/showProfile')"><span class="fa fa-info"></span></a>
            </li>
        </ul>

        <div id="mainTab" class="page-content-wrap">
            <div style="margin: 12% auto;text-align: center;">
                <img src="${ctx}/static/img/welcome.gif" />
                <div style="font-size: 35px;">欢迎来到驾考练习平台</div>
            </div>
        </div>
    </div>
</div>

<!--退出框-->
<div class="message-box animated fadeIn" data-sound="alert" id="mb-signout">
    <div class="mb-container">
        <div class="mb-middle">
            <div class="mb-title"><span class="fa fa-sign-out"></span><strong>退出</strong></div>
            <div class="mb-content">
                <p>您确定要退出吗?</p>
                <p>点击取消返回页面，点击确定退出登录。</p>
            </div>
            <div class="mb-footer">
                <div class="pull-right">
                    <a href="${ctx}/j_spring_security_logout" class="btn btn-success btn-lg">确定</a>
                    <button class="btn btn-default btn-lg mb-control-close">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>






