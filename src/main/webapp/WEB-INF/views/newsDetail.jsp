<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!doctype html>
<html class="" lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>资讯-${goodsInfo['goods'].goodsname}</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- all css here -->
<!-- bootstrap v3.3.6 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/font-awesome.min.css">
<!-- style css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/css/shopdetail.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/video-js.css"
	rel="stylesheet">
<!-- <script src="./detail/js/jquery.js"></script> -->
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>

<%--<script src="${pageContext.request.contextPath}/js/sort.js"></script>--%>

<!-- bootstrap js -->
<script
	src="${pageContext.request.contextPath}/css/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sort.js"></script>
<script src="${pageContext.request.contextPath}/js/detail.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var showproduct = {
			"boxid" : "showbox",
			"sumid" : "showsum",
			"boxw" : 400,
			"boxh" : 550,
			"sumw" : 60, //列表每个宽度,该版本中请把宽高填写成一样
			"sumh" : 60, //列表每个高度,该版本中请把宽高填写成一样
			"sumi" : 7, //列表间隔
			"sums" : 5, //列表显示个数
			"sumsel" : "sel",
			"sumborder" : 1, //列表边框，没有边框填写0，边框在css中修改
			"lastid" : "showlast",
			"nextid" : "shownext"
		}; //参数定义
		$.ljsGlasses.pcGlasses(showproduct); //方法调用，务必在加载完后执行

		$(function() {

			$('.tabs a').click(function() {

				var $this = $(this);
				$('.panel').hide();
				$('.tabs a.active').removeClass('active');
				$this.addClass('active').blur();
				var panel = $this.attr("href");
				$(panel).show();
				return fasle; //告诉浏览器  不要纸箱这个链接
			}); //end click


			$(".tabs li:first a").click(); //web 浏览器，单击第一个标签吧

		}); //end ready

		$(".centerbox li").click(function() {
			$("li").removeClass("now");
			$(this).addClass("now");

		});

		/*$("#chatto").click(function () {
		    $.ajax({
		        url: "/shop/chat/", //把表单数据发送到ajax.jsp
		        type: "POST",
		        data: {
		            sendto: 5
		        },
		        error: function (request) {
		            alert(result.msg);
		        },
		        success: function (result) {
		        }
		    });
		});*/

		$('.fav-button').click(function() {
			//$(this).removeClass("glyphicon-heart-empty");
			var goodsId = $(this).attr('data-id');
			var isChangeBtn = true;
			if (!$(this).children("i").hasClass('fa-heart')) {
				//收藏
				$.ajax({
					url : "/shop/collect",
					type : "POST",
					data : {
						goodsid : goodsId
					},
					success : function(result) {
						//收藏成功
						if (result.code === 200) {
							location.href = "/shop/login";
							isChangeBtn = false;
						}
					},
					error : function() {
						alert("收藏失败");
					}
				})
			} else {
				//取消收藏
				$.ajax({
					url : "/shop/deleteCollect",
					type : "POST",
					data : {
						goodsid : goodsId
					},
					success : function(result) {
						//取消收藏成功
						if (result.code === 200) {
							location.href = "/shop/login";
							isChangeBtn = false;
						}
					},
					error : function() {
						alert("取消收藏失败");
					}
				})
			}

			/*$.post("servlet/CollectServlet", {
			 goodsId: goodsId,
			 });
			 // alert("商品已加入购物车！");*/

			if (isChangeBtn) {
				$(this).children("i").toggleClass("fa-heart fa-heart-o");
				var likeContent = $(this).children("span").text();
				if (likeContent == '收藏') {
					$(this).children("span").text('取消收藏');
				} else {
					$(this).children("span").text('收藏');
				}
			}
		});
	});
</script>
<style>
.head {
	width: 45px !important;
	background: rgba(0, 0, 0, .0001) none repeat scroll 0 0 !important;
	border: 1px solid rgba(0, 0, 0, .075) !important;
}

.span-block {
	display: block !important;
	padding: 5px;
}
</style>

</head>

<body>
	<!--zoom elavator area one start-->

	<div class="container">
		<jsp:include page="header.jsp" />
		<div class="shop_menu shop_menu_2 main-detail-div">
			<ul class="cramb_area cramb_area_5 main-detail-nav">
				<li><h4>
						<a href="${pageContext.request.contextPath}/main">首页 /</a>
					</h4></li>
				<%--<li><a href="index.html">Shop /</a></li>
                <li><a href="index.html">Headlight/</a></li>
                <li><a href="index.html">Hats /</a></li>--%>
				<li class="br-active">${goodsInfo['goods'].goodsname}</li>
			</ul>
		</div>
	</div>


	<div class="container">
		<div class="page-header">
			<h1>${goodsInfo['goods'].goodsname}</h1>
		</div>
		<c:forEach items="${goodsInfo['image']}" var="path">
			<c:if test="${fn:indexOf(path.path,'.mp4')<0 }">
				<img src="${pageContext.request.contextPath}/shopimage/${path.path}"
					alt="..." class="img-thumbnail">
			</c:if>
			<c:if test="${fn:indexOf(path.path,'.mp4')>0 }">
			<%-- <video id="video" controls="controls" src="${pageContext.request.contextPath}/shopimage/${path.path}" style="width:100%;"></video> --%>
<%--			<video id='my-video' class='video-js vjs-default-skin vjs-fluid' controls preload='auto'--%>
<%--				width='640' height='264' poster='MY_VIDEO_POSTER.jpg'--%>
<%--				data-setup='{}'>--%>
<%--				<source src='${pageContext.request.contextPath}/shopimage/${path.path}' type='video/mp4'>--%>
<%--				<source src='MY_VIDEO.webm' type='video/webm'>--%>
<%--				<p class='vjs-no-js'>--%>
<%--					To view this video please enable JavaScript, and consider upgrading--%>
<%--					to a web browser that <a--%>
<%--						href='https://videojs.com/html5-video-support/' target='_blank'>supports--%>
<%--						HTML5 video</a>--%>
<%--				</p>--%>
<%--			</video>--%>
			</c:if>
		</c:forEach>

		<p class="lead">${goodsInfo['goods'].description}</p>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script src='${pageContext.request.contextPath}/js/video.js'></script>

</body>
</html>


