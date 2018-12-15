<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/23
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    function publishComment(value,qid){
        var content = $("#content${value}").val();
        if(content == ""){
            noty({text: "写下你想说的话。", layout: 'topRight', type: 'error', timeout: 3000});
            return;
        }
        $.post("${ctx}/user/practice/publish", {"qid":qid,"content":content}, function(data, status) {
            if(data.result){
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                loadComments(value,qid);
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        }, "json");
    }
</script>
<div class="input-group">
    <br/>
    <input type="text" id="content${value}" class="form-control" placeholder="说点什么吧..."/>
    <span class="input-group-btn">
        <button class="btn btn-primary" type="button" onclick="publishComment(${value},${question})">发表</button>
    </span>
</div>
<br/>
<div class="panel-body list-group list-group-contacts">
    <c:if test="${fn:length(comments) > 0}">
        <c:forEach items="${comments}" var="comment">
            <a href="javascript:void(0);" class="list-group-item">
                <img src="${ctx}//aviator/${comment.aviator==null?'default.jpg':comment.aviator}" class="pull-left" alt="${comment.username}"/>
                <span class="contacts-title">${comment.username}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${comment.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/> </span>
                <p>${comment.content}</p>
            </a>
        </c:forEach>
    </c:if>
    <c:if test="${fn:length(comments) < 1}">
        <div class="list-group-item">
            目前还没有评论
        </div>
    </c:if>
</div>