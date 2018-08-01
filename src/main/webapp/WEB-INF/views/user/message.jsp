<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>我的消息</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div id="userinfo-container">
        <table class="table table-hover table-responsive" style="width:100%">
            <tr>
                <th style="width:130px">商品编号</th>
                <th style="width:130px">买家编号</th>
                <th style="width:130px">购买数量</th>
                <th style="width:130px">订单时间</th>
                <th style="width:240px">评价</th>
            </tr>

            <c:if test="${not empty emptyMsg}">
            <div class="row">
                <div class="mx-auto">
                    <span>还没有用户购买你的商品</span>
                </div>
            </div>
            </c:if>

            <c:if test="${trans != null}">
            <c:forEach items="${trans}" var="tran">
            <tr>
                <td>
                    <a href="/good/${tran.good_id}">${tran.good_id}</a>
                </td>
                <td>
                    <a href="/user/${tran.buyer_id}/profile">${tran.buyer_id}</a>
                </td>
                <td>
                        ${tran.number}
                </td>
                <td>
                        ${tran.created_at}
                </td>
                <td>
                    <c:if test="${tran.reason != null}">${tran.reason}</c:if>
                    <c:if test="${tran.reason == null}">买家还没有评价</c:if>
                </td>
            </tr>
            </c:forEach>
            </c:if>
        </table>
    </div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>