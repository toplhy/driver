<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/31
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel-body form-group-separated">
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            ${question.item}/${question.type}
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            ${question.content}<br/>
            <c:forEach items="${options}" var="option">
                ${option.key}.${option.value}<br/>
            </c:forEach>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            正确答案：${question.answer}
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            试题难度：
            <c:if test="${question.diff == 1}">I</c:if>
            <c:if test="${question.diff == 2}">II</c:if>
            <c:if test="${question.diff == 3}">III</c:if>
            <c:if test="${question.diff == 4}">IV</c:if>
            <c:if test="${question.diff == 5}">V</c:if>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            试题解析：${question.analysis}
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            试题考点：${question.points}
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12 col-xs-12">
            关键字：${question.keyword}
        </div>
    </div>
    <div class="form-group"></div>
</div>