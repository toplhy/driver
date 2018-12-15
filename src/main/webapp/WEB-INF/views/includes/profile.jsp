<%@ page language="java" pageEncoding="UTF-8" %>

<script>
    function openAviatorDialog(){
        $('#aviatorModal').modal('show');
    }
    $(function(){
        $('#aviatorForm').form({
            url:'${ctx}/workspace/changeAviator',
            success: function(data){
                var data = eval('(' + data + ')');
                if(data.result){
                    $("#aviator1").attr("src",data.src);
                    $("#aviator2").attr("src",data.src);
                    $('#aviatorModal').modal('hide');
                    noty({text:data.message, layout: 'topRight', type: 'success', timeout: 2000});
                }else{
                    $('#aviatorModal').modal('hide');
                    noty({text:data.message, layout: 'topRight', type: 'error', timeout: 2000});
                }

            }
        });
    });
</script>

<li class="xn-profile">
    <a href="#" class="profile-mini">
        <img src="${ctx}/aviator/${user.aviator==null?'default.jpg':user.aviator}" id="aviator1" alt="${user.username}"/>
    </a>
    <div class="profile">
        <div class="profile-image">
            <img src="${ctx}/aviator/${user.aviator==null?'default.jpg':user.aviator}" id="aviator2" onclick="openAviatorDialog();" alt="${user.username}"/>
        </div>
        <div class="profile-data">
            <div class="profile-data-name">${user.username}</div>
            <div class="profile-data-title">登录时间:<fmt:formatDate value="${user.lastlogin}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></div>
        </div>
    </div>
</li>

<%--更换头像--%>
<div class="modal" id="aviatorModal" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="aviatorForm" enctype="multipart/form-data" method="post" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="defModalHead">
                        更换头像
                    </h4>
                </div>
                <div class="modal-body" style="text-align: center;">
                    <input type="file" class="fileinput btn-success" name="aviator" required accept="image/png,image/gif,image/jpeg" title="请选择头像图片"/>
                    <br>文件支持jpg、png、gif格式
                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" value="更换"/>
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="取消" />
                </div>
            </div>
        </div>
    </form>
</div>