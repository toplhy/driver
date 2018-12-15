<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/19
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel-body">
    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">用户名</label>
        <div class="col-md-9 col-xs-12">
            <input type="text" class="form-control" name="username" required value="${user.username}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">Email</label>
        <div class="col-md-9 col-xs-12">
            <input type="text" class="form-control" name="email" required value="${user.email}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">联系电话</label>
        <div class="col-md-9 col-xs-12">
            <input type="text" class="form-control" name="phone" required value="${user.phone}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">用户身份</label>
        <div class="col-md-9 col-xs-12">
            <select class="form-control select" name="role">
                <option value="admin">管理员</option>
                <option value="user">普通用户</option>
            </select>
        </div>
    </div>

</div>