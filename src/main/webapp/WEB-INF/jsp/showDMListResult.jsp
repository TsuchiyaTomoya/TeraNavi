
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="UTF-8">
		<title>記事一覧表示</title>
		<!-- Latest compiled and minified CSS -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
		<link href="/TeraNavi/css/navbar.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="/TeraNavi/css/mypage.css" type="text/css">
	</head>
	<body>
		<%-- ヘッダー部分のHTMLを読み込み --%>
		<jsp:include page="/WEB-INF/jsp/header.jsp"/>

		<jsp:include page="/WEB-INF/jsp/topnav.jsp"/>

		<div class="main-content">
			<div class="container visible-xs">
				<div class="dropdown">
					<button class="btn btn-danger dropdown-toggle" type="button" data-toggle="dropdown">DM<span class="caret"></span></button>
					<ul class="dropdown-menu">
						<li id="mypageTab">
							<a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}">マイページ</a>
						</li>
						<c:choose>
							<c:when test="${sessionScope.loginUser.blogStatus eq 1}">
								<li>
									<a href="/TeraNavi/articlepost">記事を書く</a>
								</li>
								<li>
									<a href="/TeraNavi/front/showDraftArticleList?writeUserId=${sessionScope.loginUser.id}">下書き一覧</a>
								</li>
								<li>
									<a href="/TeraNavi/front/showBlog?targetURL=blogSetting">ブログ設定</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="/TeraNavi/blogSetting">ブログ開設</a>
								</li>
							</c:otherwise>
						</c:choose>
						<li>
							<a href="/TeraNavi/front/commmy?groupBy=group+By+community_members_list.fk_community_id+&where=community_members_list.fk_user_id%3D+%3F+and+communities.community_delete_flag+%3D0+and+community_members_list.community_withdrawal_flag+%3D0&target=create">コミュニティ管理</a>
						</li>
						<br><br>
						<li>
							<a href="/TeraNavi/withdraw">退会</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="container hidden-xs">
				<div class="row">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>ユーザ名</th>
								<th>最新内容</th>
								<th>最新投稿日時</th>
								<!-- <th class="deletable"></th> -->
							</tr>
						</thead>
						<tbody>

							<c:forEach var="dm" items="${result}">

								<tr onclick="location.href = '/TeraNavi/front/dmreceive?sendUserId=${dm.fromUserId}'">
									<td>${dm.fromUserName}</td>
									<td>${dm.messageBody}</td>
									<td>${dm.date}</td>
								</tr>

							</c:forEach>

						</tbody>
					</table>
				</div><!--end row-->
			</div><!--end container-->

			
			<div class="visible-xs">
				<div class="container" style="width:90%;">
				<div class="row">
					<table class="table table-striped col-xs-10">
						<thead>
							<tr>
								<th class="col-xs-3">ユーザ名</th>
								<th class="col-xs-3">最新内容</th>
								<th class="col-xs-3">投稿日時</th>
								<!-- <th class="deletable"></th> -->
							</tr>
						</thead>
						<tbody>

							<c:forEach var="dm" items="${result}">

								<tr onclick="location.href = '/TeraNavi/front/dmreceive?sendUserId=${dm.fromUserId}'">
									<td class="col-xs-3">${dm.fromUserName}</td>
									<td class="col-xs-3">${dm.messageBody}</td>
									<td class="col-xs-3">${dm.date}</td>
								</tr>

							</c:forEach>

						</tbody>
					</table>
				</div><!--end row-->
			</div><!--end container-->
			</div>
			
		</div>

		<jsp:include page="/WEB-INF/jsp/footer.jsp"/>




	</body>
</html>
