<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>我的订单</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div id="userinfo-container">
        <table class="table table-hover table-responsive" style="width:100%">
            <tr>
                <th style="width:130px">商品编号</th>
                <th style="width:130px">购买数量</th>
                <th style="width:130px">订单时间</th>
                <th style="width:240px">评价</th>
                <th style="width:130px">操作</th>
            </tr>

            <c:if test="${trans == null}">
            <div class="row">
                <div class="mx-auto">
                    <span>还没有订单，快去看看有什么喜欢的商品吧！</span>
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
                    ${tran.number}
                </td>
                <td>
                    ${tran.created_at}
                </td>
                <td>
                    <c:if test="${tran.reason != null}">${tran.reason}</c:if>
                    <c:if test="${tran.reason == null}">
                        <div class="row">
                            <div class="mx-auto">
                                <span>还没有评价，快评价吧！</span>
                                <p></p>
                                <button class="btn btn-primary" type="button" data-toggle="collapse"
                                        data-target="#add-form${tran.id}" aria-expanded="false" aria-controls="add-form">
                                    <span class="fa fa-plus"> 评价</span>
                                </button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="mx-auto">
                                <div class="collapse" id="add-form${tran.id}">
                                    <p>
                                        <div class="card card-body">
                                            <form action="${pageContext.request.contextPath}/user/${tran.id}/comment"
                                                  method="post" style="width:300px">
                                                <p><textarea name="comment" id="comment" class="form-control"
                                                            placeholder="订单评价" required="true"></textarea></p>
                                                <div class="row">
                                                    <div class="mx-auto">
                                                        <button class="btn btn-primary" type="submit">保存</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/user/${tran.id}/delTran"
                          method="post" onsubmit="return confirm('确定删除吗？');">
                        <button type="submit" class="btn btn-danger">删除订单</button>
                    </form>
                </td>
            </tr>
            </c:forEach>
            </c:if>
        </table>
    </div>

</div>

</body>
</html>