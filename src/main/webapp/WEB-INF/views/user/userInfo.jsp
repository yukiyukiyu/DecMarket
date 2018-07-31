<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>个人信息</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div id="userinfo-container">
        <table class="table table-hover table-responsive" style="width:100%">
            <tr>
                <th style="width:130px">昵称</th>
                <th style="width:130px">手机</th>
                <th style="width:130px">邮箱</th>
                <th style="width:110px">QQ</th>
                <th style="width:110px">微信</th>
                <th>地址</th>
                <th>商家介绍</th>
                <th style="width:200px">操作</th>
            </tr>

            <tr>
                <td>
                    <c:if test="${userInfo.nickname != null}">${userInfo.nickname}</c:if>
                </td>
                <td>
                    <c:if test="${user.tel != null}">${user.tel}</c:if>
                </td>
                <td>
                    <c:if test="${user.email != null}">${user.email}</c:if>
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
                <td>
                    <form action="${pageContext.request.contextPath}/user/editUserInfoForm"
                          method="get">
                        <button type="submit" class="btn btn-primary">修改</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/user/delUserInfo"
                          method="post" onsubmit="return confirm('确定删除吗？');">
                        <button type="submit" class="btn btn-danger">删除</button>
                    </form>
                </td>
            </tr>
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

</body>
</html>