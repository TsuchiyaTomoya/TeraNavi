<link rel="stylesheet" href="/TeraNavi/css/navbar.css" type="text/css">
<div class="section hidden-xs">
    <div class="container">
		<div class="row">
			<div class="col-xs-10 col-xs-offset-1">
				<ul class="lead nav nav-justified nav-tabs">
					<li>
						<a href="/TeraNavi/front/top" class="text-warning">TOP</a>
					</li>
					<li>
						<a href="/TeraNavi/front/top#blog" class="text-warning">ブログ</a>
					</li>
					<li>
						<a href="/TeraNavi/front/top#community" class="text-warning">コミュニティ</a>
					</li>
					<li>
						<a href="/TeraNavi/front/top#tag" class="text-warning">タグ</a>
					</li>
					<li class="active">
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
				<li><a href="/TeraNavi/front/top">Top</a></li>
				<li><a href="/TeraNavi/front/top#blog">ブログ</a></li>
				<li><a href="/TeraNavi/front/top#community">コミュニティ</a></li>
				<li><a href="/TeraNavi/front/top#tag">タグ</a></li>

				<li>
					<a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}" class="text-warning">マイページ</a>
				</li>

			</ul>
		</div>
	</nav>
</div>