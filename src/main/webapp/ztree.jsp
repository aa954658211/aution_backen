<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/3/30
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-validator/js/bootstrapValidator.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${APP_PATH}/static/zTree_v3/css/metroStyle/metroStyle.css" type="text/css"/>
    <script type="text/javascript" src="${APP_PATH}/static/zTree_v3/js/jquery.ztree.all.min.js"></script>
</head>
<body>
<div>
    <ul id="treeDemo" class="ztree"></ul>
</div>
<script>
    let settings = {
        data: {
            simpleData: {
                enable: true,  //true 、 false 分别表示 使用 、 不使用 简单数据模式
                idKey: "permissionId",  //节点数据中保存唯一标识的属性名称
                pIdKey: "parentId",    //节点数据中保存其父节点唯一标识的属性名称
                rootPId: -1  //用于修正根节点父节点数据，即 pIdKey 指定的属性值
            },
            key: {
                name: "name"  //zTree 节点数据保存节点名称的属性名称  默认值："name"
            }
        },
        check: {
            enable: true,  //true 、 false 分别表示 显示 、不显示 复选框或单选框
            nocheckInherit: true  //当父节点设置 nocheck = true 时，设置子节点是否自动继承 nocheck = true
        },
        callback:{
            onClick:onCheck
        }
    };
    $(function () {
        $.ajax({
            type: "get",
            url: "${APP_PATH}/role/permTree",
            async: true,
            success: function (result) {
                let zTreeObj = $.fn.zTree.init($("#treeDemo"), settings, result.extend.permTree); //初始化树
                zTreeObj.expandAll(true);   //true 节点全部展开、false节点收缩
                let node1 = zTreeObj.getNodeByParam("permissionId", 5);
                zTreeObj.checkNode(node1, true, true);
                let node2 = zTreeObj.getNodeByParam("permissionId", 9);
                zTreeObj.checkNode(node2, true, true);
            }
        });
    });
    function onCheck() {
        let treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        let nodes = treeObj.getCheckedNodes(true), v = "";
        for (let i = 0; i < nodes.length; i++) {
            if(i===nodes.length-1){
                v += nodes[i].permissionId ;
            }else{
                v += nodes[i].permissionId + ",";
            }
        }
        console.log(v);
        return v;
    }
</script>
</body>
</html>
