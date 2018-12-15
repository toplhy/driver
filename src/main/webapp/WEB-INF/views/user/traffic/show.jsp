<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/11
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function() {
        $("#tocify").tocify({context: ".tocify-content",scrollTo:70, showEffect: "fadeIn",extendPage:false,selectors: "h3, h4, h5" });
    });
</script>
<ul class="breadcrumb">
    <li class="active">交规学习</li>
</ul>
<div class="panel">
    <div class="row">
        <div class="col-md-9">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="tocify-content">
                        <c:forEach items="${traffics}" var="traffic">
                            <c:if test="${traffic.get('isLeaf') == false}">
                                <h${traffic.get('index')+2}>${traffic.get('name')}</h${traffic.get('index')+2}>
                            </c:if>
                            <c:if test="${traffic.get('isLeaf') == true}">
                                <h${traffic.get('index')+2}>${traffic.get('name')}</h${traffic.get('index')+2}>
                                ${traffic.get('content')}
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3" style="position: relative;">
            <div id="tocify"></div>
        </div>
    </div>
</div>
