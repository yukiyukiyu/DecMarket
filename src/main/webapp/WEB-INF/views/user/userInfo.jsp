<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.yuki.decmarket.util.AvatarHelper"%>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <script src="${pageContext.request.contextPath}/resources/js/avatar_crop-20170927.js"></script>
    <title>个人中心</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="card">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs" role="tab-list">
                <li class="nav-item">
                    <a class="nav-link active" href="#changePasswd" role="tab" data-toggle="tab"
                       aria-controls="changePasswd">修改密码</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#nickandhead" role="tab" data-toggle="tab"
                       aria-controls="nickandhead">更换头像</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#validmsg" role="tab" data-toggle="tab"
                       aria-controls="validmsg">绑定方式</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#usermsg" role="tab" data-toggle="tab"
                       aria-controls="usermsg">个人信息</a>
                </li>
            </ul>
        </div>

        <div class="tab-content card-body">

            <div class="tab-pane active" id="changePasswd" role="tabpanel">
                <table class="table table-hover">

                    <div class="col col-md-6 col-lg-5">
                        <div class="row h-50">
                            <div class="col col-md-11 mx-auto my-auto">

                                <form action="${pageContext.request.contextPath}/user/editPassword"
                                      method="post">
                                    <c:if test="${not empty error}">
                                        <span>${error}</span>
                                    </c:if>
                                    <div class="form-group">
                                        <label for="oldpassword">原密码</label>
                                        <input type="password" name="oldpassword" id="oldpassword" class="form-control"
                                               placeholder="原密码" tabindex='1' required="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="password">新密码</label>
                                        <input type="password" name="password" id="password" class="form-control"
                                               placeholder="新密码" tabindex='2' required="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="repassword">确认新密码</label>
                                        <input type="password" name="repassword" id="repassword" class="form-control"
                                               placeholder="确认新密码" tabindex='3' required="true">
                                    </div>
                                    <div class="row">
                                        <div class="col-auto ml-auto">
                                            <input type="submit" class="btn btn-primary" value="确认修改">
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>

                </table>
            </div>

            <div class="tab-pane" id="nickandhead" role="tabpanel">
                <div id="profile">
                    <form id="avatar-form"
                          action="${pageContext.request.contextPath}/user/editAvatar"
                          method="POST">

                        <style>
                            .cropper-crop-box, .cropper-view-box {
                                border-radius: 50%;
                            }
                            .cropper-view-box {
                                box-shadow: 0 0 0 1px #39f;
                                outline: 0;
                            }
                        </style>

                        <div class="row">
                            <div class="mx-auto">
                                <div id="preview">
                                    <% String avatarPath = new AvatarHelper().getAvatarByUserId(Integer.parseInt(
                                            session.getAttribute("user_id").toString())); %>
                                    <img id="avatarpreview" class="avatar" style="max-width:500px"
                                         src="<%=avatarPath%>"/>
                                </div>
                                <div style="display: none">
                                    <input type="file" id="avatarUpload" name="avatarPic" onchange="preview(this)"/>
                                </div>
                            </div>
                        </div>
                        <input id="avatarUploadCpWidth" type="hidden" name="crop_width">
                        <input id="avatarUploadCpHeight" type="hidden" name="crop_height">
                        <input id="avatarUploadCpX" type="hidden" name="crop_x">
                        <input id="avatarUploadCpY" type="hidden" name="crop_y">
                        <input id="avatarBase64" type="hidden" name="avatar-base64">
                        <p>
                        <div class="row">
                            <div class="mx-auto">
                                <label for="avatarUpload" class="btn btn-secondary">更改头像</label>
                            </div>
                        </div>
                        </p>
                        <div class="row">
                            <div class="mx-auto">
                                <input id="upload-avatar" type="button" class="btn btn-success" value="保存">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="tab-pane" id="validmsg" role="tabpanel">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>手机号</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${user.tel}</td>
                            <td>
                                <button class="btn btn-primary" type="button" data-toggle="collapse"
                                        data-target="#editTel-form" aria-expanded="false" aria-controls="add-form">
                                    <span class="fa fa-plus"> 更换手机号</span>
                                </button>
                                <div class="row">
                                    <div class="mx-auto">
                                        <div class="collapse" id="editTel-form">
                                            <p>
                                            <div class="card card-body">
                                                <form action="${pageContext.request.contextPath}/user/editTel"
                                                      method="post">
                                                    <p><input type="text" name="newTel" id="newTel" class="form-control"
                                                              placeholder="新手机号" required="true"></p>
                                                    <button type="submit" class="btn btn-primary">确定</button>
                                                </form>
                                            </div>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>邮箱</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${user.email}</td>
                            <td>
                                <button class="btn btn-primary" type="button" data-toggle="collapse"
                                        data-target="#editEmail-form" aria-expanded="false" aria-controls="add-form">
                                    <span class="fa fa-plus"> 更换邮箱</span>
                                </button>
                                <div class="row">
                                    <div class="mx-auto">
                                        <div class="collapse" id="editEmail-form">
                                            <p>
                                            <div class="card card-body">
                                                <form action="${pageContext.request.contextPath}/user/editEmail"
                                                      method="post">
                                                    <p><input type="text" name="newEmail" id="newEmail" class="form-control"
                                                              placeholder="邮箱"></p>
                                                    <button type="submit" class="btn btn-primary">确定</button>
                                                </form>
                                            </div>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="tab-pane" id="usermsg" role="tabpanel">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width:130px">昵称</th>
                            <th style="width:110px">QQ</th>
                            <th style="width:110px">微信</th>
                            <th>地址</th>
                            <th>商家介绍</th>
                            <c:if test="${userInfo != null}">
                            <th style="width:200px">操作</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <c:if test="${userInfo.nickname != null}">${userInfo.nickname}</c:if>
                            </td>
                            <td>
                                <c:if test="${userInfo.QQ != null}">${userInfo.QQ}</c:if>
                            </td>
                            <td>
                                <c:if test="${userInfo.wechat != null}">${userInfo.wechat}</c:if>
                            </td>
                            <td class="address-th">
                                <c:if test="${userInfo.address != null}">${userInfo.address}</c:if>
                            </td>
                            <td>
                                <c:if test="${userInfo.intro != null}">${userInfo.intro}</c:if>
                            </td>
                            <c:if test="${userInfo != null}">
                            <td>
                                <form action="${pageContext.request.contextPath}/user/editUserInfoForm"
                                      method="get" style="display: inline-block">
                                    <button type="submit" class="btn btn-primary">修改</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/user/delUserInfo"
                                      method="post" onsubmit="return confirm('确定删除吗？');" style="display: inline-block">
                                    <button type="submit" class="btn btn-danger">删除</button>
                                </form>
                            </td>
                            </c:if>
                        </tr>
                    </tbody>
                </table>
                <c:if test="${userInfo == null}">
                    <div class="row">
                        <div class="mx-auto">
                            <span>还没有添加个人信息，快添加吧！</span>
                            <p></p>
                            <button class="btn btn-primary" type="button" data-toggle="collapse"
                                    data-target="#add-form" aria-expanded="false" aria-controls="add-form">
                                <span class="fa fa-plus"> 添加个人信息</span>
                            </button>
                        </div>
                    </div>
                </c:if>
                <div class="row">
                    <div class="mx-auto">
                        <div class="collapse" id="add-form">
                            <p>
                            <div class="card card-body">
                                <%@include file="createUserInfo.jsp"%>
                            </div>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>