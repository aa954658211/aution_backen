<%@page language="java" contentType="text/html;utf-8" pageEncoding="UTF-8" %>
<%
    session.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>登录页面</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <style>
        body {
            /*background:url(../img/login_bg_0.jpg) #f8f6e9;*/
        }
        .mycenter{
            margin-top: 100px;
            margin-left: auto;
            margin-right: auto;
            height: 350px;
            width:500px;
            padding: 5%;
            padding-left: 5%;
            padding-right: 5%;
        }
        .mycenter mysign{
            width: 440px;
        }
        .mycenter input,button{
            margin-top:2%;
            margin-left: 10%;
            margin-right: 10%;
        }
        .mycheckbox{
            margin-top:10px;
            margin-left: 40px;
            margin-bottom: 10px;
            height: 10px;
        }
    </style>
</head>
<body>
<form id="loginForm"  action="" method="post">
    <div class="mycenter">
        <div class="mysign">
            <div class="col-lg-11 text-center text-info">
                <h2>请登录</h2>
            </div>
            <div class="col-lg-10">
                <input type="text" class="form-control" name="username" placeholder="请输入账户名" required autofocus/>
            </div>
            <div class="col-lg-10"></div>
            <div class="col-lg-10">
                <input type="password" class="form-control" name="password" placeholder="请输入密码" required autofocus/>
            </div>
            <div class="col-lg-10"></div>
            <div class="col-lg-10 mycheckbox checkbox">
                <input type="checkbox" name="rememberme" class="col-lg-1">记住我</input>
            </div>
            <div class="col-lg-10"></div>
            <div class="col-lg-10">
                <button id="login_btn" type="submit" class="btn btn-success col-lg-12" >登录</button>
            </div>
        </div>
    </div>
</form>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script src="${APP_PATH}/static/js/jquery.form.min.js"></script>
<script type="text/javascript">
    <%--$("#login_btn").click(function () {--%>
    <%--    $("#loginForm").on("submit",function () {--%>
    <%--        console.log("提交表单");--%>
    <%--        $(this).ajaxSubmit({--%>
    <%--            type:'POST',--%>
    <%--            dataType:'json',--%>
    <%--            url:"${APP_PATH}/user/login",--%>
    <%--            data:$("#loginForm").serialize(),--%>
    <%--            success:function (result) {--%>
    <%--                if (result.code == 100){--%>
    <%--                    layer.msg("登录成功", {icon: 1, time: 1000, offset: '0px'});--%>
    <%--                    window.location.href = '${APP_PATH}/index';--%>
    <%--                }else{--%>
    <%--                    layer.alert(result.message, {icon: 5, offset: '0px'});--%>
    <%--                }--%>
    <%--            }--%>
    <%--        });--%>
    <%--    });--%>
    <%--});--%>
    $(function () {
        let message="${message}";
        if (message == "用户或密码错误, 请重试."){
            layer.alert(message, {icon: 5, offset: '0px'});
        }else if (message=='登录成功'){
            layer.msg(message, {icon: 1, time: 2000, offset: '0px'});
        }else if (message=='系统出现点问题，请稍后再试！'){
            layer.alert(message, {icon: 5, offset: '0px'});
        }
    })
</script>
</body>
</html>
