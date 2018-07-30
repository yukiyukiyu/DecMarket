<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

<form method="POST" action="${pageContext.request.contextPath}/user/login">
    <div>
        <label>用户名：</label>
        <input type="text" id="username" name="username" placeholder="用户名"
               required="true" autofocus="true"/>
        <c:if test="${not empty invalidUser}">
            <span class="error">${invalidUser}</span>
        </c:if>
    </div>
    <div>
        <label>密码：</label>
        <input type="password" id="password" name="password"
               placeholder="密码" required="true"/>
    </div>
    <div>
        <button class="btn" type="submit">登录</button>
    </div>
</form>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>