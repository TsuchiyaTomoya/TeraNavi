<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>${result.article.title}</title>

		<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">

	</head>
	<body>
		<div id="fb-root"></div>
		<script>(function (d, s, id) {
				var js, fjs = d.getElementsByTagName(s)[0];
				if (d.getElementById(id))
					return;
				js = d.createElement(s);
				js.id = id;
				js.src = "//connect.facebook.net/ja_JP/sdk.js#xfbml=1&version=v2.5&appId=584104165076285";
				fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));</script>


		<%-- ヘッダー部分のHTMLを読み込み --%>
		<jsp:include page="/WEB-INF/jsp/header.jsp"/>

		<input type="hidden" value="${result.article.articleId}" id="primaryArticleId">

		<header>
			<div class="row">
				<div class="col-md-12 hidden-xs">
					<img src="${result.blog.headerPath}" style="width:100%; height:250px">
				</div>

				<div class="col-md-12 visible-xs">
					<img src="${result.blog.headerPath}" style="width:100%; height:80px">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<p> <span  class="col-md-12 text-center" style="position:relative;margin-top:-200px;background-color:rgba(255,255,255,0.7);font-size: 60px;">
							${result.blog.title}</span>
					</p>

				</div>
			</div>
			<div class="row hidden-xs">
				<div class="col-md-12">
					<img src="${result.article.iconPath}" class="img-thumbnail" style="width:130px; height:130px; position:relative; bottom:110px; margin-left:50px;">
					<h3 style="position:relative; margin-top:-100px; margin-left:50px;">
						<a class="text-muted" href="/TeraNavi/front/mypage?paramUserId=${result.article.userId}">${result.article.userName}</a>
					</h3>
				</div>
			</div>
		</header>

		<div class="section">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<h1 class="text-center">${result.article.title}</h1>
						<p class="text-left">${result.article.createdDate}</p>
						<br>
						<br>
						<p class="text-left">${result.article.articleBody}</p>
					</div>
					<div class="col-md-2 hidden-xs">
						<h3 class="text-center text-warning">月別アーカイブ</h3>
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
								月を選択 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<c:forEach var="contents" items="${result.archives}">
									<li><a href="/TeraNavi/front/showArticleList?writeUserId=${result.article.userId}&scope=${contents.year}${contents.month}">
											${contents.year}年${contents.month}月(${contents.count})
										</a></li>
									</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<ul class="pager">
							<c:choose>
								<c:when test="${result.previous >= 0}">
									<li class="previous">
										<a href="/TeraNavi/front/showArticle?articleId=${result.previous}" style="font-weight:bold">＜前の記事へ</a>
									</li>
								</c:when>
							</c:choose>
							<li>
								<a href="#" style="font-weight:bold">ブログTOPへ</a>
							</li>
							<c:choose>
								<c:when test="${result.next >= 0}">
									<li class="next">
										<a href="/TeraNavi/front/showArticle?articleId=${result.next}" style="font-weight:bold">次の記事へ＞</a>
									</li>
								</c:when>
							</c:choose>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">

						<p>
							<c:forEach var="tag" items="${result.article.tags}">
								<a class="label label-warning">${tag.name}</a>
							</c:forEach>
						</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<i id="commentCount" class="fa fa-3x fa-comment-o fa-fw text-muted " style="margin-right:20%;">${result.article.commentCount}</i>

						<a href="https://twitter.com/share" class="twitter-share-button" data-lang="ja" data-dnt="true">ツイート</a>
						<%-- 下のdata-hrefはサイトのURLに変更してください --%>
						<div class="fb-like" data-width="130px" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>

						<a href="#" class="dropdown pull-right dropdown-toggle" data-toggle="dropdown">
							<i class="-o -square fa fa-3x fa-ellipsis-h fa-fw text-muted"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-right">
							<li>
								<a id="cautionArticle">この記事を通報する</a>

							</li>
							<li>
								<a id="cautionUser">この記事を書いたユーザを通報する</a>

							</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<hr>
					</div>
				</div>
				<div class="row">
					<div class="col-md-1 col-md-offset-2 col-xs-3">
						<img src="${sessionScope.loginUser.iconPath}" class="img-responsive img-thumbnail">
					</div>
					<form action="/TeraNavi/front/compost" method="post" class="form-horizontal" role="form">
						<div class="col-md-7 col-xs-8">
							<div class="form-group">
								<textarea name="body" class="form-control" id="commentBody" placeholder="コメントを書く"></textarea>
							</div>
						</div>
						<div class="col-md-7 col-xs-10 col-xs-offset-1">
							<div class="form-group">
								<button type="button" id="commentSubmit" class="btn btn-default pull-right hidden-xs">投稿</button>
								<button type="button" id="commentSubmit" class="btn btn-default pull-right visible-xs btn-block">投稿</button>
							</div>
						</div>
					</form>
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<hr>
						</div>
					</div>
					<div id="commentPostDiv">
						<c:forEach var="comment" items="${result.article.comments}">
							<div class="row">
								<div class="col-md-1 col-md-offset-2">
									<img src="${comment.iconPath}" class="img-responsive img-thumbnail">
									<a href="#"><p class="text-center">${comment.userName}</p></a>
								</div>
								<div class="col-md-7">
									<p>${comment.commentDate}</p>
									<p>${comment.commentBody}</p>
									<a href="#" class="dropdown pull-right dropdown-toggle" data-toggle="dropdown">
										<i class="-o -square fa fa-ellipsis-h fa-fw fa-lg text-muted"></i>
									</a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li>
											<a onclick="commentCaution('${comment.userId}')">このコメントを通報する</a>
										</li>
										<li>
											<a onclick="commentUserCaution('${comment.userId}')">このユーザを通報する</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="row">
								<div class="col-md-8 col-md-offset-2">
									<hr>
								</div>
							</div>
						</c:forEach>
					</div>
					<div>
					</div>

					<div id="cautionModal" class="modal fade">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h1 class="text-center" id="moHead">通報</h1>
								</div>
								<div id="cautionM" class="modal-body">
									<div class="form-group">
										<form action="/TeraNavi/front/caution" method="post" id="cautionForm">
											<input class="form-control" id="uiCaution" form="cautionForm" type="hidden" name="cautionUserId" value="${result.blog.userId}">
											<input class="form-control" form="cautionForm" id="targetUrl" type="hidden" name="url" value="<%=request.getRequestURI()%>">
											<div class="form-group">
												<label class="control-label">タイトル</label>
												<input class="form-control" id="cautionTitle" form="cautionForm" type="text" name="cautionTitle">
											</div>
											<div class="form-group">
												<label class="control-label">本文</label>
												<textarea class="form-control" id="cautionBody" form="cautionForm" name="cautionBody"></textarea>
											</div>
											<button id="cautionSubmit" type="button" form="cautionForm" class="btn btn-default pull-right">送信する</button>
										</form>

									</div>

								</div>
								<div class="modal-footer"></div>
							</div><!--end moal-content-->
						</div><!--end modal-dialog-->
					</div><!--end modal-->

				</div>
			</div>


			<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

			<script>
				$("#dd").click(function () {
					$('.bun').remove();
					$('#cauTile').html('警告名：<input type="text" name="cautionTitle">');
					$('#cauBody').html('警告する内容：<input type="text" name="cautionBody" >');
					$('#cauBody').append('<input type="hidden" name="url" value="location.href">');
					$('#sub').html('<input type="submit" value="この記事を警告">');
				});
			</script>
			<script>
				!function (d, s, id) {
					var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
					if (!d.getElementById(id)) {
						js = d.createElement(s);
						js.id = id;
						js.src = p + '://platform.twitter.com/widgets.js';
						fjs.parentNode.insertBefore(js, fjs);
					}
				}(document, 'script', 'twitter-wjs');
			</script>

			<script src="/TeraNavi/js/articleCaution.js"></script>
			<script src="/TeraNavi/js/commentPost.js"></script>
	</body>
</html>
