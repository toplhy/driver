<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/19
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel-body form-group-separated">
    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">用户名</label>
        <div class="col-md-9 col-xs-12" style="line-height: 30px;">${user.username}</div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">用户身份</label>
        <div class="col-md-9 col-xs-12" style="line-height: 30px;">${role}</div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">Email</label>
        <div class="col-md-9 col-xs-12" style="line-height: 30px;">${user.email}</div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">联系电话</label>
        <div class="col-md-9 col-xs-12" style="line-height: 30px;">${user.phone}</div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">注册时间</label>
        <div class="col-md-9 col-xs-12" style="line-height: 30px;"><fmt:formatDate value="${user.createtime}" pattern="yyyy-MM-dd HH:mm"/> </div>
    </div>

    <div class="form-group"></div>

</div>