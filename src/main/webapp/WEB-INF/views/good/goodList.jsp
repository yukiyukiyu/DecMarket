<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/goodlist-20170927.css"/>
    <script src="${pageContext.request.contextPath}/resources/js/good/good_list-20170928.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/good/editfav-20170928.js"></script>
    <title>商品列表</title>
</head>

<body>
<%@include file="../layout/header.jsp" %>

<div class="container">

    <div class="row">
        <c:forEach items="${requestScope.goods}" var="good">
            <div class="col-6 col-sm-4 col-lg-2">
                <div class="good">
                    <a href="/good/${good.id}">
                        <div class="card" style="box-shadow:1px 1px 2px #aaaaaa;border-style:none">
                            <div class="card-img-top">
                                <img src="${pageContext.request.contextPath}/resources/img/cover/${good.id}"
                                     title="${good.name}" class="card-img-top"/>
                                <div class="details" style="position:absolute;z-index:200;width:100%;display:none;">
                                    <div class="det-d d-none d-md-block" style="position:absolute;z-index:200;top:-37px;left:5px;
                                        color:lightgrey;font-size:12px;">
                                        售价：￥${good.price}
                                        <br/>
                                        <c:if test="${good.count == 0}">
                                            无库存QAQ
                                        </c:if>
                                        <c:if test="${good.count != 0}">
                                            库存：${good.count}
                                        </c:if>
                                    </div>
                                </div>
                                <div class="d-block d-sm-none"
                                     style="position:absolute;z-index:200;width:100%;height:25%;">
                                    <div class="det-d" style="position:absolute;z-index:200;top:-18px;color:black;font-size:12px;
                                        filter:opacity(50%);background-color: black;right:0;border-radius:5px 0px 0 0px;">
                                        ￥${good.price}&nbsp;
                                    </div>
                                    <div class="det-d"
                                         style="position:absolute;z-index:201;top:-18px;color:white;font-size:12px;right:0;">
                                        <span>￥${good.price}&nbsp;</span>
                                    </div>
                                </div>
                                <div class="d-none d-sm-none"
                                     style="position:absolute;z-index:200;width:100%;height:25%;">
                                    <div class="det-d" style="position:absolute;z-index:200;top:-18px;color:black;font-size:12px;
                                        filter:opacity(50%);background-color: black;left:0;border-radius:0px 5px 0 0px;">
                                        <c:if test="${good.count == 0}">
                                            <span>无库存QAQ</span>
                                        </c:if>
                                        <c:if test="${good.count != 0}">
                                            <span>库存：${good.count}</span>
                                        </c:if>
                                    </div>
                                    <div class="det-d"
                                         style="position:absolute;z-index:201;top:-18px;color:white;font-size:12px;left:0;">
                                        <c:if test="${good.count == 0}">
                                            <span>无库存QAQ</span>
                                        </c:if>
                                        <c:if test="${good.count != 0}">
                                            <span>库存：${good.count}</span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="d-none">
                                    <div>${good.name}</div>
                                    <div class="text-warning" style="font-size:13px"><b>￥${good.price}</b></div>
                                    <c:if test="${good.count == 0}">
                                        <div class="text-dark" style="font-size:13px">无库存QAQ</div>
                                    </c:if>
                                    <c:if test="${good.count != 0}">
                                        <div class="text-dark" style="font-size:13px">库存：${good.count}</div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="card-body" style="word-break:break-all;font-size:12px;padding:3px 7px;color:black;
                                filter:opacity(90%);height:40px;">
                                <p style="max-height:100%;margin:0; overflow:hidden;">${good.name}</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

</div>

<%@include file="../layout/footer.jsp" %>

</body>
</html>