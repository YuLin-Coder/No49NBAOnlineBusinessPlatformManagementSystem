<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>NBA网商平台</title>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
<script
	src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sort.js"></script>
<script src="${pageContext.request.contextPath}/js/holder.js"></script>
<!-- 	<script>
            $(document).ready(function(){
                $(".list-group-item").hover(function(){
                    $(this).children("div.sort-detail").show();
                },function(){
                    $(this).children("div.sort-detail").hide();
                });
            })
        </script> -->
<script>
/*$(document).ready(function () {
    $(".data-item-li").children("div").addClass("to-big");
});*/
</script>
</head>
<body>
	<div id="main" class="container">
		<!-- <div id="header">
        <ul id="header_left">
            <li id="login"><a href="">登录</a></li>
            <li id="register"><a href="">注册</a></li>
        </ul>
        <ul>
            <li><a href="">购物车</a></li>
            <li><a href="">收藏夹</a></li>
            <li><a href="">客服</a></li>
        </ul>
    </div>
    <div>

    </div> -->
		<div id="header">
			<%@ include file="header.jsp"%>

			<!-- 旋转图 -->
			<div class="header-bottom">

				<div id="mycarousel" class="carousel slide" data-ride="carousel">
					<div class="carousel-inner">
						<div class="item active">
							<img src="${pageContext.request.contextPath}/image/3.jpg" alt="">
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/image/3.jpg" alt="">
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/image/3.jpg" alt="">
						</div>
						<div class="item">
							<img src="${pageContext.request.contextPath}/image/3.jpg" alt="">
						</div>
					</div>

					<ol class="carousel-indicators">
						<li data-target="#mycarousel" data-slide-to="0" class="active"></li>
						<li data-target="#mycarousel" data-slide-to="1"></li>
						<li data-target="#mycarousel" data-slide-to="2"></li>
						<li data-target="#mycarousel" data-slide-to="3"></li>
					</ol>

					<a class="left carousel-control" href="#mycarousel" role="button"
						data-slide="prev" style="display: none;"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#mycarousel" role="button"
						data-slide="next" style="display: none;"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<div class="clear-float"></div>
			</div>
		</div>
		<div class="content">
			<div class="row">
				<c:forEach items="${newsList}" var="news">
					<div class="col-sm-6 col-md-4">
						<h3>NBA</h3>
						<div class="thumbnail" style="height: 306px;overflow: hidden;">
							<a href="${pageContext.request.contextPath}/newsdetail?goodsid=${news.goodsid}">
							<img src="${pageContext.request.contextPath}/shopimage/${news.imagePaths[0].path}" alt="..." style="width: 277px; height: 156px;">
							</a>
							<div class="caption">
								<h3><a href="${pageContext.request.contextPath}/newsdetail?goodsid=${news.goodsid}">${news.goodsname}</a></h3>
								<p>${news.description}</p>
							</div>
						</div>
					</div>
				</c:forEach>
				
			</div>
		</div>
		<div class="content">
			<div class="module">
				<div class="hd">
					<h2>全部商品</h2>
					<hr>
				</div>

				<div class="bd">
					<div class="data">
						<ul id="goods_ul">

						</ul>
						<div class="clear-float" style="clear: both;"></div>
					</div>
				</div>
			</div>


		</div>
		<div class="container" style="margin-top:10px;">
			<button id="load" type="button"
				class="btn btn-default btn-lg btn-block">加载更多</button>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
		<a href="#" id="back-to-top" style="display: inline;"><i
			class="fa fa-angle-up"></i></a>


	</div>
	<script type="text/javascript">
		var pn = 1;
		var total = 1;
		$(function() {
			getGoodsList(1);
		});
		function getGoodsList(pn) {
			$.ajax({
				url : "${pageContext.request.contextPath}/listgoods?pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var data = result.info.pageInfo.list;
					$.each(data, function(index, item) {
						var li = $("<li></li>").addClass("data-item-li").appendTo($("#goods_ul"));
						var div = $("<div></div>").addClass("to-big").appendTo(li);
						var a = $("<a></a>").attr("href", "${pageContext.request.contextPath}/detail?goodsid=" + item.goodsid).appendTo(div);
						var img = $("<img></img>").attr("src", "${pageContext.request.contextPath}/shopimage/" + item.imagePaths[0].path).attr("width", "200").attr("height", "200").appendTo(a);
						var p = $("<p></p>").addClass("text-right").appendTo(li);
						var a2 = $("<a></a>").attr("href", "${pageContext.request.contextPath}/detail?goodsid" + item.goodsid).append(item.goodsname).appendTo(p);
						var div2 = $("<div></div>").addClass("text-right").append($("<b>￥" + item.price + "</b>")).appendTo(li);
	
					});
					if(result.info.pageInfo.pages<=pn){
						$("#load").attr("disabled","disabled").html("我也是有底线的");
						
					}
				}
			});
		}
		$("#load").click(function(){
			pn += 1;
			getGoodsList(pn);
		})
		$(window).scroll(function() {
			if ($(this).scrollTop() > 100) {
				$('#back-to-top').fadeIn();
			} else {
				$('#back-to-top').fadeOut();
			}
		});
		$('#back-to-top').on('click', function(e) {
			e.preventDefault();
			$('html, body').animate({
				scrollTop : 0
			}, 1000);
			return false;
		});
	</script>
</body>
</html>


