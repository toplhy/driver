<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/30
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<ul class="breadcrumb">
    <li class="active">用户中心</li>
    <li class="active">考试记录</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <c:if test="${histories.size()<1}">
            <div class="table-responsive" style="text-align: center;">
                您还没有考试记录
            </div>
        </c:if>
        <c:if test="${histories.size()>0}">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>考试科目</th>
                            <th>考试成绩</th>
                            <th>考试开始时间</th>
                            <th>考试结束时间</th>
                            <th>评价</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${histories}" var="history" varStatus="i">
                            <tr>
                                <td>${i.index+1}</td>
                                <td>${history.item}</td>
                                <td>${history.score}</td>
                                <td><fmt:formatDate value="${history.begintime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td><fmt:formatDate value="${history.submittime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <c:if test="${history.score>=90}"><span class="label label-success label-form">木仓车神</span></c:if>
                                    <c:if test="${history.score<90}"><span class="label label-danger label-form">马路杀手</span></c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>