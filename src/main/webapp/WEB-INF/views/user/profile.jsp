<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <style>
        @media (max-width: 770px) {
            #profile_bt {
                height: 40px;
            }
        }
    </style>
    <script src="${pageContext.request.contextPath}/resources/js/good/good_list-20170928.js"></script>
    <title>用户信息</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

    <div class="card">
        <div class="card-header">
            <div class="row" style="margin-bottom:10px">
                <div class="col-md-7 col-sm-12">
                    <figure class="figure">
                        <% String avatarPath = new AvatarHelper().getAvatarByUserId(Integer.parseInt(
                                session.getAttribute("user_id").toString())); %>
                        <img src="<%=avatarPath%>"
                             style="width:150px; height:150px; border-radius:50%; overflow:hidden;margin-bottom:10px" />
                        <figcaption class="figure-caption text-center">
                            <c:if test="${userInfo.nickname != null}">
                            用户昵称： ${userInfo.nickname}
                                <c:if test="${user.baned == true}">
                                【已封禁】
                                </c:if>
                            </c:if>
                            <c:if test="${userInfo.nickname == null}">
                            用户名： ${user.username}
                                <c:if test="${user.baned == true}">
                                【已封禁】
                                </c:if>
                            </c:if>
                        </figcaption>
                    </figure>
                </div>
                <div class="col-md-5 col-sm-12" id="profile_bt">
                    <c:if test="${sessionScope.is_admin == 2 && user.baned == false}">
                        <c:if test="${user.privilege == 0}">
                            <form action="${pageContext.request.contextPath}/user/${user.id}/setadmin" method="post">
                                <input type="submit" value="设置管理员" class="btn btn-info">
                            </form>
                        </c:if>
                        <c:if test="${user.privilege == 1}">
                            <form action="${pageContext.request.contextPath}/user/${user.id}/removeadmin" method="post">
                                <input type="submit" value="解除管理员" class="btn btn-danger">
                            </form>
                        </c:if>
                        <form action="${pageContext.request.contextPath}/user/${user.id}/ban" method="post"
                              style="position:absolute;bottom:0px">
                            <input type="submit" class="btn btn-danger" value="封禁该用户">
                        </form>
                    </c:if>
                </div>
            </div>
            <ul class="nav nav-tabs card-header-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" href="#goods" aria-controls="goods" role="tab"
                       data-toggle="tab">他的商品</a>
                </li>
            </ul>
        </div>
        <div class="tab-content card-body">
            <div role="tabpanel" class="tab-pane active" id="goods" style="min-height: 270px">
                <div class="row">
                    <c:forEach items="${requestScope.goods}" var="good">
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="good" style="margin-bottom:20px;">
                            <a href="${pageContext.request.contextPath}/good/${good.id}">
                                <div class="card">
                                    <div class="card-img-top">
                                        <img src="${pageContext.request.contextPath}/resources/img/icon.png"
                                             title="${good.name}" style="width:100%"/>
                                    </div>
                                    <div class="card-body">
                                        <div style="word-break:break-all">${good.name}</div>
                                        <div class="text-warning"><b>￥${good.price}</b></div>
                                        <c:if test="${good.count == 0}">
                                        <div class="text-danger">无库存QAQ</div>
                                        </c:if>
                                        <c:if test="${good.count != 0}">
                                        <div>库存：${good.count}</div>
                                        </c:if>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    </c:forEach>
                    <c:if test="${goods == null}">
                    <div style="margin-left:auto;margin-right:auto;">他还没有发布商品呢</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>