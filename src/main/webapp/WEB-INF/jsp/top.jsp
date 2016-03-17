<!DOCTYPE>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		<script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
		<link href="/TeraNavi/css/style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="/TeraNavi/css/navbar.css" type="text/css">
		<script type="text/javascript" src="/TeraNavi/js/footerFixed.js"></script>
		<script type="text/javascript" src="/TeraNavi/js/community.js"></script>
		<jsp:include page="/WEB-INF/jsp/googleanalytics.jsp"/>
		<title>TeraNavi TOP</title>
	</head>
	<body>
		<%-- ヘッダー部分のHTMLを読み込み --%>
		<jsp:include page="/WEB-INF/jsp/header.jsp"/>

		<div class="section hidden-xs">
			<div class="container">
				<div class="row">
					<div class="col-xs-10 col-xs-offset-1">
						<ul class="lead nav nav-justified nav-tabs">
							<li class="active">
								<a href="/TeraNavi/front/top#top" data-toggle="tab" class="text-warning">TOP</a>
							</li>
							<li>
								<a href="#blog" data-toggle="tab" class="text-warning" onclick="topBlogLoad();">ブログ</a>
							</li>
							<li>
								<a href="/TeraNavi/front/TopLoadCommunity" class="text-warning">コミュニティ</a>
							</li>
							<li>
								<a href="/TeraNavi/front/showTag" id="showtags" class="text-warning">タグ</a>
							</li>
							<li>
								<a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}" class="text-warning">マイページ</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>


		<div class="visible-xs xs-top-nav">
			<nav class="nav nav-horizontal">
				<div class="mask">
					<ul class="list">
						<li><a href="TeraNavi/front/top#top" data-toggle="tab">Top</a></li>
						<li><a href="#blog" data-toggle="tab" >ブログ</a></li>
						<li><a href="#community" data-toggle="tab" >コミュニティ</a></li>
						<li><a href="" data-toggle="tab">タグ</a></li>
						<li>
							<a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}" class="text-warning">マイページ</a>
						</li>
					</ul>
				</div>
			</nav>
		</div>


		<div class="tab-content">
			<div class="tab-pane active" id="top">
				<div class="section">
					<div class="container">
						<div class="row col-md-10 col-xs-10 col-xs-offset-1 col-md-offset-1">
							<h1 class="text-warning">新着記事</h1>
						</div>
						<input type="hidden" id="topArticlesSize" value="${fn:length(result.article)}">
						<c:forEach var="article" items="${result.article}" varStatus="status">
							<div class="row col-md-10 col-xs-10 col-xs-offset-1 col-md-offset-1 well mobile-content-space">
								<div class="col-md-2 col-xs-12">
									<br>
									<div class="hidden-xs">
										<a href="/TeraNavi/front/mypage?paramUserId=${article.userId}">
											<img src="${article.iconPath}" class="img-thumbnail" style="width:100px;height:100px;" >
											<h3 class="text-muted" style="margin-top:0px;">${article.userName}</h3>
										</a>

									</div>
									<div class="visible-xs">
										<a href="/TeraNavi/front/mypage?paramUserId=${article.userId}">
											<img src="${article.iconPath}" class="img-thumbnail" style="width:100px;height:100px;">
											<h5 class="text-muted mobile-user-name" style="margin-top:0px;">${article.userName}</h5>
										</a>

									</div>
								</div>
								<div class="col-md-7 col-xs-12">
									<div class="hidden-xs">
										<a href="/TeraNavi/front/showArticle?articleId=${article.articleId}"><h2 class="text-muted">${article.title}</h2></a>
										<p id="top${status.index}"><c:out value="${article.articleBody}" /></p>
										<div class="text-right">
											<a class="btn btn-warning" href="/TeraNavi/front/showArticle?articleId=${article.articleId}">続きを読む</a>
										</div>

									</div>
									<div class="visible-xs">
										<a href="/TeraNavi/front/showArticle?articleId=${article.articleId}"><h5 class="text-muted text-center mobile-article-title">${article.title}</h5></a>
										<%-- <p class="mobile-article-body" id="top${status.index}"><c:out value="${fn:substring(article.articleBody,0,30)}" /></p> --%>

										<a class="btn btn-warning btn-block" href="/TeraNavi/front/showArticle?articleId=${article.articleId}">記事を読む</a>

									</div>
								</div>
								<div class="col-md-3 hidden-xs">
									<br><br>
									<p>${article.createdDate}</p>
									<br>
									<p>コメント数 ${article.commentCount}</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="blog"> <jsp:include page="/WEB-INF/jsp/topblog.jsp"/> </div>
			<div class="tab-pane" id="community"> <jsp:include page="/WEB-INF/jsp/topcommunity.jsp"/> </div>
			<div class="tab-pane" id="tag"> <jsp:include page="/WEB-INF/jsp/toptag.jsp"/> </div>
		</div><!-- tab-content -->

		<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

		<script src="/TeraNavi/js/topblog.js"></script>

		<script>

			$(document).ready(function () {

			//記事本文のHTMLタグ除去-----------------------------------------------------
				var size = $("#topArticlesSize").val();
				for(var i=0; i<size; i++){
					var str = $("#top"+i).text();
					var body = str.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'');
					$("#top"+i).text(body.substr(0,30));//30文字分かえす
				}
//
//				size = $("#blogArticlesSize").val();
//				for(var i=0; i<size; i++){
//					var str = $("#blog"+i).text();
//					var body = str.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'');
//					$("#blog"+i).text(body.substr(0,30));//30文字分かえす
//				}

				var tagArticleCount = $("#tagArticleCount").val();
				console.log("tagArticleCount"+tagArticleCount);
				for(var i=0; i<tagArticleCount; i++){
					size = $("#tagArticlesSize"+i).val();
					for(var j=0; j<size; j++){
						var str = $("#"+i+"tag"+j).text();
						var body = str.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'');
						$("#"+i+"tag"+j).text(body.substr(0,30));//30文字分かえす
					}
				}
			//--------------------------------------------------------------------------


				// #(ハッシュ)指定されたタブを表示する
				var hashTabName = document.location.hash;
				if (hashTabName) {
					$('.nav-tabs a[href=' + hashTabName + ']').tab('show');

					event.preventDefault();

					// // 所定の位置までスクロールする
					// var tabParent = $("#" + $('.nav-tabs a[href=' + hashTabName + ']').parents('div').attr('id'));
					// $('html, body').stop().animate({
					// 	scrollTop: 0
					// }, 2000);
				}

			});
		</script>

		<!-- 確認モーダル -->
		<div class="fade modal text-justify" id="partiCommModal">
			<div class="modal-dialog">
			  <div class="modal-content">
				<div class="modal-header">
				  <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				  </button>
				　<h4 class="modal-title text-center">確認</h4>
				 </div>
				<div class="modal-body">
					<p id="joinResultMessage" class="text-center">参加中...</p>
				</div>
				<div class="modal-footer"></div>
			  </div>
			</div>
		 </div>
	</body>
</html>
