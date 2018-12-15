<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/19
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    function showPoints(ibid){
        $.post("${ctx}/user/practice/showPoints", {"ibid":ibid}, function(data, status) {
            var html = "";
            $.each(data,function(index, element){
                html += "<a href='javascript:void(0);' class='list-group-item' onclick='showSpecial("+element.id+")'>" + element.name + "</a>";
            });
            $("#pointsList").html(html);
            $("#poitsModal").modal("show");
        }, "json");
    }
    function showSpecial(pid){
        var url = "${ctx}/user/practice/special";
        $("#poitsModal").modal("hide");
        centerLoad(url,{"pid":pid});
    }
</script>
<ul class="breadcrumb">
    <li class="active">试题练习</li>
    <li class="active">${item.name}</li>
</ul>
<div class="page-content-wrap">
    <div class="row"  style="margin-top: 20px;">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <%--专项special--%>
            <a href="#" class="tile tile-default" onclick="showPoints(${item.id})">
                <span class="fa fa-bullseye"></span>
                <p>专项练习</p>
            </a>
        </div>
        <div class="col-md-4">
            <%--随机random--%>
            <a href="#" class="tile tile-default"  onclick="centerLoad('user/practice/random',{'itemId':${item.id}})">
                <span class="fa fa-random"></span>
                <p>随机练习</p>
            </a>
        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row" style="margin-top: 20px;">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <a href="#" class="tile tile-default"  onclick="centerLoad('user/practice/wrongs',{'itemId':${item.id}})">
                <span class="fa fa-times-circle"></span>
                <p>错题练习</p>
            </a>
        </div>
        <div class="col-md-4">
            <a href="#" class="tile tile-default" onclick="centerLoad('user/practice/diff',{'itemId':${item.id}})">
                <span class="fa fa-lightbulb-o"></span>
                <p>难题攻克</p>
            </a>
        </div>
        <div class="col-md-2 "></div>
    </div>
    <div class="row" style="margin-top: 20px;">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <a href="#" class="tile tile-default" onclick="centerLoad('user/practice/exam',{'itemId':${item.id}})">
                <span class="fa fa-clock-o"></span>
                <p>模拟考试</p>
            </a>
        </div>
        <div class="col-md-4">
            <a href="#" class="tile tile-default" onclick="centerLoad('user/practice/collections',{'itemId':${item.id}})">
                <span class="fa fa-star"></span>
                <p>我的收藏</p>
            </a>
        </div>
        <div class="col-md-2"></div>
    </div>
</div>

<div class="modal" id="poitsModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">${item.name}知识点选择</h4>
            </div>
            <div class="modal-body">
                <div id="pointsList" class="list-group border-bottom">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>