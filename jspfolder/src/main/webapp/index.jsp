<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link href="<%=request.getContextPath()%>/css/base.css" type="text/css" rel="stylesheet">
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<%@ include file="/include/nav.jsp" %>
	<section>
		<div id="weather">날씨예보입니다.</div>
		<div id="youtube">
			<iframe width="440" height="250" src="https://www.youtube.com/embed/YvgKD1VfA6E?si=Cr2fSTvCdzgS42eN" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
			<iframe width="440" height="250" src="https://www.youtube.com/embed/QNBHV2_e9-A?si=LbOXFALWzT4ZP2UD" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
		</div>
		<div id="adbanner">추천사이트입니다.</div>
		<div class="mainboard">
			<div id="mboard1">
				<div class="mboardmn clearfix">
					<h3>공지사항</h3>
					<a href=# class="mainmore">더보기 +</a>
				</div>
				<ul class="mainlist">
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">공지사항리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>

				</ul>
			</div>
			<div id="mboard2">
				<div class="mboardmn clearfix">
					<h3>전체게시글</h3>
					<a href=# class="mainmore">더보기 +</a>
				</div>
				<ul class="mainlist">
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>
					<li>
						<a href="#">전체게시글리스트입니다.</a>
						<span class="mlistdate">2023.10.06</span>
					</li>

				</ul>
			</div>
		</div>
	</section>
	<%@ include file="/include/footer.jsp" %>
</body>
</html>