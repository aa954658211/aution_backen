<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/3/31
  Time: 20:05
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
    <link href="${APP_PATH}/static/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12"><h1>权限管理</h1></div>
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
                    <th>名称</th>
                    <th>路径</th>
                    <th>权限标识</th>
                    <th>父id</th>
                    <th>icon</th>
                    <th>状态</th>
                    <th>是否导航节点</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="list">
                    <tr>
                        <td><input type="checkbox" class="check_item"></td>
                        <td>${list.permissionId}</td>
                        <td>${list.name}</td>
                        <td>${list.url}</td>
                        <td>${list.perms}</td>
                        <td>${list.parentId}</td>
                        <td>${list.icon}</td>
                        <td>${list.status==1?"启用":"禁用"}</td>
                        <td>${list.isNav}</td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_btn" edit_id="${list.permissionId}"
                                    name="edit_btn"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button class="btn btn-danger btn-sm delete_btn" delete_id="${list.permissionId}"
                                    name="delete_btn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                            </button>
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
                    <li><a href="${APP_PATH}/permission/list?pageNum=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/permission/list?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                        <c:if test="${pageInfo.pageNum == nav}">
                            <li class="active"><a href="javascript:void(0)">${nav}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != nav}">
                            <li><a href="${APP_PATH}/permission/list?pageNum=${nav}">${nav}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/permission/list?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/permission/list?pageNum=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addForm">
                    <div class="row">
                        <div class="col-xs-4 col-sm-offset-1">
                            <div class="form-group">
                                <label for="name">权限名称</label>
                                <input type="text" class="form-control" id="name" name="name" placeholder="name">
                            </div>
                            <div class="form-group">
                                <label for="url">权限路径</label>
                                <input type="text" class="form-control" id="url" name="url" placeholder="url">
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="isNav" name="isNav" value="1">导航节点
                                </label>
                            </div>
                        </div>
                        <div class="col-xs-4 col-sm-offset-1">
                            <div class="form-group">
                                <label for="parentId">父节点id</label>
                                <input type="text" class="form-control" id="parentId" name="parentId" placeholder="parentId">
                            </div>
                            <div class="form-group">
                                <label for="perms">权限标识</label>
                                <input type="text" class="form-control" id="perms" name="perms" placeholder="perms">
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="status" value="1" name="status">状态
                                </label>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_add_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function getPermission(id){
        $.ajax({
            url:"${APP_PATH}/permission/getPermission/"+id,
            type: "GET",
            success:function (result) {
                //回显数据
                let permission = result.extend.permission;
                $("#name").val(permission.name);
                $("#url").val(permission.url);
                $("#isNav[value='"+permission.isNav+"']").prop("checked",true);
                $("#parentId").val(permission.parentId);
                $("#perms").val(permission.perms);
                $("#status[value='"+permission.status+"']").prop("checked",true);
            }
        })
    }
    function resetForm(){
        $("#addForm")[0].reset();
    }
    $(function () {
        $("#add_btn").click(function () {
            resetForm();
            $("#save_add_btn").attr("operate","添加");
            $("#exampleModalLabel").text("新增权限");
            $('#addModal').modal({
                backdrop: 'static',
                show: 'true'
            });
        });
        $("#save_add_btn").click(function () {
            let operate = $(this).attr("operate");
            if (operate == "添加"){
                $.ajax({
                    url: "${APP_PATH}/permission/save",
                    data: $("#addForm").serialize(),
                    type: "POST",
                    success: function (result) {
                        alert(result.message);
                        window.location.href = "${APP_PATH}/permission/list?pageNum=${pageInfo.pages}"
                    }
                });
            }else{
                $.ajax({
                    url: "${APP_PATH}/permission/update/"+$(this).attr("edit_id"),
                    data: $("#addForm").serialize(),
                    type: "PUT",
                    success: function (result) {
                        alert(result.message);
                        window.location.href = "${APP_PATH}/permission/list?pageNum=${pageInfo.pages}"
                    }
                });
            }
        });
        $(".edit_btn").on("click",function () {
            let id = $(this).attr("edit_id");
            $("#save_add_btn").attr("operate","编辑");
            $("#save_add_btn").attr("edit_id",id);
            resetForm();
            $("#exampleModalLabel").text("更改权限");
            getPermission(id);
            $('#addModal').modal({
                backdrop: 'static',
                show: 'true'
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
                    url:"${APP_PATH}/permission/delete/"+$(this).parents("tr").find("td:eq(1)").text(),
                    type:"DELETE",
                    success:function (resutl) {
                        alert("删除"+resutl.message);
                        window.location.href="${APP_PATH}/permission/list/?pageNum=${pageInfo.pageNum}";

                    }
                })
            }
        });
        //多个选择删除
        $("#delete_btn").click(function () {
            //拼接id字符串
            let names='',permissionIds='';
            $(".check_item:checked").each(function () {
                names += $(this).parent().next().next().text() + "-";
                permissionIds+=$(this).parent().next().text()+" ";
            });
            names = names.substring(0, names.length-1);
            if (names != ''){
                let confirm2 = confirm("确定删除【"+names+"】吗");
                if(confirm2){
                    $.ajax({
                        url:"${APP_PATH}/permission/deleteBatch?permissionIds="+permissionIds,
                        type:"DELETE",
                        success:function (result) {
                            alert("删除"+result.message);
                            window.location.href="${APP_PATH}/permission/list?pageNum=${pageInfo.pageNum}";
                        }
                    })
                }
            }else
                alert("请选择要删除的员工");
        });
    });
</script>
</body>
</html>
