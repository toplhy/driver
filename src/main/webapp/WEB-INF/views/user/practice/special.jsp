<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/24
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function(){
        $("#tab1").addClass("active");
    });
    function loadComments(value,qid){
        $.post("${ctx}/user/practice/comments", {"qid":qid,"value":value}, function(data, status) {
            $("#commentsDiv" + value).html(data);
            $("#commentBtn" + value).html("收起评论");
            $("#commentBtn" + value).attr("onclick","hideComments("+value+","+qid+")");
        }, "html");
    }
    function hideComments(value, qid){
        $("#commentsDiv" + value).html("");
        $("#commentBtn" + value).html("查看评论");
        $("#commentBtn" + value).attr("onclick","loadComments("+value+","+qid+")");
    }
    function preQuestion(value){
        $("#tab" + value).removeClass("active");
        value = parseInt(value) - 1;
        $("#tab" + value).addClass("active");
    }
    function nextQuestion(value){
        if(value != ${questions.size()}){
            $("#tab" + value).removeClass("active");
            value = parseInt(value) + 1;
            $("#tab" + value).addClass("active");
        }else{
            noty({text:"你已经做完了所有试题。", layout: 'topRight', type: 'success', timeout: 3000});
        }
    }
    function submitAnswer(value, answer, qid){
        var arr = new Array();
        $("input[name='type"+value+"']:checked").each(function(){
            arr.push($(this).val());
        });
        if(arr.join(",") == ""){
            noty({text:"请选择你认为正确的答案。", layout: 'topRight', type: 'error', timeout: 3000});
            return;
        }else if(arr.join(",") == answer){
            nextQuestion(value);
        }else{
            $("#analysisDiv" + value).show();
            markWrong({"qid":qid});
        }
        $("#submitBtn" + value).hide();
    }
    function markWrong(obj){
        $.post("${ctx}/user/practice/wrong", obj, function(data, status) {}, "json");
    }
    function collect(value,qid){
        $.post("${ctx}/user/practice/collect", {"qid":qid}, function(data, status) {
            if(data.result){
                $("#collectBtn" + value).html("取消收藏");
                $("#collectBtn" + value).attr("onclick","cancelCollect("+value+","+qid+")");
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        }, "json");
    }
    function cancelCollect(value,qid){
        $.post("${ctx}/user/practice/cancelCollect", {"qid":qid}, function(data, status) {
            if(data.result){
                $("#collectBtn" + value).html("收藏");
                $("#collectBtn" + value).attr("onclick","collect("+value+","+qid+")");
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        }, "json");
    }
    function tranModal(){
        if($("#transBtn").html() == "答题模式"){
            $("#transBtn").html("背题模式");
            $(".submitBtn").attr("disabled","disabled");
            $("input[type='checkbox']").attr("disabled","disabled");
            $("input[type='radio']").attr("disabled","disabled");
            $(".analysis").show();
        }else{
            $("#transBtn").html("答题模式");
            $(".submitBtn").removeAttr("disabled");
            $("input").removeAttr("disabled");
            $(".analysis").hide();
        }
    }
</script>
<div class="panel">
    <div class="panel-body">
        <div class="row">
            <div class="col-md-3">
                <a href="#" class="tile tile-default">
                    <h3>${item.name}</h3>
                    <h3>专项练习</h3>
                    <h3>${point.name}</h3>
                    <h3>[共${questions.size()}题]</h3>
                    <p><button id="transBtn" class="btn btn-info" type="button" onclick="tranModal()">答题模式</button>
                        <button class="btn" type="button" style="background-color: #C6C6C6;" onclick="centerLoad('user/practice/main',{'ibid':${item.id}})">返回上页</button></p>
                </a>
            </div>
            <div class="col-md-8">
                <div class="panel-body tab-content" style="border: 1px solid #D5D5D5;border-radius: 5px;">
                    <c:if test="${fn:length(questions)>0}">
                        <c:forEach items="${questions}" var="question" varStatus="i">
                            <div class="tab-pane" id="tab${i.index+1}">
                                <p><strong>${i.index+1}/${questions.size()}</strong>&nbsp;${question.get("content")}</p>
                                <c:forEach items="${question.get('options')}" var="option">
                                    <p>
                                        <c:if test="${question.get('type') == '单选题'}">
                                            <input type="radio" name="type${i.index+1}" value="${option.key}"/>&nbsp;&nbsp;${option.key}.${option.value}
                                        </c:if>
                                        <c:if test="${question.get('type') == '多选题'}">
                                            <input type="checkbox" name="type${i.index+1}" value="${option.key}"/>&nbsp;&nbsp;${option.key}.${option.value}
                                        </c:if>
                                    </p>
                                </c:forEach>
                                <button class="btn btn-info" type="button" value="${i.index+1}" <c:if test="${i.index == 0}">disabled</c:if> onclick="preQuestion(this.value)">上一题</button>
                                <button class="btn btn-info" type="button" value="${i.index+1}" onclick="nextQuestion(this.value)">下一题</button>
                                <button id="submitBtn${i.index+1}" class="btn btn-warning submitBtn" type="button" value="${i.index+1}" onclick="submitAnswer(this.value,'${question.answer}','${question.id}')">提交答案</button>
                                <c:if test="${question.isCollected == true}">
                                    <button id="collectBtn${i.index+1}" class="btn btn-warning" type="button" value="${i.index+1}" onclick="cancelCollect(this.value,'${question.id}')">取消收藏</button>
                                </c:if>
                                <c:if test="${question.isCollected == false}">
                                    <button id="collectBtn${i.index+1}" class="btn btn-warning" type="button" value="${i.index+1}" onclick="collect(this.value,'${question.id}')">收藏</button>
                                </c:if>

                                <div class="analysis" id="analysisDiv${i.index+1}" style="display: none;">
                                    <hr/>
                                    <h4>试题详解</h4>
                                    <p><span class="label label-success label-form">正确答案</span>&nbsp;${question.answer}</p>
                                    <p><span class="label label-warning label-form">试题考点</span>&nbsp;${question.point}</p>
                                    <p><span class="label label-info label-form">试题解析</span>&nbsp;${question.analysis}</p>
                                </div>
                                <hr/>
                                <a href="javascript:void(0);" id="commentBtn${i.index+1}" onclick="loadComments(${i.index+1},${question.id})">查看评论</a>
                                <div id="commentsDiv${i.index+1}"></div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${fn:length(questions)<1}">
                        <div style="text-align: center">题库中没有试题</div>
                    </c:if>
                </div>
            </div>
            <div class="col-md-1"></div>
        </div>
    </div>
</div>