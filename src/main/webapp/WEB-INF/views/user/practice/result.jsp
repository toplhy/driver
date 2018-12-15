<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/29
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel">
    <div class="panel-body">
        <div class="row" style="margin: 80px 0;">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-body profile bg-info">

                        <div class="profile-image">
                            <img src="${ctx}/aviator/${user.aviator==null?'default.jpg':user.aviator}" alt="${user.username}">
                        </div>
                        <div class="profile-data">
                            <div class="profile-data-name">
                                <span style="font-size: 25px;">
                                    <c:if test="${history.score >= 90}">木仓车神</c:if>
                                    <c:if test="${history.score < 90}">马路杀手</c:if>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body list-group" style="text-align: center;">
                        <a href="javascript:void(0);" class="list-group-item">考生姓名：${user.username}</a>
                        <a href="javascript:void(0);" class="list-group-item">考试科目：${item.name}</a>
                        <a href="javascript:void(0);" class="list-group-item">考试成绩：${history.score}</a>
                        <a href="javascript:void(0);" class="list-group-item">考试开始时间：<fmt:formatDate value="${history.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                        <a href="javascript:void(0);" class="list-group-item">考试结束时间：<fmt:formatDate value="${history.submittime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>
    </div>
</div>