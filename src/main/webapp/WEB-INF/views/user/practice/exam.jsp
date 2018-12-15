<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<style>
    .label-default {
        background-color: #dfdfdf;
    }
</style>
<script>
    var flag;
    var right = 0,wrong= 0,score=0,wscore=0;
    function timer(intDiff){
        flag = window.setInterval(function(){
            var day=0,hour=0,minute=0,second=0;//时间默认值
            if(intDiff > 0){
                day = Math.floor(intDiff / (60 * 60 * 24));
                hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
                minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
                second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
            }else if(intDiff == 0){
                alert("考试结束");
                window.clearInterval(flag);
            }
            if (hour <= 9) hour = '0' + hour;
            if (minute <= 9) minute = '0' + minute;
            if (second <= 9) second = '0' + second;
            $('#hour_show').html('<s id="h"></s>'+hour+':');
            $('#minute_show').html('<s></s>'+minute+':');
            $('#second_show').html('<s></s>'+second+'');
            intDiff--;
        }, 1000);
    }
    $(function(){
        <c:if test="${questions != null}">
            timer(parseInt(${item.duration*60}));
            $("#begin").val(new Date());
            $("#tab1").addClass("active");
        </c:if>
    });
    function commitPaper(){
        if(confirm("您确认要交卷吗？")){
            window.clearInterval(flag);
            $("#commit").val(new Date());
            commit();
        }
    }
    function commit(){
        centerLoad("${ctx}/user/practice/commit",{"item":${item.id},"score":score,"begintime":$("#begin").val(),"submittime":$("#commit").val()});
    }
    function showQuestion(index){
        $(".tab-pane").removeClass("active");
        $("#tab" + index).addClass("active");
    }
    function submitAnswer(value, answer, sc){
        var arr = new Array();
        $("input[name='type"+value+"']:checked").each(function(){
            arr.push($(this).val());
        });
        if(arr.join(",") == ""){
            noty({text:"请选择你认为正确的答案。", layout: 'topRight', type: 'error', timeout: 3000});
            return;
        } else if(arr.join(",") == answer){
            right = right + 1;
            score = score + sc;
            $("#submitBtn" + value).hide();
            $("#label" + value).css("background-color","#95b75d");
        }else{
            wrong = wrong + 1;
            wscore = wscore +sc;
            $("#submitBtn" + value).hide();
            $("#label" + value).css("background-color","#b64645");
        }
        if(wscore <= ${item.totalscore - item.passscore} && value!=${fn:length(questions)}){
            nextQuestion(value);
        }else if(wscore > ${item.totalscore - item.passscore} ){
            window.clearInterval(flag);
            $("#messageModalBody").html("您已答错"+wrong+"道题，考试结束，请交卷。");
            $("#commit").val(new Date());
            $("#messageModal").modal("show");
        }
    }
    function nextQuestion(value){
        $("#tab" + value).removeClass("active");
        value = parseInt(value) + 1;
        $("#tab" + value).addClass("active");
    }
</script>
<c:if test="${questions != null}">
    <div class="panel">
        <div class="panel-body">
            <div class="row">
                <input type="hidden" id="begin" value=""/>
                <input type="hidden" id="commit" value=""/>
                <div class="col-md-3">
                    <a href="#" class="tile tile-default">
                        <h3>${item.name}理论考试</h3>
                        <img id="aviator3" src="${ctx}/aviator/${user.aviator==null?'default.jpg':user.aviator}" class="img-thumbnail" style="width: 100px;"/>
                        <h4>考生姓名：${user.username}</h4>
                        <h4>考试题数：${item.singnum + item.multnum}题</h4>
                        <h4>考试时间：${item.duration}分钟</h4>
                        <h4>满分${item.totalscore}分，${item.passscore}分及格</h4>
                        <div class="time-item">
                            <strong id="hour_show">00:</strong>
                            <strong id="minute_show">00:</strong>
                            <strong id="second_show">00</strong>
                        </div>
                        <p><button id="transBtn" class="btn btn-info" type="button" onclick="commitPaper()">交卷</button></p>
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="panel-body tab-content" style="border: 1px solid #D5D5D5;border-radius: 5px;">
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
                                <button id="submitBtn${i.index+1}" class="btn btn-warning submitBtn" type="button" value="${i.index+1}" onclick="submitAnswer(this.value,'${question.answer}',<c:if test="${question.get('type') == '单选题'}">${item.singscore}</c:if><c:if test="${question.get('type') == '多选题'}">${item.multscore}</c:if>)">提交答案</button>
                            </div>
                        </c:forEach>
                    </div>
                    <span>&nbsp;</span>
                    <div class="panel-body tab-content" style="border: 1px solid #D5D5D5;border-radius: 5px;">
                        <c:forEach items="${questions}" var="question" varStatus="i">
                            <div style="padding: 5px;float: left;width: 30px;cursor:pointer;">
                                <span class="label label-default" id="label${i.index+1}" style="color: #0a0b0d" onclick="showQuestion(${i.index+1})">${i.index+1}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${questions == null}">
    <div class="panel">
        <div class="panel-body">
            <div class="row" style="text-align: center;">
                对不起，暂不能进行${item.name}的模拟考试
            </div>
        </div>
    </div>
</c:if>

<div class="modal" id="messageModal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
    <form id="pointForm" method="post" role="form" class="form-horizontal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">温馨提示</h4>
                </div>
                <div class="modal-body" id="messageModalBody">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" onclick="commit()">交卷</button>
                </div>
            </div>
        </div>
    </form>
</div>