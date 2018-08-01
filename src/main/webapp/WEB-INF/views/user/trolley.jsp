<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>购物车</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div id="userinfo-container">
        <table class="table table-hover table-responsive" style="width:100%">
            <tr>
                <th style="width:130px">商品编号</th>
                <th style="width:130px">选择数量</th>
                <th style="width:130px">加入时间</th>
                <th style="width:410px">操作</th>
                <th style="width:130px">删除</th>
            </tr>

            <c:if test="${trans == null}">
            <div class="row">
                <div class="mx-auto">
                    <span>购物车空空如也，快去看看有什么喜欢的商品吧！</span>
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
                    <form action="${pageContext.request.contextPath}/user/${tran.id}/pay"
                          method="post" style="display: inline-block;">
                        <button class="btn btn-primary" type="button" data-toggle="collapse"
                                data-target="#pay-form${tran.id}" aria-expanded="false" aria-controls="add-form">
                            <span class="fa fa-plus"> 立即付款</span>
                        </button>
                        <div class="row">
                            <div class="mx-auto">
                                <div class="collapse" id="pay-form${tran.id}">
                                    <center>
                                        <p></p>
                                        <h4>请使用支付宝扫描此二维码进行付款</h4><br/>
                                        <h6>付款成功后将自动跳转……</h6>
                                        <img src="${pageContext.request.contextPath}/resources/img/wxqr.png"
                                             style="max-width: 200px; margin-top: 1.25em; margin-bottom: 1.25em">

                                        <p>如长时间未跳转，请点击此按钮确定付款</p>
                                            <button class="btn btn-primary" type="submit">已付款</button>
                                    </center>
                                </div>
                            </div>
                        </div>
                    </form>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/user/${tran.id}/delTrolley"
                          method="post" onsubmit="return confirm('确定删除吗？');" style="display: inline-block">
                        <button type="submit" class="btn btn-danger">移出购物车</button>
                    </form>
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