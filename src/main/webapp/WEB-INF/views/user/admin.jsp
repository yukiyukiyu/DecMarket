<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="card">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs" role="tab-list">
                <li class="nav-item">
                    <a class="nav-link active" href="#userlist" role="tab" data-toggle="tab"
                       aria-controls="userlist">查看所有用户</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#translist" role="tab" data-toggle="tab"
                       aria-controls="translist">交易列表</a>
                </li>
            </ul>
        </div>

        <div class="tab-content card-body">
            <div class="tab-pane active" id="userlist" role="tabpanel">
                <table class="table table-hover">
                    <form action="${pageContext.request.contextPath}/user/query" method="post">
                        <div class="input-group">
                            <input class="form-control" name="query" id="searchq" placeholder="输入用户名查询"/>
                            <span class="input-group-btn"><input type="submit" class="btn btn-warning" value="G♂"></span>
                        </div>
                    </form>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>权限</th>
                            <th>用户名</th>
                            <th>电话</th>
                            <th>邮箱</th>
                            <th>是否封禁</th>
                            <th>注册时间</th>
                        </tr>
                    </thead>
                    <c:forEach items="${users}" var="user">
                    <tbody>
                        <tr>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/${user.id}/profile">${user.id}</a>
                            </td>
                            <td>${user.privilege}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/${user.id}/profile">${user.username}</a>
                            </td>
                            <td>${user.tel}</td>
                            <td>${user.email}</td>
                            <td>
                                <c:if test="${user.baned == false}">否</c:if>
                                <c:if test="${user.baned == true}">已封禁</c:if>
                            </td>
                            <td>${user.created_at}</td>
                        </tr>
                    </tbody>
                    </c:forEach>
                </table>
            </div>

            <div class="tab-pane" id="translist" role="tabpanel">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>交易单号</th>
                            <th>买家编号</th>
                            <th>商品编号</th>
                            <th>交易数目</th>
                            <th>评价</th>
                            <th>交易时间</th>
                        </tr>
                    </thead>
                    <c:forEach items="${trans}" var="tran">
                    <tbody>
                        <tr>
                            <td>${tran.id}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/${tran.buyer_id}/profile">${tran.buyer_id}</a>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/user/${tran.good_id}/profile">${tran.good_id}</a>
                            </td>
                            <td>${tran.number}</td>
                            <td>${tran.reason}</td>
                            <td>${tran.created_at}</td>
                        </tr>
                    </tbody>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>