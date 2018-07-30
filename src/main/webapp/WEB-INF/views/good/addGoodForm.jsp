<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp"%>
    <title>添加商品</title>
</head>

<body>
<%@include file="../layout/header.jsp"%>

<div class="container">

<div class="row">
    <div class="col col-md-10 col-lg-9 col-xl-8 mx-auto">
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/good/add" method="post">
                    <div class="form-group">
                        <label for="name">商品名称</label>
                        <input name="name" id="name" class="form-control" placeholder="商品名称"/>
                    </div>
                    <p></p>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="description">商品描述</label>
                                <textarea name="description" id="description" placeholder="商品描述" class="form-control"
                                          style="resize:none;" rows="6"></textarea>
                                <textarea id="full" placeholder="商品描述" style="resize:none;display:none" rows="6"
                                          class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="price">商品价格</label>
                                <input type="number" step="0.01" min="0" name="price" id="price" placeholder="商品价格" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="count">商品数量</label>
                                <input type="number" name="count" id="count" min="0" placeholder="库存" class="form-control"
                                       onkeyup="this.value=this.value.replace(/\D/g,'')" />
                            </div>
                        </div>
                    </div>
                    <p></p>
                    <div class="row">
                        <div class="col-auto mr-auto">
                            <button class="btn btn-primary" type="submit">确定添加</button>
                        </div>
                        <div class="col-auto ml-auto">
                            <input type="button" class="btn btn-success" value="返回首页"
                                   onclick="window.location.href=('/')">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</div>

<%@include file="../layout/footer.jsp"%>

</body>
</html>