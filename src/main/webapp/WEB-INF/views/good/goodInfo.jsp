<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/lrtk.css"/>
    <title>商品详情</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

<div class="row">
    <div class="col-12 col-md-7">
        <div class="row">
            <div class="col">
                <img src="${pageContext.request.contextPath}/resources/img/icon.png"/></a>
            </div>
        </div>
        <br/>
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">商品介绍</div>
                    <div class="card-body">${good.description}</div>
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
                <c:if test="${sessionScope.user_id != null && good.id != sessionScope.user_id}">
                <form action="${pageContext.request.contextPath}/good/${good.id}/buy" method="post">
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
                <c:if test="${good.userId == sessionScope.user_id || sessionScope.is_admin == 1}">
                <div class="btn-group">
                    <form action="/good/${good.id}/edit">
                        <input type="submit" class="btn btn-primary" value="修改">
                    </form>
                </div>
                </c:if>
                <c:if test="${sessionScope.is_admin == 1}">
                <div class="btn-group">
                    <form action="/good/${good.id}/delete" method="POST" onsubmit="return confirm('确定删除吗？');">
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
                                <a href="/user/${seller.id}">
                                    <c:if test="${sellerInfo.nickname != null}">${sellerInfo.nickname}</c:if>
                                    <c:if test="${sellerInfo.nickname == null}">${seller.username}</c:if>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <th>库存</th>
                            <td <c:if test="${good.count == 0}">class="text-danger"</c:if> >
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
                                    <c:if test="${isInFavList == null}">
                                    <button class="fa fa-star-o btn btn-primary btn-sm"
                                            onclick="add_favlist()" data-toggle="tooltip" data-placement="top"
                                            title="收藏OvO">
                                    </button>
                                    </c:if>
                                    <c:if test="${isInFavList != null}">
                                    <button class="fa fa-star btn btn-primary btn-sm"
                                            onclick="del_favlist()" data-toggle="tooltip" data-placement="top"
                                            title="取消收藏QAQ"></button>
                                    </c:if>
                                </c:if>
                                <c:if test="${sessionScope.user_id == null}">
                                <button class="fa fa-star-o btn btn-primary btn-sm"
                                        onclick="window.location.href='/user/login'"
                                        data-toggle="tooltip" data-placement="top" title="收藏OvO">
                                </button>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>上架时间</th>
                            <td>${good.createdAt}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function add_favlist() {
        var str_data = $("#fav input").map(function () {
            return ($(this).attr("name") + '=' + $(this).val());
        }).get().join("&");
        $.ajax({
            type: "POST",
            url: "/good/${good.id}/addFavList",
            data: str_data,
            success: function (msg) {
                $('.fa-star-o').attr('title','取消收藏QAQ');
                $('.fa-star-o').attr('onclick', 'del_favlist()');
                $('.fa-star-o').tooltip('dispose');
                $('.fa-star-o').tooltip('show');
                $('.fa-star-o').attr('class','fa fa-star btn btn-primary btn-sm');
            }
        });
    }
    function del_favlist() {
        var str_data1 = $("#fav input").map(function () {
            return ($(this).attr("name") + '=' + $(this).val());
        }).get().join("&");
        var str_data = str_data1 + '&_method=DELETE';
        $.ajax({
            type: "POST",
            url: "/good/${good.id}/delFavList",
            data: str_data,
            success: function (msg) {
                $('.fa-star').attr('title','收藏OvO');
                $('.fa-star').attr('onclick', 'add_favlist()');
                $('.fa-star').tooltip('dispose');
                $('.fa-star').tooltip('show');
                $('.fa-star').attr('class','fa fa-star-o btn btn-primary btn-sm');
            }
        });
    }
</script>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>