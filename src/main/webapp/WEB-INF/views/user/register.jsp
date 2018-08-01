<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>注册</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="row">
        <div class="d-none d-lg-block col-1"></div>
        <div class="d-none d-md-block col-6 col-lg-5">
            <div class="row h-100">
                <div class="col mx-auto my-auto">
                    <h2><b>DecMarket</b></h2>
                    <p></p>
                    <h4>自主研发 | 手机绑定 | 安全便捷</h4>
                </div>
            </div>
        </div>
        <div class="col col-md-6 col-lg-5">
            <div class="row h-100">
                <div class="col col-md-11 mx-auto my-auto">
                    <div class="card">
                        <div class="card-header">注册</div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/user/register" method="POST">
                                <div class="form-group">
                                    <label for="username">用户名</label>
                                    <c:if test="${not empty invalidUser}">
                                        <span>${invalidUser}</span>
                                    </c:if>
                                    <input type="text" name="username" id="username" class="form-control"
                                           placeholder="用户名" tabindex='1' required="true" autofocus="true"
                                           value="<c:if test="${oldInput.username != null}">${oldInput.username}</c:if>">
                                </div>
                                <div class="form-group">
                                    <label for="tel">手机号</label>
                                    <c:if test="${not empty invalidTel}">
                                        <span>${invalidTel}</span>
                                    </c:if>
                                    <input type="text" name="tel" id="tel" class="form-control"
                                           placeholder="手机号" tabindex='2' required="true"
                                           value="<c:if test="${oldInput.tel != null}">${oldInput.tel}</c:if>">
                                </div>
                                <div class="form-group">
                                    <label for="email">邮箱</label>
                                    <c:if test="${not empty invalidEmail}">
                                        <span>${invalidEmail}</span>
                                    </c:if>
                                    <input type="text" name="email" id="email" class="form-control"
                                           placeholder="邮箱" tabindex='3' required="true"
                                           value="<c:if test="${oldInput.email != null}">${oldInput.email}</c:if>">
                                </div>
                                <div class="form-group">
                                    <label for="password">密码</label>
                                    <c:if test="${not empty diffPassword}">
                                        <span>${diffPassword}</span>
                                    </c:if>
                                    <input type="password" name="password" id="password" class="form-control"
                                           placeholder="密码" tabindex='4' required="true"
                                           value="<c:if test="${oldInput.password != null}">${oldInput.password}</c:if>">
                                </div>
                                <div class="form-group">
                                    <label for="repassword">确认密码</label>
                                    <input type="password" name="repassword" id="repassword" class="form-control"
                                           placeholder="密码" tabindex='5' required="true"
                                           value="<c:if test="${oldInput.repassword != null}">${oldInput.repassword}</c:if>">
                                </div>
                                <div class="row">
                                    <div class="col-auto ml-auto">
                                        <input type="submit" class="btn btn-primary" value="注册">
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