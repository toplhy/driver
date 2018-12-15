<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/19
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<script>
    $(function() {
        $("#userTable").bootstrapTable({});
    });
    function queryParams(params) {
        params.size = params.limit;
        params.page = params.offset;
        params.name = $("#userName").val();
        params.role = $("#role").val();
        return params;
    }
    function indexFormatter(value, row, index) {
        return index+1;
    }
    function timeFormatter(value, row, index) {
        var date = new Date(value);
        var month = date.getMonth()+1;
        return date.getFullYear() + "-" + month +"-"+ date.getDate() +" "+date.getHours()+":"+date.getMinutes();
    }
    function linkFormatter(value, row, index){
        return "<a href='javascript:void(0);' onclick='showUser("+row.id+")'>"+row.username+"</a>";
    }
    function roleFormatter(value, row, index){
        if(value == "ROLE_ADMIN"){
            return "管理员";
        }else{
            return "普通用户";
        }
    }
    function editFormatter(value, row, index){
        var str = "<button class='btn btn-info' type='button' onclick='editUser("+row.id+")'>编辑</button>";
        str += "<button class='btn btn-danger' type='button' style='margin-left: 5px;' onclick='resetPassword("+row.id+")'>密码重置</button>";
        return str;
    }
    function searchData(){
        $("#userTable").bootstrapTable("refresh",[]);
    }
    function addUser(){
        $.post("${ctx}/admin/users/create",function(data){
            $("#userModalHead").html("添加用户");
            $("#userModalBody").html(data);
            $(".select").selectpicker();
            $("#userModal").modal("show");
        },"html");
    }
    $.extend(jQuery.validator.messages, {required: '必填字段'});
    $("#userForm").validate({
        submitHandler: function () {
            saveUser();
        }
    });
    function saveUser(){
        $("#userForm").form('submit', {
            url: "${ctx}/admin/users/saveUser",
            success: function (data) {
                var data = eval('(' + data + ')');
                if(data.result){
                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
                }else{
                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
                }
                $("#userModal").modal("hide");
                $("#userTable").bootstrapTable("refresh",[]);
            }
        });
    }
    function editUser(id){
        $.post("${ctx}/admin/users/edit",{"id":id},function(data){
            $("#userModalHead").html("用户信息修改");
            $("#userModalBody").html(data);
            $("#userModal").modal("show");
        },"html");
    }
    function showUser(id){
        $.post("${ctx}/admin/users/show",{"id":id},function(data){
            $("#showModalBody").html(data);
            $("#showModal").modal("show");
        },"html");
    }
    function resetPassword(id){
        $.post("${ctx}/admin/users/reset",{"id":id},function(data){
            if(data.result){
                noty({text: data.message, layout: 'topRight', type: 'success', timeout: 3000});
            }else{
                noty({text: data.message, layout: 'topRight', type: 'error', timeout: 3000});
            }
            $("#userTable").bootstrapTable("refresh",[]);
        },"json");
    }
</script>
<ul class="breadcrumb">
    <li class="active">用户管理</li>
    <li class="active">用户列表</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row box animated active" >
            <div id="toolbar" style="display: inline-block;width: auto;">
                用户名<input type="text" class="form-control" style="display: inline;width: auto;" id="userName" />
                身份<select class="form-control select" id="role"  data-width="180px">
                    <option value="all">全部</option>
                    <option value="ROLE_ADMIN">管理员</option>
                    <option value="ROLE_USER">普通用户</option>
                </select>
                <button class="btn btn-primary" type="button" onclick="searchData()">
                    <span class="fa fa-search"></span>查询
                </button>
                <button class="btn btn-info" type="button" onclick="addUser();">
                    <span class="fa fa-plus"></span>新增
                </button>
            </div>

            <table id="userTable" class="table-striped" data-toolbar="#toolbar" data-toggle="table"
                   data-url="${ctx}/admin/users/usersJson" data-cache="true"
                   data-show-refresh="true" data-show-toggle="false" data-show-columns="true" data-search="false"
                   data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
                   data-select-item-name="checkIds" data-sort-name="id" data-sort-order="asc">
                <thead>
                <tr>
                    <th data-field="nofield" data-formatter="indexFormatter" >序号</th>
                    <th data-field="username" data-width="15%" data-formatter="linkFormatter">用户名</th>
                    <th data-field="rolename" data-width="10%" data-formatter="roleFormatter">身份</th>
                    <th data-field="email" data-width="15%">Email</th>
                    <th data-field="phone" data-width="15%">联系电话</th>
                    <th data-field="createtime" data-width="15%" data-formatter="timeFormatter">注册时间</th>
                    <th data-field="nofield" data-formatter="editFormatter">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<div class="modal" id="userModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="userForm" method="post" role="form" class="form-horizontal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="userModalHead"></h4>
                </div>
                <div class="modal-body" id="userModalBody">

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
                    <h4 class="modal-title">用户信息查看</h4>
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