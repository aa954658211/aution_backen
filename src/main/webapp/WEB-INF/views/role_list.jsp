<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/3/25
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-validator/js/bootstrapValidator.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${APP_PATH}/static/zTree_v3/css/metroStyle/metroStyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${APP_PATH}/static/zTree_v3/js/jquery.ztree.all.min.js" ></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12"><h1>角色管理</h1></div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button id="add_btn" class="btn btn-primary">新增</button>
            <button id="delete_btn" class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>#</th>
                    <th>角色名称</th>
                    <th>角色描述</th>
                    <th>角色状态</th>
                    <th>角色权限</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="list">
                    <tr>
                        <td><input type="checkbox" class="check_item"></td>
                        <td>${list.roleId}</td>
                        <td>${list.name}</td>
                        <td>${list.description}</td>
                        <td>${list.status==1?"启用":"禁用"}</td>
                        <td><a href="javascript:void(0)" class="showPerms">查看权限</a></td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_btn" edit_id="${list.roleId}" name="edit_btn"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
                            <button class="btn btn-danger btn-sm delete_btn" delete_id="${list.roleId}" name="delete_btn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <h4>当前页为${pageInfo.pageNum},共有${pageInfo.pages}页,总记录数为${pageInfo.total}</h4>
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/role/list?pageNum=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/role/list?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                        <c:if test="${pageInfo.pageNum == nav}">
                            <li class="active"><a href="javascript:void(0)">${nav}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != nav}">
                            <li><a href="${APP_PATH}/role/list?pageNum=${nav}">${nav}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/role/list?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/role/list?pageNum=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<div class="modal fade" id="role-form-div" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="blue bigger role-form-title"></h4>
            </div>
            <form id="role-form" name="role-form" class="role-form">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label for="name">角色名称<span
                                        style="color:#F00">*</span></label>
                                <div>
                                    <input type="text" id="name" name="name"
                                           placeholder="角色名称"/>
                                </div>
                                <label for="description">角色描述<span
                                        style="color:#F00">*</span></label>
                                <div>
                                    <input type="text" id="description" name="description"
                                           placeholder="角色描述"/>
                                </div>
                                <label for="description">角色状态<span
                                        style="color:#F00">*</span></label>
                                <div>
                                    <label class='radio-inline'>
                                        <input type="radio"  name="status" value="1"/>【启用】
                                    </label>
                                    <label class='radio-inline'>
                                        <input type="radio" name="status" value="0"/>【禁用】
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label>设置权限</label>
                                <div class="row">
                                    <div class="col-xs-8 col-sm-11">
                                        <ul id="permTree" class="ztree"></ul>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_add_btn">保存</button>
            </div>
        </div>

    </div>
</div>
<script>
    //设置ztree权限树
    function getPermTree(){
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
            check:{
                enable:true,  //true 、 false 分别表示 显示 、不显示 复选框或单选框
                nocheckInherit:true  //当父节点设置 nocheck = true 时，设置子节点是否自动继承 nocheck = true
            }
        };
        $.ajax({
            type:"get",
            url:"${APP_PATH}/role/permTree",
            async:true,
            success:function(result){
                let zTreeObj = $.fn.zTree.init($("#permTree"), settings, result.extend.permTree); //初始化树
                zTreeObj.expandAll(true);   //true 节点全部展开、false节点收缩
            }
        });
    }
    //获取角色
    function getRole(id){
        $.ajax({
            url:"${APP_PATH}/role/show/"+id,
            type:"GET",
            success:function (result) {
                //回显数据
                let role = result.extend.role;
                $("#name").val(role.name);
                $("#description").val(role.description);
                $(":input[name='status'][value='"+role.status+"']").prop("checked",true);
            }
        })
    }
    //勾选所拥有的菜单
    function getPermissionByRoleId(roleId){
        $.ajax({
            url:"${APP_PATH}/role/getPermissions",
            data:{roleId:roleId},
            type:"GET",
            success:function (result) {
                let permissions = result.extend.permissions;
                //选择权限菜单树的节点
                let treeObj = $.fn.zTree.getZTreeObj("permTree");
                $.each(permissions,function () {
                    let node = treeObj.getNodeByParam("permissionId", this.permissionId);
                    treeObj.checkNode(node, true, false);
                });
            }
        })
    }
    //重置表单
    function resetForm(){
        $("#role-form")[0].reset();
        $("#permTree").empty();
    }
    $(function () {
        $("#add_btn").click(function () {
            resetForm();
            getPermTree();
            $("#save_add_btn").attr("operate","添加");
            $("#role-form-div").modal({
                backdrop:'static',
                show:'true'
            })
        });
        //新增更新二合一
        $("#save_add_btn").click(function () {
            let operate = $(this).attr("operate");
            let treeIds = onCheck();
            $("#permTree").append('<input type="hidden" name="permIds" value="'+treeIds+'"/>');
            if (operate == "添加"){
                //发送添加请求
                $.ajax({
                    url:"${APP_PATH}/role/save",
                    data:$("#role-form").serialize(),
                    type:"POST",
                    success:function (result) {
                        alert(result.message);
                        window.location.href="${APP_PATH}/role/list?pageNum=${pageInfo.pages}"
                    }
                });
            }else{
                $.ajax({
                    url:"${APP_PATH}/role/update/"+$(this).attr("edit_id"),
                    data:$("#role-form").serialize(),
                    type:"PUT",
                    success:function (result) {
                        alert(result.message);
                        window.location.href="${APP_PATH}/role/list?pageNum=${pageInfo.pages}"
                    }
                })
            }
        });
        $(".edit_btn").on("click",function () {
            let id = $(this).attr("edit_id");
            $("#save_add_btn").attr("edit_id",id);
            $("#save_add_btn").attr("operate","编辑");
            getPermTree();
            getPermissionByRoleId(id);
            resetForm();
            getRole(id);
            $("#role-form-div").modal({
                backdrop:'static',
                show:'true'
            });
        });
        //完成全选/全不选功能
        $("#check_all").click(function () {
            $(".check_item").each(function () {
                $(this).prop("checked",$("#check_all").prop("checked"));
            })
        });
        //完成单选功能
        $(".check_item").click(function () {
            let flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        //单个删除功能
        $(".delete_btn").on("click",function () {
            let confirm1 = confirm("确定删除["+$(this).parents("tr").find("td:eq(2)").text()+"]吗?");
            if (confirm1){
                $.ajax({
                    url:"${APP_PATH}/role/delete/"+$(this).parents("tr").find("td:eq(1)").text(),
                    type:"DELETE",
                    success:function (resutl) {
                        alert("删除"+resutl.message);
                        window.location.href="${APP_PATH}/role/list/?pageNum=${pageInfo.pageNum}";

                    }
                })
            }
        });
        //多个选择删除
        $("#delete_btn").click(function () {
            //拼接id字符串
            let roleNames='',roleIds='';
            $(".check_item:checked").each(function () {
                roleNames += $(this).parent().next().next().text() + "-";
                roleIds+=$(this).parent().next().text()+" ";
            });
            roleNames = roleNames.substring(0, roleNames.length-1);
            if (roleNames != ''){
                let confirm2 = confirm("确定删除【"+roleNames+"】吗");
                if(confirm2){
                    $.ajax({
                        url:"${APP_PATH}/role/deleteBatch?roleIds="+roleIds,
                        type:"DELETE",
                        success:function (result) {
                            alert("删除"+result.message);
                            window.location.href="${APP_PATH}/role/list?pageNum=${pageInfo.pageNum}";
                        }
                    })
                }
            }else
                alert("请选择要删除的员工");
        });

        //查看权限
        $(".showPerms").on("click",function () {
            let permissionTd = $(this).parent();
            let roleId = $(this).parents("tr").find("td:eq(1)").text();
            $.ajax({
                url:"${APP_PATH}/role/getPermissions",
                data:{roleId:roleId},
                type:"GET",
                success:function (result) {
                    let permissions = result.extend.permissions;
                    //回显到td中
                    permissionTd.empty();
                    let permissionNames="";
                    $.each(permissions,function () {
                        permissionNames+=this.name+"<br/>";
                    });
                    permissionTd.html(permissionNames);
                }
            });
        })
    //结束$
    });
    //获取选择的权限id
    function onCheck() {
        let treeObj = $.fn.zTree.getZTreeObj("permTree");
        let nodes = treeObj.getCheckedNodes(true), v = "";
        for (let i = 0; i < nodes.length; i++) {
            if(i===nodes.length-1){
                v += nodes[i].permissionId ;
            }else{
                v += nodes[i].permissionId + ",";
            }
        }
        return v;
    }
</script>
</body>
</html>
