<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/20
  Time: 21:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function() {
        $("#questionTable").bootstrapTable({});
        $("input.fileinput").bootstrapFileInput();
        $('#importForm').form({
            url:'${ctx}/admin/question/importQuestion',
            success: function(data){
                var data = eval('(' + data + ')');
                if(data.result){
                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                }else{
                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                }
                $("#importModal").modal("hide");
                $("#questionTable").bootstrapTable("refresh",[]);
            }
        });
    });
    function queryParams(params) {
        params.size = params.limit;
        params.page = params.offset;
        params.ibid = $("#itemId").val();
        params.type = $("#type").val();
        return params;
    }
    function searchData(){
        $("#questionTable").bootstrapTable("refresh",[]);
    }
    function indexFormatter(value, row, index) {
        return index+1;
    }
    function linkFormatter(value, row, index){
        if(value.length>20){
            value = value.substring(0,20)+"...";
            return "<a href='javascript:void(0);' onclick='showQuestion("+row.id+")'>"+value+"</a>";
        }else{
            return "<a href='javascript:void(0);' onclick='showQuestion("+row.id+")'>"+value+"</a>";
        }
    }
    function diffFormatter(value, row, index) {
        if(value == '1'){
            return 'I';
        }else if(value == '2'){
            return 'II';
        }else if(value == '3'){
            return 'III';
        }else if(value == '4'){
            return 'IV';
        }else if(value == '5'){
            return 'V';
        }
    }
    function editFormatter(value, row, index){
        var str = "<button class='btn btn-info' type='button' onclick='editQuestion("+row.id+")'>编辑</button>";
        str += "<button class='btn btn-danger' type='button' style='margin-left: 5px;' onclick='delQuestion("+row.id+")'>删除</button>";
        return str;
    }
    function showQuestion(id){
        $.post("${ctx}/admin/question/show",{"id":id},function(data){
            $("#showModalBody").html(data);
            $("#showModal").modal("show");
        },"html");
    }
    function editQuestion(id){
        $.post("${ctx}/admin/question/edit",{"id":id},function(data){
            $("#mainTab").html('');
            $("#mainTab").html(data);
            $('.select').selectpicker();
            $(".tagsinput").tagsInput({width: '100%',height:'auto',defaultText: "添加关键字"});
        },"html");
    }
    function deleteAll(){
        var selects=$('#questionTable').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            delQuestion(ids.join(","));
        }else{
            noty({text:"请选择要删除的试题。", layout: 'topRight', type: 'error', timeout: 3000});
        }
    }
    function delQuestion(ids){
        noty({
            text: '您确定要进行删除吗?',
            layout: 'topRight',
            buttons: [
                {addClass: 'btn btn-success btn-clean', text: '确定', onClick: function($noty) {
                    $noty.close();
                    $.post("${ctx}/admin/question/delQuestion",{"ids":ids},function(data){
                        if(data.result){
                            noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                        }else{
                            noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                        }
                        $("#questionTable").bootstrapTable("refresh",[]);
                    },"json");
                }},
                {addClass: 'btn btn-danger btn-clean', text: '取消', onClick: function($noty) {
                    $noty.close();
                }
            }]
        });
    }
    function exportQuestion(){
        var selects=$('#questionTable').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            document.location.href="${ctx}/admin/question/exportQuestion?ids="+ids;
        }else{
            noty({text:"请选择要导出的试题。", layout: 'topRight', type: 'error', timeout: 3000});
        }
    }
    function showImportModal(){
        $('#importModal').modal('show');
    }
    function downTemplate(){
        document.location.href="${ctx}/admin/question/downTemplate";
    }
</script>
<ul class="breadcrumb">
    <li class="active">试题管理</li>
    <li class="active">试题列表</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row box animated active" >
            <div id="toolbar" style="display: inline-block;width: auto;">
                所属题库<select class="form-control select" id="itemId" data-width="180px">
                    <option value="0">全部</option>
                    <c:forEach items="${itemList}" var="item">
                        <option value="${item.id}">${item.drivertype}·${item.name}</option>
                    </c:forEach>
                </select>
                试题类型<select class="form-control select" id="type" data-width="180px">
                    <option value="0">全部</option>
                    <c:forEach items="${typeList}" var="type">
                        <option value="${type.id}">${type.name}</option>
                    </c:forEach>
                </select>
                <button class="btn btn-primary" type="button" onclick="searchData()">
                    <span class="fa fa-search"></span>查询
                </button>
                <button class="btn btn-danger" type="button" onclick="deleteAll()">
                    <span class="fa fa-trash-o"></span>批量删除
                </button>
                <button class="btn btn-warning" type="button" onclick="showImportModal();">
                    <span class="fa fa-cloud-upload"></span>试题导入
                </button>
                <button class="btn btn-warning" type="button" onclick="exportQuestion();">
                    <span class="fa fa-cloud-download"></span>试题导出
                </button>
            </div>

            <table id="questionTable" class="table-striped" data-toolbar="#toolbar" data-toggle="table"
                   data-url="${ctx}/admin/question/questionJson" data-cache="true"
                   data-show-refresh="true" data-show-toggle="false" data-show-columns="true" data-search="false"
                   data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
                   data-select-item-name="checkIds" data-sort-name="id" data-sort-order="asc">
                <thead>
                <tr>
                    <th data-field="nofield" data-checkbox="true"></th>
                    <th data-field="nofield" data-formatter="indexFormatter" >序号</th>
                    <th data-field="content" data-width="30%" data-formatter="linkFormatter">试题内容</th>
                    <th data-field="item" data-align="center" data-width="10%">所属题库</th>
                    <th data-field="type" data-align="center" data-width="9%">试题类型</th>
                    <th data-field="diff" data-align="center" data-width="9%" data-formatter="diffFormatter">试题难度</th>
                    <th data-field="keyword" data-align="center" data-width="17%">关键字</th>
                    <th data-field="nofield" data-align="center" data-formatter="editFormatter">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<div class="modal" id="showModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <from class="form-horizontal" role="form">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">试题查看</h4>
                </div>
                <div class="modal-body" id="showModalBody">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </from>
    </div>
</div>

<%--导入--%>
<div class="modal" id="importModal" tabindex="-1" role="dialog" aria-hidden="true">
    <form id="importForm" enctype="multipart/form-data" method="post" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">试题导入</h4>
                </div>
                <div class="modal-body" style="text-align: center;">
                    <input type="button" class="btn btn-info" value="下载模板" onclick="downTemplate()"/>
                    <input type="file" class="fileinput btn-success" name="questions" required accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel" title="上传试题"/>
                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="上传"/>
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="取消" />
                </div>
            </div>
        </div>
    </form>
</div>
