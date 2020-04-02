<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/3/23
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>拍卖网站后台管理系统</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
    <style type="text/css">

        /*媒体查询，小屏幕（平板，大于等于768px）*/

        @media (min-width: 768px) {

            #leftbar {

                width: 240px;

                margin: 55px 0px 0px 0px;

                position: absolute;

                /*z-index:1;*/

                height: 500px;

                /*background:#B9DEF0;*/

            }

            .page-right {

                background: #ddd;

                margin: -5px 0px 0px 245px;

            }

        }

        /* */

        .left-dh {

            margin: 10px 0px;

        }

        @media (max-width: 768px) {

            body {

                background: #777;

            }

        }

    </style>
</head>

<body>
<!-- .navbar-static-top 去掉了由 .navbar-default 设置的左、右和顶部的边框，让它看起来更适合放在页面的头部。-->
<nav class="navbar navbar-default navbar-static-top">
    <div class="navbar-header">
        <a href="#" class="navbar-brand">网站后台管理1</a>
    </div>
    <ul class="nav navbar-nav navbar-right navbar-collapse collapse" id="login" style="margin:0px 20px 0px 0px;">
        <li><a href="#"><span class="badge"></span>个人信息</a></li>
        <li><a href="#">注销</a></li>
        <li><a href="${APP_PATH}/logout">退出</a></li>
    </ul>
    <!--侧边栏 -->
    <div class="navbar-collapse collapse" id="leftbar">
        <ul class="nav" id="mz">
            <c:forEach var="nav" items="${navbar}">
                <li class="panel panel-default">
                    <a href="#${nav.navigationId}" data-toggle="collapse" data-parent="#mz">${nav.navigationName}<span
                            class="glyphicon glyphicon-chevron-right pull-right"></span></a>
                    <ul class="panel-collapse collapse nav" id="${nav.navigationId}">
                        <c:forEach items="${nav.childNavigations}" var="child">
                            <li><a href="#" url="${child.url}">${child.name}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>
</nav>
<!--右边主要区域 -->
<div class="page-right">
    <ol class="breadcrumb">
        <li><a href="#">首页管理</a></li>
        <li><a href="#">栏目</a></li>
        <li><a href="#">增加栏目</a></li>
    </ol>
    <!-- 16:9 aspect ratio -->
    <div class="embed-responsive embed-responsive-16by9">
        <iframe class="embed-responsive-item" id="frame" src="${APP_PATH}/main"></iframe>
    </div>

</div>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</body>
<script>
    $(function () {
        $("#mz li ul li a").on("click", function () {
            let src = $(this).attr("url");
            $("#frame").attr("src", "${APP_PATH}/" + src);
        })
    })
</script>
</html>