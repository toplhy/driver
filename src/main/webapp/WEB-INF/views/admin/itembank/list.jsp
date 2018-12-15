<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/12
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function() {
        $("#itemBankTable").bootstrapTable({});
    });
    function queryParams(params) {
        params.size = params.limit;
        params.page = params.offset;
        return params;
    }
    function indexFormatter(value, row, index) {
        return index+1;
    }
    function stateFormatter(value, row, index) {
        return value==1?"正常":"禁用";
    }
    function linkFormatter(value, row, index){
        return "<a href='javascript:void(0);' onclick='showItemBank("+row.id+")'>"+row.name+"</a>";
    }
    function descsFormatter(value, row, index){
        if(value.length>30){
            return value.substring(0,30)+"...";
        }else{
            return value;
        }
    }
    function editFormatter(value, row, index){
        var str = "<button class='btn btn-info' type='button' onclick='editItemBank("+row.id+")'>编辑</button>";
        if(row.state==1){
            str += "<button class='btn btn-warning' type='button' style='margin-left: 5px;' onclick='enabledItemBank("+row.id+",0)'>禁用</button>";
        }else{
            str += "<button class='btn btn-warning' type='button' style='margin-left: 5px;' onclick='enabledItemBank("+row.id+",1)'>启用</button>";
        }
        str += "<button class='btn btn-danger' type='button' style='margin-left: 5px;' onclick='delItemBank("+row.id+")'>删除</button>";
        return str;
    }
    function addItemBank(){
        $.post("${ctx}/admin/itembank/create",function(data){
            $("#itemBankModalHead").html("新建题库");
            $("#itemBankModalBody").html(data);
            $(".select").selectpicker();
            $("#itemBankModal").modal("show");
        },"html");
    }
    function editItemBank(id){
        $.post("${ctx}/admin/itembank/create",{"id":id},function(data){
            $("#itemBankModalHead").html("编辑题库");
            $("#itemBankModalBody").html(data);
            $(".select").selectpicker();
            $("#itemBankModal").modal("show");
        },"html");
    }
    function enabledItemBank(id,state){
        $.post("${ctx}/admin/itembank/enabled",{"id":id,"state":state},function(data){
            if(data.result){
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
            $("#itemBankTable").bootstrapTable("refresh",[]);
        },"json");
    }
    function showItemBank(id){
        $.post("${ctx}/admin/itembank/show",{"id":id},function(data){
            $("#showModalBody").html(data);
            $("#showModal").modal("show");
        },"html");
    }
    $.extend(jQuery.validator.messages, {required: '必填字段'});
    $("#itemBankForm").validate({
        submitHandler: function () {
            saveItemBank();
        }
    });
    function saveItemBank(){
        $("#itemBankForm").form('submit', {
            url: "${ctx}/admin/itembank/saveItemBank",
            success: function (data) {
                var data = eval('(' + data + ')');
                if(data.result){
                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                }else{
                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                }
                $("#itemBankModal").modal("hide");
                $("#itemBankTable").bootstrapTable("refresh",[]);
            }
        });
    }
    function deleteAll(){
        var selects=$('#itemBankTable').bootstrapTable('getSelections');
        if(selects.length>0){
            var ids=new Array();
            for(var i=0;i<selects.length;i++){
                ids.push(selects[i].id);
            }
            delItemBank(ids.join(","));
        }else{
            noty({text:"请选择要删除的题库。", layout: 'topRight', type: 'error', timeout: 3000});
        }
    }
    function delItemBank(ids){
        noty({
            text: '您确定要进行删除吗?',
            layout: 'topRight',
            buttons: [
                {addClass: 'btn btn-success btn-clean', text: '确定', onClick: function($noty) {
                    $noty.close();
                    $.post("${ctx}/admin/itembank/delItemBank",{"ids":ids},function(data){
                        if(data.result){
                            noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                        }else{
                            noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                        }
                        $("#itemBankTable").bootstrapTable("refresh",[]);
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
    <li class="active">题库列表</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row box animated active" >
            <div id="toolbar">
                <button class="btn btn-info margin" type="button" onclick="addItemBank();">
                    <span class="fa fa-plus"></span>新增
                </button>
                <button class="btn btn-danger margin" type="button" onclick="deleteAll()">
                    <span class="fa fa-trash-o"></span>批量删除
                </button>
            </div>

            <table id="itemBankTable" class="table-striped" data-toolbar="#toolbar" data-toggle="table"
                   data-url="${ctx}/admin/itembank/itembankJson" data-cache="true"
                   data-show-refresh="true" data-show-toggle="false" data-show-columns="true" data-search="false"
                   data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
                   data-select-item-name="checkIds" data-sort-name="id" data-sort-order="asc">
                <thead>
                    <tr>
                        <th data-field="nofield" data-checkbox="true"></th>
                        <th data-field="nofield" data-formatter="indexFormatter" >序号</th>
                        <th data-field="name" data-width="13%" data-formatter="linkFormatter">题库名称</th>
                        <th data-field="drivertype" data-width="10%">适用车型</th>
                        <th data-field="descs" data-width="40%" data-formatter="descsFormatter">题库描述</th>
                        <th data-field="state" data-width="8%" data-formatter="stateFormatter">题库状态</th>
                        <th data-field="nofield" data-formatter="editFormatter">操作</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<div class="modal" id="itemBankModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="itemBankForm" method="post" role="form" class="form-horizontal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="itemBankModalHead"></h4>
                </div>
                <div class="modal-body" id="itemBankModalBody">

                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="保存"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal" id="showModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <div class="modal-dialog">
        <from class="form-horizontal" role="form">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">题库查看</h4>
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