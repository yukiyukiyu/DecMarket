<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form action="${pageContext.request.contextPath}/user/createUserInfo" method="post" style="width:300px">
    <p><input type="text" name="nickname" id="nickname" class="form-control"
              placeholder="昵称"></p>
    <p><input type="text" name="QQ" id="QQ" class="form-control" placeholder="QQ"></p>
    <p><input type="text" name="wechat" id="wechat" class="form-control"
              placeholder="微信"></p>
    <p><textarea name="address" id="address" class="form-control"
                 placeholder="地址"></textarea></p>
    <p><textarea name="intro" id="intro" class="form-control"
                placeholder="商家简介"></textarea></p>

    <div class="row">
        <div class="mx-auto">
            <button class="btn btn-primary" type="submit">保存</button>
        </div>
    </div>
</form>