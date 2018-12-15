<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 17-5-6
  Time: 下午8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function(){
        Morris.Bar({
            element: 'item-bar',
            data: ${items},
            xkey: 'label',
            ykeys: ['value1','value2'],
            labels: ['单选题','多选题'],
            barColors: ['#3FBAE4', '#FEA223']
        });
        Morris.Donut({
            element: 'type-donut',
            data: ${types},
            colors: ['#3FBAE4', '#FEA223','#95B75D','#A7403F','#33414E','#CDCDCD','#5A2222','#123456']
        });
    });
</script>
<ul class="breadcrumb">
    <li class="active">统计分析</li>
    <li class="active">试题情况统计</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">各车型试题数量</h3>
                    </div>
                    <div class="panel-body">
                        <div id="item-bar" style="height:330px;"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">各题型试题数量</h3>
                    </div>
                    <div class="panel-body">
                        <div id="type-donut" style="height:330px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>