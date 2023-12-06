<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="A front-end template that helps you build fast, modern mobile web apps.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>个人信息-我的订单</title>

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="images/android-desktop.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Material Design Lite">
    <link rel="apple-touch-icon-precomposed" href="images/ios-desktop.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">

    <link rel="shortcut icon" href="images/favicon.png">

    <!-- SEO: If your mobile URL is different from the desktop URL, add a canonical link to the desktop page https://developers.google.com/webmasters/smartphone-sites/feature-phones -->
    <!--
    <link rel="canonical" href="http://www.example.com/">
    -->

    <!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-light_blue.min.css"> -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/material.cyan-light_blue.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/infostyle.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/list.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sweetalert.css">
    <script src="${pageContext.request.contextPath}/js/distpicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.raty.js"></script>
    <script src="${pageContext.request.contextPath}/js/information.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
         #view-source {
            position: fixed;
            display: block;
            right: 0;
            bottom: 0;
            margin-right: 40px;
            margin-bottom: 40px;
            z-index: 900;
        }

        .templatemo-blue-button {
            background-color: #39ADB4;
            border: none;
            color: white;
        }

        .no-border{border: 0px solid transparent !important;}

        .bs-example {
            position: relative;
            padding: 45px 15px 15px;
            margin: 0 -15px 15px;
            border-color: #e5e5e5 #eee #eee;
            border-style: solid;
            border-width: 1px 0;
            -webkit-box-shadow: inset 0 3px 6px rgba(0,0,0,.05);
            box-shadow: inset 0 3px 6px rgba(0,0,0,.05);
        }

        .finish-btn{
            background-color:#e65b0e !important;
        }

        .font-color{
            color: #00BBD6; !important;
        }

        .content{
            margin: 23px 1px;
        }
        .page-info {
            padding: 30px 30px 30px 50px;
        }
        .like-button{
            left: 75% !important;
            top: 65% !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            $(".data-item-li").hover(function(){
                //需处理显示哪个按钮
                // $(this).find(".like-button").css("display","inline-block");
                $(this).find(".like-button").show();
            },function(){
                $(this).find(".like-button").hide();
            });
            $(".like-button").click(function () {
                var goodsId = $(this).attr("data-id");
                //取消收藏
                $.ajax({
                    url:"../deleteCollect",
                    type:"POST",
                    data:{
                        goodsid:goodsId
                    },
                    success:function (result) {
                        //取消收藏成功
                        if(result.code === 100){
                            location.reload();
                        }
                    },
                    error:function () {
                        alert("取消收藏失败");
                    }
                });
            });
        });
    </script>
</head>
<body>

<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
        <div id="main" class="container">
            <div id="header">
                <jsp:include page="header.jsp"/>
            </div>
            <main class="mdl-layout__content mdl-color--grey-100">
                <div class="mdl-grid demo-content">
                    <div class="content">
                        <div class="module">
                            <div class="bd">
                                <div class="data">
                                    <ul>
                                        <c:forEach items="${pageInfo.list}" var="goods">
                                            <li class="data-item-li">
                                                <div class="to-big">
                                                    <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}"> <img src="${pageContext.request.contextPath}/shopimage/${goods.imagePaths[0].path}" width="240px" height="240px" alt=""/>
                                                    </a>
                                                </div>
                                                <p class="text-right">
                                                    <a href="${pageContext.request.contextPath}/detail?goodsid=${goods.goodsid}">${goods.goodsname}</a>
                                                </p>
                                                <div class="text-right">
                                                    <b>￥${goods.price}</b>
                                                </div>
                                                <div>
                                                    <c:if test="${goods.fav}">
                                                        <button
                                                                class="like-button glyphicon glyphicon-trash btn btn-default"
                                                                data-id="${goods.goodsid}"
                                                                style="display: none;"></button>
                                                    </c:if>

                                                    <!-- <button class="like-button1 glyphicon glyphicon-heart-empty btn btn-default "></button> -->
                                                </div>
                                            </li>
                                        </c:forEach>

                                        <div class="clear-float" style="clear: both;"></div>
                                    </ul>
                                </div>
                                <div class="row page-div">
                                    <div class="col-md-5 page-info">
                                        当前第${pageInfo.pageNum}页，共${pageInfo.pages}页，总共${pageInfo.size}条记录
                                    </div>
                                    <div class="col-md-6">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination pagination-lg">

                                                <c:if test="${pageInfo.hasPreviousPage}">
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/search?keyword=${keyword}&page=${pageInfo.prePage}" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:if test="${!pageInfo.hasPreviousPage}">
                                                    <li class="disabled">
                                                        <a href="${pageContext.request.contextPath}/search?keyword=${keyword}&page=${pageInfo.prePage}" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:forEach items="${pageInfo.navigatepageNums}" var="pageNums">
                                                    <c:if test="${pageNums == pageInfo.pageNum}">
                                                        <li class="active"><a href="${pageContext.request.contextPath}/info/favorite?page=${pageNums}">${pageNums}</a></li>
                                                    </c:if>
                                                    <c:if test="${pageNums != pageInfo.pageNum}">
                                                        <li><a href="${pageContext.request.contextPath}/info/favorite?page=${pageNums}">${pageNums}</a></li>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${pageInfo.hasNextPage}">
                                                    <li>
                                                        <a href="${pageContext.request.contextPath}/info/favorite?page=${pageInfo.nextPage}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                                <c:if test="${!pageInfo.hasNextPage}">
                                                    <li class="disabled">
                                                        <a href="${pageContext.request.contextPath}/info/favorite?page=${pageInfo.nextPage}" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </c:if>

                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
</div>
<!-- <script src="https://code.getmdl.io/1.3.0/material.min.js"></script> -->
</body>
</html>
