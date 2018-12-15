<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/5
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    Morris.Line({
        element: 'userCon-line',
        data: [
            { y: '${xkey[0]}', a: ${xvalue[0]} },
            { y: '${xkey[1]}', a: ${xvalue[1]} },
            { y: '${xkey[2]}', a: ${xvalue[2]} },
            { y: '${xkey[3]}', a: ${xvalue[3]} },
            { y: '${xkey[4]}', a: ${xvalue[4]} },
            { y: '${xkey[5]}', a: ${xvalue[5]} }
        ],
        xkey: 'y',
        ykeys: ['a'],
        labels: ['用户数量'],
        resize: true,
        lineColors: ['#33414E']
    });
    Morris.Donut({
        element: 'userCon-donut',
        data: [
            {label: "管理员", value: ${userNum[0]}},
            {label: "普通用户", value: ${userNum[1]}},
        ],
        colors: ['#3FBAE4', '#FEA223']
    });
</script>
<ul class="breadcrumb">
    <li class="active">统计分析</li>
    <li class="active">用户情况统计</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">用户增长情况</h3>
                </div>
                <div class="panel-body">
                    <div id="userCon-line" style="height: 300px;"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">用户数量统计</h3>
                </div>
                <div class="panel-body">
                    <div id="userCon-donut" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>