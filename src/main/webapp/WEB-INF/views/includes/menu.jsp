<%@ page language="java" pageEncoding="UTF-8" %>
<sec:authorize ifAnyGranted="ROLE_ADMIN">
    <li class="xn-openable">
        <a href="#"><span class="fa fa-files-o"></span> <span class="xn-text">交规解读</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/traffic/menu')"><span class="fa fa-magic"></span>目录管理</a></li>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/traffic/content')"><span class="fa fa-book"></span>内容管理</a></li>
        </ul>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-tachometer"></span> <span class="xn-text">题库管理</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/itembank/list')"><span class="fa fa-bars"></span>题库列表</a></li>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/point/list')"><span class="fa fa-asterisk"></span>知识点列表</a></li>
        </ul>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-edit"></span> <span class="xn-text">试题管理</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/question/list')"><span class="fa fa-bars"></span>试题列表</a></li>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/question/create')"><span class="fa fa-plus"></span>添加试题</a></li>
        </ul>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-users"></span> <span class="xn-text">用户管理</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/users/list')"><span class="fa fa-user"></span>用户列表</a></li>
        </ul>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-superscript"></span> <span class="xn-text">统计分析</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/charts/userCon')"><span class="fa fa-user"></span>用户情况统计</a></li>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/admin/charts/questionCon')"><span class="fa fa-edit"></span>试题情况统计</a></li>
        </ul>
    </li>
</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_USER">
    <li >
        <a href="javascript:void(0);" onclick="centerLoad('${ctx}/user/traffic/show')"><span class="fa fa-files-o"></span> <span class="xn-text">交规学习</span></a>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-pencil"></span> <span class="xn-text">试题练习</span></a>
        <ul id="userMenu"></ul>
    </li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-retweet"></span> <span class="xn-text">用户中心</span></a>
        <ul>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/user/center/history',{'type':$('#itemName').html()})"><span class="fa fa-bars"></span>考试记录</a></li>
            <li><a href="javascript:void(0);" onclick="centerLoad('${ctx}/user/center/analysis',{'type':$('#itemName').html()})"><span class="fa fa-subscript"></span>进度及分析</a></li>
        </ul>
    </li>
</sec:authorize>