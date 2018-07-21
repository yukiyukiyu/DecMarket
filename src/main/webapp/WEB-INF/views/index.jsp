<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>
<h2>Hello DecMarket!</h2>

<form method="POST" action="${pageContext.request.contextPath}/user/register">
    <label>用户名：</label>
    <input id="username" name="username"
                placeholder="用户名" required="true"/>
    <label>密码：</label>
    <input id="password" name="password"
                   placeholder="密码" required="true"/>
    <button class="btn" type="submit">注册</button>
</form>

</body>
</html>
