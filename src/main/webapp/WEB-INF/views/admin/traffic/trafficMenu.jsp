<%--
  Created by IntelliJ IDEA.
  User: lhy
  Date: 2017/3/6
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../includes/taglibs.jsp" %>
<ul class="breadcrumb">
    <li class="active">交规解读</li>
    <li class="active">目录管理</li>
</ul>
<div class="panel">
    <div class="panel-body">
        <div class="row">
            <div class="col-md-3 col-sm-4 col-xs-4" >
                <input class="form-control" type="text" id="searVal" placeholder="搜索" />
            </div>
            <div class="col-md-3 col-sm-4 col-xs-4" >
            </div>
            <div class="col-md-6 col-sm-8 col-xs-8" style="text-align:right;">
                <button type="button" class="btn btn-success" onclick="createTitle();"><i class="glyphicon glyphicon-asterisk"></i>新建标题</button>
                <button type="button" class="btn btn-warning" onclick="renameTitle();"><i class="glyphicon glyphicon-pencil"></i>重命名</button>
                <button type="button" class="btn btn-dange" onclick="deleteTitle();"><i class="glyphicon glyphicon-remove"></i>删除标题</button>
            </div>
        </div>
        <div class="row" style="margin-top: 10px;">
            <div id="trafficTree">
            </div>
        </div>
    </div>
</div>
<script>
    function createTitle() {
        var ref = $('#trafficTree').jstree(true),
                sel = ref.get_selected();
        if(!sel.length) {
            noty({text: "请选择标题！", layout: 'topRight', type: 'error', timeout: 2000});
            return false;
        }
        sel = sel[0];
        sel = ref.create_node(sel, {"type":"file"});
        if(sel) {
            ref.edit(sel);
        }
    };
    function renameTitle() {
        var ref = $('#trafficTree').jstree(true),
                sel = ref.get_selected();
        if(!sel.length) {
            noty({text: "请选择标题！", layout: 'topRight', type: 'error', timeout: 2000});
            return false;
        }
        sel = sel[0];
        ref.edit(sel);
    };
    function deleteTitle() {
        var ref = $('#trafficTree').jstree(true),
                sel = ref.get_selected();
        if(!sel.length) {
            noty({text: "请选择标题！", layout: 'topRight', type: 'error', timeout: 2000});
            return false;
        }
        noty({
            text: '您确定要进行删除吗?',
            layout: 'topRight',
            buttons: [
                {addClass: 'btn btn-success btn-clean', text: '确定', onClick: function($noty) {
                    $noty.close();
                    ref.delete_node(sel);
                }},
                {addClass: 'btn btn-danger btn-clean', text: '取消', onClick: function($noty) {
                    $noty.close();
                }
                }]
        });
    };

    $(function () {
        var to = false;
        $('#searVal').keyup(function () {
            if(to) { clearTimeout(to); }
            to = setTimeout(function () {
                var v = $('#searVal').val();
                $('#trafficTree').jstree(true).search(v);
            }, 250);
        });
        $('#trafficTree').jstree({
            "core" : {
                "multiple":false,
                "check_callback" : function(operation,node,node_parent,node_position,more){
                    if(operation == 'rename_node'){
                        if(node.parent == "#"){
                            noty({text: "该标题不能进行编辑！", layout: 'topRight', type: 'error', timeout: 2000});
                            return false;
                        }else{
                            $.post("${ctx}/admin/traffic/editTraffic",{"type":"r","id":node.id,"text":node_position,"pid":node.parent},function(data){
                                if(data.result){
                                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 2000});
                                    $.jstree.reference("#trafficTree").refresh();
                                }else{
                                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 2000});
                                }
                            },"json");
                        }
                    }else if(operation == 'delete_node'){
                        if(node.parent == "#"){
                            noty({text: "该标题不能进行删除！", layout: 'topRight', type: 'error', timeout: 2000});
                            return false;
                        }else{
                            $.post("${ctx}/admin/traffic/editTraffic",{"type":"d","id":node.id},function(data){
                                if(data.result){
                                    noty({text: data.message, layout: 'topRight', type: 'success', timeout: 2000});
                                }else{
                                    noty({text: data.message, layout: 'topRight', type: 'error', timeout: 2000});
                                }
                            },"json");
                        }
                    }
                },
                'force_text' : true,
                "themes" : { "stripes" : true },
                'data' : {
                    'url' : function (node) {
                        return "${ctx}/admin/traffic/menuJson";
                    },
                    'data' : function (node) {
                        return { 'pid' : node.id };
                    }
                }
            },
            "types" : {
                "#" : {"max_children" : 1,"max_depth" : 4,"valid_children" : ["root"]},
                "default" : {"icon" :"glyphicon glyphicon-file"}
            },
            "plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow" ],
            "contextmenu" : {
                "items" : {
                    "create" : {
                        "label" : "新增标题",
                        "action" : function(data){
                            var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                            inst.create_node(obj, {}, "last", function (new_node) {
                                setTimeout(function () { inst.edit(new_node); },0);
                            });
                        }
                    },
                    "rename" : {
                        "label" : "重命名",
                        "action" : function(data){
                            var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                            inst.edit(obj);
                        }
                    },
                    "delete" : {
                        "label" : "删除标题",
                        "action" : function(data){
                            console.log(data);
                            var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                            noty({
                                text: '您确定要进行删除吗?',
                                layout: 'topRight',
                                buttons: [
                                    {addClass: 'btn btn-success btn-clean', text: '确定', onClick: function($noty) {
                                        $noty.close();
                                        if(inst.is_selected(obj)) {
                                            inst.delete_node(inst.get_selected());
                                        }
                                        else {
                                            inst.delete_node(obj);
                                        }
                                    }},
                                    {addClass: 'btn btn-danger btn-clean', text: '取消', onClick: function($noty) {
                                        $noty.close();
                                    }
                                }]
                            });
                        }
                    }
                }
            }
        });
    });
</script>