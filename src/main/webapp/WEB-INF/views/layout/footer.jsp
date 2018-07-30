<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<p></p>

<div class="footer container">
    <div class="row"><div class="mx-auto">当前处于调试模式</div></div>
    <div class="d-none d-md-flex row">
        <ul class="col-auto">
            <li>© <jsp:useBean id="now" class="java.util.Date"/><fmt:formatDate value="${now}" pattern="yyyy"/> yuki@github</li>
            <li><a href="#">隐私政策</a></li>
            <li><a href="#">服务条款</a></li>
        </ul>
        <ul class="col-auto ml-auto">
            <li><a href="#">帮助文档</a></li>
            <li><a href="#">申诉通道</a></li>
            <li><a href="#">意见反馈</a></li>
            <li><a href="#">关于我们</a></li>
        </ul>
    </div>

    <div class="d-md-none row">
        <ul class="col-auto mr-auto">
            <li>© {{date("Y")}} <a href="https://github.com/yukiyukiyu">yuki@github</a>
            </li>

        </ul>
        <ul class="col-auto ml-auto">
            <li><a href="#">帮助文档</a></li>
            <li><a href="#">意见反馈</a></li>
        </ul>
    </div>
</div>