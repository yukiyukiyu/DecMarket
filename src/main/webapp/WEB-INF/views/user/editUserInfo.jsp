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

    <div class="row">
        <div class="mx-auto">
            <div id="add-form">
                <p>
                <div class="card card-body">
                    <form action="${pageContext.request.contextPath}/user/editUserInfo" method="post">
                        <div class="form-group">
                            <label for="nickname">昵称</label>
                            <input type="text" name="nickname" id="nickname" class="form-control" value="${userInfo.nickname}">
                        </div>
                        <div class="form-group">
                            <label for="QQ">QQ</label>
                            <input type="text" name="QQ" id="QQ" class="form-control" value="${userInfo.QQ}">
                        </div>
                        <div class="form-group">
                            <label for="wechat">微信</label>
                            <input type="text" name="wechat" id="wechat" class="form-control" value="${userInfo.wechat}">
                        </div>
                        <div class="form-group">
                            <label for="address">地址</label>
                            <textarea name="address" id="address" class="form-control">${userInfo.address}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="intro">商家简介</label>
                            <textarea name="intro" id="intro" class="form-control">${userInfo.intro}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="password">密码：</label>
                            <input type="password" id="password" name="password"
                                   placeholder="密码" required="true"/>
                        </div>
                        <div class="row">
                            <div class="mx-auto">
                                <input type="submit" class="btn btn-primary" value="保存">
                            </div>
                        </div>
                    </form>
                </div>
                </p>
            </div>
        </div>
    </div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>