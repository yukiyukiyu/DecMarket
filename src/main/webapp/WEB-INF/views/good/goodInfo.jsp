<%@ page import="com.yuki.decmarket.util.CoverHelper" %>
<%@ page import="com.yuki.decmarket.model.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lrtk.css"/>
    <title>商品详情</title>
</head>

<body>
<%@include file="../layout/header.jsp" %>

<div class="container">

    <div class="row">
        <div class="col-12 col-md-7">
            <div class="row">
                <div class="col">
                    <img src="${pageContext.request.contextPath}/resources/img/cover/${good.id}"/>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <ul class="nav nav-tabs card-header-tabs" role="tab-list">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#description" role="tab" data-toggle="tab"
                                       aria-controls="description">商品描述</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#comment" role="tab" data-toggle="tab"
                                       aria-controls="description">历史评价</a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content card-body">
                            <div class="tab-pane active" id="description" role="tabpanel">
                                ${good.description}
                            </div>
                            <div class="tab-pane" id="comment" role="tabpanel">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>买家编号</th>
                                        <th>评价</th>
                                        <th>交易时间</th>
                                    </tr>
                                    </thead>
                                    <c:forEach items="${trans}" var="tran">
                                        <c:if test="${tran.reason != null}">
                                            <tbody>
                                            <tr>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/user/${tran.buyer_id}/profile">
                                                            ${tran.buyer_id}</a></td>
                                                <td>${tran.reason}</td>
                                                <td>${tran.created_at}</td>
                                            </tr>
                                            </tbody>
                                        </c:if>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="d-none d-lg-block col-1"></div>
        <div class="col col-md-5 col-lg-4">
            <p class="d-md-none"></p>
            <div class="row">
                <h4 class="col">${good.name}</h4>
            </div>
            <div class="row">
                <div class="mx-auto">
                    <div>售价：<h3 class="d-inline-block"><b class="text-warning">￥${good.price }</b></h3></div>
                </div>
            </div>
            <div class="row">
                <div class="col col-lg-9 col-xl-8 mx-auto">
                    <c:if test="${sessionScope.user_id == null}">
                        <div class="row">
                            <div class="mx-auto">
                                <span>您还未登录，登录后方可购买</span>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.user_id != null && good.user_id != sessionScope.user_id}">
                        <form action="${pageContext.request.contextPath}/good/${good.id}/pay" method="post">
                            <c:if test="${good.count > 1}">
                                <div class="input-group">
                                    <input type="number" name="count" value="1" class="form-control"
                                           min="1" max="${good.count}"/>
                                    <span class="input-group-btn">
                            <input type="submit" class="btn btn-primary" value="购买"/>
                        </span>
                                </div>
                            </c:if>
                            <c:if test="${good.count == 1}">
                                <div class="row">
                                    <div class="mx-auto">
                                        <input type="number" name="count" value="1" class="form-control d-none"/>
                                        <input type="submit" class="btn btn-primary" value="购买"/>
                                    </div>
                                </div>
                            </c:if>
                        </form>
                    </c:if>
                </div>
            </div>
            <p></p>
            <c:if test="${sessionScope.user_id != null}">
                <div class="row">
                    <div class="col-auto mx-auto">
                        <c:if test="${good.user_id == sessionScope.user_id || sessionScope.is_admin >= 1}">
                            <div class="btn-group">
                                <form action="/good/${good.id}/edit">
                                    <input type="submit" class="btn btn-primary" value="修改">
                                </form>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.is_admin >= 1}">
                            <div class="btn-group">
                                <form action="/good/${good.id}/delete" method="POST"
                                      onsubmit="return confirm('确定删除吗？');">
                                    <input type="submit" class="btn btn-danger" value="删除">
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
            <p></p>
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">商品信息</div>
                        <table class="table table-hover" style="margin-bottom:0">
                            <tbody>
                            <tr>
                                <th>卖家</th>
                                <td>
                                    <a href="/user/${seller.id}/profile">
                                        <c:if test="${sellerInfo.nickname != null}">${sellerInfo.nickname}</c:if>
                                        <c:if test="${sellerInfo.nickname == null}">${seller.username}</c:if>
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <th>库存</th>
                                <td
                                        <c:if test="${good.count == 0}">class="text-danger"</c:if> >
                                    <c:if test="${good.count > 0}">
                                        <c:if test="${good.count > 1}">${good.count} 件</c:if>
                                        <c:if test="${good.count == 1}">仅一件</c:if>
                                    </c:if>
                                    <c:if test="${good.count == 0}">没库存了QAQ</c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>收藏</th>
                                <td>
                                    <c:if test="${sessionScope.user_id != null}">
                                        <c:if test="${isInFavList != 1}">
                                            <form action="/good/${good.id}/addFavList" method="post">
                                                <button class="fa fa-star-o btn btn-primary btn-sm"
                                                        data-toggle="tooltip"
                                                        data-placement="top" title="收藏OvO">
                                                </button>
                                                <span>收藏OvO</span>
                                            </form>
                                        </c:if>
                                        <c:if test="${isInFavList == 1}">
                                            <form action="/good/${good.id}/delFavList" method="post">
                                                <button class="fa fa-star btn btn-primary btn-sm" data-toggle="tooltip"
                                                        data-placement="top" title="取消收藏QAQ">
                                                </button>
                                                <span>取消收藏QAQ</span>
                                            </form>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sessionScope.user_id == null}">
                                        <button class="fa fa-star-o btn btn-primary btn-sm"
                                                onclick="window.location.href='/user/loginForm'"
                                                data-toggle="tooltip" data-placement="top" title="收藏OvO">
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th>上架时间</th>
                                <td>${good.created_at}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../layout/footer.jsp" %>

</body>
</html>