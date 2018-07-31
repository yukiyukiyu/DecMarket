<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="banner"><div class="banner-back"></div></div>

<div class="navbar-back"><div class="navbar-bg"></div><div class="navbar-filter"></div></div>
<div class="container navbar-container">
    <nav class="navbar navbar-expand-md navbar-dark">
        <div class="dropdown">
            <button class="navbar-toggler" data-toggle="dropdown" role="button" aria-haspopup="true"
                aria-expanded="false"><span class="navbar-toggler-icon"></span></button>
            <div class="dropdown-menu dropdown-menu-right">
            <c:if test="${sessionScope.user_id == null}">
                <a href="${pageContext.request.contextPath}/user/loginForm" class="dropdown-item">登录</a>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/user/registerForm" class="dropdown-item">注册</a>
            </c:if>
            <c:if test="${sessionScope.user_id != null}">
                <a href="${pageContext.request.contextPath}/user/${sessionScope.user_id}/profile" class="dropdown-item">
                    <c:if test="${sessionScope.nickname != null}">
                        <label class="dropdown-header">${sessionScope.nickname}</label>
                    </c:if>
                    <c:if test="${sessionScope.nickname == null}">
                        <label class="dropdown-header">${sessionScope.username}</label>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/user/logout" class="dropdown-item bg-danger text-light">登出</a>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/user/userInfo" class="dropdown-item">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/getFavList" class="dropdown-item">收藏夹</a>
                <a href="${pageContext.request.contextPath}/user/trans" class="dropdown-item">我的购买</a>
                <a href="${pageContext.request.contextPath}/user/${sessionScope.user_id}/sell" class="dropdown-item">我的出售</a>
                <c:if test="${sessionScope.is_admin >= 1}">
                    <a href="${pageContext.request.contextPath}/admin" class="dropdown-item">管理中心</a>
                </c:if>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/message" class="dropdown-item">消息</a>
                <a href="${pageContext.request.contextPath}/good/add" class="dropdown-item">出售</a>
            </c:if>
            </div>
        </div>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">DecMarket</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
            <c:if test="${sessionScope.user_id == null}">
                <li class="nav-item">
                <a href="${pageContext.request.contextPath}/user/loginForm" class="nav-link nav-btn">登录</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/user/registerForm" class="nav-link nav-btn">注册</a>
                </li>
            </c:if>
            <c:if test="${sessionScope.user_id != null}">
                <li class="nav-item dropdown">
                    <a class="nav-link navbar-avatar nav-btn" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <c:if test="${sessionScope.nickname != null}">
                            <label class="dropdown-header">${sessionScope.nickname}</label>
                        </c:if>
                        <c:if test="${sessionScope.nickname == null}">
                            <label class="dropdown-header">${sessionScope.username}</label>
                        </c:if>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a href="${pageContext.request.contextPath}/user/userInfo" class="dropdown-item">个人中心</a>
                        <a href="${pageContext.request.contextPath}/user/getFavList" class="dropdown-item">收藏夹</a>
                        <a href="${pageContext.request.contextPath}/user/trans" class="dropdown-item">我的购买</a>
                        <a href="${pageContext.request.contextPath}/user/${sessionScope.user_id}/sell" class="dropdown-item">我的出售</a>
                        <c:if test="${sessionScope.is_admin >= 1}">
                            <a href="${pageContext.request.contextPath}/admin" class="dropdown-item">管理中心</a>
                        </c:if>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/user/logout" class="dropdown-item bg-danger text-light">登出</a>
                    </div>
                </li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/message" class="nav-link nav-btn">消息</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/good/addGoodForm" class="nav-link nav-btn">出售</a></li>
            </c:if>
            </ul>
        </div>
    </nav>
</div>

<div class="container search-container">
    <div class="row">
        <div class="col-md-8 col-lg-9 d-none d-md-block">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/resources/img/logo-20180729.png"/>
            </a>
        </div>
        <div class="col col-md-4 col-lg-3 ml-auto">
            <img src="${pageContext.request.contextPath}/resources/img/icon.png" class="banner-icon"/>
            <form action="${pageContext.request.contextPath}/good" method="GET">
            <div class="input-group">
                <input class="form-control" name="query" id="searchq" placeholder="开始交易吧 OwO"/>
                <span class="input-group-btn"><input type="submit" class="btn btn-warning" value="G♂"></span>
            </div>
            </form>
        </div>
    </div>
</div>

<div class="container classbar-container">
    <ul class="nav nav-pills classbar-pills">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/good"
                class="nav-link classbar-btn">所有商品</a>
        </li>
    </ul>
</div>

<p></p>
<p></p>