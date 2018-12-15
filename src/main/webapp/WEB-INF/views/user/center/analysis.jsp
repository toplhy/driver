<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/30
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function(){
        $(".nav").find("li").first().addClass("active");
        transItem(${items[0].id});
    });
    function transItem(itemId){
        $.post("${ctx}/user/center/charts", {"itemId":itemId}, function(data, status) {
            initDonut(data.wrongs,data.falg);
            initLine(data.histories);
        }, "json");
    }
    function initDonut(data,falg){
        $("#wrong-donut").html("");
        if(falg){
            $("#wrong-donut").html("<div style='text-align: center;'>还没有错题记录<div>");
        }else{
            Morris.Donut({
                element: 'wrong-donut',
                data: data,
                colors: ['#3FBAE4', '#FEA223','#95B75D','#A7403F','#33414E','#CDCDCD','#5A2222']
            });
        }
    }
    function initLine(data){
        $("#exam-line").html("");
        if(data == ""){
            $("#exam-line").html("<div style='text-align: center;'>还没有考试记录</div>");
        }else{
            Morris.Line({
                element: 'exam-line',
                data: data,
                xkey: 'y',
                ykeys: ['a'],
                labels: ['考试成绩'],
                resize: true,
                lineColors: ['#33414E']
            });
        }
    }
</script>
<ul class="breadcrumb">
    <li class="active">用户中心</li>
    <li class="active">进度及分析</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <c:if test="${items.size()>0}">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default tabs">
                        <ul class="nav nav-tabs nav-justified">
                            <c:forEach items="${items}" var="item">
                                <li><a href="#tab" data-toggle="tab" onclick="transItem('${item.id}')">${item.name}</a></li>
                            </c:forEach>
                        </ul>
                        <div class="panel-body tab-content">
                            <div class="tab-pane active" id="tab">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">各知识点错题数量统计</h3>
                                            </div>
                                            <div class="panel-body">
                                                <div id="wrong-donut" style="height:330px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">近10次模拟考试成绩折线图</h3>
                                            </div>
                                            <div class="panel-body">
                                                <div id="exam-line"  style="height:330px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${items.size()<1}">
            <div style="text-align: center;">暂无该类型题库。</div>
        </c:if>
    </div>
</div>