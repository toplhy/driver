<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/14
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<div class="panel-body form-group-separated">
    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">题库名称</label>
        <div class="col-md-10 col-xs-12" style="line-height: 30px;">${itembank.name}</div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">适用车型</label>
        <div class="col-md-10 col-xs-12" style="line-height: 30px;">${itembank.drivertype}</div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">题库描述</label>
        <div class="col-md-10 col-xs-12" style="line-height: 30px;">${itembank.descs}</div>
    </div>

    <div class="form-group">
        <label class="col-md-12 col-xs-12 control-label" style="text-align: left;font-size: 14px;">试卷生成规则</label>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">单选题</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.singnum}个</div>
        <label class="col-md-2 col-xs-12 control-label">每个</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.singscore}分</div>
    </div>
    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">多选题</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.multnum}个</div>
        <label class="col-md-2 col-xs-12 control-label">每个</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.multscore}分</div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">试卷总分</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.totalscore}分</div>
        <label class="col-md-2 col-xs-12 control-label">及格总分</label>
        <div class="col-md-4 col-xs-12" style="line-height: 30px;">${itembank.passscore}分</div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">试卷时间</label>
        <div class="col-md-10 col-xs-12" style="line-height: 30px;">${itembank.duration}分钟</div>
    </div>

    <div class="form-group"></div>
</div>