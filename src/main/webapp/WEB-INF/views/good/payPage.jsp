<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">商品信息</div>
                <table class="table table-hover" style="margin-bottom:0">
                    <tbody>
                    <tr>
                        <th>商品名称</th>
                        <td>
                            <a href="${pageContext.request.contextPath}/good/${good.id}">${good.name}</a>
                        </td>
                    </tr>
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
                        <td <c:if test="${good.count == 0}">class="text-danger"</c:if> >
                            <c:if test="${good.count > 0}">
                                <c:if test="${good.count > 1}">${good.count} 件</c:if>
                                <c:if test="${good.count == 1}">仅一件</c:if>
                            </c:if>
                            <c:if test="${good.count == 0}">没库存了QAQ</c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>上架时间</th>
                        <td>${good.created_at}</td>
                    </tr>
                    <tr>
                        <th>购买数量</th>
                        <td>${count}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <p></p>

    <form action="${pageContext.request.contextPath}/good/${good.id}/addTrolley/${count}" method="post">
        <button class="btn btn-primary" type="submit">
            <span class="fa fa-plus"> 加入购物车</span></button>
    </form>

    <button class="btn btn-primary" type="button" data-toggle="collapse"
            data-target="#pay-form" aria-expanded="false" aria-controls="add-form">
        <span class="fa fa-plus"> 立即付款</span>
    </button>
    <div class="row">
        <div class="mx-auto">
            <div class="collapse" id="pay-form">
                <center>
                <h4>请使用支付宝扫描此二维码进行付款</h4><br/>
                <h6>付款成功后将自动跳转……</h6>
                <img src="${pageContext.request.contextPath}/resources/img/wxqr.png"
                     style="max-width: 200px; margin-top: 1.25em; margin-bottom: 1.25em">

                <p>如长时间未跳转，请点击此按钮确定付款</p>
                <form action="${pageContext.request.contextPath}/good/${good.id}/buy/${count}" method="post">
                    <button class="btn btn-primary" type="submit">已付款</button>
                </form>
                </center>
            </div>
        </div>
    </div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>