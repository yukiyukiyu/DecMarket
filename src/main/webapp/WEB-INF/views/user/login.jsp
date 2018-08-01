<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>登录</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="row">
        <div class="d-none d-lg-block col-1"></div>
        <div class="d-none d-md-block col-6 col-lg-5">
            <div class="row h-50">
                <div class="col mx-auto my-auto">
                    <h2><b>DecMarket</b></h2>
                    <p></p>
                    <h4>自主研发 | 手机绑定 | 安全便捷</h4>
                </div>
            </div>
        </div>
        <div class="col col-md-6 col-lg-5">
            <div class="row h-50">
                <div class="col col-md-11 mx-auto my-auto">
                    <div class="card">
                        <div class="card-header">登录
                            <c:if test="${not empty registerOK}">
                                <span>${registerOK}</span>
                            </c:if>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/user/login" method="POST">
                                <div class="form-group">
                                    <label for="username">用户名</label>
                                    <c:if test="${not empty invalidUser}">
                                        <span>${invalidUser}</span>
                                    </c:if>
                                    <c:if test="${not empty banedUser}">
                                        <span>${banedUser}</span>
                                    </c:if>
                                    <input type="text" name="username" id="username" class="form-control"
                                           placeholder="可以使用手机验证码快捷登录" tabindex='1' required="true"
                                           autofocus="true">
                                </div>
                                <div class="form-group">
                                    <label for="password">密码（<a href="${pageContext.request.contextPath}/user/iforgotit">忘记密码？</a>）</label>
                                    <c:if test="${not empty passwdError}">
                                        <span>${passwdError}</span>
                                    </c:if>
                                    <input type="password" name="password" id="password" class="form-control"
                                           placeholder="密码" tabindex='2' required="true">
                                </div>
                                <div class="row">
                                    <div class="col-auto mr-auto">
                                        <input type="submit" class="btn btn-primary" value="登录">
                                    </div>
                                    <div class="col-auto ml-auto">
                                        <input type="button" class="btn btn-success" value="手机验证码快捷登录" onclick="window.location.href='/telValidate'">
                                    </div>
                                </div>
                            </form>
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