<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/18
  Time: 18:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function() {
        $("#pointTable").bootstrapTable({});
    });
    function queryParams(params) {
        params.size = params.limit;
        params.page = params.offset;
        params.name = $("#pointName").val();
        params.ibid = $("#itemId").val();
        return params;
    }
    function indexFormatter(value, row, index) {
        return index+1;
    }
    function descsFormatter(value, row, index){
        if(value.length>30){
            return value.substring(0,30)+"...";
        }else{
            return value;
        }
    }
    function editFormatter(value, row, index){
        var str = "<button class='btn btn-info' type='button' onclick='editPoint("+row.id+")'>编辑</button>";
        str += "<button class='btn btn-danger' type='button' style='margin-left: 5px;' onclick='delPoint("+row.id+")'>删除</button>";
        return str;
    }
    function searchData(){
        $("#pointTable").bootstrapTable("refresh",[]);
    }
    function addPoint(){
        $.post("${ctx}/admin/point/create",function(data){
            $("#pointModalHead").html("新建知识点");
            $("#pointModalBody").html(data);
            $(".select").selectpicker();
            $("#pointModal").modal("show");
        },"html");
    }
    function editPoint(id){
        $.post("${ctx}/admin/point/create",{"id":id},function(data){
            $("#pointModalHead").html("编辑知识点");
            $("#pointModalBody").html(data);
            $(".select").selectpicker();
            $("#pointModal").modal("show");
        },"html");
    }
    $.extend(jQuery.validator.messages, {required: '必填字段'});
    $("#pointForm").validate({
        submitHandler: function () {
            savePoint();
        }
    });
    function savePoint(){
        $("#pointForm").form('submit', {
            url: "${ctx}/admin/point/savePoint",
            success: function (data) {
                var data = eval('(' + data + ')');
                if(data.result){
                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                }else{
                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                }
                $("#pointModal").modal("hide");
                $("#pointTable").bootstrapTable("refresh",[]);
            }
        });
    }
    function deleteAll(){
        var selects=$('#pointTable').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            delPoint(ids.join(","));
        }else{
            noty({text:"请选择要删除的知识点。", layout: 'topRight', type: 'error', timeout: 3000});
        }
    }
    function delPoint(ids){
        noty({
            text: '您确定要进行删除吗?',
            layout: 'topRight',
            buttons: [
                {addClass: 'btn btn-success btn-clean', text: '确定', onClick: function($noty) {
                    $noty.close();
                    $.post("${ctx}/admin/point/delPoint",{"ids":ids},function(data){
                        if(data.result){
                            noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                        }else{
                            noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                        }
                        $("#pointTable").bootstrapTable("refresh",[]);
                    },"json");
                }},
                {addClass: 'btn btn-danger btn-clean', text: '取消', onClick: function($noty) {
                    $noty.close();
                }
            }]
        });
    }
</script>
<ul class="breadcrumb">
    <li class="active">题库管理</li>
    <li class="active">知识点列表</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row box animated active" >
            <div id="toolbar" style="display: inline-block;width: auto;">
                知识点名称
                <input type="text" class="form-control" style="display: inline;width: auto;" id="pointName" />
                所属题库
                <select class="form-control select" id="itemId" data-width="180px">
                    <option value="0">全部</option>
                    <c:forEach items="${itemList}" var="item">
                        <option value="${item.id}">${item.drivertype}·${item.name}</option>
                    </c:forEach>
                </select>
                <button class="btn btn-primary" type="button" onclick="searchData()">
                    <span class="fa fa-search"></span>查询
                </button>
                <button class="btn btn-info" type="button" onclick="addPoint();">
                    <span class="fa fa-plus"></span>新增
                </button>
                <button class="btn btn-danger" type="button" onclick="deleteAll()">
                    <span class="fa fa-trash-o"></span>批量删除
                </button>
            </div>

            <table id="pointTable" class="table-striped" data-toolbar="#toolbar" data-toggle="table"
                   data-url="${ctx}/admin/point/pointJson" data-cache="true"
                   data-show-refresh="true" data-show-toggle="false" data-show-columns="true" data-search="false"
                   data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
                   data-select-item-name="checkIds" data-sort-name="id" data-sort-order="asc">
                <thead>
                <tr>
                    <th data-field="nofield" data-checkbox="true"></th>
                    <th data-field="nofield" data-formatter="indexFormatter" >序号</th>
                    <th data-field="name" data-width="20%">知识点名称</th>
                    <th data-field="itemname" data-width="15%">所属题库</th>
                    <th data-field="descs" data-width="35%" data-formatter="descsFormatter">知识点描述</th>
                    <th data-field="nofield" data-formatter="editFormatter">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<div class="modal" id="pointModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="pointForm" method="post" role="form" class="form-horizontal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="pointModalHead"></h4>
                </div>
                <div class="modal-body" id="pointModalBody">

                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="保存"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </form>
</div>