<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/3/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/bootstrap.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-validator/js/bootstrapValidator.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-validator/css/bootstrapValidator.min.css" rel="stylesheet" />
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12"><h1>用户管理</h1></div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <shiro:hasPermission name="user:save">
                <button id="add_btn" class="btn btn-primary">新增</button>
            </shiro:hasPermission>
            <shiro:hasPermission name="user:delete">
                <button id="delete_btn" class="btn btn-danger">删除</button>
            </shiro:hasPermission>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>#</th>
                    <th>username</th>
                    <th>role</th>
                    <th>email</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="list">
                    <tr>
                        <td><input type="checkbox" class="check_item"></td>
                        <td>${list.userId}</td>
                        <td>${list.username}</td>
                        <td>${list.role.name}</td>
                        <td>${list.email}</td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_btn" edit_id="${list.userId}" name="edit_btn"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
                            <button class="btn btn-danger btn-sm delete_btn" delete_id="${list.userId}" name="delete_btn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
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
                    <li><a href="${APP_PATH}/user/list?pageNum=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/user/list?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                        <c:if test="${pageInfo.pageNum == nav}">
                            <li class="active"><a href="javascript:void(0)">${nav}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != nav}">
                            <li><a href="${APP_PATH}/user/list?pageNum=${nav}">${nav}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/user/list?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/user/list?pageNum=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<%--新增模态框--%>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增用户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addForm">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">username</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="username" id="username" placeholder="username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="password" id="password" placeholder="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email" placeholder="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">选择角色</label>
                        <div class="col-sm-6" id="roles">
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
<%--编辑模态框--%>
<div class="modal fade" id="updModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改用户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updForm">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">username</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="usernamep"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" placeholder="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">选择角色</label>
                        <div class="col-sm-6" id="rolesp">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_upd_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<script>
    function getUser(id) {
        //1.发送ajax查员工信息
        $.ajax({
            url:"${APP_PATH}/user/show/"+id,
            type:"GET",
            success:function (result) {
                let user=result.extend.user;
                //2.回显员工信息
                $("#usernamep").text(user.username);
                $("#rolesp input[name='roleIds'][value='" + user.role.roleId + "']").prop("checked",true);
                $("#updForm input[name='email']").val(user.email);
            }
        })
    }
    function getRoles(ele) {
        $.ajax({
            url:"${APP_PATH}/user/listRoles",
            type:"GET",
            success:function (result) {
                //显示角色单选框
                let roles = result.extend.roles;
                $(roles).each(function () {
                    $(ele).append("<label class='radio-inline'><input type='radio' name='roleIds'  value='"+
                        this.roleId+"'/>["+this.name+"]");
                    $(ele).append("</label>");
                });
            }
        });
    }
    $(function () {
        $("#add_btn").click(function () {
            $("#roles").empty();
            getRoles("#roles");
            $('#addModal').modal({
                backdrop:'static',
                show:'true'
            });
        });
        $("#save_add_btn").click(function () {
            if(!validate_add_form()){
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/user/save",
                data:$("#addForm").serialize(),
                type:"POST",
                success:function (result) {
                    alert(result.message);
                    window.location.href="${APP_PATH}/user/list?pageNum=${pageInfo.pages}"
                }
            });
        });

        //弹出修改模态框
        $(".edit_btn").on("click",function () {
            let id = $(this).attr("edit_id");
            $("#save_upd_btn").attr("edit_id",id);
            $("#rolesp").empty();
            getRoles("#rolesp");
            getUser(id);
            //3.显示模态框
            $("#updModal").modal("show");

        });

        //修改员工
        $("#save_upd_btn").click(function () {
            let email = $("#updForm input[name='email']").val();
            let emailRegex = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!emailRegex.test(email)){
                alert("电子邮箱格式错误");
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/user/update/"+$(this).attr("edit_id"),
                data:$("#updForm").serialize(),
                type:"PUT",
                success:function (result) {
                    alert("修改成功")
                    window.location.href="${APP_PATH}/user/list?pageNum=${pageInfo.pageNum}";
                }
            })
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
                    url:"${APP_PATH}/user/delete/"+$(this).parents("tr").find("td:eq(1)").text(),
                    type:"DELETE",
                    success:function (resutl) {
                        alert("删除"+resutl.message);
                        window.location.href="${APP_PATH}/user/list/?pageNum=${pageInfo.pageNum}";

                    }
                })
            }
        });
        //多个选择删除
        $("#delete_btn").click(function () {
            //拼接id字符串
            let usernames='',userIds='';
            $(".check_item:checked").each(function () {
                usernames += $(this).parent().next().next().text() + "-";
                userIds+=$(this).parent().next().text()+" ";
            });
            usernames = usernames.substring(0, usernames.length-1);
            if (usernames != ''){
                let confirm2 = confirm("确定删除【"+usernames+"】吗");
                if(confirm2){
                    $.ajax({
                        url:"${APP_PATH}/user/deleteAll?userIds="+userIds,
                        type:"DELETE",
                        success:function (result) {
                            alert("删除"+result.message);
                            window.location.href="${APP_PATH}/user/list?pageNum=${pageInfo.pageNum}";
                        }
                    })
                }
            }else
                alert("请选择要删除的员工");
        });
        //用户名验证
        $("#addForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        remote:{
                            type:'GET',
                            message:'用户已存在',
                            delay :1000,
                            url:'${APP_PATH}/user/checkUsername'
                        }
                    }
                },password:{
                    message:'密码验证失败',
                    validators: {
                        notEmpty: {
                            message:'密码不能为空'
                        },stringLength:{
                            max:16,
                            min:6,
                            message:'密码长度在6-16位'
                        }
                    }
                }
            }
        });

    });


    function validate_add_form(){
        let username = $("#username").val();
        let usernameRegex = /^[A-Za-z0-9_]{5,16}$|^[\u2E80-\u9FFF]{2,4}$/;
        let email = $("#email").val();
        let emailRegex = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if(!usernameRegex.test(username)){
            alert("姓名格式错误");
            return false;
        }
        if(!emailRegex.test(email)){
            alert("电子邮箱格式错误");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
