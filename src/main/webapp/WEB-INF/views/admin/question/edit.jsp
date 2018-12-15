<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/4/9
  Time: 21:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function(){
        $(".summernote_question").summernote({height: 200, focus: true,
            toolbar: [["insert",["picture"]]]
        });
        showOptions();
        getPoint('${question.get("itemId")}');
    });
    function showOptions(){
        var text = $("#qtype").find(":selected").text();
        if(text == "单选题"){
            $("#singleOption").show();
            $("#multOption").find("input").val("");
            $("#multOption").hide();
        }else if(text == "多选题"){
            $("#multOption").show();
            $("#singleOption").find("input").val("");
            $("#singleOption").hide();
        }else{
            $("#singleOption").find("input").val("");
            $("#singleOption").hide();
            $("#multOption").find("input").val("");
            $("#multOption").hide();
        }
    }
    function addOneOption(mark){
        var num = $("#"+mark+"Tr input").size();
        if(num<6){
            $("#"+mark+"Row label").html(String.fromCharCode(65+num));
            var clone = $("#"+mark+"Row").clone();
            clone.find(".form-group input").attr("name",mark+"Options");
            $("#"+mark+"Tr").append(clone.html());
            if(mark == "single"){
                var answer = "<div style='width: 50px;float:left;'><input type='radio' value='"+String.fromCharCode(65+num)+"' name='answer'/>&nbsp;&nbsp;"+String.fromCharCode(65+num)+"&nbsp;&nbsp;</div>";
                $("#"+mark+"Answer").append(answer);
            }else if(mark == "mult"){
                var answer = "<div style='width: 50px;float:left;'><input type='checkbox' value='"+String.fromCharCode(65+num)+"' name='answer'/>&nbsp;&nbsp;"+String.fromCharCode(65+num)+"&nbsp;&nbsp;</div>";
                $("#"+mark+"Answer").append(answer);
            }
        }else{
            noty({text: "选项不能超过6个", layout: 'topRight', type: 'error', timeout: 3000});
        }
    }
    function removeOneOption(mark){
        $("#"+ mark + "Tr").find(".form-group").last().replaceWith("");
        if(mark == "single"){
            $("#"+mark+"Answer").find("div").last().replaceWith("");
        }else if(mark == "mult"){
            $("#"+mark+"Answer").find("div").last().replaceWith("");
        }
    }
    function getPoint(id){
        $.post("${ctx}/admin/question/getPoint",{"ibid":id},function(data){
            var html = "<select class='form-control select' multiple name='point' id='point'>";
            html += "<option value='0'>请选择</option>";
            $.each(data, function (i, n) {
                html += "<option value='"+ n.name+"'>"+ n.name+"</option>";
            });
            html += "</select>";
            $('#pointSelect').html(html);
            $('#point').selectpicker();
            $('#point').selectpicker('val', "${question.get('points')}".split(","));

        },"json");
    }
    function alterQuestion(){
        $("input[name='content']").val($(".summernote_question").code());
        $.post("${ctx}/admin/question/alterQuestion",$("#questionForm").serialize(),function(data){
            if(data.result){
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                centerLoad("${ctx}/admin/question/list");
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
        },"json");
    }
    function backToList(){
        $.post("${ctx}/admin/question/list",function(data){
            $("#mainTab").html('');
            $("#mainTab").html(data);
            $('.select').selectpicker();
        },"html");
    }
</script>
<ul class="breadcrumb">
    <li class="active">试题管理</li>
    <li class="active">试题修改</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <form id="questionForm" method="post" role="form" class="form-horizontal">
            <input type="hidden" name="id" value="${question.get('id')}" />
            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">试题类型</label>
                <div class="col-md-10 col-xs-12">
                    <select class="form-control select" id="qtype" name="type" onchange="showOptions()">
                        <option value="0">请选择</option>
                        <c:forEach items="${typeList}" var="type">
                            <option value="${type.id}"
                                <c:if test="${type.id == question.get('typeId')}">selected</c:if>
                            >${type.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">所属题库</label>
                <div class="col-md-10 col-xs-12">
                    <select class="form-control select" name="ibid" onchange="getPoint(this.value)">
                        <option value="0">请选择</option>
                        <c:forEach items="${itemList}" var="item">
                            <option value="${item.id}"
                                <c:if test="${item.id == question.get('itemId')}">selected</c:if>
                            >${item.drivertype}·${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">知识点</label>
                <div class="col-md-10 col-xs-12" id="pointSelect">
                    <select class="form-control select" name="point">
                        <option value="0">请选择</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">试题内容</label>
                <div class="col-md-10 col-xs-12">
                    <input name="content" type="hidden"/>
                    <textarea class="summernote_question">${question.get('content')}</textarea>
                </div>
            </div>

            <div id="singleOption" style="display: none;">
                <div class="form-group">
                    <label class="col-md-2 col-xs-12 control-label">试题选项</label>
                    <div class="col-md-10 col-xs-12" id="singleTr">
                        <c:forEach items="${options}" var="option">
                            <div class="form-group">
                                <label class="col-md-1 col-xs-12 control-label">${option.key}</label>
                                <div class="col-md-10 col-xs-12">
                                    <input type="text" class="form-control" value="${option.value}" name="singleOptions"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3">
                        <button type="button" class="btn btn-success btn-sm" onclick="addOneOption('single')">新建选项</button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-xs-12 control-label">试题答案</label>
                    <div class="col-md-10 col-xs-12" id="singleAnswer">
                        <c:forEach items="${options}" var="option">
                            <div style="width: 50px;float:left;"><input type="radio" value="${option.key}" <c:if test="${question.get('answer') == option.key}">checked</c:if> name="answer"/>&nbsp;&nbsp;${option.key}&nbsp;&nbsp;</div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div id="singleRow" style="display: none;">
                <div class="form-group">
                    <label class="col-md-1 col-xs-12 control-label"></label>
                    <div class="col-md-10 col-xs-12">
                        <input type="text" class="form-control" value=""/>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeOneOption('single')">删除选项</button>
                    </div>
                </div>
            </div>

            <div id="multOption"  style="display: none;">
                <div class="form-group">
                    <label class="col-md-2 col-xs-12 control-label">试题选项</label>
                    <div class="col-md-10 col-xs-12" id="multTr">
                        <c:forEach items="${options}" var="option">
                            <div class="form-group">
                                <label class="col-md-1 col-xs-12 control-label">${option.key}</label>
                                <div class="col-md-10 col-xs-12">
                                    <input type="text" class="form-control" value="${option.value}" name="multOptions"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3">
                        <button type="button" class="btn btn-success btn-sm" onclick="addOneOption('mult')">新建选项</button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 col-xs-12 control-label">试题答案</label>
                    <div class="col-md-10 col-xs-12" id="multAnswer">
                        <c:forEach items="${options}" var="option">
                            <div style="width: 50px;float:left;"><input type="checkbox" value="${option.key}" <c:if test="${fn:contains(question.get('answer'),option.key)}">checked</c:if> name="answer"/>&nbsp;&nbsp;${option.key}&nbsp;&nbsp;</div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div id="multRow" style="display: none;">
                <div class="form-group">
                    <label class="col-md-1 col-xs-12 control-label"></label>
                    <div class="col-md-10 col-xs-12">
                        <input type="text" class="form-control" value=""/>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-danger btn-sm" onclick="removeOneOption('mult')">删除选项</button>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">试题难度</label>
                <div class="col-md-10 col-xs-12">
                    <select class="form-control select" name="difficulty">
                        <option value="1" <c:if test="${question.get('diff')==1}">selected</c:if>>I</option>
                        <option value="2" <c:if test="${question.get('diff')==2}">selected</c:if>>II</option>
                        <option value="3" <c:if test="${question.get('diff')==3}">selected</c:if>>III</option>
                        <option value="4" <c:if test="${question.get('diff')==4}">selected</c:if>>IV</option>
                        <option value="5" <c:if test="${question.get('diff')==5}">selected</c:if>>V</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">试题解析</label>
                <div class="col-md-10 col-xs-12">
                    <textarea class="form-control" rows="3" name="analysis">${question.get('analysis')}</textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 col-xs-12 control-label">关键字</label>
                <div class="col-md-10 col-xs-12">
                    <input type="text" class="tagsinput" value="${question.get('keyword')}" name="keyword"/>
                </div>
            </div>

            <div id="saveBtn" style="bottom:0px;right:50px!important;bottom:50px!important;position:fixed;text-align:right;">
                <button type="button" class="btn btn-info" onclick="alterQuestion()">修改</button><br/><br/>
                <button type="button" class="btn btn-warning" onclick="backToList()">返回</button>
            </div>
        </form>
    </div>
</div>