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
    <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
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


    </style>
</head>
<body>

<%--修改商品信息模态框--%>
<!-- Modal -->
<div class="modal fade" id="update-info" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改个人信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="update-form0" name="update-form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">昵称</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="name" id="name" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email" id="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="telephone" class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="telephone" name="telephone">
                            <span id="span1"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveInfo" >保存</button>
            </div>
        </div>
    </div>
    <script>

        $(function(){
            $('#update-form0').validate({
                rules: {
                    telephone: {
                        required: true,
                        number: true,
                        minlength:11,
                        maxlength:11,
                    },
                    email: {
                        required: true,
                        email: true,
                    }
                },
                messages: {

                    telephone: {
                        required:"联系电话不能为空",
                        number: "请输入一个正确的电话号",
                        minlength: "请输入一个正确的电话号",
                        maxlength: "请输入一个正确的电话号",
                    },
                    email: {
                        required: "邮箱输入不能为空",
                        email: "请输入一个正确的邮箱",
                    }
                }
            });
        })
    </script>
</div>

<%--修改商品信息模态框--%>
<!-- Modal -->
<div class="modal fade" id="update-Psw" tabindex="-1" role="dialog" aria-labelledby="myModalLabelPsw">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelPsw">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updatePsw-form" name="update-form" method="post">
                    <div class="form-group">
                        <label for="oldPsw" class="col-sm-2 control-label">旧密码</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name="oldPsw" id="oldPsw">
                        </div>
                    </div>
                    <div class="form-group" style="display: none" id="oldPswError">
                        <label for="name" class="col-sm-2 control-label"></label>
                        <div class="col-sm-9">
                            <label style="color: #BD1F3B">密码错误</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="newPsw" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" name="newPsw" id="newPsw">
                        </div>
                    </div>
                    <div class="form-group" style="display: none" id="newPswError">
                        <label for="name" class="col-sm-2 control-label"></label>
                        <div class="col-sm-9">
                            <label style="color: #BD1F3B">密码应长度大于8</label>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="savePsw" >保存</button>
            </div>
        </div>
    </div>
</div>

<div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
    <div id="main" class="container">
        <div id="header">
            <jsp:include page="header.jsp"/>
        </div>
        <main class="mdl-layout__content mdl-color--grey-100">
            <div class="mdl-grid demo-content">
                <div class="demo-charts mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col mdl-grid">
                    <div class="tab-content">
                        <table class="table" cellpadding="6" cellspacing="1">
                            <thead>
                            <th style="border: 0px solid transparent">
                                <%--<h1>个人信息</h1>--%>
                            </th>
                            </thead>
                            <tbody >
                            <tr >
                                <th style="border: 0px solid transparent" class="tl">用户号</th>
                                <td style="border: 0px solid transparent" class="tr" id="userIdVal">${user.getUserid()}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">用户名</th>
                                <td style="border: 0px solid transparent" class="tr" id="nameVal">${user.getUsername()}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">注册时间</th>
                                <td style="border: 0px solid transparent" class="tr" id="regTimeVal">
                                    ${user.regtime.year+1900} 年
                                    ${user.regtime.month+1} 月
                                    ${user.regtime.date} 日
                                </td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">邮箱</th>
                                <td style="border: 0px solid transparent" class="tr" id="emailVal">${user.getEmail()}</td>
                            </tr>
                            <tr>
                                <th style="border: 0px solid transparent" class="tl">手机号</th>
                                <td style="border: 0px solid transparent" class="tr" id="telephoneVal">${user.getTelephone()}</td>
                            </tr>
                            <i Psw="${user.getPassword()}" id="Psw"></i>
                            </tbody>
                        </table>
                    </div>
                    <div class="mdl-card__actions mdl-card--border">
                        <button class="templatemo-blue-button" id="changeInfo"><h5>修改信息</h5></button>
                        <button class="templatemo-blue-button" id="changePsw"><h5>修改密码</h5></button>
                        <button class="templatemo-blue-button" id="dizhiguanli"><h5>地址管理</h5></button>

                    </div>
                </div>
            </div>
            </main>
            <script>
            $(function(){
                $("#dizhiguanli").click(function(){
                    window.location.href="http://localhost:8080/minority/info/address"
                })
            })
        </script>
    </div>
</div>
</body>
</html>
