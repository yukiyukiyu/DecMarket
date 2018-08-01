<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <%@include file="../layout/basic.jsp" %>
    <script src="${pageContext.request.contextPath}/resources/js/avatar_crop-20170927.js"></script>
    <title>添加商品</title>
</head>

<body>
<%@include file="../layout/header.jsp" %>

<div class="container">

    <div class="row">
        <div class="col col-md-10 col-lg-9 col-xl-8 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form id="good-form"
                          action="<c:if test="${good == null}">${pageContext.request.contextPath}/good/add</c:if>
                                <c:if test="${good != null}">${pageContext.request.contextPath}/good/${good.id}/editMethod/${good.user_id}</c:if>"
                          method="post">
                        <div class="form-group">
                            <label for="name">商品名称</label>
                            <input name="name" id="name" class="form-control" placeholder="商品名称"
                                   value="<c:if test="${good != null}">${good.name}</c:if>"/>
                        </div>
                        <p></p>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="description">商品描述</label>
                                    <textarea name="description" id="description" placeholder="商品描述"
                                              class="form-control"
                                              style="resize:none;" rows="6">
                                    <c:if test="${good!= null}">${good.description}</c:if>
                                </textarea>
                                    <textarea id="full" placeholder="商品描述" style="resize:none;display:none" rows="6"
                                              class="form-control"></textarea>
                                    <div style="display:none" id="ele"></div>
                                    <div class="d-sm-none">
                                        <div id="imgdiv"></div>
                                        <div id="mb_div_upload" style="display:none">
                                            <div style="margin-top:8px;text-align:right;display:block">
                                                <label style="margin-bottom:0">
                                                    <a class="fa fa-plus-circle" style="font-size:60px;"></a>
                                                    <input type="file" id="btn_file" style="display:none"
                                                           multiple="multiple">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="price">商品价格</label>
                                    <input type="number" step="0.01" min="0" name="price" id="price" placeholder="商品价格"
                                           class="form-control"
                                           value="<c:if test="${good != null}">${good.price}</c:if>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="count">商品数量</label>
                                    <input type="number" name="count" id="count" min="0" placeholder="库存"
                                           class="form-control"
                                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                                           value="<c:if test="${good != null}">${good.count}</c:if>"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="goodCoverUpload" class="btn btn-primary">上传商品封面</label>
                                <div id="preview"></div>
                            </div>
                            <div style="display: none">
                                <input type="file" id="goodCoverUpload" class="show-for-sr" name="goodCoverPic"
                                       onchange="preview(this)"/>
                                <input id="goodCoverUploadCpWidth" type="hidden" name="crop_width">
                                <input id="goodCoverUploadCpHeight" type="hidden" name="crop_height">
                                <input id="goodCoverUploadCpX" type="hidden" name="crop_x">
                                <input id="goodCoverUploadCpY" type="hidden" name="crop_y">
                                <input id="goodCoverBase64" type="hidden" name="good-cover-base64">
                            </div>
                        </div>
                        <p></p>
                        <div class="row">
                            <div class="col-auto mr-auto">
                                <button id="submit-good" class="btn btn-primary">
                                    <c:if test="${good == null}">确定添加</c:if>
                                    <c:if test="${good != null}">确定修改</c:if>
                                </button>
                            </div>
                            <div class="col-auto ml-auto">
                                <input type="button" class="btn btn-success" value="商品列表"
                                       onclick="window.location.href=('/good')">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // WYSIWYG Editor
        editor();

        function editor() {
            $('#trg').text('less');
            $("#description").froalaEditor({
                imageUploadParam: 'source',
                imageUploadParams: {
                    key: "7e945496f2de8cbc710ecca702062e9b",
                    format: "flea-mart"
                },
                imageUploadURL: 'https://flimg.neupioneer.com/api/1/upload',
                requestWithCORS: true,
                pluginsEnabled: ['image', 'link', 'colors',
                    'fontSize', 'fontFamily', 'fullscreen'],
                toolbarButtonsMD: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily', 'fontSize', 'color', 'align', 'quote', '-',
                    'insertImage', '|', 'emoticons', 'help', 'fullscreen', '|', 'undo', 'redo'],
                toolbarButtonsSM: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily', 'fontSize', 'color', 'align', 'quote', '-',
                    'insertImage', '|', 'emoticons', 'help', 'fullscreen', '|', 'undo', 'redo'],
                toolbarButtonsXS: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily', 'fontSize', 'color', 'align', 'quote', '-',
                    'insertImage', '|', 'emoticons', 'help', 'fullscreen', '|', 'undo', 'redo'],
                toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily', 'fontSize', 'color', 'align', 'quote', '-', 'insertImage', '|', 'emoticons', 'help', 'fullscreen', '|', 'undo', 'redo'],
                height: 150
            });
        }

        $('a[href="https://www.froala.com/wysiwyg-editor?k=u"]').wrap("<div hidden='hidden'></div>");
    </script>

</div>

<%@include file="../layout/footer.jsp" %>

</body>
</html>