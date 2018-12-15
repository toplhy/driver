<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/13
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<div class="panel-body">
    <input type="hidden" name="id" value="${itembank.id}">
    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">题库名称</label>
        <div class="col-md-10 col-xs-12">
            <input type="text" class="form-control" name="name" required value="${itembank.name}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">适用车型</label>
        <div class="col-md-10 col-xs-12">
            <select class="form-control select" name="drivertype">
                <c:forEach items="${typeList}" var="type">
                    <option value="${type.name}" <c:if test="${itembank.drivertype.equals(type.name)}">selected</c:if>>${type.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">题库描述</label>
        <div class="col-md-10 col-xs-12">
            <textarea class="form-control" name="descs" rows="3" required>${itembank.descs}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-12 col-xs-12 control-label" style="text-align: left;font-size: 14px;">定义试卷生成规则</label>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">单选题</label>
        <div class="col-md-3 col-xs-12">
            <input type="text" class="form-control" id="singnum" name="singnum" required value="${itembank.singnum}" onblur="calTotalScore()"/>
        </div>
        <label class="col-md-1 col-xs-12 control-label" style="text-align: left;">个</label>
        <label class="col-md-2 col-xs-12 control-label">每个</label>
        <div class="col-md-3 col-xs-12">
            <input type="text" class="form-control" id="singscore" name="singscore" required value="${itembank.singscore}" onblur="calTotalScore()"/>
        </div>
        <label class="col-md-1 col-xs-12 control-label" style="text-align: left;">分</label>
    </div>
    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">多选题</label>
        <div class="col-md-3 col-xs-12">
            <input type="text" class="form-control" id="multnum" name="multnum" required value="${itembank.multnum}" onblur="calTotalScore()"/>
        </div>
        <label class="col-md-1 col-xs-12 control-label" style="text-align: left;">个</label>
        <label class="col-md-2 col-xs-12 control-label">每个</label>
        <div class="col-md-3 col-xs-12">
            <input type="text" class="form-control" id="multscore" name="multscore" required value="${itembank.multscore}" onblur="calTotalScore()"/>
        </div>
        <label class="col-md-1 col-xs-12 control-label" style="text-align: left;">分</label>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">试卷总分</label>
        <div class="col-md-10 col-xs-12">
            <input type="text" class="form-control" style="background-color: #F9F9F9;color: #555;" id="totalscore" name="totalscore" readonly value="${itembank.totalscore}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">及格总分</label>
        <div class="col-md-10 col-xs-12">
            <input type="text" class="form-control" name="passscore" required value="${itembank.passscore}"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-2 col-xs-12 control-label">试卷时间</label>
        <div class="col-md-10 col-xs-12">
            <input type="text" class="form-control" name="duration" required value="${itembank.duration}"/>
        </div>
    </div>
</div>
<script>
    function calTotalScore(){
        var sum = 0;
        if($("#singnum").val()!="" && $("#singscore").val()!=""){
            sum += parseInt($("#singnum").val()) * parseFloat($("#singscore").val());
        }
        if($("#multnum").val()!="" && $("#multscore").val()!=""){
            sum += parseInt($("#multnum").val()) * parseFloat($("#multscore").val());
        }
        $("#totalscore").val(sum);
    }
</script>