<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>收藏夹</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/favlist.css" />
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <form method="POST" id="favdel">
        <div class="row">
            <div class="col-auto mr-auto"><h4>收藏商品</h4></div>
            <div class="col-auto ml-auto">
                <a href="#" class="btn btn-primary" onclick="editfav()" id="editbutton">编辑收藏夹</a>
                <a href="#" class="btn btn-primary" onclick="submitdel()" style="display:none" id="del_submit">删除选中商品</a>
            </div>
        </div>
        <div class="row">
            <c:forEach items="${favList}" var="good">
                <div class="yesrpg col-6 col-md-4 col-lg-2">
                    <div class="good" style="margin-bottom:20px;">
                        <a href="${pageContext.request.contextPath}/good/${good.id}">
                            <div class="card" style="box-shadow:1px 1px 2px #aaaaaa;border-style:none">
                                <div class="card-img-top">
                                    <div style="position:absolute;z-index:201">
                                        <input type="checkBox" name="del_goods" value="0" id="box${good.id}" class="cb"
                                               onclick="setValue(${good.id})" style="visibility:hidden;width:20%;z-index:203" />
                                    </div>
                                    <img src="${pageContext.request.contextPath}/resources/img/icon.png" class="titlepic card-img-top goodinfo-img"/>
                                    <div class="details" style="position:absolute;z-index:200;width:100%;display:none;">
                                        <div class="det-d d-none d-md-block" style="position:absolute;z-index:200;top:-37px;left:5px;color:lightgrey;font-size:12px;">
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
                                    <div class="d-block d-sm-none" style="position:absolute;z-index:200;width:100%;height:25%;">
                                        <div class="det-d" style="position:absolute;z-index:200;top:-18px;color:black;font-size:12px;filter:opacity(50%);background-color: black;right:0;border-radius:5px 0px 0 0px;">
                                            ￥${good.price}&nbsp;
                                        </div>
                                        <div class="det-d" style="position:absolute;z-index:201;top:-18px;color:white;font-size:12px;right:0;">
                                            <span>￥${$good.price}&nbsp;</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="word-break:break-all;font-size:12px;padding:3px 7px;color:black;filter:opacity(90%);height:40px;">
                                    <p style="max-height:100%;margin:0; overflow:hidden;">${good.name}</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </form>

    <script src="${pageContext.request.contextPath}/resources/js/good/editfav-20170928.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/good/ToolTip.js"></script>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>