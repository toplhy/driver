<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/11
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<style type="text/css">
    .introjs-tooltipReferenceLayer{position:fixed;}
    .introjs-helperLayer{position:fixed;}
    .introjs-overlay{background-color: #000;}
</style>
<ul class="breadcrumb">
    <li class="active">交规解读</li>
    <li class="active">内容管理</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <form id="contentForm" class="form-horizontal" role="form">
            <div class="form-group">
                <label class="col-md-1 control-label">目录</label>
                <div class="col-md-3">
                    <select class="form-control select" onchange="getFirsrt(this.value)">
                        <option value="#">请选择</option>
                        <c:forEach items="${menus}" var="menu">
                            <option value="${menu.id}">${menu.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3" id="firstLevel"></div>
                <div class="col-md-3" id="secondLevel"></div>
            </div>
            <div class="form-group"  id="contentDiv" style="display: none;">
                <div class="col-md-12">
                    <input type="hidden" id="contentId" name="tid">
                    <textarea class="summernote_traffic" name="content"></textarea>
                </div>
            </div>
            <div id="saveBtn" style="display:none;bottom:0px;right:50px!important;bottom:50px!important;position:fixed;text-align:right;">
                <button type="button" data-step="1" data-intro="在线编辑过程中为防止内容丢失，请点击此处及时保存!" data-position="left" class="btn btn-info" onclick="saveContent();">保存</button>
            </div>
        </form>
    </div>
</div>

<script>
    function getFirsrt(pid){
        if(pid != "#"){
            $.post("${ctx}/admin/traffic/nextMenu",{"pid":pid},function(data){
                if(data.length>0){
                    var html = "<select class='form-control select' onchange='getSecond(this.value)'>";
                    $.each(data, function (i, n) {
                        html += "<option value='"+ n.id+"'>"+ n.name+"</option>";
                    });
                    html += "</select>";
                    $('#firstLevel').html(html);
                    $('.select').selectpicker();
                    getSecond(data[0].id);
                }else{
                    getContent(pid);
                }
            },"json");
        }else {
            $("#firstLevel").html("");
            $("#secondLevel").html("");
            $("#contentDiv").hide();
            $("#saveBtn").hide();
        }
    }
    function getSecond(pid){
        $.post("${ctx}/admin/traffic/nextMenu",{"pid":pid},function(data){
            if(data.length>0){
                var html = "<select class='form-control select' onchange='getContent(this.value)'>";
                $.each(data, function (i, n) {
                    html += "<option value='"+ n.id+"'>"+ n.name+"</option>";
                });
                html += "</select>";
                $('#secondLevel').html(html);
                $('.select').selectpicker();
                getContent(data[0].id);
            }else{
                $("#secondLevel").html("");
                getContent(pid);
            }
        },"json");
    }
    function getContent(id){
        $("#contentId").val(id);
        $("#saveBtn").show();
        introJs().setOptions({'overlayOpacity': '0.5', 'doneLabel':'我知道了','exitOnEsc':false,'exitOnOverlayClick':false,'showStepNumbers':false,'showBullets':false}).start();
        $.post("${ctx}/admin/traffic/getTrafficContent",{"tid":id},function(data) {
            if(data == null){
                data = "";
            }else{
                data = data.content;
            }
            $(".summernote_traffic").code(data);
            $("#contentDiv").show();
        },"json");
    }
    $(function(){
        $(".summernote_traffic").summernote({height: 400, focus: true,
            toolbar: [
                ['style', ['bold', 'italic', 'underline']],
                ['font', ['strikethrough']],
                ['fontsize', ['fontsize']],
                ["insert",["link","picture"]],
                ['table', ['table']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['view', ['fullscreen', 'help']]
            ]
        });
    });
    function saveContent(){
        $.post("${ctx}/admin/traffic/saveTrafficContent",{"tid":$("#contentId").val(),"content":$(".summernote_traffic").code()},function(data){
            if(data.result){
                noty({text: data.message,layout: 'topRight',type:'success',timeout:2000});
            }else{
                noty({text: data.message,layout: 'topRight',type:'error',timeout:2000});
            }
        },"json");
    }
</script>