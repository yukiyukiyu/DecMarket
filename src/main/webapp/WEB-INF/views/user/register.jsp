<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <jsp:include page="../layout/basic.jsp">
    </jsp:include>
</head>

<body>
<jsp:include page="../layout/header.jsp" flush="true">
</jsp:include>

<form method="POST" action="${pageContext.request.contextPath}/user/register">
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
        <label>确认密码：</label>
        <input type="password" name="repassword" id="repassword"
               placeholder="确认密码"/>
        <c:if test="${not empty diffPassword}">
            <span class="error">${diffPassword}</span>
        </c:if>
    </div>
    <div>
        <label>手机号：</label>
        <input type="text" id="tel" name="tel" placeholder="手机号"
               required="true"/>
    </div>
    <div>
        <label>邮箱</label>
        <input type="text" id="email" name="email" placeholder="邮箱"
               required="true"/>
    </div>
    <div>
        <button class="btn" type="submit">注册</button>
    </div>
</form>

</body>
</html>