<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/18
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel-body">
    <input type="hidden" name="id" value="${point.id}">
    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">知识点名称</label>
        <div class="col-md-9 col-xs-12">
            <input type="text" class="form-control" name="name" required value="${point.name}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">所属题库</label>
        <div class="col-md-9 col-xs-12">
            <select class="form-control select" name="ibid">
                <c:forEach items="${itemList}" var="item">
                    <option value="${item.id}" <c:if test="${item.id == point.ibid}">selected</c:if>>${item.drivertype}·${item.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-3 col-xs-12 control-label">知识点描述</label>
        <div class="col-md-9 col-xs-12">
            <textarea class="form-control" name="descs" rows="3" required>${point.descs}</textarea>
        </div>
    </div>

</div>