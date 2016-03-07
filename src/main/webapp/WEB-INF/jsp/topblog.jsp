

<div class="section">
	<div class="container">
		<div class="row col-md-10 col-xs-11 col-xs-offset-1 col-md-offset-1">
			<h1 class="text-warning">各科新着記事</h1>
		</div>
		<c:forEach var="article" items="${result.department}">
			<div class="row col-md-10 col-xs-10 col-xs-offset-1 col-md-offset-1 well mobile-content-space">
				<div class="col-md-2 col-xs-12">
					<br>
					<div class="hidden-xs">
						<img src="${article.iconPath}" class="img-responsive img-thumbnail">
						<a href="/TeraNavi/front/mypage?paramUserId=${article.userId}"><h3 class="text-center text-muted">${article.userName}</h3></a>

					</div>
					<div class="visible-xs">
						<img src="${article.iconPath}" class="img-responsive img-thumbnail mobileThumbnail">
						<a href="/TeraNavi/front/mypage?paramUserId=${article.userId}"><h5 class="text-center text-muted mobile-user-name">${article.userName}</h5></a>

					</div>
				</div>
				<div class="col-md-7 col-xs-12">
					<div class="hidden-xs">
						<a href="/TeraNavi/front/showArticle?articleId=${article.articleId}"><h2 class="text-muted">${article.title}</h2></a>
						<p id="articleBody"><c:out value="${article.articleBody}" />...</p>
						<div class="text-right">
							<a class="btn btn-warning" href="/TeraNavi/front/showArticle?articleId=${article.articleId}">続きを読む</a>
						</div>

					</div>
					<div class="visible-xs">
						<a href="/TeraNavi/front/showArticle?articleId=${article.articleId}"><h5 class="text-muted">${article.title}</h5></a>
						<p class="mobile-article-body" id="articleBody"><c:out value="${article.articleBody}" />...</p>

						<a class="btn btn-warning btn-block" href="/TeraNavi/front/showArticle?articleId=${article.articleId}">続きを読む</a>

					</div>
				</div>
				<div class="col-md-3 hidden-xs">
					<br><br>
					<p>投稿日時 ${article.createdDate}</p>
					<br>
					<p>コメント数 ${article.commentCount}</p>
				</div>
			</div>
		</c:forEach>
	</div>
</div>


<div class="section">
    <div class="container">
		<div class="row col-md-10 col-xs-11 col-xs-offset-1 col-md-offset-1">
			<h1 class="text-warning">人気ブログ</h1>
		</div>
		<div class="row col-md-10 col-md-offset-1 col-xs-10 col-xs-offset-1">
			<c:forEach var="blog" items="${result.blog}">
				<div class="col-md-4 well well-lg col-xs-12 mobile-content-space"><!--ブログ一件の領域-->
					<div class="row"><!--アイコンとユーザー名の領域-->
						<div class="col-md-5 col-xs-12">
							<img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
								 class="img-responsive img-thumbnail">
						</div>
						<div class="col-md-7">

							<a href=""><h2 class="text-center text-muted">ユーザ名</h2></a>
						</div>
					</div><!--アイコンとユーザー名の領域おわり-->
					<div class="row"><!--ブログ名と紹介文の領域-->
						<div class="hidden-xs">
							<h1 class="text-center">
								<a href="/TeraNavi/front/showBlog?bloguserId=${blog.userId}">
									<h3 class="text-muted">${blog.title}${blog.userId}</h3>
								</a>
							</h1>

						</div>
						<div class="visible-xs">
							<a href=""><h3 class="text-muted text-center mobile-blog-title">${blog.title}</h3></a>

						</div>

						<p class="text-center">${blog.explanation}</p>
					</div><!--ブログ名と紹介文の領域おわり-->
				</div><!--ブログ一件の領域おわり-->
			</c:forEach>

		</div>
    </div>
</div>
